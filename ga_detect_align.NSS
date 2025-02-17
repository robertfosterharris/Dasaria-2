// ga_detect_align
// Wired 05/02/2009 Pretty much rewritten
//edited for subtlety by atharin june 15 2009
//Added a hook for non-detection items, int IsNonDetectable(), june 19 09  --Atharin
/*
Level:  			Clr 1
Components: 		V, S, DF
Casting Time: 		1 standard action
Range: 				60 ft.
Area: 				Cone-shaped emanation
Duration: 			Concentration, up to 10 min./ level (D)  {One round per class level}
Saving Throw: 		None
Spell Resistance:	No

You can sense the presence of evil. The amount of information revealed
depends on how long you study a particular area or subject. 
*/

int IsNonDetectable(object oTarget)
{
	//1. Has nondetect amulet
	if (GetItemPossessedBy(oTarget,"carci_nondetect") != OBJECT_INVALID)
	{ return TRUE; }

	//2. ???
	
	//3. ???
	
else { return FALSE; }
}

void ActionDetectAlignment(object oPC);

void main()
{
	object oPC = GetPCSpeaker();
	AssignCommand(oPC,ActionCastFakeSpellAtObject(SPELLABILITY_TURN_UNDEAD,oPC));
    DelayCommand(2.0f,ActionDetectAlignment(oPC));
}

void ActionDetectAlignment(object oPC)
{
	float fDuration;
	object oTarget;
    int nAlign;
	effect eVisI;
	effect eVisT;
	int COUNTER_ALIGN;
	int nCount = 0;
	string sAlign;

	if (GetLevelByClass(CLASS_TYPE_PALADIN,oPC) > 0)
	{
		eVisI = EffectVisualEffect(VFX_COM_HIT_DIVINE);	
		eVisT = EffectVisualEffect(VFX_DUR_SICKENED);
		fDuration = RoundsToSeconds(GetLevelByClass(CLASS_TYPE_PALADIN,oPC));
		COUNTER_ALIGN = ALIGNMENT_EVIL;
		sAlign = "evil";
	}
	else if (GetLevelByClass(CLASS_TYPE_BLACKGUARD,oPC) > 0) 
	{	
		eVisI = EffectVisualEffect(VFX_COM_HIT_NEGATIVE);	
		eVisT = EffectVisualEffect(VFX_DUR_SPELL_SHIELD_OF_FAITH);
		fDuration = RoundsToSeconds(GetLevelByClass(CLASS_TYPE_BLACKGUARD,oPC));
		COUNTER_ALIGN = ALIGNMENT_GOOD;
		sAlign = "good";
	}
	else
	{
		// oh shit!
		return;
	}

    //Get first target in spell area
    oTarget = GetFirstObjectInShape(SHAPE_CONE, 18.288, GetLocation(oPC));
    while(GetIsObjectValid(oTarget))
    {
        //Check the current target's alignment
        nAlign = GetAlignmentGoodEvil(oTarget);
		
		if (!IsNonDetectable(oTarget))
		{
        if(nAlign == COUNTER_ALIGN)
        {
            //Apply the VFX
			//ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisI, oTarget);
			//if (!GetIsInCombat(oTarget))
			 //PlayCustomAnimation(oTarget, "*damage01",0,1.0f);
            //ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVisT, oTarget, fDuration);
			//nCount++;
			SendMessageToPC(oPC, "<i>You detect "+sAlign+" within "+GetName(oTarget));
        }
		}
        //Get next target in spell area
        oTarget = GetNextObjectInShape(SHAPE_CONE, 18.288, GetLocation(OBJECT_SELF));
    }
	//SendMessageToPC(oPC,"<i>You detect "+IntToString(nCount)+" "+sAlign+" creatures within your line of sight.</i>");
}