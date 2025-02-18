//
//	03/30/2007	RFH		REMOVED BAG REMOVAL CALL
//						ADDED PC STATS TO LOG
//
//	09/21/2008	Wired	Restore HP to nLoggedHP on Login
//  10/02/2008  Wired	Restore Spells on Login
//  12/12/2008  Wired   Allow staff to create Favored Souls and Spirit Shamen
//  01/16/2009  Wired	Allow anybody to create FS or SS
//	02/23/2009	Wired 	Hook for xp_chat
//	04/27/2009	Wired	Boot unsupported SOZ races
//	04/30/2009	RFH		TURNED OFF BOOT CODE - WE DON'T NEED IT WITH ELC
//  06/10/2009  Wired	Delay Execution of DMFI code by 2 seconds
//  07/17/2009	Atharin	DENIED^
//  07/17/2009  Wired	Remove xp_chat hook, native function in 1.23
//  09/17/2009	Wired	Back out Paladin's Bonus to Saves if not LG
//  09/18/2009	Wired	Add d2 MySQL, use GetIsStaff in std_i0_misc
//  09/19/2009  Wired   Add hook for lycantrophy
//  10/03/2009  Wired	Remove custom spelltracking/HPtracking
//  10/03/2009	Wired	ReEquip Items on login (we now skip OnEquip while loading)
//  10/03/2009	Wired	Moved old/dead code to end of file
//  11/04/2009  Wired	Restore death_event_OnLogin( oPC ), erroneously moved to old code block
//						research: MOD may be outdated if HPs persist across resets in 1.23
// 	wired 11/21/09		restore hitpoint tracking code, OEI native is causing invalid characters/crashes
//  wired 12/17/10      remove werewolf code, don't need it here, area heartbeat will get them anyway
//  wired 06/26/11		track logins plus set up sry anonymity
//  wired 07/06/11		protect vault in the absence of master server
//  wired 01/29/12		make sure pcs don't enter server mounted after a reset
//  wired 06/29/12		boot any dm logins from cd keys not on staff whitelist
//	wired 06/20/12		remove any xp_craft abortions on login
//  wired 09/21/12		TEMP: Apply Dakhen Curse on Login
//  wired 12/26/12		add a persistent vfx if found on login

#include "das_i0_version"
#include "death_i0_bleed"
#include "death_i0_respawn"
#include "rw_coinage"
#include "std_decrement_spells"
#include "std_faction_i0"
#include "std_i0_misc"
#include "std_quest_i0"
#include "d2_sql_log"
#include "ginc_lycan"
#include "x2_inc_itemprop"
#include "ginc_effect_util"
#include "std_inc_mounts"
#include "ginc_custom_races"
//
//	FUNCTION PROTOTYPES
//
int reserve_check(object oPC);
int reserve_count_online();
int reserve_get_limit();
string GetClassString(int iClass);
string GetGenderString(int iGender);
string GetSubRaceString(int iSubRace);
void LogCharacterStats(object oPC);
void RemoveTempWeaponBuffs(object oPC);
void ReQuipHands(object oPC, int bAgain = TRUE);
void ReQuip(object oPC, int nSlot, int bAgain = TRUE);

