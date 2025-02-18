// rvnw_woodspirit_od
// wired 10/21/2008	Only advance journal if they have the quest, this area is now open
// wired 04/22/2014 update for embers_reboot
void main()
{
	effect eWail = EffectVisualEffect(736);
	effect eLight = EffectVisualEffect(VFX_DUR_LIGHT_WHITE_15);
	object oKiller = GetLastKiller();
	object oMarker = GetNearestObjectByTag("rvnw_reserve_marker");
	
	SetUseableFlag(oMarker,TRUE);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLight,oMarker, 120.0f);
	DelayCommand(120.0,SetUseableFlag(oMarker,FALSE));
	
	
	int nEntry = GetJournalEntry("rvnwd_embers_reboot",oKiller);
	if (nEntry == 1 || nEntry == 2)
		{
			AddJournalQuestEntry("rvnwd_embers_reboot", 3, oKiller,TRUE,FALSE,FALSE);
		}
	
	
	SpeakString("<i>Gurth gothrim Tel'taur!</i>");
	ApplyEffectToObject(0,eWail,OBJECT_SELF);
	CreateObject(OBJECT_TYPE_CREATURE,"c_elmair",GetLocation(OBJECT_SELF),1);
	CreateObject(OBJECT_TYPE_CREATURE,"c_elmair",GetLocation(OBJECT_SELF),1); 
}