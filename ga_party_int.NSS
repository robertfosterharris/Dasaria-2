// ga_local_int(string sVariable, string sChange, string sTarget)
/*
   This script changes a local int variable's value
   
   Parameters:
     string sVariable   = Name of variable to change
     string sChange     = VALUE	  (EFFECT)
	 					  "5"     (Set to 5)
						  "=-2"   (Set to -2)
						  "+3"    (Add 3)
						  "+"     (Add 1)
						  "++"    (Add 1)
						  "-4"    (Subtract 4)
						  "-"     (Subtract 1)
						  "--"    (Subtract 1)
     string sTarget	= Target tag or identifier. If blank then use OBJECT_SELF
*/

#include "ginc_param_const"
#include "ginc_var_ops"
#include "std_i0_misc"

void main(string sVariable, string sChange, string sTarget)
{
    object oTarg = GetTarget(sTarget, TARGET_OBJECT_SELF);
	if (GetIsObjectValid(oTarg) == FALSE) 
		PrintString("ga_party_int: " + sTarget + " is invalid");

	int nOldValue = GetLocalInt(oTarg, sVariable);
	int nNewValue = CalcNewIntValue(nOldValue, sChange);

	SetPartyInt(oTarg, sVariable, nNewValue);
	
    //PrintString(sTarget + "'s variable " + sVariable + " is now set to " + IntToString(nNewValue) );
}