//
//	MAIN
//
void main()
{
	int nLoginCount;
	object oJournal;
	object oPC;

	oPC = GetEnteringObject();
	
	if (!GetIsPC(oPC) || !GetIsObjectValid(oPC)) return;
	
	//	do this up here so use these strings and 
	//  never operate on these for an invalid object
 	SetLocalString(oPC, "LastExit", GetName(OBJECT_SELF));
	SetLocalString(oPC, "LastEntry", "CRASHED BEFORE ON ENTER");
	SetLocalString(oPC, "PlayerName", GetPCPlayerName(oPC));
	SetLocalString(oPC, "PlayerIPAddy", GetPCIPAddress(oPC));
	SetLocalString(oPC, "PlayerPublicCDKey", GetPCPublicCDKey(oPC)	);
	
	// forbid dm logins of non-whitelisted cd keys
	if (GetIsDM(oPC) && !GetIsStaff(oPC))
	{
		SendMessageToPC(oPC,"UNAUTHORIZED DM LOGIN!");
		trackEvent(oPC, "UNAUTH_DM", OBJECT_INVALID,0,0,GetLocalString(oPC, "PlayerName"),GetLocalString(oPC, "PlayerIPAddy"));
		WriteTimestampedLogEntry("UNAUTH_DM_LOGIN: User "+GetLocalString(oPC, "PlayerName")+" CD KEY "+GetLocalString(oPC, "PlayerPublicCDKey")+" from IP: "+GetLocalString(oPC, "PlayerIPAddy"));
		DelayCommand(6.0,BootPC(oPC));	
	}
	
	// protect vault in absence of master server
	if (!UnlockVault(oPC))
	{
		DelayCommand(6.0, BootPC(oPC));	
	}	 
	else
	{
		SetPlotFlag(oPC,FALSE);
		SetImmortal(oPC,FALSE);
	
		//	ADD JOURNAL
		oJournal = std_journal_event_login(oPC);
		
		string sHPVarName = GetName(oPC) + "_HP";
		string sHPInitName = GetName(oPC) + "_Init";
		
		if ( GetLocalInt(GetModule(),sHPInitName) == 1) 
		{
			int nLastHP = GetLocalInt(OBJECT_SELF,sHPVarName);
			SendMessageToPC(oPC,"Current hitpoints calibrated to last logout, " + IntToString(nLastHP) + " HP.");
			effect eDamage = EffectDamage(GetCurrentHitPoints(oPC) - nLastHP, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_PLUS_FIVE,TRUE);
			ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPC);
	
			RemoveOrphanedEffects(oPC);
	    } 
		else 
		{
	       // First time they signed on, don't kill them!
			SendMessageToPC(oPC,"Current hitpoints initiated.");
			SetLocalInt(OBJECT_SELF,sHPVarName,GetCurrentHitPoints(oPC));
			SetLocalInt(OBJECT_SELF,sHPInitName,1);
			
			MountedPCCleanUp(oPC);
	    }
	 		// restore spells
	        if(GetIsSpellCaster(oPC)) DecrementSpells(oPC);
		
		// INSERT/UPDATE pc_data
		//sPCid = getPCid(oPC);	
		saveChar_OCE(oPC);
		trackEvent(oPC,"LOGIN",OBJECT_INVALID,GetHitDice(oPC),GetXP(oPC));
	
		// Check for a full server
		if (reserve_count_online() > reserve_get_limit())
		{	
			if (!reserve_check(oPC))
			{
				SendMessageToPC(oPC, "The server is full.");
				DelayCommand(1.0, FloatingTextStringOnCreature("The server is full", oPC, FALSE, 60.0));
				DelayCommand(12.0, BootPC(oPC));
				return;
			}	
			else
			{
				SendMessageToPC( oPC, "Membership has it's privileges.  Welcome aboard." );
			}
		}
			
		// Reload persistant quests
		persist_onjoin( oPC );
		
		// reload persistent vfx
		string sVFX = GetLocalString(oJournal,"d2_persist_vfx");
		if (sVFX != "")
		{
			effect eProp = SupernaturalEffect(SetEffectSpellId(EffectNWN2SpecialEffectFile(sVFX), -898));
			ApplyEffectToObject(DURATION_TYPE_PERMANENT, eProp, oPC);
		}
		
		// Set the factions
		std_reputation_reset( oPC, "cearguard" );		
			
		// Pointless really
		nLoginCount = GetLocalInt( oJournal, "std_login_count");
		nLoginCount++;
		SetLocalInt( oJournal, "std_login_count", nLoginCount);
		SendMessageToPC( oPC, "Login count: " + IntToString(nLoginCount));		
		
		// Announce the game time
		SendMessageToPC( oPC, time_print_pretty());
		
		// Welcome message / MoTD
		SendMessageToPC(oPC, "Welcome to Dasaria.  Please Read the Server Rules!");
		if (GetLocalString(GetModule(),"motd") != "") DelayCommand(6.0, FloatingTextStringOnCreature("Message of the Day: "+GetLocalString(GetModule(),"motd"),oPC,FALSE));
		
		// If they left while dead, kill them again
		death_event_OnLogin( oPC );	
		
		// Set up DM & peristent anonymity
		SetLocalInt(oPC,"Scry_Anon",GetLocalInt(oJournal,"Scry_Anon"));
		if (GetIsDM(oPC)) SetLocalInt(oPC,"Scry_Anon",1);
	
		// LOG CHARACTER STATISTICS	
		LogCharacterStats(oPC);	
		
		// CURE DAKHEN CURSE
		if (persist_check_requirements(oPC, "dakhen_curse", 1))
		{
			persist_advance_single(oPC, "dakhen_curse", 1, 2, 0, "You are cured.");
			
		}
		// IF AN 2ND LEVEL+ EVIL PALADIN LOGS ON, BACK OUT THEIR CHA BONUS TO SAVES
		if (GetLocalInt(oPC,"CheckedSaves") != 1)
		{
			if ( (	GetLevelByClass(CLASS_TYPE_PALADIN,oPC) > 1 && ( GetAlignmentGoodEvil(oPC) != ALIGNMENT_GOOD || GetAlignmentLawChaos(oPC) != ALIGNMENT_LAWFUL )	)	)
			{
				SendMessageToPC(oPC, "You have forsaken the path of the righteous.  The gods turn their back on you.");
				ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectSavingThrowDecrease(SAVING_THROW_ALL,GetAbilityModifier(ABILITY_CHARISMA,oPC),SAVING_THROW_ALL)),oPC);
			}	
			SetLocalInt(oPC,"CheckedSaves",1);
		}
		
		// remove any xp_craft abortions on login
		object oXPCraftedItem = GetItemPossessedBy(oPC, "xp_craft_temp"); 
		if (GetIsObjectValid(oXPCraftedItem)) 
		{ 
			trackEvent(oPC, "XPCRAFT_DUPE", OBJECT_INVALID,0,GetGoldPieceValue(oXPCraftedItem),GetName(oXPCraftedItem),GetName(oXPCraftedItem));
			WriteTimestampedLogEntry("XP_CRAFT Duplicate Item Removed: User "+GetLocalString(oPC, "PlayerName")+" PC "+GetFirstName(oPC)+" "+GetLastName(oPC)+" CD KEY "+GetLocalString(oPC, "PlayerPublicCDKey")+" from IP: "+GetLocalString(oPC, "PlayerIPAddy")+" item "+GetName(oXPCraftedItem)+", value "+IntToString(GetGoldPieceValue(oXPCraftedItem))+"gp removed.");			
			DelayCommand(1.0f,DestroyObject(oXPCraftedItem)); 
       	} 
		
		//	ACTIVATE DMFI
		ExecuteScript( "dmfi_mod_pcload", GetModule());	
	}
	
	ResetHertitageFeatUses(oPC);
	
}

