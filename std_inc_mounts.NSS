// std_inc_mounts
//
// BETA .02
// wired 2012/02/10
// wired 08/04/2012 add new races up to planetouched

/*

	oMount and nMountType localvars will always refer the PCs current, or most recently-ridden mount
	oRider localvar on a mount is a reference to the current/last PC to have ridden it

*/

#include "x0_i0_position"
#include "std_persist_i0"
#include "nw_i0_plot"
#include "sfpb_config"
#include "d2_sql"
#include "ginc_das_jail"
#include "std_i0_misc"

const int bDEBUG_mounts = FALSE;
const int bRequireRideSkill = TRUE;

// price of mounts
const int nMOUNT_C1_PRICE = 1000;
const int nMOUNT_C2_PRICE = 2500;
const int nMOUNT_C3_PRICE = 5000;
const int nMOUNT_C4_PRICE = 10000;

const int nMOUNT_C5_PRICE = 1000;
const int nMOUNT_C6_PRICE = 2500;
const int nMOUNT_C7_PRICE = 5000;
const int nMOUNT_C8_PRICE = 10000;

// minimum required ride skill
const int nMOUNT_C1_RIDE  = 1;
const int nMOUNT_C2_RIDE  = 7;
const int nMOUNT_C3_RIDE  = 11;	
const int nMOUNT_C4_RIDE  = 17;

const int nMOUNT_C5_RIDE  = 1;
const int nMOUNT_C6_RIDE  = 7;
const int nMOUNT_C7_RIDE  = 11;
const int nMOUNT_C8_RIDE  = 17;

// size of mounts
const int nMOUNT_C1_SIZE  = 3;
const int nMOUNT_C2_SIZE  = 3;
const int nMOUNT_C3_SIZE  = 3;
const int nMOUNT_C4_SIZE  = 3;

const int nMOUNT_C5_SIZE  = 2;
const int nMOUNT_C6_SIZE  = 2;
const int nMOUNT_C7_SIZE  = 2;
const int nMOUNT_C8_SIZE  = 2;


// maximum speed
const float fMOUNT_C1_MAX_SPEED = 1.25;
const float fMOUNT_C2_MAX_SPEED = 1.50;
const float fMOUNT_C3_MAX_SPEED = 1.75;
const float fMOUNT_C4_MAX_SPEED = 2.00;

const float fMOUNT_C5_MAX_SPEED = 1.25;
const float fMOUNT_C6_MAX_SPEED = 1.50;
const float fMOUNT_C7_MAX_SPEED = 1.75;
const float fMOUNT_C8_MAX_SPEED = 2.00;

// special entry for paladin mounts
const float fMOUNT_C0_MAX_SPEED = 2.00;

const float fReSaleValue = 0.5;			// % of original value NPC will pay to re-purchse mount 

/////////////////////////////////
// prototypes

// get creature size from type
int GetMountSize(int nMountType);

// check if pc is mounted; should be persisted
int GetIsMounted(object oPC);

// is this a mount?  for setting up context menu mostly...
int GetIsMount(object oTarget);

// block mounted transition into interior areas unless so marked
int GetCanTransition(object oPC, object oArea, int bParty = FALSE);

// saddle up! can be called from convo or gui
void ActionMount(object oMount, int nType);

// ensure PC gets into the saddle
void DelayedEquipSaddle(object oPC, object oSaddle);

// the purpose of this is to avoid destroying creature
// before the PC has gotten close enough to it
// void DelayedRecursiveDestroyMount(object oPC, object oMount);

// get off that unicorn! can be called from unequip or gui
void ActionDismount(object oPC, object oSaddle = OBJECT_INVALID);

// do some sanity checking when a PC re-enters the mod after reset
void MountedPCCleanUp(object oPC);

// forward and backward checking of appearance & subrace
int GetRaceApp(object oPC, int nRace, int bTrueApp = FALSE);

// shift PC appearance
void SetMountedAppearance(object oPC, int nReverse = FALSE);

// restore PC appearance
void RemoveMountedAppearance(object oPC);

// apply various effects while mounted (WIP)
void ApplyMountedEffects(object oPC);

// turn of any action modes like hellfire or combat expertise
void SetActionModesOff(object oPC);

// strip any unwanted spell effects
void RemoveSpecificSpellEffect(object oPC, int nSpellID);

// remove mounted effects on dismount
void RemoveMountedEffects(object oPC);

// get creature max speed 
float GetMountMaxModifier(int nMountType);

// ride skill bonus
void SetMountedMovementModifier(object oPC);

// get required ranks to mount creature
int GetRequiredRanks(int nMountType);

// conditionals for mounting an object
int CheckRide(object oPC, object oMount = OBJECT_INVALID);

// mounted spellcasting hook
int CheckMountedSpell(object oPC, int nSpellID);

// borrowed from ga_destroy_item
void DestroyItems(object oTarget,string sItem,int nNumItems);

// limit ui while riding
void ActivateRideUI(object oPC);

// restore to normal ui
void DeactivateRideUI(object oPC);

// get the purchase price of a mount
int GetMountPrice(int class);

// set convo tokens for mount prices
void SetMountPriceTokens();

// do I own any mount?  returns mount type or zero
int GetMountType(object oPC);

// is this my mount?
int CheckMountOwner(object oPC, object oMount);

// buy mount
void BuyMount(object oPC, int class);

// calculate resale value and populate tokens
void GetMountResaleValue(object oPC);

// sell mount
void SellMount(object oPC);

// spawn mount at location
object SpawnMount(object oPC, int nMountType, location lLoc);

// if i leave the area, limbo my mount
void SendMountToLimbo(object oPC, object oArea);

// when i return to an area where i left my mount, restore it
void FetchMountFromLimbo(object oPC);

// pc has died while mounted
void OnMountedPCDeath(object oPC);

// remove references to mount on death
void OnMountDeath(object oMount);

// delete horse from db
void RemoveMount(object oPC);

// entering a stable, spawn my mount
void SpawnMountIfNeeded(object oPC);

// used in horse theft
void XferMountOwner(object oNewOwner, int nMountType, object oOldOwner);

// Steal this horse
void ActionStealMount(object oPC, object oMount);

void ActionMountedCombatStop(object oCreature);

void DetermineMountedCombatRound(object oIntruder, object oCreature);

// paladin mount functions
void SummonMount();
void NameSummonedMount(object oPC, object oTarget);
void SetUpSummonedMount(object oPC);


/////////////////////////////////
// implementation

// get mount size from type
int GetMountSize(int nMountType)
{
	int nMountSize = 3;
	
	if (bDEBUG_mounts) SendMessageToPC(GetFirstPC(),"DEBUG: GetMountSize() received nMountType "+IntToString(nMountType));
	
	switch (nMountType)
	{
		case 1: nMountSize = nMOUNT_C1_SIZE; break;
		case 2: nMountSize = nMOUNT_C2_SIZE; break;
		case 3: nMountSize = nMOUNT_C3_SIZE; break;
		case 4: nMountSize = nMOUNT_C4_SIZE; break;
		
		case 5: nMountSize = nMOUNT_C5_SIZE; break;
		case 6: nMountSize = nMOUNT_C6_SIZE; break;
		case 7: nMountSize = nMOUNT_C7_SIZE; break;		
		case 8: nMountSize = nMOUNT_C8_SIZE; break;							
		default:
			nMountSize = 3;
	}
	if (bDEBUG_mounts) SendMessageToPC(GetFirstPC(),"DEBUG: GetMountSize() returning nMountSize "+IntToString(nMountSize));
	return nMountSize;
}

// get required ranks to mount creature
int GetRequiredRanks(int nMountType)
{
	int nRanks = 0;
	
	switch (nMountType)
	{
		case 1: nRanks = nMOUNT_C1_RIDE; break;
		case 2: nRanks = nMOUNT_C2_RIDE; break;
		case 3: nRanks = nMOUNT_C3_RIDE; break;
		case 4: nRanks = nMOUNT_C4_RIDE; break;
		
		case 5: nRanks = nMOUNT_C5_RIDE; break;
		case 6: nRanks = nMOUNT_C6_RIDE; break;
		case 7: nRanks = nMOUNT_C7_RIDE; break;		
		case 8: nRanks = nMOUNT_C8_RIDE; break;							
		default:
			nRanks = 0;
	}
	return nRanks;
}

