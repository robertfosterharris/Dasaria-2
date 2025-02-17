//	GLOBAL ACTION - SETS THE COHORTS DESIRED META CLASS
//
//	sMetaClass	=	arcane, divine, rogue or warrior
//
//	ROBERT HARRIS	05/02/2015	ROBERTHARRIS@ROBERTHARRIS.COM
//
#include "std_i0_cohort"

void main(string sMetaClass)
{
	object oPC;
	
	oPC = GetPCSpeaker();
	
	if	((sMetaClass == "arcane")	||
		 (sMetaClass == "divine")	||
		 (sMetaClass == "rogue")	||
		 (sMetaClass == "warrior"))
		{
			SetLocalString(oPC, "sMetaClass", sMetaClass);
		}
	else
		{
			DeleteLocalString(oPC, "sMetaClass");
		}
}