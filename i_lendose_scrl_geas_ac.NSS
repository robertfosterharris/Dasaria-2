#include "ginc_partymath"
#include "ginc_henchman"
#include "ginc_cutscene"

void main()
{
	object oPC = GetItemActivator();
	object oTarget = GetItemActivatedTarget();
	string sQuestName = "lendose_toystore";
	int nJournalEntry = GetHighJournalEntry(sQuestName,oPC);
	effect eVis = EffectVisualEffect(VFX_DUR_SHINING_SHIELD);
	
	if (GetTag(oTarget) == "kobblenort_golem" && nJournalEntry == 8)
	{
		FloatingTextStringOnCreature("<color=cyan>"+GetName(oPC)+"</color> <color=mediumpurple>is casting Geas/Quest</color>",oPC,TRUE,0.0f);
		AddJournalQuestEntry(sQuestName,9,oPC,TRUE);
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVis,oTarget,30.f);
		FloatingTextStringOnCreature("<color=cyan>"+GetName(oPC)+"</color> <color=mediumpurple>Casts Geas/Quest</color>",oPC,TRUE,0.0f);
		
		SetCommandable(TRUE,oTarget);
		RemoveAllEffects(oTarget,FALSE);		
		SetCreatureScriptsToSet(oTarget,SCRIPTSET_NPC_ASSOCIATES);
		SetPlotFlag(oTarget, FALSE);
		SetBumpState(oTarget, BUMPSTATE_BUMPABLE);
		HenchmanAdd(oPC,oTarget,TRUE,TRUE);
	}
	else
	{
		FloatingTextStringOnCreature("<color=cyan>"+GetName(oPC)+"</color> <color=mediumpurple>is casting Geas/Quest</color>",oPC,TRUE,0.0f);
		FloatingTextStringOnCreature("<color=purple>Spell Failed!</color>",oPC,TRUE,0.0f);
	}
}