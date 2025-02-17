//	ON UNLOCKED - SYNCS THE LEVER ASSOCIATED WITH THIS DOOR
//
//	OBJECT VARIABLES:
//	sLeverList	COMMA DELEIMTED LIST OF LEVERS TO SYNC
//
//	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM	05/07/2012
//
#include "x0_i0_stringlib"

void main()
{
	int nNth;
    object oLever;
	string sLever;
	string sLeverList;
	
	nNth = 0;
	sLeverList = GetLocalString(OBJECT_SELF, "sLeverList");
	sLever = GetTokenByPosition(sLeverList, ",", nNth);
	
	while (sLever != "")
	{
		oLever = GetObjectByTag(sLever);
		if (GetIsObjectValid(oLever))
		{
			AssignCommand(oLever, ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
		}
		nNth++;
		sLever = GetTokenByPosition(sLeverList, ",", nNth);
	}
}