//
//	BOOTS CHARACTERS USING MOTB CLASSES OR RACES
//
void BootMotB(object oPC)
{
	int bBootPC;
	
	bBootPC = FALSE;
	if (GetClassString(GetClassByPosition(1, oPC)) == "Unsupported") bBootPC = TRUE;
	if (GetClassString(GetClassByPosition(2, oPC)) == "Unsupported") bBootPC = TRUE;
	if (GetClassString(GetClassByPosition(3, oPC)) == "Unsupported") bBootPC = TRUE;
	if (GetClassString(GetClassByPosition(4, oPC)) == "Unsupported") bBootPC = TRUE;
	if (GetSubRaceString(GetSubRace(oPC)) == "Unsupported")  bBootPC = TRUE;
	
	if (bBootPC) DisplayMessageBox(oPC, 0, "You've logged in with a class or race that is currently unsupported on Dasaria.", "gui_bootPC_ok");
}
//
//	ADDS A TAB DELIMITED STRING THE THE SERVER LOG CONTAINING CHARACTER STATISTICS
//	
void LogCharacterStats(object oPC)
{
	WriteTimestampedLogEntry("	PC STATS 1.3	" +
	GetPCPlayerName(oPC) + "	" +
	GetName(oPC) + "	" +
	GetGenderString(GetGender(oPC)) + "	" +
   	GetAlignmentLawChaosString(GetAlignmentLawChaos(oPC)) + " " +
   	GetAlignmentGoodEvilString(GetAlignmentGoodEvil(oPC)) + "	" +
	GetSubRaceString(GetSubRace(oPC)) + "	" +
	IntToString(GetXP(oPC)) + "	" +
	GetClassString(GetClassByPosition(1, oPC)) + "	" +
	IntToString(GetLevelByClass(GetClassByPosition(1, oPC), oPC)) + "	" +
	GetClassString(GetClassByPosition(2, oPC)) + "	" +
	IntToString(GetLevelByClass(GetClassByPosition(2, oPC), oPC)) + "	" +
	GetClassString(GetClassByPosition(3, oPC)) + "	" +
	IntToString(GetLevelByClass(GetClassByPosition(3, oPC), oPC)) + "	" +
	GetClassString(GetClassByPosition(4, oPC)) + "	" +
	IntToString(GetLevelByClass(GetClassByPosition(4, oPC), oPC)) + "	" +
	IntToString(value_of_equipped_items(oPC))
	);
}
//
//	RETURNS THE GENDER STRING
//
string GetGenderString(int iGender)
{
	string sGenderString;
	
	switch (iGender)
	{
		case GENDER_BOTH:
 			sGenderString = "Both";
			break;
		case GENDER_FEMALE:
 			sGenderString = "Female";
			break;
		case GENDER_MALE:
 			sGenderString = "Male";
			break;
		case GENDER_NONE:
 			sGenderString = "None";
			break;
		case GENDER_OTHER:
 			sGenderString = "Other";
			break;
	}
	
	return sGenderString;
}

