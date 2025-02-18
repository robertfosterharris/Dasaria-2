// ph_showroom_exit
// wired 03/21/2011
// wired 08/12/2011 replace uses of GetIsLocationValid(location) with  GetIsObjectValid(GetAreaFromLocation(location))

#include "x0_i0_position"

void main()
{
	object oPC = GetClickingObject();
	
	// return to stored location
	location lReturnTo = GetLocalLocation(oPC,"lReturnTo");	
	if (GetIsObjectValid( GetAreaFromLocation(lReturnTo) ) )
	//if (GetIsLocationValid(lReturnTo) )
	{
		AssignCommand(oPC,JumpToLocation(lReturnTo));
		return;
	}
	
	// return to the area you last left
	lReturnTo = CalcSafeLocation(oPC,GetCenterPointOfArea(    GetObjectByTag( GetLocalString(oPC,"LastExitTag") )    ),10.0f,TRUE,FALSE);
	if (GetIsObjectValid( GetAreaFromLocation(lReturnTo) ) )
	//if (GetIsLocationValid(lReturnTo) )
	{
		AssignCommand(oPC,JumpToLocation(lReturnTo));
		return;
	}
	
	// return to starting location
	AssignCommand(	oPC,JumpToLocation	(	GetStartingLocation()	)	);
	
}