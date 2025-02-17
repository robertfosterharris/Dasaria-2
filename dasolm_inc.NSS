// 	Name     : dasolm_inc
// 	Purpose  : Scripting functions for Dasaria2 Lendose Missions
// 	Author   : Wired
// 	Modified : 	06/28/2010
//				08/02/2010 Changes to reflect Rebel/Imperial detente

#include "ginc_renown"
#include "ginc_overland"
#include "ginc_group"
#include "ginc_henchman"
#include "x0_i0_partywide"
#include "X0_I0_ASSOC"
#include "ginc_journal"

/************************************/
/* Constants                        */
/************************************/

//const int bDEBUG = TRUE;
const int SOLDIER_COST = 150;
const int MINLEVEL = 15;

/************************************/
/* Function prototypes              */
/************************************/

// Abbreviated Multiplayer Overland Map OCE
// Swaps UI for entering players
// Groups all players under the command of one PC
void DasOL_OCE(object oPC);

// Removes effects
// Restores GUI
void DasOL_Exit(object oPC);

// Ensure the party is gathered before enter OLM
int DasOL_CheckPartyGathered(object oPC);

// Jump party only when aligned
void JumpAlliedParty(object oPC, string sWP);

// If either the invited oPC -OR- someone else 
// in the party is on the OLM and in a different
// faction, break oPC out of the Party
int DasOL_ValidateParty(object oPC);

// Ensure everyone in the part is aligned
int DasOL_CheckPartyAligned(object oPC);

// Set conversation tokens
void DasOL_SetTokens(object oPC); 

// Determine Maxmium # of Allies based on
// CHA bonus and other factors
int DasOL_GetMaxAllies(object oPC);

// Check MaxAllies < Remaining Allies
int DasOL_CheckMaxAllies(object oPC);

// Records how many soldiers the PC still retains after leaving the mission area
void DasOL_Enc_SetAlliesRemaining(object oLeader);

// Spawn party leader's allies and add to party
void DasOL_Enc_SpawnAllies(object oPC, object oArea);

// Spawn in henchman and add to party
void DasOL_Enc_SpawnAlly(string sRef, object oWP, object oLeader);

// Remove allies from leader
void DasOL_Enc_RemoveAllies(object oLeader);

// Look around the area for spawnpoints and spawn
// appropriate opponents for the incoming faction
// 1 Imperial
// 2 Rebel
// 3 Canite
void DasOL_Enc_SpawnEnemies(object oArea, int nMetaFac, object oPC);

// Set up any placables required
void DasOL_Enc_SpawnPlaceables(object oPC);

// Sets the area as being in use by a particular metafaction
void DasOL_Enc_AreaSetInUse(object oArea, object oLeader, int nMetaFaction = 0);

// Returns the MetaFaction using the area or zero
// if the area is free
int DasOL_Enc_AreaGetInUse(object oArea);

// Check to see if an area is occupied by
// hostiles or friendlies
int DasOL_Enc_Check(object oPC, object oArea);

// Set up an area for a mission
void DasOL_Enc_AreaOCE(object oArea, object oPC);

// Enter an ecounter area
void DasOL_Enc_Enter(object oPC, object oEnterWP);

// Leave an encounter area
void DasOL_Enc_Exit(object oPC, int bVictory);

// Break down an encounter area
void DasOL_Enc_AreaOnExit(object oPC);

// Clear stuff out of an area 
void DasOL_CleanArea(object oPC);

// Internal Only
void DasOL_setReps(object oPC, int nMetaFaction, int nTargetRep);

// Adjusts a PC's Personal Reputation to NPC factions
// and PC Dislike based on faction membership -- Area Enter/Exit
void DasOL_setRepsOnEnter(object oPC, int bDoPlayer = TRUE);

// Purge all reputation when you leave the battlefield
// Call this ONLY on respawn or upon returning to Lendose
//
void DasOL_fixReps(object oPC);

// +/- Renown on in-OLM PVP, end current mission
// if party leader, withdraw allies
void DasOL_DeathHook(object oDead, object oKiller);

// - renown for respawning, end current mission, and return a "home base" respawn point
// if  party leader, withdraw allies
location DasOL_RespawnHook(object oPC);

// I want to use this a couple of places, so including it here
int IsGroupHostile(string sGroupName, object oPC);


/************************************/
/* Implementation                   */
/************************************/

void DasOL_OCE(object oPC)
{
	if (!GetIsObjectValid(oPC) || !GetIsPC(oPC) || GetIsDM(oPC)) return;	
	
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(SetEffectSpellId(EffectSpellFailure(100),-2222)), oPC);
	//PrettyDebug("Swapping UI for " + GetName(oPC));
	ActivateOLMapUI(oPC);//Activating GUI
	CloseGUIScreen(oPC, "SCREEN_MINIMAP");
	DisplayGuiScreen(oPC, GUI_SCREEN_DEFAULT_MODEBAR, FALSE); // let them stealth if they can
	RemoveAllEffects(oPC,0);//Removing all effects
	ApplyEffectToObject(DURATION_TYPE_PERMANENT,
	ExtraordinaryEffect(EffectSetScale(0.7,0.7,0.7)),oPC);//Scaling PCs
	SetMovementRateFactor(oPC,0.75);

	DasOL_setRepsOnEnter(oPC);
	
	// Set Party Leader
	object oLeader = GetFactionLeader(oPC);
	if (!GetIsPC(oLeader)) { oLeader = oPC; };
	//SetPartyActor(oLeader);  << single player nonsense!
	SetMaxHenchmen(18);
}

void DasOL_Exit(object oPC)
{
	// getispc is supposed to return false if they've left the module
	// 
	if (!GetIsObjectValid(oPC) || !GetIsPC(oPC) || GetIsDM(oPC)) return;	
	
	//Deactivating GUI
	DeactivateOLMapUI(oPC);
	
	RemoveAllEffects(oPC,FALSE);
	SetMovementRateFactor(oPC,1.0);	
}

int DasOL_CheckPartyLeader(object oPC)
{
	object oLeader = GetFactionLeader(oPC);
	if (oPC != oLeader) return FALSE;
	else return TRUE;
}

// 
void JumpAlliedParty(object oPC, string sWP)
{
	object oWP = GetWaypointByTag(sWP);
	object oPartyMem;
	
	if (DasOL_CheckPartyGathered(oPC) && DasOL_CheckPartyAligned(oPC))
	{	
		if (bDEBUG) SendMessageToPC(oPC,"Party is aligned and proximate to each other.");
		
		oPartyMem = GetFirstFactionMember(oPC);	
	    while (GetIsObjectValid(oPartyMem)) 
		{
			if (bDEBUG) { SendMessageToPC(oPC,"Jumping "+GetFirstName(oPartyMem)+" to "+sWP); }
			
			AssignCommand(oPartyMem, JumpToObject(oWP));
	        oPartyMem = GetNextFactionMember(oPC);
	    }
	}
}

