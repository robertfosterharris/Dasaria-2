//gui_ph_knock

#include "ginc_playerhousing"

void main()
{
	object oKnocker = GetLocalObject(OBJECT_SELF,"oKnocker");
	FriendInvite(OBJECT_SELF, oKnocker);
}