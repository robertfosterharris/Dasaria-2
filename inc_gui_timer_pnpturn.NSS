// inc_gui_timer_pnpturn
// DM Loki
// Version 2.2
// Include file for PnPTurn system.
// Timer functions by ---.
// 06/20/12

#include "ginc_actions"
#include "X0_I0_PARTYWIDE"
#include "nw_i0_spells"

// Constants
//------------------------------------------------------------------------------

const string GUI_TIMER_XML = "pnptimer.xml";
const string GUI_TIMER_SCREEN_NAME = "SCREEN_TIMER";
const string GUI_TIMER_TEXT_NAME = "TIMER_TEXT";
const string GUI_TIMER_TEXT_DEFAULT = "Time Remaining";
const string GUI_TIMER_VARNAME_TIMEVAR = "GUITimer_TimeVar";
const string GUI_TIMER_VARNAME_STOPVAR = "GUITimer_StopVar";
const string GUI_TIMER_VARNAME_OPEN = "GUITimer_Open"; //Do not manually change this variable

//------------------------------------------------------------------------------
// Function prototypes
//------------------------------------------------------------------------------
void StartTimer(object oPC);

void DecTimer(object oPC, string sTimeVar, string sStopVar);

void EndTimer(object oPC);

void PauseTimer(object oPC);

void ResumeTimer(object oPC);

void CloseTimer(object oPC);

void ClearUpTimer(object oPC);

void AdjustTimer(object oPC, int nAdjust);

int IsTimerActive(object oPC);

void PnPPopulate(object oPC, object oTarget);

void PnPSort(object oPC);

void TurnAdvance(object oPC);

void PnPClear(object oPC);

void PnPList(object oPC);

void PnPSelect(object oPC);

void PnPListUpdate(object oPC);

void PnPTokenGen(object oPC);

object CreatureMatch(string sMatch, int iType);


//------------------------------------------------------------------------------
// Function definitions
//------------------------------------------------------------------------------

//Private function for StartTimer().
//Repeatedly lowers the timer value by one each second.
void DecTimer(object oPC, string sTimeVar, string sStopVar)
{
if (GetGlobalInt("pnp_debug")>1) {SendMessageToAllDMs("DecTimer(oPC): " + GetName(oPC));}//Debug

	if(!GetLocalInt(oPC, GUI_TIMER_VARNAME_OPEN))
	{
		return;
	}
	
	int n = GetLocalInt(oPC, sTimeVar);
	if(!n)
	{
		ExecuteScript("n_pnptimer",oPC);
		ClearUpTimer(oPC);
		return;
	}
	
	int nStop = GetLocalInt(oPC, sStopVar);
	if(nStop == 1)
	{
		ClearUpTimer(oPC);
		return;
	}
	
	if(nStop != 2)
	{
		n--;
	}
	
	SetLocalInt(oPC, sTimeVar, n);
	if (GetGlobalInt("pnp_debug")>1) {SendMessageToAllDMs("DecTimer n " + IntToString(n));}//Debug
	DelayCommand(1.0, DecTimer(oPC, sTimeVar, sStopVar));
}

//------------------------------------------------------------------------------
//Begins the timer for oPC. Note that oPC can have only one timer active at
//once.
void StartTimer(object oPC)
{
	if (GetGlobalInt("pnp_debug")>1) {SendMessageToAllDMs("StartTimer(oPC): " + GetName(oPC));}//Debug
	string sTimeVar = "GUITimer_TimeLeft";
	string sStopVar = "GUITimer_StopVar";
	
	SetLocalInt(oPC, GUI_TIMER_VARNAME_OPEN, TRUE);
	SetLocalString(oPC, GUI_TIMER_VARNAME_STOPVAR, sStopVar);
	SetLocalString(oPC, GUI_TIMER_VARNAME_TIMEVAR, sTimeVar);
	SetLocalInt(oPC, "GUITimer_TimeLeft", 30);
	DisplayGuiScreen(oPC, "SCREEN_TIMER", FALSE, "pnptimer.xml");
	
	DelayCommand(1.0, DecTimer(oPC, sTimeVar, sStopVar));
}

