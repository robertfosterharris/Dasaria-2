// talonroad_phylactery_death
// wired 10/08/2008

#include "ginc_partymath"

void main()
{
	location lPhylactery;
	object oLich;
	object oPC;
	effect eWail;

	lPhylactery = GetLocation(OBJECT_SELF);
	oLich = GetNearestObjectByTag("talonroad_lich");
	SetPlotFlag(oLich,FALSE);
	eWail = EffectVisualEffect(VFX_HIT_SPELL_WAIL_OF_THE_BANSHEE);
	ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eWail,lPhylactery);
	
	oPC = GetLastHostileActor();
	
	if (GetIsObjectValid(GetMaster(oPC)) == TRUE)
	{
            oPC = GetMaster(oPC);
	}	
	
	// something other than a PC blew me up
	// give credit to the nearest PC on quest
	if ( !GetIsObjectValid(oPC) || !GetIsPC(oPC))
	{
		oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC,OBJECT_SELF);
	}
		
	if (GetHighJournalEntry("talontmb_lich",oPC) == 1)
	{
			AddJournalQuestEntry("talontmb_lich",2,oPC,TRUE);
	}
		
	ExecuteScript("std_plc_respawn",OBJECT_SELF);	
}