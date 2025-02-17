//	ONCLICKED DOOR SCRIPT REMOVES A COMMA DELIMITED LIST OF ITEMS FROM A CHARACTER
//
//	OBJECT VARIABLES
//	sItemsToRemove - COMMA DELIMITED LIST OF ITEMS TO REMOVE FROM THE PLAYER
//
//	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM	03/03/2007

#include "x0_i0_stringlib"

void main()
{
	int nNth;
	object oPC;
	object oTarget;
	string sItem;
	string sItemsToRemove;

	nNth = 0;
	oPC = GetClickingObject();
	oTarget = GetTransitionTarget(OBJECT_SELF);
	sItemsToRemove = GetLocalString(OBJECT_SELF, "sItemsToRemove");
    
	sItem = GetTokenByPosition(sItemsToRemove, ",", nNth);
	while (sItem != "")
	{
		DestroyObject(GetItemPossessedBy(oPC, sItem));
		nNth++;
		sItem = GetTokenByPosition(sItemsToRemove, ",", nNth);
	}
    
	AssignCommand(oPC, JumpToObject(oTarget));
}