int DasOL_ValidateParty(object oPC)
{
	object oPartyMem = GetFirstFactionMember(oPC, TRUE);
	
	while (GetIsObjectValid(oPartyMem)) 
	{
		// is anybody in the party on the OLM?
		if (FindSubString(GetTag(GetArea(oPartyMem)),"lendose_ol",0) > 0 || FindSubString(GetTag(GetArea(oPC)),"lendose_ol",0) > 0)
		{
			// if so, then check my allegience against
			// that of others in the party; sadly this
			// is a second loop through the party
			if (!DasOL_CheckPartyAligned(oPC))
			{
				// remove me from the party
				RemoveFromParty(oPC);
				return FALSE;
			}		
		}		
		oPartyMem = GetNextFactionMember(oPC, TRUE);
	}
	return TRUE;		
}

int DasOL_CheckPartyAligned(object oPC)
{
	object oPartyMem = GetFirstFactionMember(oPC, TRUE);
	int nMetaFaction = getMetaFaction(oPC);
	int nPartyMemFaction;
	
	while (GetIsObjectValid(oPartyMem)) 
	{		
		nPartyMemFaction = getMetaFaction(oPartyMem);
		
		// factions are inequal
		if ( nMetaFaction != nPartyMemFaction)
		{
			// // wired 08/02/10: only if if either of the unequal factions is 3/Canite
			if (nMetaFaction == 3 || nPartyMemFaction == 3)
			{
				SendMessageToPC(oPC,		"[ Only allies may party together in the battlezone. ]");
				SendMessageToPC(oPartyMem,	"[ Only allies may party together in the battlezone. ]");
				return FALSE;
			}
			
			if (nMetaFaction == 0 || nPartyMemFaction == 0)
			{
				SendMessageToPC(oPC,		"[ Only declared combatants may enter the battlezone. ]");
				SendMessageToPC(oPartyMem,	"[ Only declared combatants may enter the battlezone. ]");
				return FALSE;			
			}
		}
		
		if (GetHitDice(oPartyMem) < MINLEVEL)
		{
			SendMessageToPC(oPC,		"[ Everyone in your party must be at least level "+IntToString(MINLEVEL)+" to continue. ]");
			SendMessageToPC(oPartyMem,	"[ You do not meet the minimum level requirement ]");
			return FALSE;			
		}
	oPartyMem = GetNextFactionMember(oPC, TRUE);
	}
	return TRUE;
}

int DasOL_CheckPartyGathered(object oPC)
{
	if (bDEBUG) SendMessageToPC(oPC,"There are "+IntToString(GetNumberPartyMembers(oPC)-1)+" in the party.");
	
	if (DasOL_CheckPartyAligned(oPC))
	{	
		object oMember = GetFirstFactionMember(oPC,1);
		while (GetIsObjectValid(oMember))
		{
			float fDist = GetDistanceBetween(oPC,oMember);
			if  ( (fDist > 9.0 || fDist == 0.0) && oMember != oPC)
			{
				SendMessageToPC(oPC,"[ You must gather your party together before heading out! ]");
				return FALSE;
			}
			oMember = GetNextFactionMember(oPC,1);
		}
		return TRUE;
	}
	else
	{
		return FALSE;
	}
}

void DasOL_SetTokens(object oPC)
{
	object oLeader 	= GetFactionLeader(oPC);
	int nSoldiersNum = GetLocalInt(oLeader,"LendOL_Soldiers");
	int nSoldiersMax = DasOL_GetMaxAllies(oLeader);
	int nArmy = nSoldiersMax*6;
	
	SetCustomToken(918301,GetName(GetFactionLeader(oPC)));
	SetCustomToken(918302,IntToString(nSoldiersNum));
	SetCustomToken(918303,IntToString(nSoldiersMax));
	SetCustomToken(918311,getMetaFactionName(getMetaFaction(oPC)));
	SetCustomToken(918312,IntToString(nArmy));
	
	switch (getMetaFaction(oPC))
	{
	case 1:
		SetCustomToken(918305,"VARANA");
		SetCustomToken(192200,"the 10th legion");
		SetCustomToken(192201,"Fort Cratos");
		SetCustomToken(192202,"Talon officer");
		SetCustomToken(192203,"Lochwar");
		SetCustomToken(192204,"Imperial");
		SetCustomToken(192205,"Commander Vaugrim");
		SetLocalString(oPC,"OL_Allegiance","Varanite");		
		break;
	case 2:
		SetCustomToken(918305,"DASARIA");
		SetCustomToken(192200,"the Daybreak Alliance");
		SetCustomToken(192201,"the Front Bastion");
		SetCustomToken(192202,"Tyrakian crusader");
		SetCustomToken(192203,"Utu");
		SetCustomToken(192204,"Dasarian");
		SetCustomToken(192205,"Adelaide the Bright");
		SetLocalString(oPC,"OL_Allegiance","Dasarian");		
		break;
	case 3:
		SetCustomToken(918305,"THE REALM OF CANAS");		
		SetCustomToken(192200,"the Canite Horde");
		SetCustomToken(192201,"Fort Phazzan");
		SetCustomToken(192202,"Kor Warleader");
		SetCustomToken(192203,"Canas");
		SetCustomToken(192204,"Canite");
		SetCustomToken(192205,"Lord Avgral");
		SetLocalString(oPC,"OL_Allegiance","Canite");				
		break;
	}
}

int DasOL_GetMaxAllies(object oPC)
{
	if (!GetIsPC(oPC)) return 0;
	
	int nCha = GetAbilityScore(oPC,ABILITY_CHARISMA);
	int nRenownModifier = (getRank(getPCMetaFactionRenown(oPC)))*3;
	int nMaxAllies = 0;
	
	//if (nCha < 8)  nMaxAllies = 0;
	if ((nCha >= 8) && (nCha < 10))  nMaxAllies = 2;
	if ((nCha >= 10) && (nCha < 12))  nMaxAllies = 5;
	if ((nCha >= 12) && (nCha < 14))  nMaxAllies = 7;
	if ((nCha >= 14) && (nCha < 16))  nMaxAllies = 9;
	if ((nCha >= 16) && (nCha < 18))  nMaxAllies = 12;
	if ((nCha >= 18) && (nCha < 20))  nMaxAllies = 14;
	if (nCha >= 20)  nMaxAllies = 17;
	
	// modifiers: X times your rank
	nMaxAllies = nMaxAllies+nRenownModifier;
	
	if (nMaxAllies >= 17) nMaxAllies = 17;
	
	// modifiers: leadership 3 free guys
	if (GetHasFeat(FEAT_LEADERSHIP,oPC,TRUE))
	{
		nMaxAllies = nMaxAllies + 3;
	}	
		
	return nMaxAllies;
}

