// This is a wand that gives the targeted PC the emblem of the bard faction, along with some fireworks for effect
void main()
{
	object oPC;
	object oTarget;
	object oItem;
	string sPlayerName;
	int iBardLevel;
	
	oPC = GetItemActivator();
	oTarget = GetItemActivatedTarget();
	sPlayerName = GetName(oTarget);
	iBardLevel = GetLevelByClass(CLASS_TYPE_BARD,oTarget);
	
	//message + animate "play flute" + sound on the player
	SendMessageToPC( oPC, "You begin to play the fife");
	AssignCommand(oPC, PlayAnimation(31, 1.0, 5.0));
    AssignCommand(oPC, PlaySound("gui_flutesong01"));    
	effect eFNF    = ExtraordinaryEffect( EffectVisualEffect(VFX_DUR_BARD_SONG) );
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFNF, GetLocation(oPC));
	
	if (iBardLevel > 0)
	{	
		// some pretty effects on the target
		effect eGive = EffectVisualEffect(VFX_DUR_SHINING_SHIELD);
		ApplyEffectToObject(DURATION_TYPE_INSTANT, eGive, oTarget);
			
		// welcome target to the faction	
		FloatingTextStringOnCreature("Welcome, " + sPlayerName + " chosen of Teshalia", oTarget);
		
		// give target the item
		CreateItemOnObject("faction_bard_talisman", oTarget);
	}
	else
	{
		// sorry, charlie
		FloatingTextStringOnCreature(sPlayerName + " must first embark on the path of the player.", oTarget, FALSE);
	}
}