void RemoveTempWeaponBuffs(object oPC)
{
    IPRemoveAllItemProperties(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC),  DURATION_TYPE_TEMPORARY);
    IPRemoveAllItemProperties(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC), DURATION_TYPE_TEMPORARY);
}

void ReQuipHands(object oPC, int bAgain = FALSE)
{
   object oRight = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
   object oLeft  = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);
   if (oRight!=OBJECT_INVALID) 
   {
      AssignCommand(oPC, ClearAllActions(TRUE));
      AssignCommand(oPC, ActionUnequipItem(oRight));
      DelayCommand(0.1, AssignCommand(oPC, ActionEquipItem(oRight, INVENTORY_SLOT_RIGHTHAND)));
      DelayCommand(1.0, AssignCommand(oPC, ActionEquipItem(oRight, INVENTORY_SLOT_RIGHTHAND)));	  
   }
   if (oLeft!=OBJECT_INVALID) 
   {
      AssignCommand(oPC, ClearAllActions(TRUE));
      AssignCommand(oPC, ActionUnequipItem(oLeft));
      DelayCommand(0.2, AssignCommand(oPC, ActionEquipItem(oLeft, INVENTORY_SLOT_LEFTHAND)));
      DelayCommand(1.0, AssignCommand(oPC, ActionEquipItem(oLeft, INVENTORY_SLOT_LEFTHAND)));	  
   }
   if (bAgain) DelayCommand(0.5, ReQuipHands(oPC, FALSE)); // DO IT A SECOND TIME
}

void ReQuip(object oPC, int nSlot, int bAgain = FALSE)
{
   object oItem = GetItemInSlot(nSlot, oPC);
   if (oItem==OBJECT_INVALID) return;
   AssignCommand(oPC, ClearAllActions(TRUE));
   AssignCommand(oPC, ActionUnequipItem(oItem));
   DelayCommand(0.1, AssignCommand(oPC, ActionEquipItem(oItem, nSlot)));
   DelayCommand(1.0, AssignCommand(oPC, ActionEquipItem(oItem, nSlot)));   
   if (bAgain) DelayCommand(0.2, ReQuip(oPC, nSlot, FALSE)); // DO IT A SECOND TIME
}

