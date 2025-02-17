// This is a wand that gives the targeted PC the emblem of a faction, along with some fireworks for effect
void main()
{
	object oPC;
	object oTarget;
	object oItem;
	string sPlayerName;
	
	oPC = GetItemActivator();
	oTarget = GetItemActivatedTarget();
	sPlayerName = GetName(oTarget);
		
    AssignCommand(oPC, PlaySound("sfx_bansheewail"));  
	AssignCommand(oTarget, PlaySound("sfx_bansheewail"));  
	effect eFNF    = ExtraordinaryEffect( EffectVisualEffect(VFX_HIT_SPELL_WAIL_OF_THE_BANSHEE) );
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFNF, GetLocation(oPC));
	
	// some pretty effects on the target
	effect eGive = EffectVisualEffect(VFX_DUR_BLUR);
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eGive, oTarget);
			
	// welcome target to the faction	
	FloatingTextStringOnCreature("Welcome, " + sPlayerName + " to Clan Stormbeard", oTarget,FALSE);
		
	// give target the item
	CreateItemOnObject("faction_dwarves_talisman", oTarget);
}