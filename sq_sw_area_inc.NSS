//:://///////////////////////////////////////////////////////////////
//:: Spirit World: Include
//:: sq_sw_area_inc.nss
//:: 
//:: Include script for sq_sw_area_enter and sq_sw_area_exit 
//:://///////////////////////////////////////////////////////////////

//:://///////////////////////////////////////////////////////////////
//:: Created By: Richard Pavlicek (k9burn@yahoo.com
//:: Created On: Jan 16, 2007
//:: Created For: Dasaria (Depheant)
//:://///////////////////////////////////////////////////////////////

void sq_sw_RemoveSpellFailure(object oPC)
{
    // Remove effects which are spell failure (supernatural)
    effect eCheck = GetFirstEffect(oPC);
    while(GetIsEffectValid(eCheck))
    {
        if(GetEffectSubType(eCheck) == SUBTYPE_SUPERNATURAL)
        {
            if(GetEffectType(eCheck) == EFFECT_TYPE_SPELL_FAILURE
			|| GetEffectType(eCheck) == EFFECT_TYPE_VISUALEFFECT)
            {
                RemoveEffect(oPC, eCheck);
            }
        }
        eCheck = GetNextEffect(oPC);
    }
}