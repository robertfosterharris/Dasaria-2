// dasolm_ga_enc_init
//
// jump warparty to a specific waypoint with tag sDest
// if empty, look for waypoint called waypoint_ClickedObjectTag

#include "dasolm_inc"

void main(string sDest)
{
	object oPC = GetPCSpeaker();
	object oEnterWP;
	
	if (sDest == "")
	{
		sDest = "enter_"+GetTag(OBJECT_SELF);
	}
	 
	oEnterWP = GetWaypointByTag(sDest);
	
	if ( !GetIsObjectValid( oEnterWP ) )
	{
		SendMessageToPC(oPC,"Error: Invalid Destination");
		return;
	}
	
	DasOL_Enc_Enter(oPC,oEnterWP);
}