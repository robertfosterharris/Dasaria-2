// talonroad_night_enc_enter
// wired 09/18/2008 enable quest encounter if it's nighttime
// wired updated 5/20/2010
// wired re-write 10/20/2011

#include "ginc_partymath"
#include "ginc_trigger"

void main()
{
	object oPC = GetEnteringObject();
	int nCurrentHour = GetTimeHour();
	
	if (GetHighJournalEntry("talonroad_culnul",oPC) == 5) 
	{
		if (nCurrentHour <= 6 || nCurrentHour >= 19)
		{
			CreateObject(OBJECT_TYPE_PLACEABLE,"culnul_circle",GetLocation(GetNearestObjectByTag("wp_culnul_circle")));
			
			AddJournalQuestEntry("talonroad_culnul",6,oPC,TRUE);
			
			CreateObject(OBJECT_TYPE_CREATURE,"culnul_ritual_cirumvax",GetLocation(GetNearestObjectByTag("wp_tristan_cirumvax")));
			CreateObject(OBJECT_TYPE_CREATURE,"culnul_neutral_deathseeker1",GetLocation(GetNearestObjectByTag("wp_tristan_death1")));
			CreateObject(OBJECT_TYPE_CREATURE,"culnul_neutral_deathseeker2",GetLocation(GetNearestObjectByTag("wp_tristan_death2")));
			CreateObject(OBJECT_TYPE_CREATURE,"culnul_kristin_dar",GetLocation(GetNearestObjectByTag("wp_tristan_dar")));
			CreateObject(OBJECT_TYPE_CREATURE,"culnul_marnya_velvax",GetLocation(GetNearestObjectByTag("wp_tristan_velvax")));
			CreateObject(OBJECT_TYPE_CREATURE,"culnul_demon",GetLocation(GetNearestObjectByTag("wp_tristan_demon")));
			
			AssignCommand(oPC,ClearAllActions());
			DelayCommand(1.0,DoSpeakTrigger(oPC));
		}
		else
		{
			FloatingTextStringOnCreature("The hour is not yet ripe. Perhaps you should go wait out of sight of the graveyard and return later.",oPC);
		}
	}
}