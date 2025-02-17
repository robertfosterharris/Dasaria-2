// gui_death_hidden_click.nss
/*
	NOT ON DASARIA
*/

void main()
{
	WriteTimestampedLogEntry("EXPLOIT! Player "+GetPCPlayerName(OBJECT_SELF)+", CDKEY "+GetPCPublicCDKey(OBJECT_SELF)+" controlling character "+GetName(OBJECT_SELF)+" attempted illegal invocation of death_hidden_click.nss");
}