//gc_localstring_length
//This script checks for the number of letters in a local string variable.
//frac
#include "ginc_var_ops"
#include "ginc_param_const"

int StartingConditional(string sVariable, string sCheck, string sTarget)
{
object oTarg = GetTarget(sTarget, TARGET_OBJECT_SELF);
int nLength = GetStringLength(GetLocalString(oTarg, sVariable));
int iRet = CompareInts(nLength, sCheck);

    return (iRet);
/*    if (GetStringLength(GetLocalString(OBJECT_SELF, "solution")) > nLength) {
        return TRUE;
    } else {
        return FALSE;
    }*/
}