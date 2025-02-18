// Wired 10/12/2008 There was a bug in this, it was only detecting
// the caster's own alignment. Maybe that's why they left it out?


//::///////////////////////////////////////////////
//:: Detect_Evil
//:: NW_S2_DetecEvil.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    All creatures of Evil Alignment within LOS of
    the Paladin glow for a few seconds.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Aug 14, 2001
//:://////////////////////////////////////////////

void main()
{
    //Declare major variables
    object oTarget;
    int nEvil;
    //effect eVis = EffectVisualEffect(VFX_COM_SPECIAL_RED_WHITE);
	//effect eVis = EffectVisualEffect(VFX_DUR_SPELL_MAGE_ARMOR);  // this one works
	effect eVis = EffectVisualEffect(VFX_DUR_SICKENED);
    
    //Get first target in spell area
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 20.0, GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oTarget))
    {
        //Check the current target's alignment
        nEvil = GetAlignmentGoodEvil(oTarget);
        if(nEvil == ALIGNMENT_EVIL)
        {
            //Apply the VFX
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget, 90.0);
        }
        //Get next target in spell area
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    }
}