//------------------------------------------------------------------------------
//Tells oPC's timer to stop on the next iteration. This is just a wrapper for
//setting the correct variable on oPC (see StartTimer()).
void EndTimer(object oPC)
{
	if (GetGlobalInt("pnp_debug")>1) {SendMessageToAllDMs("EndTimer(oPC): " + GetName(oPC));}//Debug
	SetLocalInt(oPC, GetLocalString(oPC, GUI_TIMER_VARNAME_STOPVAR), 1);
}

//------------------------------------------------------------------------------
//Pauses the timer for oPC. Note that if you have just set the timer to close on
//its next iteration, this will cause it to pause *instead* of closing.
void PauseTimer(object oPC)
{
	if (GetGlobalInt("pnp_debug")>1) {SendMessageToAllDMs("PauseTimer(oPC): " + GetName(oPC));}//Debug
	SetLocalInt(oPC, GetLocalString(oPC, GUI_TIMER_VARNAME_STOPVAR), 2);
}

//------------------------------------------------------------------------------
//Resumes the timer for oPC. Note that if you have just set the timer to close on
//its next iteration, this will prevent that.
void ResumeTimer(object oPC)
{
	if (GetGlobalInt("pnp_debug")>1) {SendMessageToAllDMs("ResumeTimer(oPC): " + GetName(oPC));}//Debug
	SetLocalInt(oPC, GetLocalString(oPC, GUI_TIMER_VARNAME_STOPVAR), FALSE);
}

//------------------------------------------------------------------------------
//Closes the timer for oPC. You can make the timer close itself by calling
void CloseTimer(object oPC)
{
	if (GetGlobalInt("pnp_debug")>1) {SendMessageToAllDMs("CloseTimer(oPC): " + GetName(oPC));}//Debug
	SetLocalInt(oPC, GUI_TIMER_VARNAME_OPEN, FALSE);
	CloseGUIScreen(oPC, GUI_TIMER_SCREEN_NAME);
}

//------------------------------------------------------------------------------
//Closes the timer for oPC and cleans up all related variables. This is done
//automatically by the timer if you stop it using EndTimer(), but if you want to
//do it instantly, you can use this function.
void ClearUpTimer(object oPC)
{
	if (GetGlobalInt("pnp_debug")>1) {SendMessageToAllDMs("ClearUpTimer(oPC): " + GetName(oPC));}//Debug
	SetLocalInt(oPC, GUI_TIMER_VARNAME_OPEN, FALSE);
	CloseGUIScreen(oPC, GUI_TIMER_SCREEN_NAME);
	
	string sStopVar = GetLocalString(oPC, GUI_TIMER_VARNAME_STOPVAR);
	string sTimeVar = GetLocalString(oPC, GUI_TIMER_VARNAME_TIMEVAR);
	DelayCommand(0.5, DeleteLocalString(oPC, GUI_TIMER_VARNAME_STOPVAR));
	DelayCommand(0.5, DeleteLocalString(oPC, GUI_TIMER_VARNAME_TIMEVAR));
	DelayCommand(0.5, DeleteLocalInt(oPC, sStopVar));
	DelayCommand(0.5, DeleteLocalInt(oPC, sTimeVar));
}

//------------------------------------------------------------------------------
//Adjusts oPC's timer by nAdjust.
void AdjustTimer(object oPC, int nAdjust)
{
	if (GetGlobalInt("pnp_debug")>1) {SendMessageToAllDMs("AdjustTimer(oPC): " + GetName(oPC));}//Debug
	string sTimeVar = GetLocalString(oPC, GUI_TIMER_VARNAME_TIMEVAR);
	int n = GetLocalInt(oPC, sTimeVar);
	
	n += nAdjust;
	if(!n)
	{
		n = 0;
	}
	
	SetLocalInt(oPC, sTimeVar, n);
}

//------------------------------------------------------------------------------
//Returns whether oPC has a timer currently active. Note that the timer is
//considered active if the GUI is open - it may or may not be paused.
int IsTimerActive(object oPC)
{
	if (GetGlobalInt("pnp_debug")>1) {SendMessageToAllDMs("IsTimerActive(oPC): " + GetName(oPC));}//Debug
	return GetLocalInt(oPC, GUI_TIMER_VARNAME_OPEN);
}

