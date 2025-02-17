// gc_renown
// wired 08/03/2011
//
#include "ginc_renown"
#include "ginc_var_ops"
#include "ginc_param_const"

int StartingConditional(string sCheck)
{
    object oTarg = GetPCSpeaker();
    
    int nValue = getPCMetaFactionRenown(oTarg);
    int iRet = CompareInts(nValue, sCheck);

    return (iRet);
}