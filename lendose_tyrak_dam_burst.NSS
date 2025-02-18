//	lendose_tyrak_dam_burst
//	wired 02/28/2010

#include "ginc_partymath"

void main()
{
	object oPC = GetLastHostileActor();
	object oWater = GetNearestObjectByTag("lendose_water_plc_a");
	object oWheel = GetNearestObjectByTag("lendose_tyrak_waterwheel");
	effect eExplode = EffectNWN2SpecialEffectFile("fx_wooden_explosion_big");
	effect eSlide = EffectNWN2SpecialEffectFile("fx_rockslide");
	
	ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eExplode,GetLocation(GetObjectByTag("wp_lendose_damgoboom")));
	ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eSlide,GetLocation(GetObjectByTag("wp_lendose_damgoboom")));
	ApplyEffectToObject(DURATION_TYPE_INSTANT,eExplode,oWheel);
	PlaySound("al_en_expbarrel05");
	
	location lTorrent = GetLocation(GetObjectByTag("wp_lendose_torrent_start"));
	object oTorrent =	CreateObject(OBJECT_TYPE_PLACED_EFFECT,"moefx_waterfall",lTorrent);

	ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDeath(TRUE),oWater);
	ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDeath(TRUE),oWheel);
	
	DestroyObject(oTorrent,300.0f);

	if (GetIsObjectValid(GetMaster(oPC)) == TRUE)
	{
            oPC = GetMaster(oPC);
	}
	
	if (GetHighJournalEntry("phoenix_dryad",oPC) == 1)
	{
		AddJournalQuestEntry("phoenix_dryad",2,oPC,TRUE);
	}
	ExecuteScript("std_plc_respawn",OBJECT_SELF);	
}