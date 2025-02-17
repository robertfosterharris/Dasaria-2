
#include "ginc_partymath"

void main()
{
	object oPC = GetItemActivator();
	object oTarget = GetItemActivatedTarget();
	string sQuestName = "lendose_toystore";
	int nJournalEntry = GetHighJournalEntry(sQuestName,oPC);
	effect eVis = EffectVisualEffect(VFX_HIT_SPELL_METEOR_SWARM_LRG);
	effect eDeath = EffectDeath(TRUE);
	
	if (GetTag(oTarget) == "lendose_kobblenort_mold" && nJournalEntry == 7)
	{
		FloatingTextStringOnCreature("<color=lightblue>"+GetName(oPC)+"</color> <color=mediumpurple>is casting Limited Wish</color>",oPC,TRUE,0.0f);
		AddJournalQuestEntry(sQuestName,8,oPC,TRUE);
		ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oTarget,30.f);
		FloatingTextStringOnCreature("<color=lightblue>"+GetName(oPC)+"</color> <color=mediumpurple>Casts Limited Wish</color>",oPC,TRUE,0.0f);
			
		ApplyEffectToObject(DURATION_TYPE_INSTANT,eDeath,oTarget);
		CreateObject(OBJECT_TYPE_CREATURE,"kobblenort_golem",GetLocation(GetObjectByTag("wp_golem_create")));
	}
	else
	{
		FloatingTextStringOnCreature("<color=lightblue>"+GetName(oPC)+"</color> <color=mediumpurple>is casting Limited Wish</color>",oPC,TRUE,0.0f);
		FloatingTextStringOnCreature("<color=mediumpurple>Spell Failed!</color>",oPC,TRUE,0.0f);
	}
}