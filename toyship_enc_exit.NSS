// toyship_enc_exit
// wired 08/22/2009 disable encounter on exit
void main()
{
	string sETag = GetLocalString(OBJECT_SELF,"sETag");
	object oEncounter = GetNearestObjectByTag(sETag);
	SetEncounterActive(FALSE,oEncounter);
	
}