int GetMountPrice(int class)
{
	int nPrice = 0;
	
	switch (class)
	{
		case 1: nPrice = nMOUNT_C1_PRICE; break;
		case 2: nPrice = nMOUNT_C2_PRICE; break;
		case 3: nPrice = nMOUNT_C3_PRICE; break;
		case 4: nPrice = nMOUNT_C4_PRICE; break;
		
		case 5: nPrice = nMOUNT_C5_PRICE; break;
		case 6: nPrice = nMOUNT_C6_PRICE; break;
		case 7: nPrice = nMOUNT_C7_PRICE; break;		
		case 8: nPrice = nMOUNT_C8_PRICE; break;							
		default:
			nPrice = 0;
	}
	return nPrice;
}

// get creature max speed 
float GetMountMaxModifier(int nMountType)
{
	float fModifier = 1.0;
	
	switch (nMountType)
	{
		case 0: fModifier = fMOUNT_C0_MAX_SPEED; break;
	
		case 1: fModifier = fMOUNT_C1_MAX_SPEED; break;
		case 2: fModifier = fMOUNT_C2_MAX_SPEED; break;
		case 3: fModifier = fMOUNT_C3_MAX_SPEED; break;
		case 4: fModifier = fMOUNT_C4_MAX_SPEED; break;
		
		case 5: fModifier = fMOUNT_C5_MAX_SPEED; break;
		case 6: fModifier = fMOUNT_C6_MAX_SPEED; break;
		case 7: fModifier = fMOUNT_C7_MAX_SPEED; break;		
		case 8: fModifier = fMOUNT_C8_MAX_SPEED; break;							
		default:
			fModifier = 1.0;
	}
	return fModifier;
}

void SetMountPriceTokens()
{
	SetCustomToken(9034691,IntToString(GetMountPrice(1)));
	SetCustomToken(9034692,IntToString(GetMountPrice(2)));
	SetCustomToken(9034693,IntToString(GetMountPrice(3)));
	SetCustomToken(9034694,IntToString(GetMountPrice(4)));
	
	SetCustomToken(9034695,IntToString(GetMountPrice(5)));
	SetCustomToken(9034696,IntToString(GetMountPrice(6)));
	SetCustomToken(9034697,IntToString(GetMountPrice(7)));
	SetCustomToken(9034697,IntToString(GetMountPrice(8)));	
}

int GetIsMounted(object oPC)
{
	if (bDEBUG_mounts) SendMessageToPC(oPC,"DEBUG: GetIsMounted() Running!");
	
	object oJournal = std_journal_get( oPC );
	if (GetIsObjectValid(oJournal) )
	{
		return GetLocalInt(oJournal,"nIsMounted");
	}
	else
	{
		return GetLocalInt(oPC,"nIsMounted"); 
	}
}

int GetIsMount(object oTarget)
{

	if (bDEBUG_mounts) SendMessageToPC(GetFirstPC(),"DEBUG: GetIsMount Running!");
	
	string sTag = GetTag(oTarget);

	if (!GetIsObjectValid(oTarget)) return FALSE;
	
	if (GetStringLeft(sTag,8) == "d2_mount" || GetStringLeft(sTag,13) == "c_ancom_horse" )
	{
		if (bDEBUG_mounts) SendMessageToPC(GetFirstPC(),"DEBUG: Creature Tag was either d2_mount nor c_ancom_horse.");
		return TRUE;
	}

		if (bDEBUG_mounts) SendMessageToPC(GetFirstPC(),"DEBUG: Creature Tag was NEITHER d2_mount nor c_ancom_horse!");
	return FALSE;
}

int GetCanTransition(object oPC, object oArea, int bParty = FALSE)
{
	if (bDEBUG_mounts) SendMessageToPC(oPC,"DEBUG: GetCanTransition() Running!");
	
	object oPartyMem;
	object oAssociate = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oPC);	
	int bStop = FALSE;;
	
	// prevent transition to interior area, unless marked otherwsie	
	if ( (	GetIsAreaInterior(oArea) && GetLocalInt(oArea,"nAllowMountedTransition") !=1)) bStop = TRUE;
	
	// prevent transition to any area, if marked disallow
	if (GetLocalInt(oArea,"nDisallowMounts") == 1) bStop = TRUE;
	
	if (bStop == TRUE)
	{
		if (GetIsMounted(oPC))
		{
			SendMessageToPC(oPC,"You must dismount to enter this area");
			return FALSE;
		}
		
		if (bParty == TRUE)
		{
			oPartyMem = GetFirstFactionMember(oPC);
			while (GetIsObjectValid(oPartyMem))
			{			
				if (GetIsMounted(oPartyMem))
				{
					FloatingTextStringOnCreature("You must dismount to enter this area.",oPC,TRUE);
					return FALSE;
				}
			
				oPartyMem = GetNextFactionMember(oPC);
			}		
		}
	}	

	// at this point the PC will transition; deal 
	// with any mounts that are animal companions
	if ( 	GetIsObjectValid(oAssociate) && 					// there is a companion
			GetIsMount(oAssociate) &&							// and it's a mount
			GetIsAreaInterior(oArea) && 						// and you're headed for an interior
			GetLocalInt(oArea,"nAllowMountedTransition") !=1	// where mounts aren't explicitly permitted
		)
	{
		if (bDEBUG_mounts) SendMessageToPC(oPC,"DEBUG: Running the GetCanTransition Destroy code to get rid of mount.");
		SetLocalInt(oAssociate,"bLimboed",TRUE);
		SetLocalString(oPC,"sAreaParkedMount",GetTag(oArea));
		SetLocalInt(oPC,"PallyParkedMount",1);				
		RemoveSummonedAssociate(oPC,oAssociate);
		DelayCommand(2.0,RemoveSummonedAssociate(oPC,oAssociate));	
		DestroyObject(oAssociate);
		DelayCommand(2.0,DestroyObject(oAssociate));
		OnMountDeath(oPC);
	}
	
	return TRUE;
}

// NB: run by OBJECT_SELF
void ActionMount(object oMount, int nMountType)
{
	object oSaddle;
	object oCloak;
	object oPC = OBJECT_SELF;
	object oJournal = std_journal_get( oPC ); 
	object oWP;
	location lMountLoc = GetLocation(oMount);
	location lMountFromLoc = GetStepLeftLocation(oMount);
	vector vTarget = GetPosition(oMount);
	effect eDamageShare;
	
	if (bDEBUG_mounts) SendMessageToPC(oPC,"DEBUG: ActionMount() Running!");
	
	if (!GetIsObjectValid(oMount)) 
	{
		SendMessageToPC(oPC,"Object not Valid!");
		return;
	}
	
	// save reference to item in cloak slot
	oCloak = GetItemInSlot(INVENTORY_SLOT_CLOAK);
	if (GetIsObjectValid(oCloak))
	{
		SetLocalObject(oPC,"oCloakInSlotPriorToMount",oCloak);
	}

	// skip check on paladin mount his own companion
	if (nMountType != 0)
	{
		if (!CheckRide(oPC,oMount)) return;
	}
	
	// stop mount from moving
	AssignCommand(oMount,ClearAllActions()); 
	SetCommandable(FALSE,oMount);
	
	// run to side of horse working around buggy actionmovetoloc 
	oWP = CreateObject(OBJECT_TYPE_WAYPOINT,"NW_WAYPOINT001",lMountFromLoc,FALSE);
	ActionMoveToObject(oWP,TRUE);
	
	// face the horse
	ActionDoCommand(SetFacingPoint(vTarget));
	
	// play some animation?
	//PlayAnimation(ANIMATION_FIREFORGET_ACTIVATE);
	
	// create saddle item surreptitiously  
	oSaddle = CreateItemOnObject("d2_saddle"+IntToString(nMountType),oPC,1,"d2_saddle",FALSE);
		
	ActionEquipItem(oSaddle,INVENTORY_SLOT_CLOAK);

	// mounting PC is now 'oRider' of mount for reference
	// not to be confused with legal ownership
	SetLocalObject(oMount,"oRider",oPC);	
	
	// destroy mount (takes a second)
	DelayCommand(1.0f,SendCreatureToLimbo(oMount));
	//DelayedRecursiveDestroyMount(oPC,oMount);
	
	// jump pc to horse previous location
	//DelayCommand(1.0,ActionJumpToLocation(lMountLoc));
	ActionJumpToLocation(lMountLoc);
	
	// these are references to the last creature mounted
	// only relevant intra-reset, so use local vars
	SetLocalInt(oPC, "nMountType", nMountType);
	SetLocalObject(oPC,"oMount",oMount);  
	
	DelayCommand(2.0,DelayedEquipSaddle(oPC,oSaddle));

	DestroyObject(oWP);
			
	ActionDoCommand(SetCommandable(TRUE));
	SetCommandable(FALSE);
}