//-------------------------------------------------------------------------------------------------------
// Function to populate player list.
void PnPPopulate(object oPC, object oTarget)
{
if (GetGlobalInt("pnp_debug")>1) {SendMessageToAllDMs("PnPPopulate(oPC,oTarget): " + GetName(oPC) + GetName(oTarget));}//Debug

string sLoop,sPC,sPC1,sPCDex,sPCInit,sPCName,sName,sPCroll,sPCmod,sPCInitT,sJA,sJB,sPCNameA,sPCNameB,sPCInitA,sPCInitB,sTempA,sTempB,sActivName,sPartyCount,sPosition,sTarget,sPCList;
int i,j,iPCroll,iPCDex,iPCInit,iPartyCount,iPosition,iInitA,iInitB,iPlayerCount;
object oCreature,oRecord,oTarget;
effect eDur;

//Pull CDKEY of DM from activator, set up variables using CDKEY as prefix.
sActivName = GetPCPublicCDKey(oPC);
sPC1 = sActivName + "sPC1";
sPartyCount = sActivName + "iPartyCount";
sPosition = sActivName + "iPosition";
oRecord  = GetObjectByTag("PnP_Turn_Record");
SetEffectSpellId(EffectNWN2SpecialEffectFile("pnpturneffect"),-50);

if (GetIsObjectValid(oTarget))
	{
	if (GetGlobalInt("pnp_debug")>2) {SendMessageToAllDMs("PnPPopulate: GetIsObjectValid(oTarget) = TRUE");}//Debug
	iPartyCount = GetLocalInt(oRecord, sPartyCount);
	i = iPartyCount;
	oCreature = oTarget;
	} else
		{
		if (GetGlobalInt("pnp_debug")>2) {SendMessageToAllDMs("PnPPopulate: GetIsObjectValid(oTarget) = FALSE");}//Debug
		iPartyCount = 0;
		i=0;
		oCreature = GetFirstPC(TRUE);
		}

while (GetIsObjectValid(oCreature))
	{
	if (sActivName == GetLocalString(GetItemPossessedBy(oCreature, "pnpturn"), "sActivName"))
		{
		//Clear off remaining VFX from old party list
		effect eEffect = GetFirstEffect(oCreature);
		while (GetIsEffectValid(eEffect))
			{
			if (GetEffectSpellId(eEffect) == -50)
				{RemoveEffect(oCreature, eEffect);}
			eEffect = GetNextEffect(oCreature);
			}
		i++;
		sLoop = IntToString(i);
		if (GetGlobalInt("pnp_debug")>3) {SendMessageToAllDMs("sLoop: " + sLoop);}	
		sPCDex = "iPC" + sLoop + "Dex";
		sPCInit = sActivName + "iPC" + sLoop + "Init";
		sPCName = sActivName + "sPC" + sLoop;	
		sName = GetName(oCreature);
		iPCDex = GetAbilityModifier(1, oCreature);
		if (GetHasFeat(377, oCreature) == 1) 
			{iPCDex = iPCDex + 4;}
		iPCroll = d20(1);
		iPCInit = iPCroll + iPCDex;
		sPCroll = IntToString(iPCroll);
		sPCmod = IntToString(iPCDex);
		sPCInitT = IntToString(iPCInit);
		FloatingTextStringOnCreature("Initiative Roll, " + sName +": " + sPCroll + "+" + sPCmod + " = " + sPCInitT, oCreature, FALSE);
		SetLocalInt(oRecord, sPCInit, iPCInit);
		SetLocalString(oRecord, sPCName, sName);
		if (GetGlobalInt("pnp_debug")>3) {SendMessageToAllDMs(GetName(oCreature)+" Init: " + IntToString(iPCInit));}
		if (!GetIsDM(oCreature))
			{DisplayGuiScreen(oCreature, "PNP_SELECT_BAR_PC", FALSE, "pnp_select_bar_pc.xml");}
		}
	
	if (GetIsObjectValid(oTarget))
		{oCreature = OBJECT_INVALID;}
	else
		{oCreature = GetNextPC(TRUE);}
	}

SetLocalInt(oRecord, sPartyCount, i);
if (GetGlobalInt("pnp_debug")>2) {SendMessageToAllDMs("PnPPopulate i " + sLoop);}//Debug
SetLocalInt(oRecord, sPosition, 0);
if (GetGlobalInt("pnp_debug")>2) {SendMessageToAllDMs("PnPPopulate sPosition: " + sPosition);}//Debug
		
}	 

