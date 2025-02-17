// dracolich_phylactery_death
// wired 06/30/2009
void main()
{
	location lPhylactery;
	object oLich;
	object oPC;
	effect eWail;

	lPhylactery = GetLocation(OBJECT_SELF);
	oLich = GetNearestObjectByTag("dracolich");
	SetPlotFlag(oLich,FALSE);
	eWail = EffectVisualEffect(VFX_HIT_SPELL_WAIL_OF_THE_BANSHEE);
	ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eWail,lPhylactery);
	
	ExecuteScript("std_plc_respawn",OBJECT_SELF);	
}