void DelayedEquipSaddle(object oPC, object oSaddle)
{
	if (bDEBUG_mounts) SendMessageToPC(oPC,"DEBUG: DelayedEquipSaddle() Running!");
	
	if (	GetTag(GetItemInSlot(INVENTORY_SLOT_CLOAK,oPC)) != "d2_saddle"	)
	{
		AssignCommand(oPC,ActionEquipItem(oSaddle,INVENTORY_SLOT_CLOAK));
	}
}

void MountedPCCleanUp(object oPC)
{
	if (bDEBUG_mounts) SendMessageToPC(oPC,"DEBUG: OnMountedPCCleanUp() Running!");
	
	int nCurrentApp 	= GetAppearanceType(oPC); 
	int nRace 			= GetSubRace(oPC);  
	int nTrueApp  		= GetRaceApp(oPC,nRace,TRUE);
	object oJournal 	= std_journal_get( oPC );
	int nJournaledApp 	= GetLocalInt(oJournal,"nOriginalAppearance");
	
	if (bDEBUG_mounts) SendMessageToPC(oPC,"DEBUG: Sanity Check, Correcting Appearance!");
		
	AssignCommand(GetModule(),DestroyObject(GetLocalObject(oPC,"oSaddle")));
		
	// update journaled appearance
	if (nJournaledApp >=4012)
	{
		if (bDEBUG_mounts) SendMessageToPC(oPC,"DEBUG: Correcting invalid stored appearance!");
		SetLocalInt(oJournal,"nOriginalAppearance", nTrueApp);
	}
	
	// fix appearance
	if (nCurrentApp >=4012)
	{
		// set correct appearance
		if (bDEBUG_mounts) SendMessageToPC(oPC,"DEBUG: Setting True Appearance to "+IntToString(nTrueApp));
		SetCreatureAppearanceType(oPC, nTrueApp);
	}
		
	// update vars
	SetLocalInt(oJournal,"nIsMounted", FALSE);
	DeleteLocalObject(oPC,"oMount");
		
	// destroy any saddles
	if (bDEBUG_mounts) SendMessageToPC(oPC,"DEBUG: Destroying any saddles found!");
	DestroyItems( oPC,"d2_saddle",-1);
		
	// fix any effects
	RemoveMountedEffects(oPC);
}

int GetRaceApp(object oPC, int nRace, int bTrueApp = FALSE)
{
	int nHorseApp =	-1;
	int nTrueApp  = -1;
	
	switch (nRace)
	{
      case RACIAL_SUBTYPE_HALFORC:			nHorseApp = 4012; nTrueApp = 0; break;
      case RACIAL_SUBTYPE_ROCK_GNOME:		nHorseApp = 4013; nTrueApp = 2; break;
      case RACIAL_SUBTYPE_HUMAN:            nHorseApp = 4014; nTrueApp = 6; break;
      case RACIAL_SUBTYPE_LIGHTFOOT_HALF:	nHorseApp = 4015; nTrueApp = 3; break;
      case RACIAL_SUBTYPE_HALFELF:			nHorseApp = 4016; nTrueApp = 4; break;
      case RACIAL_SUBTYPE_SHIELD_DWARF:		nHorseApp = 4017; nTrueApp = 0; break;
      case RACIAL_SUBTYPE_MOON_ELF:			nHorseApp = 4018; nTrueApp = 1; break;
      case RACIAL_SUBTYPE_AASIMAR:			nHorseApp = 4019; nTrueApp = 563; break;
      case RACIAL_SUBTYPE_TIEFLING:			nHorseApp = 4020; nTrueApp = 564; break;
      case RACIAL_SUBTYPE_SUN_ELF:			nHorseApp = 4021; nTrueApp = 1; break;
      case RACIAL_SUBTYPE_WOOD_ELF:			nHorseApp = 4022; nTrueApp = 1; break;
      case RACIAL_SUBTYPE_DROW:				nHorseApp = 4023; nTrueApp = 1; break;
      case RACIAL_SUBTYPE_SVIRFNEBLIN:		nHorseApp = 4024; nTrueApp = 568; break;
      case RACIAL_SUBTYPE_GOLD_DWARF:		nHorseApp = 4025; nTrueApp = 569; break;
      case RACIAL_SUBTYPE_GRAY_DWARF:		nHorseApp = 4026; nTrueApp = 570; break;
      case RACIAL_SUBTYPE_STRONGHEART_HALF:	nHorseApp = 4027; nTrueApp = 3; break;
	  
	  // new dasarian races
	   // humans
	   case 67:
	   case 68:
	   case 69:
	   case 70:
	   case 71:
	   case 72:
	   case 73:
	   case 74:
	   case 75:
	   case 76:
	   nHorseApp = 4014; nTrueApp = 6; break;
	   // dwarves
	   case 77:
	   case 78:
	   case 79:
	   nHorseApp = 4025; nTrueApp = 569; break;
	   // elves
	   case 80:
	   case 81:
	   case 82:
	   nHorseApp = 4018; nTrueApp = 1; break;
	   // gnomes
	   case 83:
	   case 84:
	   nHorseApp = 4013; nTrueApp = 2; break;
	   // halflings
	   case 85:
	   case 86:
       nHorseApp = 4015; nTrueApp = 3; break;
	   // h'elves
	   case 87:
	   case 88:
	   nHorseApp = 4016; nTrueApp = 4; break;
	   // h'orcs
	   case 89: 
	   case 90:
	   case 91:
	   case 92:
	   nHorseApp = 4012; nTrueApp = 0; break;	   

	   // planetouched
	   case 93:
	   case 94:
	   case 95:
	   case 96:
	   case 97:
	   case 99:
	   case 100:
	   nHorseApp = 4014; nTrueApp = 6; break;
	  
	  /*
      case RACIAL_SUBTYPE_EARTH_GENASI:		nHorseApp = 4028; break;
      case RACIAL_SUBTYPE_FIRE_GENASI:		nHorseApp = 4029; break;
      case RACIAL_SUBTYPE_AIR_GENASI:		nHorseApp = 4030; break;
      case RACIAL_SUBTYPE_WATER_GENASI:		nHorseApp = 4031; break;
      case RACIAL_SUBTYPE_HALFDROW:			nHorseApp = 4032; break;  
	 */    
	}   
	
  	if (bTrueApp) return nTrueApp; 
	else return nHorseApp;
}

void SetMountedAppearance(object oPC, int bReverse = FALSE)
{
	if (bDEBUG_mounts) SendMessageToPC(oPC,"DEBUG: SetMountedAppearance() Running!");
	
	object oJournal = std_journal_get( oPC );  
	int bJournal = GetIsObjectValid(oJournal);
	int nHorseApp =-1;
	int nTrueApp =-1;	
	int nRace = GetSubRace(oPC);  
	int nOrigApp = GetAppearanceType(oPC); 
	int nJournaledApp;
	
	nHorseApp = GetRaceApp(oPC,nRace,FALSE);
	nTrueApp  = GetRaceApp(oPC,nRace,TRUE);
	
   // somebody's got the wrong orignal appearance saved, correct it here
	if (nJournaledApp >= 4012)  
	{
      	if (GetIsObjectValid(oJournal)) SetLocalInt(oJournal,"nOriginalAppearance", nTrueApp);
		else SetLocalInt(oPC, "nOriginalAppearance", nTrueApp);	
	}
	
	// no weird stuff getting on a mount
	if (GetIsShapechanged(oPC) == TRUE)
	{
	  	SendMessageToPC(oPC, "Cannnot mount while polymorphed or in wildshape.");
      	return;
	}
	
	// no resized people getting on mounts
	if (GetHasSpellEffect(SPELL_ENLARGE_PERSON,oPC) || GetHasSpellEffect(VFX_HIT_SPELL_REDUCE_PERSON,oPC))
	{
		SendMessageToPC(oPC, "You're not the right size to mount that creature!");
      	return;	
	}	
	
	// process special instruction to revert appearance
	if (bReverse == TRUE)
	{	
		// otherwise use the imputed original appearance from subrace
		if (bDEBUG_mounts) SendMessageToPC(oPC,"DEBUG: Restoring Imputed Appearance!");
		
		   // panic!
		   if (nTrueApp == -1)
		   { 
		      SendMessageToPC(oPC, "Error: Contact a DM for manual appearance change.");
		      return;
		   }		
		
	   	SetCreatureAppearanceType(oPC, nTrueApp);
		return;
   }
   
   // panic!
   if (nHorseApp == -1)
   { 
      SendMessageToPC(oPC, "Your species cannot cannot mount this creature.");
      return;
   }
   
   // don't overwrite their stored appearance type if this a forced requip
   if (GetLocalInt(oPC,"nForceRequip") != TRUE)
   {
      	if (bJournal)
		{
		   SetLocalInt(oJournal,"nOriginalAppearance", nOrigApp);
		   SetLocalInt(oJournal,"nIsMounted",TRUE);
		}
		else
		{
		   SetLocalInt(oPC, "nOriginalAppearance", nOrigApp);
		   SetLocalInt(oPC,"nIsMounted",TRUE);		
		}
	}
	else
	{
		// clear the temporary var set in the _ue
		DeleteLocalInt(oPC,"nForceRequip");
		// the PC is mounted again, so make sure var says so
		if (bJournal) SetLocalInt(oPC,"nIsMounted",TRUE);
		else SetLocalInt(oJournal,"nIsMounted",TRUE);
	}
	
	SetCreatureAppearanceType(oPC, nHorseApp);
	ApplyMountedEffects(oPC);
	ActivateRideUI(oPC);
}