//-------------------------------------------------------------------------------------------------------
// Function to sort the player list.		
void PnPSort(object oPC)
{
if (GetGlobalInt("pnp_debug")>1) {SendMessageToAllDMs("PnPSort(oPC): " + GetName(oPC));}//Debug

int i,j,iPCroll,iPCDex,iPCInit,iPartyCount,iPosition,iInitA,iInitB;
string sLoop,sPC,sPCDex,sPCInit,sPCName,sName,sPCroll,sPCmod,sPCInitT,sJA,sJB,sPCNameA,sPCNameB,sPCInitA,sPCInitB,sTempA,sTempB,sActivName,sPartyCount,sPosition;
object oRecord;

//Grab CDKEY of DM off activator. Read vars off the Record object.
sActivName = GetPCPublicCDKey(oPC);
sPartyCount = sActivName + "iPartyCount";
sPosition = sActivName + "iPosition"; 
oRecord  = GetObjectByTag("PnP_Turn_Record");  
iPartyCount = GetLocalInt(oRecord, sPartyCount);
iPosition = GetLocalInt(oRecord, sPosition);
sLoop = IntToString(iPosition);
if (GetGlobalInt("pnp_debug")>2) {SendMessageToAllDMs("PnPSort sActivName: " + sActivName);}//Debug
			
//Begin sorting of stored variables
for(i = 0; i < iPartyCount; i++) // Make a pass through for each element
	{  
	for(j = 1; j < iPartyCount; j++) // Go through the list beginning to end
		{      
		sJA = IntToString(j);
		sJB = IntToString(j + 1);	  
		sPCNameA = sActivName + "sPC" + sJA;
		sPCNameB = sActivName + "sPC" + sJB;
		sPCInitA = sActivName + "iPC" + sJA + "Init";
		sPCInitB = sActivName + "iPC" + sJB + "Init";
		iInitA = GetLocalInt(oRecord, sPCInitA); 	
		iInitB = GetLocalInt(oRecord, sPCInitB);	  

		if(iInitA < iInitB) // If the the second number is greater, swap it
			{              
			sTempA = GetLocalString(oRecord, sPCNameA);       
			sTempB = GetLocalString(oRecord, sPCNameB);
			SetLocalString(oRecord, sPCNameA, sTempB);
			SetLocalString(oRecord, sPCNameB, sTempA);
			SetLocalInt(oRecord, sPCInitA, iInitB);
			SetLocalInt(oRecord, sPCInitB, iInitA);
			}
		}
	}  	
	return;
}