int DasOL_CheckMaxAllies(object oPC)
{
	object oLeader 	= GetFactionLeader(oPC);
	int nSoldiersNum = GetLocalInt(oLeader,"LendOL_Soldiers");
	int nSoldiersMax = DasOL_GetMaxAllies(oLeader);		
	int nDifference = nSoldiersMax - nSoldiersNum;
		
	//No more room!
	if (nDifference < 1) 
	{ 
		return FALSE;
	}		
	else
	{ 
		// there are <CUSTOM918304> troops willing to join your command
		SetCustomToken(918304,IntToString(nDifference));
		return nDifference;
	}
}

int DasOL_CheckRecruits(object oPC)
{
	if (bDEBUG) SendMessageToPC(oPC,"Inside DasOL_CheckRecruits()");
	
	int nPrice;
	int nGold;
	int nMaxRecruits;	
	int nDifference = DasOL_CheckMaxAllies(oPC);
	
	if (nDifference == 0)
	{
		SendMessageToPC(oPC,"You cannot find any more troops who are willing to join your ranks.");
		return FALSE; 
	}
	
	nGold = GetGold(oPC);		
	if (nGold < SOLDIER_COST)
	{		
		SendMessageToPC(oPC,"Though there are fighters willing to follow you into battle here, you cannot afford to supply them.");
		return FALSE;
	}
	
	// how many times can the cost of a solider be divided into the gold we have?
	nMaxRecruits = FloatToInt(IntToFloat(nGold)/IntToFloat(SOLDIER_COST));
	// can't recruit more soliders than nDifference tells us
	if (nMaxRecruits > nDifference) nMaxRecruits = nDifference;
	// this is the cost of the maximum number of solider the pc can recruit
	nPrice = nMaxRecruits*SOLDIER_COST;
	
	//you can afford to hire <CUSOM918306> soldiers
	SetCustomToken(918306, IntToString(nMaxRecruits));
	SetLocalInt(oPC,"nMaxRecruits",nMaxRecruits);
		
	//recruit them for <CUSTOM918305> crowns
	SetCustomToken(918305, IntToString(nPrice));
	SetLocalInt(oPC,"nPrice",nPrice);
		
	return TRUE;
}

void DasOL_DoRecruit(object oPC, int nMaxRecruits = 0)
{

	if (bDEBUG) SendMessageToPC(oPC,"Inside DasOL_DoRecruit()");
	
	object oLeader 		= GetFactionLeader(oPC);
	int nSoldiersNum 	= GetLocalInt(oLeader,"LendOL_Soldiers");
	int nPrice;
	int nPartyHench;
	
	if (nMaxRecruits == 0)
	{
		nMaxRecruits	= GetLocalInt(oPC,"nMaxRecruits");	
	}	
	
	nPrice = nMaxRecruits*SOLDIER_COST;
	
	object oMember		= GetFirstFactionMember(oLeader);	
	// if oPC is recruiting nuke all other PCs henchmen first
	while (GetIsObjectValid(oMember))
	{
		if (oMember != oPC)
		{
			DasOL_Enc_RemoveAllies(oMember);
		}	
		oMember = GetNextFactionMember(oLeader);
	}
	
	if (bDEBUG) SendMessageToPC(oPC,"DEBUG: Leader has "+IntToString(nSoldiersNum)+" you can afford "+IntToString(nMaxRecruits)+" more.");
		
	SendMessageToPC(oLeader,IntToString(nMaxRecruits)+" troops have joined your ranks.");
	
	if (oPC != oLeader)
	{
		SendMessageToPC(oPC,IntToString(nMaxRecruits)+" troops have joined "+GetFirstName(oLeader)+"'s ranks.");
	}
	
	SetLocalInt(oLeader,"LendOL_Soldiers",nSoldiersNum+nMaxRecruits);
	
	TakeGoldFromCreature(nPrice,oPC,TRUE,TRUE);
}

void DasOL_Enc_SpawnAlly(string sRef, object oWP, object oLeader)
{
	object oHench = CreateObject(OBJECT_TYPE_CREATURE,sRef,GetLocation(oWP));
	SetMaxHenchmen(18);
	//AddHenchman(oLeader,oHench);
	HenchmanAdd(oLeader,oHench,TRUE,TRUE);
	SetLocalObject(oHench,"oMaster",oLeader);
	SetAssociateState(NW_ASC_MODE_STAND_GROUND,TRUE,oHench);
}

void DasOL_Enc_SpawnAllies(object oPC, object oArea)
{
	if (!GetIsObjectValid(oPC) || !GetIsPC(oPC) || GetIsDM(oPC)) return;
	
	object oLeader = GetFactionLeader(oPC);
	int nSoldiersNum = GetLocalInt(oLeader,"LendOL_Soldiers");
	int nMetaFaction = getMetaFaction(oLeader);
	int nCount; 
	int nSwordC=0; 
	int nArchC=0;
	int nHalbC=0;	
	int nDefaultHenchmen;
	string sLoc; 
	string sRef;
	object oWP;
	string sMetaFaction = IntToString(nMetaFaction);
	int nSwords; 
	int nArchers; 
	int nHalberds;
	float fDelSpawn;
	
	/*
	//Reduce party members # from total soldiers 
	int nPartyMems=0;
	object oPartyMember = GetFirstFactionMember(oLeader,TRUE);
	while (GetIsObjectValid(oPartyMember))
	{
	if (oPartyMember!=oLeader)
	{ nPartyMems++; }
	oPartyMember=GetNextFactionMember(oLeader,TRUE);
	}
	
	nSoldiersNum = nSoldiersNum - nPartyMems;
	*/
	
	nSwords = FloatToInt(IntToFloat(nSoldiersNum) * 0.5); //50% swordsmen
	nArchers = FloatToInt(IntToFloat(nSoldiersNum) * 0.3); //30% archers
	nHalberds = FloatToInt(IntToFloat(nSoldiersNum) * 0.2); //20% polearms
	
	if (bDEBUG)
	{
		SendMessageToPC(oPC,IntToString(nSoldiersNum)+" soliders: "
			+IntToString(nSwords)+ " swords, "
			+IntToString(nArchers)+ " archers, "
			+IntToString(nHalberds)+ " halberds.");
	}
	
	//max henchmen in server is..
	//nDefaultHenchmen = GetMaxHenchmen();
	
	
	// three spawn locations for each mission area
	// waypoints have tags like 'mission_enterwp1'
	// allies have tags like lndol_1_swordsman 
	// where 1 is the PC's metafaction
	while (nCount < nSoldiersNum)
	{
		int nLoc = d3(1);
		sLoc = "mission_enterwp"+IntToString(nLoc);
	
		if (nSwordC < nSwords)
		{
			sRef = "lndol_"+sMetaFaction+"_swordsman";
			nSwordC++;
			fDelSpawn = 0.5;
		}
		else if (nArchC < nArchers)
		{
			sRef = "lndol_"+sMetaFaction+"_archer";
			nArchC++;
			fDelSpawn = 1.0;
		}
		else 
		{
			sRef = "lndol_"+sMetaFaction+"_halberd";		
			fDelSpawn = 1.5;
		}
	
		oWP = GetNearestObjectByTag(sLoc,oPC,1);
		DelayCommand(fDelSpawn,DasOL_Enc_SpawnAlly(sRef, oWP, oLeader));
		nCount++;
	}	
	//DelayCommand(5.0,SetMaxHenchmen(nDefaultHenchmen));
}