void RemoveMountedAppearance(object oPC)
{
	if (bDEBUG_mounts) SendMessageToPC(oPC,"DEBUG: RemoveMountedAppearance() Running!");
	
	object oJournal = std_journal_get( oPC );
	int nRace = GetSubRace(oPC); 
	int nOrigApp;
	
	if (GetIsObjectValid(oJournal))
	{
		nOrigApp = GetLocalInt(oJournal, "nOriginalAppearance");
		SetLocalInt(oJournal,"nIsMounted",FALSE);
	}
	else
	{
		nOrigApp = GetLocalInt(oPC, "nOriginalAppearance");
		SetLocalInt(oPC,"nIsMounted",FALSE);
	}
	
	// failsafe here for illogical value of previous appearance
	if (nOrigApp >= 4012)
	{
		nOrigApp = GetRaceApp(oPC,nRace,TRUE);
	}
	
	SetCreatureAppearanceType(oPC, nOrigApp);
	DeactivateRideUI(oPC);	
}

void ActionDismount(object oPC, object oSaddle = OBJECT_INVALID)
{
	if (bDEBUG_mounts) SendMessageToPC(oPC,"DEBUG: ActionDismount() Running!");
	
	SetCollision(oPC,FALSE);
	
	object oJournal = std_journal_get( oPC );
	object oCloak;
	object oMount;	
	int nMountType;
	location lLocPCDismountTo = GetStepLeftLocation(oPC);
	location lCurLocMount = GetLocation(oPC);

	oCloak = GetLocalObject(oPC,"oCloakInSlotPriorToMount");
	oMount = GetLocalObject(oPC,"oMount");


	// if passed oSaddle isn't valid, destroy all saddles in PCs inventory
	if (!GetIsObjectValid(oSaddle))
	{
		DestroyItems( oPC,"d2_saddle",-1);
	}
	// if saddle was valid, create a horse creature
	else
	{
		RecallCreatureFromLimboToLocation(oMount,lCurLocMount);
		// they might be a hidden companion, so do this too
		AssignCommand(oMount,JumpToObject(oPC,FALSE));
		SetScriptHidden(oMount,FALSE,FALSE);		
	}	
		        
	RemoveMountedAppearance(oPC);		 
	AssignCommand(oPC,JumpToLocation(lLocPCDismountTo));
	DestroyObject(oSaddle,0.0f,FALSE);
	
	// requip item to cloak slot using saved reference
	if (	GetIsObjectValid(oCloak) && GetItemPossessor(oCloak) == oPC	)
	{
		ActionEquipItem(oCloak,INVENTORY_SLOT_CLOAK);
		AssignCommand(oPC,	ActionEquipItem(oCloak,INVENTORY_SLOT_CLOAK));
		DelayCommand(1.5,ActionEquipItem(oCloak,INVENTORY_SLOT_CLOAK));
		DelayCommand(3.0,AssignCommand(oPC,	ActionEquipItem(oCloak,INVENTORY_SLOT_CLOAK)));
	}
	RemoveMountedEffects(oPC);
	DelayCommand(1.0,RemoveMountedAppearance(oPC));	   // double check
	DeleteLocalInt(oPC,"nMountType");
	SetCollision(oPC,TRUE);
}

/*
Armor class: 
If the horse has a higher armor class than the rider, the rider is given a natural armor bonus equal to the difference in armor class.
Hit points: 
The rider receives half the hit points of the horse in the form of temporary hit points.
Skill decrease: 
The rider receives a -50 penalty to disable trap, hide, move silently, open lock, pick pocket, set trap, and tumble while riding. (The armor class bonus from tumble is not negated.)
*/
void ApplyMountedEffects(object oPC)
{
	if (bDEBUG_mounts) SendMessageToPC(oPC,"DEBUG: ApplyMountedEffects() Running!");
	
	int nPCAC = GetAC(oPC);
	int nPCHP = GetCurrentHitPoints(oPC);
	int nACMod = 0;
	int nHPMod = 0;	
	float fSpeed =9.0;
	float fBonus = 0.0;
	effect eLink;
	effect eACIncrease;
	effect eHPIncrease;
	effect eHeal;
	effect eSkillDecreaseDT = EffectSkillDecrease(SKILL_DISABLE_TRAP,50);
	effect eSkillDecreaseMS = EffectSkillDecrease(SKILL_MOVE_SILENTLY,50);
	effect eSkillDecreaseHI = EffectSkillDecrease(SKILL_HIDE,50);
	effect eSkillDecreaseOL = EffectSkillDecrease(SKILL_OPEN_LOCK,50);
	effect eSkillDecreasePP = EffectSkillDecrease(SKILL_SLEIGHT_OF_HAND,50);
	effect eSkillDecreaseST = EffectSkillDecrease(SKILL_SET_TRAP,50);
	effect eSkillDecreaseTU = EffectSkillDecrease(SKILL_TUMBLE,50);
	effect eAttackDecrease  = EffectAttackDecrease(50);
	
	// temp hardcode
	//nMountAC = 25;
	// = 200;
	
	// record some information about the mount
	int nMountHPcur = GetLocalInt(oPC,"nHPcur_mnt");
	int nMountHPmax = GetLocalInt(oPC,"nHPmax_mnt");
	int nMountAC	= GetLocalInt(oPC,"nAC_mnt");
	//string sOrigName = GetLocalString(oPC,"sOrigName_mnt");
	
	// if using ride skill, give them a speed bonus based on ride ranks
	if (bRequireRideSkill) SetMountedMovementModifier( oPC);
	
	// removed any speed-modifying spells
    if (GetHasSpellEffect( SPELL_HASTE, oPC ) == TRUE)						RemoveSpecificSpellEffect( oPC, SPELL_HASTE);
    if (GetHasSpellEffect( SPELLABILITY_FAVORED_SOUL_HASTE, oPC ) == TRUE)	RemoveSpecificSpellEffect( oPC, SPELLABILITY_FAVORED_SOUL_HASTE);
	if (GetHasSpellEffect( SPELLABILITY_WARPRIEST_HASTE, oPC ) == TRUE)		RemoveSpecificSpellEffect( oPC, SPELLABILITY_WARPRIEST_HASTE);
	if (GetHasSpellEffect( SPELL_EXPEDITIOUS_RETREAT, oPC ) == TRUE) 		RemoveSpecificSpellEffect( oPC, SPELL_EXPEDITIOUS_RETREAT);
	if (GetHasSpellEffect( SPELL_I_FLEE_THE_SCENE, oPC ) == TRUE) 			RemoveSpecificSpellEffect( oPC, SPELL_I_FLEE_THE_SCENE);	
	
	// apply AC increase if warranted
	if (nMountAC > nPCAC) 
	{
		nACMod = nMountAC - nPCAC;
		eACIncrease = EffectACIncrease(nACMod);	
		ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(SetEffectSpellId(eACIncrease,7131)),oPC);		
	}
	
	// apply HP increase if warranted
	if (nMountHPmax > nPCHP) 
	{
		nHPMod = nMountHPmax - nPCHP;
		// store this so we can back it out later, use max hitpoints here
		SetLocalInt(oPC,"nHPMod_Mount",nHPMod);
		eHPIncrease = EffectBonusHitpoints(nHPMod);
		ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(SetEffectSpellId(eHPIncrease,7132)),oPC);		
	}
   
	// apply skill penalties
	eLink	= EffectLinkEffects(eSkillDecreaseDT, eSkillDecreaseMS);
	eLink	= EffectLinkEffects(eSkillDecreaseOL, eLink);
	eLink	= EffectLinkEffects(eSkillDecreasePP, eLink);
	eLink	= EffectLinkEffects(eSkillDecreaseST, eLink);
	eLink	= EffectLinkEffects(eSkillDecreaseTU, eLink);  
	eLink	= EffectLinkEffects(eSkillDecreaseHI, eLink);
	eLink	= EffectLinkEffects(eAttackDecrease, eLink);	
	
	ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(SetEffectSpellId(eLink,7133)),oPC);
	
	// kill any action modes
	SetActionModesOff(oPC);
	
	// heal up to the amount provided by the horse's current hitpoints (not max)
	eHeal = EffectHeal(nMountHPcur-nPCHP);
	ApplyEffectToObject(DURATION_TYPE_INSTANT,eHeal,oPC);	
}

