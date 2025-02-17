// unlock, relock in f seconds.
// wired 9/16/08
#include "ginc_param_const"
void main(string sDoorTag, float fRelock)
{
	object oDoor = GetTarget(sDoorTag);
	SetLocked(oDoor, FALSE);
	ActionOpenDoor(oDoor);
	DelayCommand(60.0f, ActionCloseDoor(oDoor));
	DelayCommand(fRelock, SetLocked(oDoor, TRUE) );
}