void DasOL_Enc_SpawnEnemies(object oArea, int nMetaFac, object oPC)
{
	string sTemplate;
	string sGroupName = GetTag(oArea)+"_N";
	object oWP = GetFirstObjectInArea(oArea);
	object oCreature;
	
	if (bDEBUG) SendMessageToPC(GetFirstPC(),"In the SpawnEnemies Function");
	if (bDEBUG) SendMessageToPC(GetFirstPC(),"nMetFac was passed as "+IntToString(nMetaFac));
	if (bDEBUG) SendMessageToPC(GetFirstPC(),"Spawning Enemies");
	
	while (GetIsObjectValid(oWP))	
	{
		if (bDEBUG) SendMessageToPC(GetFirstPC(),"DEBUG: Found an object");
		if  (GetObjectType(oWP) == OBJECT_TYPE_WAYPOINT)
		{
			if (bDEBUG) SendMessageToPC(GetFirstPC(),"DEBUG: And it's a waypoint.");
	
			if (bDEBUG) SendMessageToPC(GetFirstPC(),"Found a Waypoint");
			sTemplate = GetLocalString(oWP,IntToString(nMetaFac));
			
			if (bDEBUG) SendMessageToPC(GetFirstPC(),"Template was "+sTemplate);
			if (sTemplate != "")
			{
				if (bDEBUG) SendMessageToPC(GetFirstPC(),"And I'm spawning it now.");
				oCreature = CreateObject(OBJECT_TYPE_CREATURE,sTemplate,GetLocation(oWP),FALSE);
				//oCreature = CreateObject(OBJECT_TYPE_PLACEABLE,sTemplate,GetLocation(oWP),FALSE);
				if (GetIsReactionTypeHostile(oPC,oCreature))
				{
					AddToGroup(sGroupName,oCreature);
				}
				else
				{
					AddToGroup("NeutralsGroup",oCreature);
				}
			}
		}
		else
		{
			if (bDEBUG) SendMessageToPC(GetFirstPC(),"DEBUG: And it's NOT  waypoint.");
		}
		
		oWP = GetNextObjectInArea(oArea);
	}	
}

void DasOL_Enc_SpawnPlaceables(object oPC)
{
	if (bDEBUG) SendMessageToPC(GetFirstPC(),"DEBUG: DasOL_Enc_SpawnPlaceables");
	
	int n = 1;
	object oWP = GetNearestObjectByTag("wp_plc_spawn",oPC,n);
	string sTemplate;
	
	while (GetIsObjectValid(oWP))
	{
		sTemplate = GetLocalString(oWP,"sTemplate");
		
		if (bDEBUG) SendMessageToPC(GetFirstPC(),"DEBUG: sTemplate was: "+sTemplate);
		
		if (sTemplate != "")
		{
			if (bDEBUG) SendMessageToPC(GetFirstPC(),"DEBUG: Creating Object");
			CreateObject(OBJECT_TYPE_PLACEABLE,sTemplate,GetLocation(oWP),FALSE);
		}
		n++;
		oWP = GetNearestObjectByTag("wp_plc_spawn",oPC,n);
	}
}


// Enter a area
void DasOL_Enc_Enter(object oPC, object oEnterWP)
{
	if (!GetIsObjectValid(oPC) || !GetIsPC(oPC) || GetIsDM(oPC)) return;
	
	if (DasOL_CheckPartyAligned(oPC) && DasOL_CheckPartyGathered(oPC))
	{
		
		object oArea = GetArea(oEnterWP);
	
		string sAreaTag = GetTag(oArea);
		int nXP = GetJournalQuestExperience(sAreaTag);
		
		if (bDEBUG) SendMessageToPC(oPC,"DasOL_Enc_Enter: sAreaTag is "+sAreaTag);
		if (bDEBUG) SendMessageToPC(oPC,"DasOL_Enc_Enter: Quest Experience is "+IntToString(nXP));
		
		string sGroup = ObjectToString(GetFactionLeader(oPC));
		GroupAddFaction(sGroup, oPC, GROUP_LEADER_FIRST, TRUE);
		//FactionToGroup(oPC,sGroup, GROUP_LEADER_FIRST, TRUE);
		
		object oReEnterWP = CreateObject(OBJECT_TYPE_WAYPOINT,"NW_WAYPOINT001",GetLocation(oPC),FALSE,"DasOL_Return_"+ObjectToString(oPC));
		GroupSetLocalObject(sGroup,"DasOL_Return",oReEnterWP);
		
		GroupSetLocalInt(sGroup,"bVictory",FALSE);
		
		// is there a quest with the same tag as the area?
		if ( nXP > 0 ) 
		{
			AddJournalQuestEntry(sAreaTag,1,oPC,TRUE);
		}
		else // add a generic encounter entry
		{
			AddJournalQuestEntry("dasolm_rand_encounter",1,oPC,TRUE,FALSE,TRUE);
		}	
		
		JumpAlliedParty(oPC,GetTag(oEnterWP));
	}
}

void DasOL_Enc_SetAlliesRemaining(object oLeader)
{
	int nCounter=1; 
	object oHench;
	int nMax = DasOL_GetMaxAllies(oLeader);
	int nRemaining;
	
	oHench = GetHenchman(oLeader,1);
	
	while (GetIsObjectValid(oHench))
	{
		if (bDEBUG) SendMessageToPC(oLeader,"Counting Henchman #"+IntToString(nCounter));
		nCounter++;
		oHench = GetHenchman(oLeader,nCounter);
	}
	
	if (nMax < nCounter-1)
	{
		nRemaining = nMax;
	}
	else
	{
		nRemaining = nCounter-1;
	}
	
	SetLocalInt(oLeader,"LendOL_Soldiers",nRemaining);
	SendMessageToPC(oLeader,"You have "+IntToString(nRemaining)+" troops left under your command.");
}

void DasOL_Enc_RemoveAllies(object oLeader)
{
	int nCounter = 20;
	object oHench;
	
	for (nCounter=GetLocalInt(oLeader,"LendOL_Soldiers"); nCounter>0; nCounter--)
	{
		oHench = GetHenchman(oLeader,nCounter);
		RemoveHenchman(oLeader,oHench);
		// clear my actions
		AssignCommand(oHench,ClearAllActions(TRUE));
		// make me appear to run towards the exit
		AssignCommand(oHench,ActionForceMoveToLocation(GetLocation(GetNearestObjectByTag("std_respawn_area_wp"))));
		// destroy me
		DestroyObject(oHench, 3.0f);
		if (bDEBUG) SendMessageToPC(oLeader,"Removing Henchman #"+IntToString(nCounter));	
	}
}