void SetActionModesOff(object oPC)
{
	if (bDEBUG_mounts) SendMessageToPC(oPC,"DEBUG: SetActionModesOff() Running!");
	
	if (GetActionMode(oPC, ACTION_MODE_COMBAT_EXPERTISE)==TRUE) 			SetActionMode(oPC, ACTION_MODE_COMBAT_EXPERTISE, FALSE);
	if (GetActionMode(oPC, ACTION_MODE_DETECT)==TRUE) 						SetActionMode(oPC, ACTION_MODE_DETECT, FALSE);
	if (GetActionMode(oPC, ACTION_MODE_HELLFIRE_BLAST)==TRUE) 				SetActionMode(oPC, ACTION_MODE_HELLFIRE_BLAST, FALSE);
	if (GetActionMode(oPC, ACTION_MODE_HELLFIRE_SHIELD)==TRUE) 				SetActionMode(oPC, ACTION_MODE_HELLFIRE_SHIELD, FALSE);
	if (GetActionMode(oPC, ACTION_MODE_IMPROVED_COMBAT_EXPERTISE)==TRUE)	SetActionMode(oPC, ACTION_MODE_IMPROVED_COMBAT_EXPERTISE, FALSE);
	if (GetActionMode(oPC, ACTION_MODE_PARRY)==TRUE) 						SetActionMode(oPC, ACTION_MODE_PARRY, FALSE);					
	if (GetActionMode(oPC, ACTION_MODE_STEALTH)==TRUE) 						SetActionMode(oPC, ACTION_MODE_STEALTH, FALSE);
}

void RemoveSpecificSpellEffect(object oPC, int nSpellID)
{
	effect eSpell = GetFirstEffect(oPC);
	int nCurSpellID;
	
    while (GetIsEffectValid(eSpell))
    {				
		nCurSpellID = GetEffectSpellId(eSpell);
		
    	if(nCurSpellID == nSpellID)
        {
        	RemoveEffect(oPC, eSpell);
        }
        eSpell =GetNextEffect(oPC);
	}
}

void RemoveMountedEffects(object oPC)
{
	if (bDEBUG_mounts) SendMessageToPC(oPC,"DEBUG: RemoveMountedEffects() Running!");
	
	effect eMounted;
	int nSpellID;
	int nHPMod_Mount;
	float fStoredMovementRateFactor = GetLocalFloat(oPC,"fStoredMovementRateFactor");
	
	/*
	float fBonus = 0.0;

	if( GetHasFeat(FEAT_BARBARIAN_ENDURANCE, oPC) ) fBonus = 0.1; 
	if( GetHasFeat(1806, oPC) ) fBonus = 0.1;	// warder frantic reactions
    if( GetHasFeat(FEAT_MONK_ENDURANCE, oPC) )
    {
 		float fBonus = 0.1 * (GetLevelByClass(CLASS_TYPE_MONK, oPC) / 3 );
        if (fBonus > 0.90) fBonus = 0.9;
    }
	
	// always reset movement modifier to 1.0 on dismount
	SetMovementRateFactor(oPC, 1.0+fBonus);	
	*/
	
	// restore stored movement rate factor on dismount
	if (fStoredMovementRateFactor == 0.0) fStoredMovementRateFactor = 1.0;
	
	SetMovementRateFactor(oPC, fStoredMovementRateFactor);
	
	// fix temporary hitpoints short of death
	nHPMod_Mount = GetLocalInt(oPC,"nHPMod_Mount");
	if (GetCurrentHitPoints(oPC) > nHPMod_Mount)
	{
		SendMessageToPC(oPC,"Mounted creature temporary bonus hitpoints removed. ");
		ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(nHPMod_Mount,DAMAGE_TYPE_MAGICAL,DAMAGE_POWER_NORMAL,TRUE),oPC);
	}
	
	// find the linked eMounted effect and strip it
	eMounted = GetFirstEffect(oPC);
    while (GetIsEffectValid(eMounted))
    {				
		nSpellID = GetEffectSpellId(eMounted);
		
    	if(nSpellID > 7130 && nSpellID <= 7133)
        {
        	RemoveEffect(oPC, eMounted);
        }
        eMounted=GetNextEffect(oPC);
	}	
}

void SetMountedMovementModifier(object oPC)
{
	float fBase = 1.1;		// figure even if you're bad at riding, a horse is still faster
	float fBonus = 0.0;		// add up all of the PC movement bonus that won't apply while mounted
	float mBonus = 0.0; 		// for tracking monk bonus
	float fMod = 0.0;			// existing modifiers (such as OLM)

	if (bDEBUG_mounts) SendMessageToPC(oPC,"DEBUG: SetMountedMovementModifier() Running!");

	// get and store PCs current movement mod	
	float fStoredMovementRateFactor = GetMovementRateFactor(oPC);
	SetLocalFloat(oPC,"fStoredMovementRateFactor",fStoredMovementRateFactor);	
	
	// get maximum horse speed
	int nMountType = GetLocalInt(oPC, "nMountType");
	float fMaxMod = GetMountMaxModifier(nMountType);
	
		// add up all of the PC movement bonus that won't apply 
		// while mounted so we can back it all out of horse speed
		if( GetHasFeat(FEAT_BARBARIAN_ENDURANCE, oPC) ) fBonus = fBonus+0.1; 
		if( GetHasFeat(1806, oPC) ) fBonus = fBonus+0.1;	// warder frantic reactions
		if( GetHasFeat(FEAT_WOODLAND_STRIDE, oPC) ) fBonus = fBonus+0.1;	// woodland stride	
		if( GetHasFeat(FEAT_DASH, oPC) ) fBonus = fBonus+0.05;	// dash	
	    if( GetHasFeat(FEAT_MONK_ENDURANCE, oPC) )
	    {
	 		mBonus = 0.1 * (GetLevelByClass(CLASS_TYPE_MONK, oPC) / 3 );
	        fBonus = fBonus+mBonus;
			if (fBonus > 0.90) fBonus = 0.9;
	    }	
	
	// probably zero but they may be on OLM	
	fMod = GetLocalFloat(oPC, "fMod");  	
	fMod = fMod - fBonus;
	
	// apply bonus for ride ranks
	int nRideRanks = GetSkillRank(SKILL_RIDE,oPC);		
	float fRideMod = ( (IntToFloat(nRideRanks) * 0.1) +fBase);
	fMod = fMod + fRideMod;
	
	// cap horse at its maximum speed
	// horse can go no faster than its
	// max no matter how skilled PC is
	if (fMaxMod < fMod)
	{
		fMod = fMaxMod;
	}	
	
	// change pc speed
	SetMovementRateFactor(oPC, fMod);
}

int CheckRide(object oPC, object oMount = OBJECT_INVALID)
{
	if (bDEBUG_mounts) SendMessageToPC(oPC,"DEBUG: CheckRide() Running!");
	
	int nRideRanks;
	int nPCSize = GetCreatureSize(oPC);
	int nMountSize;
	int nMountType;
	
	if (!GetIsObjectValid(oMount)) 
	{
		SendMessageToPC(oPC,"Invalid target.");
		return FALSE;
	}
	
	nMountType = StringToInt(GetStringRight(GetResRef(oMount),1));
	nMountSize = GetMountSize(nMountType);
	
	// default to medium
	if (nMountSize == 0) nMountSize = 3;
	// kludge so dwarves go on small steeds
	if (GetRacialType(oPC) == RACIAL_TYPE_DWARF) nPCSize = 2;
	
	// indoors
	if (GetIsAreaInterior(GetArea(oPC)))
	{
		SendMessageToPC(oPC,"You can't mount that inside here.");
	 	return FALSE;
	}
	
	// already mounted
	if (GetIsMounted(oPC))
	{
		SendMessageToPC(oPC,"You must dismount before selecting a new mount.");
		return FALSE;
	}
	
	// wrong size creature
	if (nPCSize > nMountSize)
	{
		SendMessageToPC(oPC,"You are too large to mount a creature of this stature.");
		return FALSE;
	}
	if (nPCSize < nMountSize)
	{
		SendMessageToPC(oPC,"You are too small to mount a creature of this stature.");
		return FALSE;
	}
	
	// set the bRequireRideSkill constant to TRUE if you want to use these
	if (bRequireRideSkill == TRUE)
	{
		nRideRanks = GetSkillRank(SKILL_RIDE,oPC);
		
		// no ride skill and not paladin
		if (nRideRanks < 1 && !GetLevelByClass(CLASS_TYPE_PALADIN,oPC) > 0)
		{
			SendMessageToPC(oPC,"You lack the required skill to mount a creature.");
			return FALSE;
		}
	
		// creature has nRequiredRanks local var specifying a minimum rank requirement
		if (GetIsObjectValid(oMount) && nRideRanks <  GetRequiredRanks(nMountType))
		{
			SendMessageToPC(oPC,"You lack sufficient ride skill to mount a creature of this spirit.");
			return FALSE;	
		}
	}
	
	return TRUE;
}