//-------------------------------------------------------------------------------------------------------
// Function to advance the current player.
void TurnAdvance(object oPC)
{
if (GetGlobalInt("pnp_debug")>1) {SendMessageToAllDMs("TurnAdvance(oPC): " + GetName(oPC));}//Debug

int i,j,iPCroll,iPCDex,iPCInit,iPartyCount,iPosition,iInitA,iInitB;
string sLoop,sPC,sPCDex,sPCInit,sPCName,sName,sPCroll,sPCmod,sPCInitT,sJA,sJB,sPCNameA,sPCNameB,sPCInitA,sPCInitB,sTempA,sTempB,sActivName,sPartyCount,sPosition,sGender;
object oPartyMember,oCreature,oRecord;
effect eDur;

//Get data on current player selected and remove existing effect
//Grab CDKEY of DM off widget of the activator. Read vars off the Record object.
eDur = SetEffectSpellId(EffectNWN2SpecialEffectFile("pnpturneffect"),-50);
eDur = SupernaturalEffect(eDur);
oRecord  = GetObjectByTag("PnP_Turn_Record");	

//Read DM CDKEY off widget unless DM is activator. Needed for DM crash recovery.
if (GetIsDM(oPC))
	{sActivName = GetPCPublicCDKey(oPC);}
		else
		{sActivName = GetLocalString(GetItemPossessedBy(oPC, "pnpturn"), "sActivName");}

if (GetGlobalInt("pnp_debug")>2) {SendMessageToAllDMs("TurnAdvance sActivName: " + sActivName);}//Debug
sPartyCount = sActivName + "iPartyCount";
sPosition = sActivName + "iPosition";
if (GetGlobalInt("pnp_debug")>2) {SendMessageToAllDMs("TurnAdvance sPosition: " + sPosition);}//Debug   
iPartyCount = GetLocalInt(oRecord, sPartyCount);
iPosition = GetLocalInt(oRecord, sPosition);
sLoop = IntToString(iPosition);

if (iPosition > 0)
	{
	sPCName = sActivName + "sPC" + sLoop;
	sName = GetLocalString(oRecord, sPCName);

	//Check to see if PC caller is current player, deny turn change if not.
	if ((GetName(oPC) != sName) && (GetIsDM(oPC) == FALSE))
		{
		SendMessageToPC(oPC, "You may only advance the count on your turn.");
		SendMessageToPC(CreatureMatch(sActivName, 2), sName + " tried to advance out of turn.");
		return;
		}
   
	//Attempt to find current creature by name match and remove pnpturneffect.
	oCreature = CreatureMatch(sName, 1);
	if(!GetIsObjectValid(oCreature))
		{SendMessageToPC(CreatureMatch(sActivName, 2), "Could not find current player: Skipping VFX Removal");}
		else
			{ 
			effect eEffect = GetFirstEffect(oCreature);
			while (GetIsEffectValid(eEffect))
				{
				if (GetEffectSpellId(eEffect) == -50)
					{RemoveEffect(oCreature, eEffect);}
				eEffect = GetNextEffect(oCreature);
				}
			}
	ClearUpTimer(oCreature);		 
	}
   
//Begin applying effects to next player
//Reset the turn position to one if at end of party list
iPosition++;
if (GetGlobalInt("pnp_debug")>2) {SendMessageToAllDMs("TurnAdvance iPosition1: " + IntToString(iPosition));}//Debug
if (iPosition > iPartyCount)
	{iPosition = 1;}
if (GetGlobalInt("pnp_debug")>2) {SendMessageToAllDMs("TurnAdvance iPosition2: " + IntToString(iPosition));}//Debug
SetLocalInt(oRecord, sPosition, iPosition);
if (GetGlobalInt("pnp_debug")>2) {SendMessageToAllDMs("TurnAdvance sPosition1: " + sPosition);}//Debug	
sLoop = IntToString(iPosition);
sPCName = sActivName + "sPC" + sLoop;
sName = GetLocalString(oRecord, sPCName);
oCreature = CreatureMatch(sName, 1);
 
if(!GetIsObjectValid(oCreature))
	{
	SendMessageToPC(CreatureMatch(sActivName, 2), "Could not find next player. Rerun tool to skip ahead.");
	return;
	} else
		{	
		//Tell PCs whose turn it is (Party only)	
		FloatingTextStringOnCreature("<c=gold>Turn: " + sName + "</c>", oCreature, TRUE);
		ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDur, oCreature);
		//Tell DM whose turn it is (Item Activator)   
		SendMessageToPC(CreatureMatch(sActivName, 2), "<c=gold>Turn: " + sName + "</c>");
		AssignCommand(oCreature,StartTimer(oCreature));
		}
}