// Leave an area
void DasOL_Enc_Exit(object oPC, int bVictory)
{
	if (!GetIsObjectValid(oPC) || !GetIsPC(oPC) || GetIsDM(oPC)) return;
	
	object oLeader = GetFactionLeader(oPC);
	object oHench;
	object oReEnterWP;
	object oTarg;
	int nSoldiersNum = GetLocalInt(oLeader,"LendOL_Soldiers");
	string sAreaTag = GetTag(GetArea(oPC));
		
	oReEnterWP = GetLocalObject(oPC,"DasOL_Return");
	
	// special case
	if (bVictory == 3)
	{
		DelayCommand(2.0,JumpAlliedParty(oPC,GetTag(oReEnterWP)));
		return;
	}
	
	if (DasOL_CheckPartyAligned(oPC) && DasOL_CheckPartyGathered(oPC))
	{
		// This section, which awards Bonus XP, is only run for victory.
		if(bVictory == 1)
		{
			// is there a quest with the same tag as the area? success
			if ( GetJournalQuestExperience(sAreaTag) > 0 ) 
			{
				// unless of course they've already earned it due
				// to normal questwriting stuff that happened in 
				// the area while they were there
				if (GetJournalEntry(sAreaTag,oPC) == 1)
				{
					AddJournalQuestEntry(sAreaTag,2,oPC,TRUE);
					RewardPartyQuestXP(oPC, sAreaTag);
				}
			}
			else // add a generic encounter entry
			{
				AddJournalQuestEntry("dasolm_rand_encounter",2,oPC,TRUE,FALSE,TRUE);
				RewardPartyQuestXP(oPC, "dasolm_rand_encounter");
			}		
			
			// Bump renown
			changePCPartyMetaFactionRenown(oPC,1);
		}		
		else
		{	
			// is there a quest with the same tag as the area? failure
			if ( GetJournalQuestExperience(sAreaTag) > 0 ) 
			{
				AddJournalQuestEntry(sAreaTag,3,oPC,TRUE);
			}
			else // update a generic encounter entry failed
			{
				AddJournalQuestEntry("dasolm_rand_encounter",3,oPC,TRUE,FALSE,TRUE);
			}
			
			// Ding renown
			changePCPartyMetaFactionRenown(oPC,-1);
		}

		// special: if you stealthed in, remove bNoAllies var
		// and don't mess with the recorded number of allies
		if (GetLocalInt(oLeader,"bNoAllies") == 1)
		{
			DeleteLocalInt(oLeader,"bNoAllies");
		}
		else
		{
			// otherwise go ahead and decrement the recorded
			// number of allies to the remaining or max #
			//DasOL_Enc_SetAlliesRemaining(oLeader); 
			// WIRED: Henchman now have an OnDeath that decrements
			// this so there's no need to do it on exit
			if (oPC == oLeader)
			{
				SendMessageToPC(oLeader,"You have "+IntToString(nSoldiersNum)+" troops left under your command.");
			}
		}	
		
		// always remove allies, whether we think we 
		// had them or not, could have picked one up
		// through regular quest-type stuff or error
		DasOL_Enc_RemoveAllies(oLeader);
		
		//DasOL_CleanArea(oPC);
		DelayCommand(2.0,JumpAlliedParty(oPC,GetTag(oReEnterWP)));
	}
}

void DasOL_Enc_AreaOnExit(object oExiter)
{
	string sLeft;
	object oCreature;
	object oArea = OBJECT_SELF;
	
	if (bDEBUG) SendMessageToPC(oExiter,"Running DasOL_Enc_AreaOnExit()");
	
    object oPC = GetFirstPC();
	
	while (oPC != OBJECT_INVALID)
    {
        if (OBJECT_SELF == GetArea(oPC) && !GetIsDM(oPC)) 
		{
			if (bDEBUG) SendMessageToPC(oExiter,"Someobody's still in there, exiting.");
			return;
		}
        else oPC = GetNextPC();
    }
    
	// If we've made it this far, we know that there aren't any PCs in the area
	// We now resume our scheduled despawning.
	
    oCreature = GetFirstObjectInArea(oArea);
    
	while (oCreature != OBJECT_INVALID)
    {		
		if (GetObjectType(oCreature) == OBJECT_TYPE_CREATURE)
		{
			//sLeft = GetStringLeft(GetTag(oCreature),6);
			//if (sLeft == "lndol_") { 
			
			// KILL 'EM ALL!!
			DestroyObject(oCreature); 
			
			//}
		}
        oCreature = GetNextObjectInArea(oArea);
    }
	
	if (bDEBUG) SendMessageToPC(oExiter,"bInUse was "+IntToString(GetLocalInt(oArea,"bInUse")));
	if (bDEBUG) SendMessageToPC(oExiter,"oPartyLeader was "+ObjectToString(GetLocalObject(oArea,"oPartyLeader")));
	
	if (bDEBUG) SendMessageToPC(oExiter,"Freeing Area Up");
	// free up the area
	DeleteLocalInt(oArea,"bInUse");
	DeleteLocalObject(oArea,"oPartyLeader");
	
	if (bDEBUG) SendMessageToPC(oExiter,"bInUse is now "+IntToString(GetLocalInt(oArea,"bInUse")));
	if (bDEBUG) SendMessageToPC(oExiter,"oPartyLeader is now "+ObjectToString(GetLocalObject(oArea,"oPartyLeader")));
	
	ExecuteScript("j4acs_ha_exit",oArea);
}

// Sets the area as being in use by a particular metafaction
void DasOL_Enc_AreaSetInUse(object oArea, object oLeader, int nMetaFaction = 0)
{
	if (GetIsObjectValid(oArea))
	{
		SetLocalInt(oArea,"bInUse",nMetaFaction);
		SetLocalObject(oArea,"oPartyLeader",oLeader);
	}
}

// Returns the MetaFaction using the area or zero
// if the area is free
int DasOL_Enc_AreaGetInUse(object oArea)
{
	if (bDEBUG) SendMessageToPC(GetFirstPC(),"Running DasOL_Enc_AreaGetInUse()");
	
	int bInUse = GetLocalInt(oArea,"bInUse");
	if (bDEBUG) SendMessageToPC(GetFirstPC(),"DasOL_Enc_AreaGetInUse() bInUse was "+IntToString(bInUse));
	
	if (bInUse > 0) 
	{
		return bInUse;
	}
	else 
	{
		return 0;
	}
}