/*	
	Casting Spells while Mounted (called from mod_spell_script)
	You can cast a spell normally if your mount moves up to a normal move (its speed)
	either before or after you cast. If you have your mount move both before and after
	you cast a spell, then you’re casting the spell while the mount is moving, and you
	have to make a Concentration check due to the vigorous motion (DC 10 + spell level)
	or lose the spell. If the mount is running (quadruple speed), you can cast a spell
	when your mount has moved up to twice its speed, but your Concentration check is more
	difficult due to the violent motion (DC 15 + spell level).	
*/
int CheckMountedSpell(object oPC, int nSpellID)
{
	if (bDEBUG_mounts) SendMessageToPC(oPC,"DEBUG: CheckMountedSpell() Running!");
	
	switch (nSpellID)
	{
		case SPELL_HASTE:
		case SPELLABILITY_FAVORED_SOUL_HASTE:
		case SPELLABILITY_WARPRIEST_HASTE:
		case SPELL_EXPEDITIOUS_RETREAT:
		case SPELL_I_FLEE_THE_SCENE:
		SendMessageToPC(oPC,"Cannot hasten a mounted creature.");
		return FALSE;
		break;
		
		case SPELL_POLYMORPH_SELF:
		case SPELL_I_WORD_OF_CHANGING:
		case SPELL_SHAPECHANGE:
		case SPELL_TENSERS_TRANSFORMATION:
		case SPELLABILITY_ELEMENTAL_SHAPE:
		case SPELLABILITY_EPIC_SHAPE_DRAGON:
		case SPELLABILITY_EPIC_SHAPE_DRAGONKIN:
		case SPELLABILITY_MAGICAL_BEAST_WILD_SHAPE:
		case SPELLABILITY_MAGICAL_BEAST_WILD_SHAPE_CELESTIAL_BEAR:
		case SPELLABILITY_MAGICAL_BEAST_WILD_SHAPE_PHASE_SPIDER:
		case SPELLABILITY_MAGICAL_BEAST_WILD_SHAPE_WINTER_WOLF:
		case SPELLABILITY_PLANT_WILD_SHAPE:
		case SPELLABILITY_PLANT_WILD_SHAPE_SHAMBLING_MOUND:
		case SPELLABILITY_PLANT_WILD_SHAPE_TREANT:
		case SPELLABILITY_WILD_SHAPE:
		case SPELLABILITY_WILD_SHAPE_BADGER:
		case SPELLABILITY_WILD_SHAPE_BOAR:
		case SPELLABILITY_WILD_SHAPE_BROWN_BEAR:
		case SPELLABILITY_WILD_SHAPE_PANTHER:
		case SPELLABILITY_WILD_SHAPE_WOLF:	
		
		SendMessageToPC(oPC,"Cannot shapechange while mounted.");
		return FALSE;
		break;
		
		default:		
		// do nothing
	}
	
	// block of polymorph spells missing from constants
	if (nSpellID >= 387 && nSpellID <= 405)
	{
		SendMessageToPC(oPC,"Cannot shapechange while mounted.");
		return FALSE;
	}	
	
	int nDC = 15 + GetSpellLevel(nSpellID);
	
	if (GetIsSkillSuccessful(oPC,SKILL_CONCENTRATION,nDC,TRUE))
	{
		return TRUE;
	}
	return FALSE;
}

void DestroyItems(object oTarget,string sItem,int nNumItems)
{
    int nCount = 0;
    object oItem = GetFirstItemInInventory(oTarget);

    while (GetIsObjectValid(oItem) == TRUE && nCount < nNumItems)
    {
        if (GetTag(oItem) == sItem)
        {
            int nRemainingToDestroy = nNumItems - nCount;
			int nStackSize = GetItemStackSize(oItem);
			
			if(nStackSize <= nRemainingToDestroy)
			{
				DestroyObject(oItem,0.1f);
				nCount += nStackSize;
			}
            else
			{
				int nNewStackSize = nStackSize - nRemainingToDestroy;
				SetItemStackSize(oItem, nNewStackSize);
				break;
			}
        }
        oItem = GetNextItemInInventory(oTarget);
    }
//
//	ALSO DESTROY EQUIPPED ITEMS!
//	
	int nSlot = 0;
	while (nSlot < NUM_INVENTORY_SLOTS && nCount < nNumItems )
	{
		object oItem = GetItemInSlot(nSlot, oTarget);
		if (GetTag(oItem) == sItem)
		{
			DestroyObject(oItem, 0.1f);
			nCount++;
		}
		nSlot++;
	}
}

/*
	oRider on a horse is the last PC to have ridden the horse and does not imply legal title to the mount
	oOwner is legit owner of a mount who originally spawned it into the module
*/
int CheckMountOwner(object oPC, object oMount)
{
	if (bDEBUG_mounts) SendMessageToPC(oPC,"DEBUG: CheckMountOwner() Running!");
	
	object oRider = GetLocalObject(oMount,"oRider");
	object oOwner = GetLocalObject(oMount,"oOwner");
	
	if (oRider == oPC || oOwner == oPC)
	{
		return TRUE;
	}
	return FALSE;
}

int GetMountType(object oPC)
{

	if (bDEBUG_mounts) SendMessageToPC(oPC,"DEBUG: GetMountType() Running!");
	
	string sSQL;
	string pcid = getPCid(oPC);
	int nType;	
	
	if (pcid == "ERROR_OBJ_INVALID") return FALSE;
	
	sSQL = 	"SELECT class FROM mount_records WHERE pcid = "+pcid;
	SQLExecDirect(sSQL);
	if (SQLFetch() == SQL_SUCCESS)
	{
		nType = StringToInt(SQLGetData(1));	
		return nType;
	}
	return 0;	
}


void BuyMount(object oPC, int class)
{
	if (bDEBUG_mounts) SendMessageToPC(oPC,"DEBUG: BuyMount() Running!");
	
	string sSQL;
	string pcid = getPCid(oPC);
	string sName;
	
	if (pcid == "ERROR_OBJ_INVALID") return;
	
	int nPrice = GetMountPrice(class);
	object oMount;
	
	if (GetMountType(oPC) > 0)
	{
		SendMessageToPC(oPC,"You already own a mount.");
		return;
	}
	
	//if (nBanked >= nPrice)
	if (GetGold(oPC) >= nPrice)
	{
		sSQL = 	"INSERT INTO mount_records (pcid,class) VALUES ("+pcid+","+IntToString(class)+")";
		SQLExecDirect(sSQL);
		if (bDEBUG_mounts) SendMessageToPC(oPC,sSQL);
		
		if (SQLGetAffectedRows() > 0)
		{
			SendMessageToPC(oPC,"Mount Purchased");
			
			TakeGoldFromCreature(nPrice,oPC,TRUE);
			
			// gimmie a pony!
			oMount = SpawnMount(oPC, class, GetLocation(oPC));
			DelayCommand(2.0,	AssignCommand(oPC,	ActionMount(oMount, class)	)	);
		}	
		else
		{
			SendMessageToPC(oPC,"INSERT FAILED");
		}
	}
	else
	{
		SendMessageToPC(oPC,"You do not have enough gold to afford this mount.");
	}
}

void GetMountResaleValue(object oPC)
{
	if (bDEBUG_mounts) SendMessageToPC(oPC,"GetMountResaleValue() Running!");
	
	int nMountType 			= GetMountType(oPC);
	int nMountPrice			= GetMountPrice(nMountType);
	float fMountResaleValue = IntToFloat(nMountPrice) * fReSaleValue;
	int nMountResaleValue 	= FloatToInt(fMountResaleValue);
	
	SetCustomToken(9034690,IntToString(nMountResaleValue));
	SetLocalInt(oPC,"nMountResaleValue",nMountResaleValue);
}

