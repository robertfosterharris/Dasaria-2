// ga_mount_limbo
// wired 02/04/2012
// send player's mount to limbo

#include "std_inc_mounts"

void main()
{

    object oPC = GetPCSpeaker();
	
	DelayCommand(2.0f,SendMountToLimbo(oPC,GetArea(oPC)));

}