//
//	RETURNS THE SUBRACE STRING
//	
string GetSubRaceString(int iSubRace)
{
	string sSubRaceString;
	
	switch (iSubRace)
	{
		case RACIAL_SUBTYPE_GOLD_DWARF:
			sSubRaceString = "Dwarf:Gold";
			break;
		case RACIAL_SUBTYPE_GRAY_DWARF:
			sSubRaceString = "Dwarf:Gray";
			break;
		case RACIAL_SUBTYPE_SHIELD_DWARF:
			sSubRaceString = "Dwarf:Shield";
			break;
		case RACIAL_SUBTYPE_DROW:
			sSubRaceString = "Elf:Dark";
			break;
		case RACIAL_SUBTYPE_MOON_ELF:
			sSubRaceString = "Elf:Moon";
			break;
		case RACIAL_SUBTYPE_SUN_ELF:
			sSubRaceString = "Elf:Sun";
			break;
		//case RACIAL_SUBTYPE_WILD_ELF:
		//	sSubRaceString = "MotB";
		//	break;
		case RACIAL_SUBTYPE_WOOD_ELF:
			sSubRaceString = "Elf:Wood";
			break;
		case RACIAL_SUBTYPE_SVIRFNEBLIN:
			sSubRaceString = "Gnome:Deep";
			break;
		case RACIAL_SUBTYPE_ROCK_GNOME:
			sSubRaceString = "Gnome:Rock";
			break;
		case RACIAL_SUBTYPE_GHOSTWISE_HALF:
			sSubRaceString = "Halfling:Ghostwise";
			break;
		case RACIAL_SUBTYPE_LIGHTFOOT_HALF:
			sSubRaceString = "Halfling:Lightfoot";
			break;
		case RACIAL_SUBTYPE_STRONGHEART_HALF:
			sSubRaceString = "Halfling:Strongheart";
			break;
		case RACIAL_SUBTYPE_AASIMAR:
			sSubRaceString = "Aasimar";
			break;
		case RACIAL_SUBTYPE_TIEFLING:
			sSubRaceString = "Tiefling";
			break;
		case RACIAL_SUBTYPE_HALFELF:
			sSubRaceString = "Half-Elf";
			break;
		case RACIAL_SUBTYPE_HALFORC:
			sSubRaceString = "Half-Orc";
			break;
		case RACIAL_SUBTYPE_HUMAN:
			sSubRaceString = "Human";
			break;

		// Wired 4/27/09: Rather than listing out every possibility, just boot if not on above list
		default:
			sSubRaceString = "Unsupported";	
	}			
	return sSubRaceString;
}
//
//	RETURNS CLASS STRING
//	
string GetClassString(int iClass)
{
	string sClassString;
		
	switch (iClass)
	{
		case CLASS_TYPE_INVALID:
			sClassString = "";
			break;
		case CLASS_TYPE_BARBARIAN:
			sClassString = "Barbarian";
			break;
		case CLASS_TYPE_BARD:
			sClassString = "Bard";
			break;
		case CLASS_TYPE_CLERIC:
			sClassString = "Cleric";
			break;
		case CLASS_TYPE_DRUID:
			sClassString = "Druid";
			break;
		case CLASS_TYPE_FIGHTER:
			sClassString = "Fighter";
			break;
		case CLASS_TYPE_MONK:
			sClassString = "Monk";
			break;
		case CLASS_TYPE_PALADIN:
			sClassString = "Paladin";
			break;
		case CLASS_TYPE_RANGER:
			sClassString = "Ranger";
			break;
		case CLASS_TYPE_ROGUE:
			sClassString = "Rogue";
			break;
		case CLASS_TYPE_SORCERER:
			sClassString = "Sorcerer";
			break;
		case CLASS_TYPE_WIZARD:
			sClassString = "Wizard";
			break;
		case CLASS_TYPE_SHADOWDANCER:
			sClassString = "Shadowdancer";
			break;
		case CLASS_TYPE_HARPER:
			sClassString = "Harper";
			break;
		case CLASS_TYPE_ARCANE_ARCHER:
			sClassString = "Arcane Archer";
			break;
		case CLASS_TYPE_ASSASSIN:
			sClassString = "Assassin";
			break;
		case CLASS_TYPE_BLACKGUARD:
			sClassString = "Blackguard";
			break;
		case CLASS_TYPE_DIVINECHAMPION:
			sClassString = "Divine Champion";
			break;
		case CLASS_TYPE_WEAPON_MASTER:
			sClassString = "Weapon Master";
			break;
		case CLASS_TYPE_PALEMASTER:
			sClassString = "Palemaster";
			break;
		case CLASS_TYPE_SHIFTER:
			sClassString = "Shifter";
			break;
		case CLASS_TYPE_DWARVENDEFENDER:
			sClassString = "Dwarven Defender";
			break;
		case CLASS_TYPE_DRAGONDISCIPLE:
			sClassString = "Red Dragon Disciple";
			break;
		case CLASS_TYPE_WARLOCK:
			sClassString = "Warlock";
			break;
		case CLASS_TYPE_ARCANETRICKSTER:
			sClassString = "Arcane Trickster";
			break;
		case CLASS_TYPE_FRENZIEDBERSERKER:
			sClassString = "Frenzied Berserker";
			break;
		case CLASS_TYPE_SHADOWTHIEFOFAMN:
			sClassString = "Shadow Thief of Amn";
			break;
		case CLASS_NWNINE_WARDER:
			sClassString = "Neverwinter Nine";
			break;
		case CLASS_TYPE_DUELIST:
			sClassString = "Duelist";
			break;
		case CLASS_TYPE_WARPRIEST:
			sClassString = "Warpriest";
			break;
		case CLASS_TYPE_ELDRITCH_KNIGHT:
			sClassString = "Eldritch Knight";
			break;
		
		// Supported MOTB Classes
		case CLASS_TYPE_FAVORED_SOUL:
			sClassString = "Favoured Soul";
			break;		
		case CLASS_TYPE_SPIRIT_SHAMAN:
			sClassString = "Spirit Shaman";
			break;
		
		// Wired 4/27/09: Supported SOZ Classes
		case CLASS_TYPE_SWASHBUCKLER:
			sClassString = "Swashbuckler";
			break;
		case CLASS_TYPE_HELLFIRE_WARLOCK:
			sClassString = "Hell Fire Warlock";
			break;
									
		// Wired 4/27/09: Rather than listing out every possibility, just boot if not on above list
		default:
			sClassString = "Unsupported";
	}	
	return sClassString;
}	

