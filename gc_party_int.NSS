// gc_party_int
// gc_local_int for the whole party

#include "ginc_var_ops"
#include "ginc_param_const"

int StartingConditional(string sVariable, string sCheck, string sTarget)
{
	object oPC = GetTarget(sTarget, TARGET_OBJECT_SELF);
	int nValue;
    int iRet;

    object oPartyMem = GetFirstFactionMember(oPC, TRUE);
	
    while (GetIsObjectValid(oPartyMem))
    {
	    nValue = GetLocalInt(oPartyMem, sVariable);
	   	
		if ( CompareInts(nValue, sCheck) ) return TRUE;
		
        oPartyMem = GetNextFactionMember(oPC, TRUE);
    }
    return FALSE;
}