// wired 08/02/10: For the time being, treat Rebels & Imperials as friendlies entering an area (to be expanded)
int DasOL_Enc_Check(object oPC, object oArea)
{
	if (!GetIsPC(oPC)) return 0;

	if (bDEBUG) SendMessageToPC(oPC,"Running DasOL_Enc_Check()");		
	
	int nMetaFac;
	int nOccupiedBy;
	object oLeader = GetFactionLeader(oPC);
	nMetaFac = getMetaFaction(oLeader);
	
	nOccupiedBy = DasOL_Enc_AreaGetInUse(oArea);
	
	if (bDEBUG) SendMessageToPC(oPC,"DasOL_Enc_AreaGetInUse() returned "+IntToString(nOccupiedBy));	
	
	if (GetLocalObject(oArea,"oPartyLeader") == oLeader) return 0;
	
	// area is occupied, send a shout
	if (nOccupiedBy == 0)
	{
		if (bDEBUG) SendMessageToPC(oPC,"DEBUG: Area unoccupied.");
		return 0;
	}
	// different faction is in the area	
	if (nOccupiedBy != nMetaFac)
	{
		// AND one of these factions is 3/Canite
		if (nOccupiedBy == 3 || nMetaFac == 3)
		{
			if (bDEBUG) SendMessageToPC(oPC,"DEBUG: DasOL_Enc_Check() nMetaFac (of leader) was different than the one found on the area.");
			return 1; // occupied by hostile
		}
		// otherwise it's 1 & 2 together, so pretend friendly
		else
		{			
			if (bDEBUG) SendMessageToPC(oPC,"DEBUG: DasOL_Enc_Check() nOccupied == nMetaFac, occupied by friendlies.");
			return 2; // occupied by friendly
		}
	}
	// back to the case where it's a real friendy
	if (nOccupiedBy == nMetaFac)
	{
		if (bDEBUG) SendMessageToPC(oPC,"DEBUG: DasOL_Enc_Check() nOccupied == nMetaFac, occupied by friendlies.");
		return 2; // occupied by friendly
	}
	else
	{
	 	if (bDEBUG) SendMessageToPC(oPC,"DEBUG: DasOL_Enc_Check() Something stupid happened but I'm pretending the area's unoccupied.");
		return 0; // unoccupied
	}
}

// TO DO: Rewrite so sounds aren't actions?
// This is only firing for the party leader, so use oPC
void DasOL_Enc_AreaOCE(object oArea, object oPC)
{
	if (!GetIsObjectValid(oPC) || !GetIsPC(oPC) || GetIsDM(oPC) || GetLocalInt(oArea,"bSupress") == 1 ) return;
	
	if (bDEBUG) SendMessageToPC(oPC,"Inside DasOL_DoRecruit()");
	
	object oReEnterWP;
	
	// failsafe: bunch of unaligned players in one party
	// entering together, just kick them right back out
	// to where they started, fyi: oPC is party leader here
	if (!DasOL_CheckPartyAligned(oPC))
	{
		oReEnterWP = GetLocalObject(oPC,"DasOL_Return");
		JumpPartyToArea(oPC, oReEnterWP);
	}
	
	object oLeader = GetFactionLeader(oPC); // ALWAYS THE INCOMING LEADER
	object oNewMember;						// ALWAYS INCOMING PARTYMEMBER
	object oRealLeader;						// ALWAYS THE LEADER OF RECORD
	object oExistMember;					// ALWAYS LEADER OF RECORD MEMBER

	int nMetaFac = getMetaFaction(oLeader);
	int nExclude = GetLocalInt(oArea, "nExclude");	
	
	object oSound= GetNearestObjectByTag("clarion_horn",oPC);

	
	if (!GetIsObjectValid(oLeader) && bDEBUG) SendMessageToPC(oPC,"DEBUG: No valid leader");
	if (nMetaFac == 0 && bDEBUG) SendMessageToPC(oPC,"DEBUG: Failed to get your party leader's metafaction.");	
	
	switch (DasOL_Enc_Check(oPC,oArea))
	{
		case 0: // regular way
					
			DasOL_Enc_AreaSetInUse(oArea, oLeader, nMetaFac); 
			if (bDEBUG) SendMessageToPC(oPC,"Case 0: Spawning Enemies from AreaOCE");
			
			// A "do nothing" switch for a particular faction, first implemented
			// for canite temple
			if (nMetaFac != nExclude)
			{
				DasOL_Enc_SpawnEnemies(oArea, nMetaFac,oLeader);
				DasOL_Enc_SpawnPlaceables(oLeader);
				if (bDEBUG) SendMessageToPC(oPC,"Spawning Allies");
			}
				
			if (GetLocalInt(oLeader,"bNoAllies") != 1)
			{
				DelayCommand(3.0,DasOL_Enc_SpawnAllies(oPC,oArea));
			}
			
		break;
		
		case 1:	// hostiles entering
		
			if (bDEBUG) SendMessageToPC(oPC,"Case 1: catches hostile occupation condition");			
			
			// special case, just boot entering hostile party
			if (GetLocalInt(oArea,"nOpposedAllowAllies") == 1 && oLeader != oRealLeader)
			{
				SendMessageToPC(oLeader,"There is a battle going on in this area and you are unable to safely approach.");
				oReEnterWP = GetLocalObject(oLeader,"DasOL_Return");
				JumpPartyToArea(oLeader, oReEnterWP);
			}
			
			if (GetLocalInt(oLeader,"bNoAllies") != 1)
			{
				DelayCommand(3.0,DasOL_Enc_SpawnAllies(oPC,oArea));
			}
			// notify exiting players in the area
			oRealLeader = GetLocalObject(oArea,"oPartyLeader");
			SoundObjectPlay(oSound);
			
			oExistMember = GetFirstFactionMember(oRealLeader);
			while (GetIsObjectValid(oExistMember) && GetArea(oExistMember) == oArea)
			{			
				FloatingTextStringOnCreature("Hostile forces have entered the area!",oExistMember,FALSE);
				oExistMember = GetNextFactionMember(oRealLeader);			
			}
			
			// notifying incoming players			
			oNewMember = GetFirstFactionMember(oLeader);
			while (GetIsObjectValid(oNewMember) && GetArea(oNewMember) == oArea)
			{			
				FloatingTextStringOnCreature("This area is occupied by a hostile force!",oNewMember,FALSE);
				oNewMember = GetNextFactionMember(oLeader);			
			}
			
		break;
		
		case 2:	// allies entering
		
			// i'm going to say in this instance, don't double-up the allies
			// oLeader still has his/her number of solider recorded if they
			// want to split up or choose a new leader later
			if (bDEBUG) SendMessageToPC(oPC,"Case 2: Allies Entering");
			
			oRealLeader = GetLocalObject(oArea,"oPartyLeader");
			
			// do nothing on a re-join
			if (oRealLeader == oLeader) return;
			
			SoundObjectPlay(oSound);

			// inform the existing party that they're being joined
			oExistMember = GetFirstFactionMember(oRealLeader);
			
			while (GetIsObjectValid(oExistMember) && GetArea(oExistMember) == oArea)
			{			
				FloatingTextStringOnCreature("Reinforcements have arrived!",oExistMember,FALSE);
			
			oExistMember = GetNextFactionMember(oRealLeader);			
			}			
						
			// bust the incoming party
			// and add it to the existing
			oNewMember = GetFirstFactionMember(oLeader);
			
			while (GetIsObjectValid(oNewMember))
			{
				if (GetArea(oNewMember) == oArea)
				{
					// avoid an infinite loop
					if (oNewMember != oLeader)
					{
						RemoveFromParty(oNewMember);
						AddToParty(oNewMember,oRealLeader);						
						FloatingTextStringOnCreature("You find this area occupied by friendly forces and join their party!",oNewMember,FALSE);
					}	
				}
				
			oNewMember = GetNextFactionMember(oLeader);
			}
			// now put the leader in
			AddToParty(oLeader,oRealLeader);
			FloatingTextStringOnCreature("You find this area occupied by friendly forces and join their party!",oLeader,FALSE);
			
		break;
		
		default:
		SendMessageToPC(oPC,"DasOL_Enc_Check()fails to catch anythng");
	}
}