int reserve_get_limit()
{
	return 45;
}

int	 reserve_count_online()
{
	int	i = 0;
	object oPC = GetFirstPC();
	while ( GetIsObjectValid( oPC ) )
	{
		++i;
		oPC = GetNextPC();
	}
	return i;
}

int reserve_check(object oPC)
{
	// DMs can always log in
	if ( GetIsDM( oPC ) )
		return TRUE;

	return GetIsStaff(oPC);			
}




	
/* 


	//	BOOT CHARACTERS WITH MOTB CLASSES OR RACES - UNLESS YOU ARE ON STAFF
	//	AS LONG AS ECL IS RUNNING WE DON'T NEED THIS
	//	BootMotB(oPC);

//wired: moved these to d2_sql because they're needed
//there and it's included here anyway
//string GetAlignmentGoodEvilString(int iAlignment);
//string GetAlignmentLawChaosString(int iAlignment);

//JODY BAG REMOVAL REMOVE THIS ONCE 1.04 HAS BEEN RELEASED 
void remove_bags(object oPC) 
	{ 
	object bagx1 = GetItemPossessedBy(oPC, "das_item_travpack1"); 
	if (GetIsObjectValid(bagx1)) 
		{ 
        DestroyObject(bagx1); 
       	} 
	object bagx2 = GetItemPossessedBy(oPC, "das_item_travpack2"); 	
	if (GetIsObjectValid(bagx2)) 
		{ 
		DestroyObject(bagx2); 
		} 
	object bag1 = GetItemPossessedBy(oPC, "NW_IT_CONTAIN001");
	if (GetIsObjectValid(bag1)) 
		{ 
		DestroyObject(bag1);
		} 
	object bag2 = GetItemPossessedBy(oPC, "NW_IT_CONTAIN002");
	if (GetIsObjectValid(bag2)) 
		{ 
		DestroyObject(bag2); 
		} 
	object bag3 = GetItemPossessedBy(oPC, "NW_IT_CONTAIN003");
	if (GetIsObjectValid(bag3)) 
		{ 
		DestroyObject(bag3); 
		} 
	object bag4 = GetItemPossessedBy(oPC, "NW_IT_CONTAIN004");
	if (GetIsObjectValid(bag4)) 
		{ 
		DestroyObject(bag4); 
		} 
	object bag5 = GetItemPossessedBy(oPC, "NW_IT_CONTAIN005");
	if (GetIsObjectValid(bag5)) 
		{ 
		DestroyObject(bag5); 
		} 
	object bag6 = GetItemPossessedBy(oPC, "NW_IT_CONTAIN006");
	if (GetIsObjectValid(bag6)) 
		{ 
		DestroyObject(bag6); 
		} 
      }
	  
/*
//
//	RETURNS THE LAWFUL / CHAOTIC ALIGNMENT STRING
//
string GetAlignmentLawChaosString(int iAlignment)
{
	string sAlignmentString;
	
	switch (iAlignment)
	{
		case ALIGNMENT_CHAOTIC:
 			sAlignmentString = "Chaotic";
			break;
		case ALIGNMENT_LAWFUL:
 			sAlignmentString = "Lawful";
			break;
		case ALIGNMENT_NEUTRAL:
 			sAlignmentString = "Neutral";
			break;
	}
	
	return sAlignmentString;
}
//
//	RETURNS THE GOOD / EVIL ALIGNMENT STRING
//
string GetAlignmentGoodEvilString(int iAlignment)
{
	string sAlignmentString;
	
	switch (iAlignment)
	{
		case ALIGNMENT_EVIL:
 			sAlignmentString = "Evil";
			break;
		case ALIGNMENT_GOOD:
 			sAlignmentString = "Good";
			break;
		case ALIGNMENT_NEUTRAL:
 			sAlignmentString = "Neutral";
			break;
	}
	
	return sAlignmentString;
}
	// Announce version - Not used.
	// SendMessageToPC( oPC, "Script Version: " + IntToString(core_version_major) + "." + IntToString(core_version_minor) );
				
	string sHPVarName = GetName(oPC) + "_HP";
	string sHPInitName = GetName(oPC) + "_Init";
	
	if ( GetLocalInt(GetModule(),sHPInitName) == 1) 
	{
		int nLastHP = GetLocalInt(OBJECT_SELF,sHPVarName);
		SendMessageToPC(oPC,"Current hitpoints calibrated to last logout, " + IntToString(nLastHP) + " HP.");
		effect eDamage = EffectDamage(GetCurrentHitPoints(oPC) - nLastHP, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_PLUS_FIVE,TRUE);
		ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPC);

    } 
	else 
	{
       // First time they signed on, don't kill them!
		SendMessageToPC(oPC,"Current hitpoints initiated.");
		SetLocalInt(OBJECT_SELF,sHPVarName,GetCurrentHitPoints(oPC));
		SetLocalInt(OBJECT_SELF,sHPInitName,1);
    }
 		// restore spells
        if(GetIsSpellCaster(oPC))
        DecrementSpells(oPC);
		
	// If they left while dead, kill them again
	death_event_OnLogin( oPC );		
	
*/		