// gui_death_respawn.nss
/*
	NOT ON DASARIA
*/

void main()
{
	WriteTimestampedLogEntry("EXPLOIT! Player "+GetPCPlayerName(OBJECT_SELF)+", CDKEY "+GetPCPublicCDKey(OBJECT_SELF)+" controlling character "+GetName(OBJECT_SELF)+" attempted illegal invocation of gui_death_respawn.nss");
}