void SellMount(object oPC)
{
	if (bDEBUG_mounts) SendMessageToPC(oPC,"DEBUG: SellMount() Running!");
	
	string sSQL;
	string pcid = getPCid(oPC);	
	if (pcid == "ERROR_OBJ_INVALID") return;
	
	int nMountType 	= GetMountType(oPC);
	int nMountPrice;
	float fMountResaleValue;
	int nMountResaleValue;
	object oMount;
	
	// if they have a mount
	if (nMountType > 0)
	{		
		nMountPrice			= GetMountPrice(nMountType);
		fMountResaleValue 	= IntToFloat(nMountPrice) * fReSaleValue;
		nMountResaleValue 	= FloatToInt(fMountResaleValue);
		
		oMount = GetLocalObject(oPC,"oMount");	
		if (GetIsObjectValid(oMount))
		{
			if (bDEBUG_mounts) SendMessageToPC(oPC,"DEBUG: SellMount() destroying mount!");
			DestroyObject(oMount);
			//DelayCommand(2.0,DeleteLocalObject(oPC,"oMount"));
		}
		else
		{
			if (bDEBUG_mounts) SendMessageToPC(oPC,"DEBUG: SellMount() found no mount to destroy!");
		}
		
		RemoveMount(oPC);
		
		GiveGoldToCreature(oPC,nMountResaleValue);
	
	}	
}

object SpawnMount(object oPC, int nMountType, location lLoc)
{
	if (bDEBUG_mounts) SendMessageToPC(oPC,"DEBUG: SpawnMount() Running!");
	
	if (!GetIsLocationValid(lLoc)) lLoc = GetRandomLocation( GetArea(oPC), oPC, 3.0f );

	object oMount = CreateObject(OBJECT_TYPE_CREATURE,"d2_mount_"+IntToString(nMountType),lLoc,FALSE);
	SetFirstName(oMount,GetFirstName(oPC)+" "+GetLastName(oPC)+"'s "+GetFirstName(oMount));	
	SetLocalObject(oMount,"oRider",oPC);
	SetLocalObject(oPC,"oMount",oMount);
	return oMount; 
}

// remove horse from db (sale or death)
void RemoveMount(object oPC)
{
	if (bDEBUG_mounts) SendMessageToPC(oPC,"DEBUG: RemoveMount() Running!");
	
	DeleteLocalObject(oPC,"oMount");
	
	string sSQL;
	string pcid = getPCid(oPC);	
	if (pcid == "ERROR_OBJ_INVALID") return;

	sSQL = 	"DELETE FROM mount_records WHERE pcid = "+pcid;
	SQLExecDirect(sSQL);	
}


void OnMountedPCDeath(object oPC)
{
	if (bDEBUG_mounts) SendMessageToPC(oPC,"DEBUG: OnMountedDeath() Running!");
	
	MountedPCCleanUp(oPC);
	OnMountDeath(oPC);
}

// called from OnMountedPCDeath or from creature's ondeath event
// if PC is off mount at time of death, need to pass oPC from _de
void OnMountDeath(object oPC)
{
	if (bDEBUG_mounts) SendMessageToPC(oPC,"DEBUG: OnMountDeath() Running!");
	
	object oJournal = std_journal_get( oPC );  
	
	if (GetIsObjectValid(oPC))
	{
		DeleteLocalInt(oPC,"nMountType");
		DeleteLocalObject(oPC,"oMount");  
	}	
	RemoveMount(oPC);
}

// ok to use local vars here
void SendMountToLimbo(object oPC, object oArea)
{
	if (bDEBUG_mounts) SendMessageToPC(oPC,"DEBUG: SendMountToLimbo() Running!");
	
	object oMount;
	string sAreaTag;
	location lReturnTo;
	//object oArea = GetArea(oPC);	
	
	oMount = GetLocalObject(oPC,"oMount");
	
	if (!GetIsObjectValid(oMount))
	{
		if (bDEBUG_mounts) SendMessageToPC(oPC,"DEBUG: SendMountToLimbo() oMount was invalid, deleting!");
		DeleteLocalObject(oPC,"oMount");
		return;	
	}
	
	// pull the ejector seat, no reason to do any work here!
	if (GetArea(oMount) != oArea)
	//if (GetLocalInt(oMount,"bLimboed") == TRUE || GetName(GetArea(oMount)) == "Limbo" )
	{
		// if (bDEBUG_mounts) SendMessageToPC(oPC,"DEBUG: SendMountToLimbo() Area of Mount != Area called from, nothing to do");
		if (bDEBUG_mounts) SendMessageToPC(oPC,"DEBUG: SendMountToLimbo() Creature "+GetFirstName(oMount)+" is already in limbo!");		
		 return;
	}
	
	if (bDEBUG_mounts) SendMessageToPC(oPC,"DEBUG: SendMountToLimbo() Looks normal, regular way.");
	
	sAreaTag = GetTag(oArea);
	//sAreaTag = GetLocalString(oPC,"LastExitTag");
	if (bDEBUG_mounts) SendMessageToPC(oPC,"DEBUG: SendMountToLimbo() sAreaTag: "+sAreaTag);
	
	lReturnTo = GetLocation(oMount);
	if (bDEBUG_mounts) SendMessageToPC(oPC,"DEBUG: SendMountToLimbo() lReturnTo: "+LocationToString(lReturnTo));	
	
	SetLocalString(oPC,"sAreaParkedMount",sAreaTag);
	SetLocalLocation(oMount,"lReturnTo",lReturnTo);

	if (bDEBUG_mounts) SendMessageToPC(oPC,"DEBUG: Sending Creature to Limbo!");
	SetLocalInt(oMount,"bLimboed",TRUE);
	SendCreatureToLimbo(oMount);		

}

// ok to use local vars here
void FetchMountFromLimbo(object oPC)
{
	if (bDEBUG_mounts) SendMessageToPC(oPC,"DEBUG: FetchMountFromLimbo() Running!");
	
	object oArea = GetArea(oPC); 
	string sAreaTag = GetTag(oArea);
	object oMount = GetLocalObject(oPC,"oMount");
	location lReturnTo;
	int nPallyParked = GetLocalInt(oPC,"PallyParkedMount");
	

	if (GetLocalString(oPC,"sAreaParkedMount") == sAreaTag) // && GetIsObjectValid(oMount))
	{
		// paladin summoned mount
		if (nPallyParked == TRUE)
		{
			if (bDEBUG_mounts) SendMessageToPC(oPC,"DEBUG: FetchMountFromLimbo() Spawning Paladin Mount!");
			
			//IncrementRemainingFeatUses(oPC,3041);
			ResetFeatUses(oPC,3041,TRUE,TRUE);
			//AssignCommand(oPC,SummonMount());
			DeleteLocalInt(oPC,"nPallyParked");
		}
		// regular mount from limbo
		else
		{		
			if (bDEBUG_mounts) SendMessageToPC(oPC,"DEBUG: FetchMountFromLimbo() Creature is being recalled NOW!");
			
			lReturnTo = GetLocalLocation(oMount,"lReturnTo");
			
			if (!GetIsLocationValid(lReturnTo)) lReturnTo = GetRandomLocation( oArea, oPC, 3.0f );
			
			RecallCreatureFromLimboToLocation(oMount,lReturnTo);
			DeleteLocalInt(oMount,"bLimboed");
			
			// actually leave these here in case pc leaves the server after re-entering area
			//DeleteLocalString(oPC,"sAreaParkedMount");
			//DeleteLocalLocation(oMount,"lReturnTo");
		}
	}
	else
	{
		if (bDEBUG_mounts) SendMessageToPC(oPC,"DEBUG: FetchMountFromLimbo() No mount was left in this area, do nothing.");
	}
}

void SpawnMountIfNeeded(object oPC)
{
	if (bDEBUG_mounts) SendMessageToPC(oPC,"DEBUG: SpawnMountIfNeeded() Running!");
	
	object oMount = GetLocalObject(oPC,"oMount");
	
	location lLoc = GetLocation(	GetNearestObjectByTag("wp_mount_sp")	);
	int nMountType = GetMountType(oPC);
	
	if (!GetIsLocationValid(lLoc)) lLoc = GetRandomLocation( GetArea(oPC), oPC, 3.0f );
	
	// if mount does not exist elsewhere in the module
	if (!GetIsObjectValid(oMount))	
	{	
		// and player owns mount
		if (nMountType > 0)
		{
			SpawnMount(oPC, nMountType, lLoc);	
		}
	}
}

