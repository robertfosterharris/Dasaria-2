//	ON EXIT - RETURNS PLACEABLES TO UNUSEABLE STATE
//
//	SEE SISTER SCRIPT - GTR_USEABLE_BY_SKILL_EN
//
//	TRIGGER VARIABLES
//
//	nSkill		- THE SKILL BEING USED
//	nDC			- THE DIFFICULTY CLASS OF THE SKILL
//	sPlaceables	- A COMMA DELIMITED LIST OF OBJECT TAGS TO MAKE USEABLE
//	sMessage	- MESSAGE TO SEND PC ON SUCCESSFUL CHECK
//
//	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM	11/21/2007
//
//	10/03/2012		RFH		MADE MULTIPLAYER FRIENDLY
//

#include "x0_i0_stringlib"

void main()
{
	int bOccupied;
	int nNth;
	object oPC;
	object oPlaceable;
	string sPlaceable;
	string sPlaceables;
	
	bOccupied = FALSE;
	oPC = GetFirstInPersistentObject();
	if (GetIsPC(oPC)) bOccupied = TRUE;
	
	while (GetIsObjectValid(oPC) && !bOccupied)
	{
		oPC = GetNextInPersistentObject();
		if (GetIsPC(oPC)) bOccupied = TRUE;
	}
	
	if (!bOccupied)
	{
		DeleteLocalInt(OBJECT_SELF, "USEABLE_" + GetTag(OBJECT_SELF));

		nNth = 0;
		sPlaceables = GetLocalString(OBJECT_SELF, "sPlaceables");
    
		sPlaceable = GetTokenByPosition(sPlaceables, ",", nNth);
		while (sPlaceable != "")
		{
			oPlaceable = GetObjectByTag(sPlaceable);
			SetUseableFlag(oPlaceable, FALSE);
			nNth++;
			sPlaceable = GetTokenByPosition(sPlaceables, ",", nNth);
		}
	}
}