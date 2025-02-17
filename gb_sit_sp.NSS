//	ON SPAWN - HAVE CREATURES SIT IN A CHAIR AFTER SPAWNING
//
//	REQUIRED CREATURE VARIABLES
//	SpawnScript	= gb_sit_sp
//
//	OPTIONAL CREATURE VARIABLES
//	bChairFlip 	= 1 IF CHAIR ORIENTATION IS BACKWARDS.
//
//	USAGE NOTES:
//	SET CREATURE VARIABLES
//	SET CHAIR TAG
//	SET CHAIR TO STATIC = FALSE
//	SEE GTR_SIT_EN
//
//	ROBERT HARRIS	02/29/2008	ROBERTHARRIS@ROBERTHARRIS.COM
//
#include "x0_i0_anims"

void Sit(object oCreature);

void main()
{
	float fOrientation;
	object oArea;
	object oCreature;
	object oChair;
	location lChair;
	vector vPosition;
	
	oCreature = OBJECT_SELF;
	
	oChair = GetObjectByTag("chair_" + GetTag(oCreature));
	if (GetIsObjectValid(oChair))
	{
		fOrientation = GetFacing(oChair);
		if (GetLocalInt(oCreature, "bChairFlip") == 0)
		{
			if (fOrientation >= 180.0)
			{
				fOrientation = fOrientation - 180;
			}
			else
			{
				fOrientation = fOrientation + 180;
			}
		}
		oArea = GetArea(oChair);
		vPosition = GetPosition(oChair);
		lChair = Location(oArea, vPosition, fOrientation);
		SetLocalLocation(oCreature, "lChair", lChair);
		
		SetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS, FALSE);
    	SetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS, FALSE);
		SetBumpState(oCreature, BUMPSTATE_UNBUMPABLE);
		SetOrientOnDialog(oCreature, FALSE);
		ClearAllActions(TRUE);
		ActionJumpToLocation(lChair);
		ActionDoCommand(Sit(oCreature));
	}
	DeleteLocalInt(oCreature, "bChairFlip");
	DeleteLocalString(oCreature, "SpawnScript");
}
	
void Sit(object oCreature)
{
	PlayCustomAnimation(oCreature, "sitidle", 1);
}	