void XferMountOwner(object oPC, int nMountType, object oOldOwner)
{
	if (bDEBUG_mounts) SendMessageToPC(oPC,"DEBUG: XferMountOwner() Running!");
	
	string sSQL;
	string sNewpcid = getPCid(oPC);	
	string sOldpcid = getPCid(oOldOwner);
	
	// abort on invalid object
	if (sNewpcid == "ERROR_OBJ_INVALID") return;
	
	// for my sanity, you can only have one mount
	// so if PC already has one, must abandon it
	if (GetMountType(oPC) > 0) 
	{
		SendMessageToPC(oPC,"Previous mount abandoned.");
		RemoveMount(oPC);
	}	
	
	// xfer from valid player, transfer ownership
	if (sOldpcid != "ERROR_OBJ_INVALID")
	{	
		sSQL = 	"UPDATE mount_records SET pcid = '+sNewpcid+' WHERE pcid = "+sNewpcid;
		SQLExecDirect(sSQL);
		if (SQLFetch() == SQL_SUCCESS)
		{
			SendMessageToPC(oPC,"Mount ownership transferred.");
		}
	}
	else
	{
		// xfer from environment, insert ownership		
		sSQL = 	"INSERT INTO mount_records (pcid,class) VALUES ("+sNewpcid+","+IntToString(nMountType)+")";
		SQLExecDirect(sSQL);
		if (bDEBUG_mounts) SendMessageToPC(oPC,sSQL);
		
		if (SQLGetAffectedRows() > 0)
		{
			SendMessageToPC(oPC,"Mount ownership transferred.");
		}		
	}
}

void ActionStealMount(object oPC, object oMount)
{
	if (bDEBUG_mounts) SendMessageToPC(oPC,"DEBUG: ActionStealMount() Running!");
	
	string sResRef = GetResRef(oMount);	
	int nMountType = StringToInt(GetStringRight(sResRef,1));
	int nDC = nMountType*5;
	int nCaught = FALSE;
	object oArea = GetArea(oPC);
	object oWitness;
	object oOwner = GetLocalObject(oMount,"oOwner");
	object oGenericGuard;
	object oMorellGuard;
	object oBadGuard;
	
	if (GetLocalInt(oArea,"nHorseTheftAutoWarrant") == 1)
	{
		issueIndictment(oPC, GetObjectByTag("d2_faction_cearguard"));
		nCaught = TRUE;
	}	
	
	oWitness = GetFirstObjectInShape(SHAPE_SPHERE,60.0,GetLocation(oPC),TRUE,OBJECT_TYPE_CREATURE);
	while (GetIsObjectValid(oWitness))
	{
		// if witness is disliked by hostiles and is not an animal
		if (GetStandardFactionReputation( STANDARD_FACTION_HOSTILE ,oWitness) < 50 && GetRacialType(oWitness) != RACIAL_TYPE_ANIMAL && !GetIsPC(oWitness) && oWitness != oPC)
		{
			// if witnessed by member of guard faction, use oWitness
			// otherwise, generic 'cear guard' will issue the warrant
			oGenericGuard = GetObjectByTag("d2_faction_cearguard");
			oMorellGuard = GetObjectByTag("d2_faction_morellguards");					
			if (!GetFactionEqual(oWitness,oGenericGuard) || !GetFactionEqual(oWitness,oMorellGuard) ) oWitness = oGenericGuard;
			
			issueIndictment(oPC, oWitness);
			issueWarrant(oPC, oWitness);
			nCaught = TRUE;
			break;
		}
		
		oWitness = GetNextObjectInShape(SHAPE_SPHERE,60.0,GetLocation(oPC),TRUE,OBJECT_TYPE_CREATURE);
	}

	if (GetIsSkillSuccessful(oPC,SKILL_SLEIGHT_OF_HAND,nDC,TRUE))
	{	
		// XferMountOwner(object oMount, object oOldOwner, object oNewOwner);
		AssignCommand(oPC,ActionMount(oMount,nMountType));
		XferMountOwner(oPC,nMountType,oOwner);
		if (nCaught == TRUE) DisplayMessageBox(oPC,0,"<color=red>Theft Detected!</color>\n\n<i>Your crime has been reported to the authorities!");		
	}
	else
	{
		AssignCommand(oMount,ActionMoveAwayFromObject(oPC,TRUE,10.0f));
	}
	
	DeleteLocalObject(oPC,"oMountTarget");
}

// this is assigned to PC so use OBJECT_SELF
void ActionMountedCombatStop(object oCreature)
{
	if (bDEBUG_mounts) SendMessageToPC(OBJECT_SELF,"ActionMountedCombatStop() Running!");
	
	ClearAllActions(TRUE);
	ActionMoveAwayFromObject(oCreature,TRUE,4.0f);
	PlaySound("whinny32000");	
	ActionDoCommand(SetCommandable(TRUE));
	SetCommandable(FALSE);
}

void ActivateRideUI(object oPC)
{
	if (bDEBUG_mounts) SendMessageToPC(oPC,"DEBUG: ActivateRideUI() Running!");
	
	//Close all of the Ingame UI elements we want hidden.
	CloseGUIScreen(oPC, "SCREEN_HOTBAR");
	CloseGUIScreen(oPC, "SCREEN_HOTBAR_2");
	CloseGUIScreen(oPC, "SCREEN_HOTBAR_V1");
	CloseGUIScreen(oPC, "SCREEN_HOTBAR_V2");
	CloseGUIScreen(oPC, "SCREEN_MODEBAR");
}

void DeactivateRideUI(object oPC)
{	
	if (bDEBUG_mounts) SendMessageToPC(oPC,"DEBUG: DeactivateRideUI() Running!");
	
	DisplayGuiScreen(oPC, "SCREEN_HOTBAR", FALSE);
	DisplayGuiScreen(oPC, "SCREEN_HOTBAR2", FALSE);
	DisplayGuiScreen(oPC, "SCREEN_HOTBAR_V1", FALSE);
	DisplayGuiScreen(oPC, "SCREEN_HOTBAR_V2", FALSE);
	DisplayGuiScreen(oPC, "SCREEN_MODEBAR", FALSE);
}

void NameSummonedMount(object oPC, object oTarget)
{
	SetLocalObject(oPC, "oTarget", oTarget);
	SetLocalInt(oPC, "nMount", 1);	
	DisplayInputBox (oPC, 0, "Name Your Mount!", "gui_name_change_ok", "gui_name_change_cancel",
	TRUE, "", 0, "", 0, "", GetName(oTarget));
}

void SetUpSummonedMount(object oPC)
{
	object oComp = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION,oPC);
	object oJournal = std_journal_get( oPC );
	int nPCSize = GetCreatureSize(oPC);
	string sName = "";
			
	if (!GetIsObjectValid(oComp))
	{
		SendMessageToPC(oPC,"DEBUG: Could not locate mount!");
	}	
	
	if (bDEBUG_mounts) SendMessageToPC(oPC,"DEBUG: My tag is "+GetTag(oComp));
	
	if (GetIsObjectValid(oJournal) )
	{
		sName = GetLocalString(oJournal,"sMountName");
	}	
	
	if (nPCSize == 2 || GetRacialType(oPC) == RACIAL_TYPE_DWARF)
	{
		SetScale(oComp,0.7,0.7,0.7);
	}
	
	if (sName == "")
	{
		NameSummonedMount(oPC,oComp);
	} 
	else
	{
		SetFirstName(oComp,sName);
	}
	
	SetLocalObject(oComp,"oRider",oPC);
	SetLocalObject(oPC,"oMount",oComp);
	
}

void SummonMount()
{
	string sQual = "1";
	int nHD = GetHitDice(OBJECT_SELF);
	
	if (nHD>=3) sQual = "2";
	if (nHD>=6) sQual = "3";
	if (nHD>=9) sQual = "4";
	if (nHD>=12) sQual = "5";
	if (nHD>=15) sQual = "6";
	if (nHD>=18) sQual = "7";
					
	if (!GetIsAreaInterior( GetArea(OBJECT_SELF) ))
	{	
	    //Yep thats it		
	    SummonAnimalCompanion(OBJECT_SELF,"c_ancom_horse"+sQual);
		DelayCommand(1.0f,SetUpSummonedMount(OBJECT_SELF));
	}
	else
	{
		SendMessageToPC(OBJECT_SELF,"Cannot summon mount inside!");
	}
}