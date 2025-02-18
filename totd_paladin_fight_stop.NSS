//	ON EXHAUSTED -	MARK RAVAEL'S PARTY AS DEFEATED CHECK IF FIGHT IS FINISHED
//
//	07/22/08	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM

#include "totd_paladin_fight_inc"

void main()
{
	object oArea;
	
	oArea = GetObjectByTag("thayadmount");
	SetLocalInt(oArea, "totd_party_dead", TRUE);
	finishFight(oArea);	
}