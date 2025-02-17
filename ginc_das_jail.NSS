//	INCLUDE FILE FOR THE JAILING SYSTEM
//
//	02/06/07	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM
//	05/20/08	ROBERT HARRIS	CREATED AND USED LEGAL_STATUS_* CONSTANTS
//	04/30/09	ROBERT HARRIS	REVIEW INDICTMENT BEFORE AUTOMATICALLY ISSUING A WARRANT
//  08/14/09    Wired           Skip reputation shift against cear_guards when player controlled
//	04/28/11	Wired			Do not issue warrants to lycanthropes in shifted form
//
#include "std_faction_i0"
#include "nw_i0_generic"
//
//	CONSTANTS
//
const float WARRANTGRACEPERIOD = 600.0f;	//  NUMBER OF SECONDS BEFORE A WARRANT IS ISSUED FOR THE PLAYERS ARREST
const float JAILTIME = 900.0f;				//  NUMBER OF SECONDS THE PLAYER STAYS IN JAIL
const int LEGAL_STATUS_CLEAR = 0;			//	LEGAL ISSUES RESOLVED
const int LEGAL_STATUS_INDICTMENT = 1;		//	CHARACTER IS GUILTY OF A CRIME
const int LEGAL_STATUS_WARRANT = 2;			//	GUARDS ARE HOSTILE
//
//	FUNCTION DEFINITIONS
//
void issueIndictment(object oCriminal, object oGuard);
void issueWarrant(object oCriminal, object oGuard);
void issueResolved(object oCriminal);
void reviewIndictment(object oCriminal, object oGuard);
location GetOpenCell(object oCriminal);
int GetIsCellLocked(object oCell);
//
//	CHARGES A CHARACTER WITH A CRIME
//	THE CRIMINAL MUST SUBCUMB TO JAIL TIME OR A WARRANT WILL BE ISSUED FOR THE CRIMINALS ARREST
//
void issueIndictment(object oCriminal, object oGuard)
{
	string sCriminal;
	string sGuard;
	object oJournal = std_journal_get( oCriminal );
	// Mr. Hyde is already hostile, do not issue warrants against Dr. Jekyll
	if (GetLocalInt(oJournal,"nLycan") > 0) return;
	
	SetLocalInt(oCriminal, "nLegalStatus", LEGAL_STATUS_INDICTMENT);
	SetLocalObject(oCriminal, "oGuard", oGuard);

	sCriminal = GetName(oCriminal);
	sGuard = GetName(oGuard);
	
	SendMessageToPC(oCriminal, sGuard + " has found you guilty of a crime.");
	SendMessageToPC(oGuard, sCriminal + " has been found guilty of a crime.");
	WriteTimestampedLogEntry("LEGAL ACTION: " + sGuard + " has found " + sCriminal + " guilty of a crime.");
	DelayCommand(WARRANTGRACEPERIOD, reviewIndictment(oCriminal, oGuard));
}
//
//	ISSUES A WARRANT FOR THE CRIMINALS ARREST
//	MAKES THE GUARDS HOSTILE TOWARD CRIMINAL
//
void issueWarrant(object oCriminal, object oGuard)
{
	int nReputation;
	object oFaction;
	string sCriminal;
	string sGuard;
	object oJournal = std_journal_get( oCriminal );
	// Mr. Hyde is already hostile, do not issue warrants against Dr. Jekyll
	if (GetLocalInt(oJournal,"nLycan") > 0) return;
	
	SetLocalInt(oCriminal, "nLegalStatus", LEGAL_STATUS_WARRANT);
	SetLocalObject(oCriminal, "oGuard", oGuard);
		
	sCriminal = GetName(oCriminal);
	sGuard = GetName(oGuard);
		
	SendMessageToPC(oCriminal, sGuard + " has issued a warrant for your arrest.");
	SendMessageToPC(oGuard, "A warrant has been issued for the arrest of " + sCriminal + ".");
	WriteTimestampedLogEntry("LEGAL ACTION: " + sGuard + " has issued a warrant for the arrest of " + sCriminal + ".");
		
	if (!GetIsPC(oGuard))
	{
		oFaction = GetObjectByTag("d2_faction_cearguard");				//GET CEAR GUARD FACTION REPRESENTATIVE FROM ~FACTION AREA
		nReputation = GetReputation(oFaction, oCriminal);				//GET PC'S REPUTATION WITH GUARD
	
		if (std_reputation_get(oCriminal, "cearguard") == -1)			//IF THE PC'S REPUTATION WITH THE CEAR GUARD HASN'T BEEN STORED TO THE JOURNAL
		{
			std_reputation_set(oCriminal, "cearguard", nReputation);	//STORE THE PC'S REPUTATION TO THE JOURNAL
		}		
		AdjustReputation(oCriminal, oFaction, 0 - nReputation);			//ADJUST THE PC'S REPUTATION TO ZERO
	}
}
//
//	CLEARS THE CHARACTERS CRIMINAL STATUS - JUSTICE HAS BEEN SERVED
//
void issueResolved(object oCriminal)
{
	object oGuard;
	string sCriminal;
	
	oGuard = GetLocalObject(oCriminal, "oGuard");

	DeleteLocalInt(oCriminal, "nLegalStatus");
	DeleteLocalObject(oCriminal, "oGuard");
	
	sCriminal = GetName(oCriminal);
		
	SendMessageToPC(oCriminal, "Justice has been served.");
	SendMessageToPC(oGuard, "Justice has been served in the case of " + sCriminal + ".");
	WriteTimestampedLogEntry("LEGAL ACTION: Justice has been served in the case of " + sCriminal + ".");
	
	std_reputation_reset(oCriminal, "cearguard");					//RESTORE PC'S REPUTATION TO VALUE STORED IN THE JOURNAL
}
//
//	REVIEW THE CHARACTERS CRIMINAL STATUS TO SEE IF A WARRANT NEEDS TO BE ISSUED
//
void reviewIndictment(object oCriminal, object oGuard)
{
	if (GetLocalInt(oCriminal, "nLegalStatus") == LEGAL_STATUS_INDICTMENT) issueWarrant(oCriminal, oGuard);
}
//
//   RETURNS THE LOCATION OF AN OPEN CELL
//
location GetOpenCell(object oCriminal)
{
   int nCell;
   location locCell;
   object oCell;
   string sCell;

   sCell = GetLocalString(oCriminal, "sDistrict") + "jail_wp_cell";
   oCell = GetObjectByTag(sCell, nCell);
   while (GetIsObjectValid(oCell) && GetIsCellLocked(oCell))
   {
      nCell++;
      oCell = GetObjectByTag(sCell, nCell);
   }
   
   if (GetIsObjectValid(oCell))
   {
      locCell = GetLocation(oCell);
   }      
   else
   {
      locCell = GetStartingLocation();
   }
   DeleteLocalString(oCriminal, "sDistrict");
   
   return locCell;
}
//
//	RETURNS TRUE IF OCELL IS CURRENTLY LOCKED
//
int GetIsCellLocked(object oCell)
{
	object oDoor;

	oDoor = GetNearestObjectByTag("jail_d_cell", oCell);
	return GetLocked(oDoor);
}