// 2bridges_athorius_saveplayer
// add the player as an object so i update his/her journal on death
// also handy to relocate my master if they crash
void main()
{
	object oPlayer = GetPCSpeaker();
	SetLocalObject(OBJECT_SELF,"oPlayer",oPlayer);
	ActionForceFollowObject(oPlayer,0.5f);
}