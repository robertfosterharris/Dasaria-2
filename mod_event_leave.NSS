// wired 09/21/08 	added hitpoint tracking code
// wired 02/23/09	give up xp_chat id on leave
// wired 07/17/09   remove xp_chat reference, deprecated
// wired 10/02/09	remove hitpoint tracking code
// wired 11/21/09	restore hitpoint tracking code
// wired 06/24/11	log exit to db

#include "d2_sql_log"

void main()
{
	object oPC;
	int nTransitionState;
	 
	oPC = GetExitingObject();
	
	// REMOVE
	//SendMessageToPC(oPC,"MOD_EVENT_LEAVE");
	
	nTransitionState = GetLocalInt(oPC, "TransitionState");
	
	// record hitpoints
	int nLastHitPoints =  GetCurrentHitPoints(oPC);
	string sHPVarName = GetName(oPC) + "_HP";
	string sHPInitName = GetName(oPC) + "_Init";
	SetLocalInt(OBJECT_SELF,sHPVarName,nLastHitPoints);
	SetLocalInt(OBJECT_SELF,sHPInitName,1);
	
	if (GetIsObjectValid(oPC) &&  GetLocalInt(oPC,"bVaultFailure") != TRUE )
	{
		saveChar_OCL(oPC);	
		trackEvent(oPC,"AREA_ENTER",OBJECT_INVALID,0,0,"EXIT", GetLocalString(oPC, "PlayerName"));	
		trackEvent(oPC,"LOG_OUT",OBJECT_INVALID,0,0,GetLocalString(oPC, "LastExit"), GetLocalString(oPC, "PlayerName"));
	}
	
	if (GetIsPC(oPC) && !GetIsDM(oPC) && nTransitionState > 0)
	{
		WriteTimestampedLogEntry ("	Transition v1.7:	" + GetLocalString(oPC, "PlayerName") + "	" + GetName(oPC) + "	" + GetLocalString(oPC, "LastExit") + "	" + GetLocalString(oPC, "LastEntry") + "	" + IntToString(nTransitionState));
		
		DeleteLocalInt(oPC, "TransitionState");
		DeleteLocalString(oPC, "LastExit");
		DeleteLocalString(oPC, "LastEntry");	
	}		
}