// Adjusts a PC's personal rep to players and NPC faction on enter
void DasOL_setRepsOnEnter(object oPC, int bDoPlayer = TRUE)
{
	if (!GetIsObjectValid(oPC) || !GetIsPC(oPC) || GetIsDM(oPC)) return;
	
	if (bDEBUG) SendMessageToPC(oPC,"Hey, I'm in DasOL_setRepsOnEnter()");
   
    int nFac = getMetaFaction(oPC);
	
	// no reason to do anything if PC
	// isn't in a faction, so don't
	if (nFac < 1) return;
	
	if (bDEBUG) SendMessageToPC(oPC,"And you're in MF #"+IntToString(nFac));
		
    int nPlayerFac;
    object oPlayer;
	string sAreaTag;
   
	if (bDoPlayer == TRUE)
	{
	    // First set player dis/like
	    oPlayer = GetFirstPC();
		
		if (bDEBUG) SendMessageToPC(oPC,"Doing Player Dislike");
			
	    while (GetIsObjectValid(oPlayer))
	    {
			sAreaTag = GetTag(GetArea(oPlayer));
			if (bDEBUG) SendMessageToPC(oPC,"In the Player Loop, checking "+GetFirstName(oPlayer)+" in "+sAreaTag);
		
	        // player is on the map
	        if (FindSubString(sAreaTag,"lendose_ol",0) != -1)
	        {
				if (bDEBUG) SendMessageToPC(oPC,GetFirstName(oPlayer)+" is on the battlefield");
				
				nPlayerFac = getMetaFaction(oPlayer);
				if (bDEBUG) SendMessageToPC(oPC,GetFirstName(oPlayer)+"'s faction is "+IntToString(nPlayerFac));
	           
	            // player factions not equal, set hostile
	            if (nPlayerFac > 0 && nPlayerFac != nFac)
	            {
					// wired 08/02/10: only if if either of the unequal factions is 3/Canite
					 if (nPlayerFac == 3 || nFac == 3)
	            	 {
		                SetPCDislike(oPC,oPlayer);
						SetPCDislike(oPlayer,oPC);
						if (bDEBUG) SendMessageToPC(oPC,"You're in different factions and SHOULD dislike each other");
					 }
	            }
	   
	            // player factions the same, set friendly
	            if     (nPlayerFac > 0 && nPlayerFac == nFac)
	            {
	                SetPCLike(oPC,oPlayer);
					SetPCLike(oPlayer,oPC);
					if (bDEBUG) SendMessageToPC(oPC,"Prob uncessary, but ensuring you like each other.");
	            }   
			}
			oPlayer = GetNextPC();
	    }   
	   if (bDEBUG) SendMessageToPC(oPC,"Exited Player Loop");
	}
	
    // Now set NPC dis/like
	if (bDEBUG) SendMessageToPC(oPC,"Doing Faction Dislike");
	
	// wired 08/02/10: Rebels vs Imperial set NPCs to 50/Neutral
    switch (nFac)
    {
        case 1:
			if (bDEBUG) SendMessageToPC(oPC,"IMPERIAL");
            DasOL_setReps(oPC,1,100);
            DasOL_setReps(oPC,2,50);
            DasOL_setReps(oPC,3,0);
        break;
        case 2:
			if (bDEBUG) SendMessageToPC(oPC,"REBEL");
            DasOL_setReps(oPC,1,50);
            DasOL_setReps(oPC,2,100);
            DasOL_setReps(oPC,3,0);
        break;
        case 3:
			if (bDEBUG) SendMessageToPC(oPC,"CANITE");
            DasOL_setReps(oPC,1,0);
            DasOL_setReps(oPC,2,0);
            DasOL_setReps(oPC,3,100);
        break;
        default:
        SendMessageToPC(oPC,"DasOL_setRepsOnEnter: Something terrible happened.");
    }
}

void DasOL_fixReps(object oPC)
{
	object oPlayer = GetFirstPC();
	
	while (GetIsObjectValid(oPlayer))
    {
	    SetPCLike(oPC,oPlayer);
		SetPCLike(oPlayer,oPC);
		oPlayer = GetNextPC();
	}
}

void DasOL_setReps(object oPC, int nMetaFaction, int nTargetRep)
{
	if (!GetIsObjectValid(oPC) || !GetIsPC(oPC) || GetIsDM(oPC)) return;
	
	if (bDEBUG) SendMessageToPC(oPC,"Setting Player's Reps vs. Faction #"+IntToString(nMetaFaction));
   
    int nCurRep;
	
    object oMember;
	object oPlayer;
   
    if (nMetaFaction == 1) oMember = GetObjectByTag(METAFAC_IMPERIAL_PROXY);
    if (nMetaFaction == 2) oMember = GetObjectByTag(METAFAC_REBEL_PROXY);
    if (nMetaFaction == 3) oMember = GetObjectByTag(METAFAC_CANITE_PROXY);
   
    nCurRep        =    GetReputation(oMember,oPC);       
    if (bDEBUG) SendMessageToPC(oPC,"Current Rep was "+IntToString(nCurRep));
	
    // adjust up
    if  (nCurRep < nTargetRep)
    {
		if (bDEBUG) SendMessageToPC(oPC,"Adjusting Up");
        AdjustReputation(oPC, oMember,50);
    }
   
    // adjust down
    if  (nCurRep > nTargetRep)
    {
		if (bDEBUG) SendMessageToPC(oPC,"Adjusting Down");
        AdjustReputation(oPC,oMember,-50);
    }
}

