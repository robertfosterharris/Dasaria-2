/*

	This script removes all supernatural spell failure and visual
	effects from any PC exiting the area
	
	2006/1/16	Richard Pavlicek (k9burn@yahoo.com
		Initial revision
    04/30/2007  RFH     CALLED GLOBAL ON EXIT SCRIPT
*/




#include "j4acs_uglyhack"
#include "sq_sw_area_inc"

void main()
{
    //Declare major variables
    object oPC = GetExitingObject();

	// This spell failure only applies to PC's
	if (GetIsPC(oPC)) sq_sw_RemoveSpellFailure(oPC);

    ExecuteScript("j4acs_ha_exit", OBJECT_SELF);
}