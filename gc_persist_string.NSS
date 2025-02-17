// sTarget = $PC or $PC_SPEAKER

// gc_local_string(string sVariable, string sCheck, string sTarget)
/* 
   This script checks a local string variable's value.

   Parameters:
     string sVariable  = This is the name of the variable checked.
     string sCheck     = This is the string to compare equality against.
     string sTarget    = This is the tag or identifier of the Target. If blank then use OWNER
*/
// FAB 10/4
// EPF 4/12/05 variable name changes, some minor cleaning
// BMA 4/27/05 added GetTarget(), new description
// BMA 7/19/05 added object invalid printstring
// BMA-OEI 7/28/05 - added debug printstring

#include "ginc_param_const"
#include "std_persist_i0"

int StartingConditional(string sVariable, string sCheck, string sTarget)
{
    object oTarget = GetTarget(sTarget, TARGET_OWNER);
	object oJournal = std_journal_get( oTarget );
	
	string sValue = GetLocalString(oJournal, sVariable);

	PrintString("gc_local_string: Object '" + GetName(oJournal) + "' variable '" + sVariable + "' = '" + sValue + "' compare to '" + sCheck + "'");
    if (sValue == sCheck)
    {
    	return TRUE;
    }
    else
    {
    	return FALSE;
    }
}