void CleanOLArea(object oPC)
{
	int nEnemy = 1;
	int nItem = 1;
	int nPlaceable = 1;
	int nAoE = 1;
	
	object oGroundItem	= GetNearestObject(OBJECT_TYPE_ITEM, oPC, nItem);
	object oCreature	= GetNearestCreature(CREATURE_TYPE_IS_ALIVE,CREATURE_ALIVE_BOTH, oPC, nEnemy);
	object oPlaceable	= GetNearestObject(OBJECT_TYPE_PLACEABLE, oPC, nPlaceable);
	object oAoE			= GetNearestObject(OBJECT_TYPE_AREA_OF_EFFECT, oPC);
	
	/*	Destroy any hostile creatures which are still alive.	*/
	while(GetIsObjectValid(oCreature))			
	{
		if(!GetFactionEqual(oCreature, oPC))	//Don't delete members of the Player Faction, because that will make the player sad.
		{
			PrettyDebug("Removing remaining creatures.");
			object oItem = GetFirstItemInInventory(oCreature);
			while(GetIsObjectValid(oItem))
			{
				PrettyDebug("Removing Item from Creature");
				DestroyObject(oItem, 0.2f);
				oItem = GetNextItemInInventory(oCreature);
			}
			DestroyObject(oCreature, 0.5f);
		}
		nEnemy++;
		oCreature = GetNearestCreature(CREATURE_TYPE_IS_ALIVE,CREATURE_ALIVE_BOTH, oPC, nEnemy);
	}

	/*	Destroy all items which are lying on the ground.	*/	
	while (GetIsObjectValid(oGroundItem))
	{
		PrettyDebug("Removing trash.");
		DestroyObject(oGroundItem, 0.5f);
		nItem++;
		oGroundItem = GetNearestObject(OBJECT_TYPE_ITEM, oPC, nItem);
	}
	
	/*	Destroy any Placeables containing items	*/
	while (GetIsObjectValid(oPlaceable))
	{
		if(GetHasInventory(oPlaceable))
		{
			object oItem = GetFirstItemInInventory(oPlaceable);
			while(GetIsObjectValid(oItem))
			{
				PrettyDebug("Removing Item from Placeable Container");
				DestroyObject(oItem, 0.2f);
				oItem = GetNextItemInInventory(oPlaceable);
			}
			
			PrettyDebug("Removing placeable with inventory.");
			DestroyObject(oPlaceable, 0.5f);
		}
		
		nPlaceable++;
		oPlaceable = GetNearestObject(OBJECT_TYPE_PLACEABLE, oPC, nPlaceable);
	}
	
	while(GetIsObjectValid(oAoE))
	{
		object oAoECreator = GetAreaOfEffectCreator(oAoE);
		if( GetFactionEqual(oAoECreator, oPC) == FALSE || GetAreaOfEffectDuration(oAoE) != DURATION_TYPE_PERMANENT )
		{
			PrettyDebug("Removing AoE.");
			DestroyObject(oAoE, 0.5f);
		}
		nAoE++;
		oAoE = GetNearestObject(OBJECT_TYPE_AREA_OF_EFFECT, oPC, nAoE);
	}
}

void DasOL_DeathHook(object oDead, object oKiller)
{
	int nMetaDead = getMetaFaction(oDead);
	int nMetaKill = getMetaFaction(oKiller);
	int nMod = 3; // starting up/down renown in a pvp of same or lower level
	object oArea = GetArea(oDead);
	string sAreaTag = GetTag(oArea);
	int nRankDead = getRank(getPCMetaFactionRenown(oDead)) +1;	// rank could be zero, so add 1
	int nRankKiller = getRank(getPCMetaFactionRenown(oKiller)) +1; // rank could be zero, so add 1
	int nDiff = nRankDead - nRankKiller; // if difference is 0, same rank
	
	// if killer is lower rank than loser, increase renown
	// to 3 times difference between their ranks
	if (nDiff > 0) nMod = nMod + (nDiff *3);

	if (nMetaDead != nMetaKill)
	{	
		// Fail the mission
		if ( GetJournalQuestExperience(sAreaTag) > 0 ) 
		{
			AddJournalQuestEntry(sAreaTag,3,oDead,TRUE);
		}
		else // update a generic encounter entry failed
		{
			AddJournalQuestEntry("dasolm_rand_encounter",3,oDead,TRUE);
		}
		
		/*
		// Withdraw Allies
		if (GetFactionLeader(oDead) == oDead)
		{
			//set my remaning allies
			DasOL_Enc_SetAlliesRemaining(oDead); 
		
			//and withdraw them
			DasOL_Enc_RemoveAllies(oDead);	
		}
		*/
		
		AddJournalQuestEntry("dasolm_PVP",1,oKiller);	

		changePCMetaFactionRenown(oDead,-nMod);
		changePCMetaFactionRenown(oKiller,nMod);
	}
}

location DasOL_RespawnHook(object oPC)
{
	int nMetaFac = getMetaFaction(oPC);
	string sAreaTag = GetTag(GetArea(oPC));
	
	// We might want to set the faction NPC to 
	// remark on PC's failure or something....
	SetLocalInt(oPC,"OLM_Respawned",GetLocalInt(oPC,"OLM_Respawned")+1);
	
	if (sAreaTag != "lendose_ol_map")
	{
		// Fail the mission
		if ( GetJournalQuestExperience(sAreaTag) > 0 ) 
		{
			AddJournalQuestEntry(sAreaTag,3,oPC,TRUE);
		}
		else // update a generic encounter entry failed
		{
			AddJournalQuestEntry("dasolm_rand_encounter",3,oPC,TRUE,FALSE,TRUE);
		}
	}
	
	if (GetLocalInt(oPC,"bNoAllies") == 1)
	{
		DeleteLocalInt(oPC,"bNoAllies");
	}	
	
	// Withdraw Allies
	if (GetFactionLeader(oPC) == oPC)
	{
		//set my remaning allies
		DasOL_Enc_SetAlliesRemaining(oPC); 
	
		//and withdraw them
		DasOL_Enc_RemoveAllies(oPC);	
	}
		
	// PC and his metafaction lose renown for respawning
	changePCMetaFactionRenown(oPC,-1);
	
	// Fix Reps
	DasOL_fixReps(oPC);
	
	// Respawn location is faction "home base"
	return GetLocation( GetObjectByTag("lendose_OLM_rspwn"+IntToString(nMetaFac)) ); 
}

int IsGroupHostile(string sGroupName, object oPC)
{
	object oGroupMember = GetFirstInGroup(sGroupName);
	
	if (bDEBUG) SendMessageToPC(oPC,GetName(oGroupMember)+" is the first member in Group: "+sGroupName);
	
	while(GetIsObjectValid(oGroupMember))
	{
		if(GetIsReactionTypeHostile(oPC, oGroupMember))
		{
			if (bDEBUG) SendMessageToPC(oPC,GetName(oGroupMember)+" is hostile to you, returning TRUE");
			return TRUE;
		}
		oGroupMember = GetNextInGroup(sGroupName);
	}
	
	if (bDEBUG) SendMessageToPC(oPC,"No members were hostile to you.");
	return FALSE;
}


/*

void main()
{

}
*/