//-------------------------------------------------------------------------------------------------------
// Function to clear current player list for active DM.
void PnPClear(object oPC)
{
if (GetGlobalInt("pnp_debug")>1) {SendMessageToAllDMs("PnPClear(oPC): " + GetName(oPC));}//Debug

int i;
string sLoop,sActivName,sName;
object oCreature,oRecord;
effect eDur;

//Set spell effect ID so we can remove any lingering pnpturneffects on existing players.
//Grab CDKEY of DM off widget of the activator. Read vars off the Record object. 
eDur = SetEffectSpellId(EffectNWN2SpecialEffectFile("pnpturneffect"),-50);
eDur = SupernaturalEffect(eDur);
sActivName = GetPCPublicCDKey(oPC);
oRecord  = GetObjectByTag("PnP_Turn_Record");
i = 1;
sLoop = sActivName + "sPC1";
//SendMessageToAllDMs("PnPClear oPC: " + GetName(oPC));//Debug

while (GetLocalString(oRecord, sLoop) != "") 
	{
	sName = GetLocalString(oRecord, sLoop);
	oCreature = CreatureMatch(sName, 1);
	effect eEffect = GetFirstEffect(oCreature);
	while (GetIsEffectValid(eEffect))
		{
		if (GetEffectSpellId(eEffect) == -50)
			{RemoveEffect(oCreature, eEffect);}
		eEffect = GetNextEffect(oCreature);
		}
	SetLocalString(oRecord, sLoop, "EOF");
	i++;
	sLoop = sActivName + "sPC" + IntToString(i);
	ClearListBox(oCreature, "SCREEN_PNP_LIST", "LISTBOX");
	ClearUpTimer(oCreature);
	}
	
oCreature = GetFirstPC(TRUE);

while (GetIsObjectValid(oCreature))
	{
	if (sActivName == GetLocalString(GetItemPossessedBy(oCreature, "pnpturn"), "sActivName"))
		{DeleteLocalString(GetItemPossessedBy(oCreature, "pnpturn"), "sActivName");}
	oCreature = GetNextPC(TRUE);
	}	
	
SendMessageToPC(oPC, "Player List Cleared");
}	   

//-------------------------------------------------------------------------------------------------------
// Function to read out list of current players and initiatives.
void PnPList(object oPC)
{
if (GetGlobalInt("pnp_debug")>1) {SendMessageToAllDMs("PnPList(oPC): " + GetName(oPC));}//Debug

string sActivName,sPartyCount,sPosition,sLoop,sPCName,sPCInit,sName,sI,sTexts,sInit;
object oRecord;
int iPartyCount,iPosition,i,iInit;

//Clear off current list
ClearListBox(oPC, "SCREEN_PNP_LIST", "LISTBOX");

//Grab CDKEY of DM off widget of the activator. Read vars off the Record object.
if (GetIsDM(oPC))
	{sActivName = GetPCPublicCDKey(oPC);}
		else
		{sActivName = GetLocalString(GetItemPossessedBy(oPC, "pnpturn"), "sActivName");}
		
sPartyCount = sActivName + "iPartyCount";
sPosition = sActivName + "iPosition"; 
oRecord  = GetObjectByTag("PnP_Turn_Record");  
iPartyCount = GetLocalInt(oRecord, sPartyCount);
iPosition = GetLocalInt(oRecord, sPosition);
if (GetGlobalInt("pnp_debug")>2) {SendMessageToAllDMs("PnPList sPosition: " + sPosition);}//Debug
if (GetGlobalInt("pnp_debug")>2) {SendMessageToAllDMs("PnPList iPosition: " + IntToString(iPosition));}//Debug


	//Loop through list on oRecord to pull names and initiatives.
	for(i = 1; i <= iPartyCount; i++)
		{
		sI = IntToString(i);  
		sPCName = sActivName + "sPC" + sI;
		sPCInit = sActivName + "iPC" + sI + "Init";
		sName = GetLocalString(oRecord, sPCName); 	
		iInit = GetLocalInt(oRecord, sPCInit);
		sInit = IntToString(iInit);
		if (GetGlobalInt("pnp_debug")>3) {SendMessageToAllDMs("PnPList sPCName: " + sPCName);}//Debug
		if (GetGlobalInt("pnp_debug")>3) {SendMessageToAllDMs("PnPList sPCInit: " + sPCInit);}//Debug
		if (GetGlobalInt("pnp_debug")>3) {SendMessageToAllDMs("PnPList iInit: " + IntToString(iInit));}//Debug
		// Stop loop if the end of list is reached
		if (iInit = 0)
			{
			if (GetGlobalInt("pnp_debug")>3) {SendMessageToAllDMs("PnPList iInit = 0; Break Loop");}//Debug
			break;
			}
		if (GetGlobalInt("pnp_debug")>3) {SendMessageToAllDMs("PnPList iPosition: " + IntToString(iPosition) + " " + IntToString(i));}//Debug
		if (iPosition == i)
			{sTexts = "PNP_LIST_NAME_CURRENT="+sName+";PNP_LIST_INIT_CURRENT="+sInit;}
			else
				{sTexts = "PNP_LIST_NAME="+sName+";PNP_LIST_INIT="+sInit;}
		if (GetGlobalInt("pnp_debug")>3) {SendMessageToAllDMs("sTexts: " + sTexts);}//Debug
		AddListBoxRow(oPC, "SCREEN_PNP_LIST", "LISTBOX", "Row "+IntToString(i), sTexts, "", "", "");
		}
	
}

