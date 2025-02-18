//	ON DEATH -	MARK RAVAEL AS DEFEATED CHECK IF FIGHT IS FINISHED
//
//	07/22/08	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM

#include "totd_paladin_fight_inc"

void main()
{
	object oArea;
	object oCurrentArea;
	
	oArea = GetObjectByTag("thayadmount");
	oCurrentArea = GetArea(OBJECT_SELF);
	if (oArea == oCurrentArea)
	{
		SetLocalInt(oArea, "totd_paladin_dead", TRUE);
		finishFight(oArea);
	}		
}