//	GLOBAL CONDITIONAL: CHECKS IF PC SPEAKER'S LAST COHORT'S STATUS EQUALS sSTATUS
//
//	ROBERT HARRIS	05/01/2015	ROBERTHARRIS@ROBERTHARRIS.COM
//
#include "std_i0_cohort"

int StartingConditional(string sStatus)
{
	int bMatch;
	object oPC;
	string sSQL;
	
	bMatch = FALSE;
	oPC = GetPCSpeaker();
	
	sSQL = "select cohort_status from cohort where leader_id = " + getPCid(oPC) + " order by cohort_id desc limit 1";
	SQLExecDirect(sSQL);
	if ((SQLFetch() == SQL_SUCCESS) && (sStatus == SQLGetData(1))) bMatch = TRUE;

	return bMatch;
}