//-------------------------------------------------------------------------------------------------------
// Function to read out list of all players to a selectable text box.
void PnPSelect(object oPC)
{
if (GetGlobalInt("pnp_debug")>1) {SendMessageToAllDMs("PnPSelect(oPC): " + GetName(oPC));}//Debug
string sActivName,sCreature,sName,sTexts,sVariables,sTextures;
object oCreature;
int iCreature;

//Clear off current list
ClearListBox(oPC, "SCREEN_PNP_SELECT_LIST", "LISTBOX");

//Grab CDKEY of DM off widget of the activator. Read vars off the Record object.
sActivName = GetPCPublicCDKey(oPC);
if (GetGlobalInt("pnp_debug")>2) {SendMessageToAllDMs("PnPSelect(oPC) sActivName: " + sActivName);}//Debug

oCreature = GetFirstPC(TRUE);

while (GetIsObjectValid(oCreature))
	{
	
	sName = GetName(oCreature);

	if (sActivName == GetLocalString(GetItemPossessedBy(oCreature, "pnpturn"), "sActivName"))
		{
		if (GetGlobalInt("pnp_debug")>3) {SendMessageToAllDMs("PnPSelect(oPC) Match: " + GetName(oCreature));}//Debug
		sTextures = "LISTBOX_TINT=b_g_lg03_pressed.tga";
		} else
			{
			if (GetGlobalInt("pnp_debug")>3) {SendMessageToAllDMs("PnPSelect(oPC) non-Match: " + GetName(oCreature));}//Debug
			sTextures = "LISTBOX_TINT=b_g_lg03_normal.tga";
			}
	sTexts = "PNP_LIST_NAME=  "+sName;
	sVariables = "5="+sName;
		
	if (GetGlobalInt("pnp_debug")>3) {SendMessageToAllDMs("PnPSelect(oPC) sCreature: " + sCreature);}//Debug
	if (GetGlobalInt("pnp_debug")>3) {SendMessageToAllDMs("PnPSelect(oPC) sVariables: " + sVariables);}//Debug
	if (GetGlobalInt("pnp_debug")>3) {SendMessageToAllDMs("PnPSelect(oPC) sTexts: " + sTexts);}//Debug
	AddListBoxRow(oPC, "SCREEN_PNP_SELECT_LIST", "LISTBOX", sName, sTexts, sTextures, sVariables, "");				
	oCreature = GetNextPC(TRUE);	
	}
}


//-------------------------------------------------------------------------------------------------------
// Function to update the list box of all associated players and DM.
void PnPListUpdate(object oPC)
{
if (GetGlobalInt("pnp_debug")>1) {SendMessageToAllDMs("PnPListUpdate(oPC): " + GetName(oPC));}//Debug
string sActivName;
object oCreature;

if (GetIsDM(oPC))
	{sActivName = GetPCPublicCDKey(oPC);}
		else
		{sActivName = GetLocalString(GetItemPossessedBy(oPC, "pnpturn"), "sActivName");}
oCreature = GetFirstPC(TRUE);
while (GetIsObjectValid(oCreature))
	{
	if ((sActivName == GetLocalString(GetItemPossessedBy(oCreature, "pnpturn"), "sActivName")) || sActivName == GetPCPublicCDKey(oCreature))
		{
		if (GetGlobalInt("pnp_debug")>3) {SendMessageToAllDMs("PnPListUpdate(oPC) Match: " + GetName(oCreature));}//Debug
		PnPList(oCreature);
		}				
	oCreature = GetNextPC(TRUE);	
	}
}

//-------------------------------------------------------------------------------------------------------
// Function to find player or DM with passed match value.
// Set iType to 1 for names, 2 for CDKEYs.
object CreatureMatch(string sMatch, int iType)
{
if (GetGlobalInt("pnp_debug")>1) {SendMessageToAllDMs("CreatureMatch(sMatch,iType): " + sMatch + ", " + IntToString(iType));}//Debug

object oCreature;

switch (iType)
	{
	case 1 : //Match name.
	oCreature = GetFirstPC(TRUE);
	while ((GetName(oCreature) != sMatch) && (GetIsObjectValid(oCreature)))
		{oCreature = GetNextPC(TRUE);}
	return oCreature; 
	break;

	case 2 : //Match CDKEY.
	oCreature = GetFirstPC(TRUE);
	while ((GetPCPublicCDKey(oCreature) != sMatch) && (GetIsObjectValid(oCreature)))
	{oCreature = GetNextPC(TRUE);}
	return oCreature;   
	break;

	default : //None of the above happens.
	}
oCreature = OBJECT_INVALID;
return oCreature;
}

//-------------------------------------------------------------------------------------------------------
// Function to generate player list for dialog as tokens.
void PnPTokenGen(object oPC)
{
if (GetGlobalInt("pnp_debug")>1) {SendMessageToAllDMs("PnPTokenGen(oPC): " + GetName(oPC));}//Debug

object oCreature,oRecord;
int i,j,iPartyCount,iMatch;
string sActivName,sPartyCount,sJ,sPCName,sName,sPCList;

sActivName = GetPCPublicCDKey(oPC);
oRecord  = GetObjectByTag("PnP_Turn_Record");
if (GetGlobalInt("pnp_debug")>2) {SendMessageToAllDMs("PnPTokenGen sActivName" + sActivName);}//Debug

//Clear previous list off DM
for(i = 1501; i <= 1510; i++)
	{ 
	sPCList = "sPC" + IntToString(i);
	SetLocalString(oPC,sPCList,"");
	}

//Start custom tokens at 1501, add one for each new player found not on the tool.
i=1501;
oCreature = GetFirstPC(TRUE);
while (GetIsObjectValid(oCreature))
	{
	if (GetGlobalInt("pnp_debug")>3) {SendMessageToAllDMs("PnPToken Creature with possible widget: oCreature" + GetName(oCreature));}//Debug
	
	if (GetIsObjectValid(GetItemPossessedBy(oCreature, "pnpturn")) && (GetIsDM(oCreature) == FALSE))
		{
		if (GetGlobalInt("pnp_debug")>3) {SendMessageToAllDMs("PnPToken Creature with widget: oCreature" + GetName(oCreature));}//Debug
		iMatch = 0;
		
		for(j = 1; j <= 10; j++)
			{
			sJ = IntToString(j);  
			sPCName = sActivName + "sPC" + sJ;
			sName = GetLocalString(oRecord, sPCName);
			if (GetGlobalInt("pnp_debug")>3) {SendMessageToAllDMs("PnPToken Creature internal loop: sName" + sName);}//Debug
			
			if (CreatureMatch(sName, 1) == oCreature)
				{iMatch = 1;}
			}
		if (iMatch != 1)
			{
			sPCList = "sPC" + IntToString(i);
			SetLocalString(oPC,sPCList,GetName(oCreature));
			if (GetGlobalInt("pnp_debug")>3) {SendMessageToAllDMs("PnPToken Creature with no match: oCreature" + GetName(oCreature));}//Debug
			i++;
			}
		}
	oCreature = GetNextPC(TRUE);
	}	
}