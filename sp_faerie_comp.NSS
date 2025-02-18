// sp_faerie_comp 
// wired 2012/07/13

#include "x2_inc_spellhook"
#include "std_inc_npc_levelup"

void LevelMySummon()
{
	object oSummon = GetAssociate(ASSOCIATE_TYPE_SUMMONED,OBJECT_SELF);
	
	if (!GetIsObjectValid(oSummon))
	{
		SendMessageToPC(OBJECT_SELF,"DEBUG: Could not locate faerie companion!");
	}
	int nLevel = GetHitDice(OBJECT_SELF)-3;

 	LevelMeUpTo(oSummon, nLevel, CLASS_TYPE_FEY ,TRUE);	
		
}

void main()
{

     /*
      Spellcast Hook Code
      Added 2003-06-23 by GeorgZ
      If you want to make changes to all spells,
      check x2_inc_spellhook.nss to find out more

    */
	
	SendMessageToPC(OBJECT_SELF,"Summoning Faerie Companion.");

        if (!X2PreSpellCastCode())
        {
        // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
            return;
        }

    // End of Spell Cast Hook
    //Declare major variables    
   
    effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3);
	effect eSummon = ExtraordinaryEffect(EffectSummonCreature("d2_faerie_comp"));
	
    //Apply the VFX impact and summon effect
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eVis, GetSpellTargetLocation());
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(),HoursToSeconds(72));
	
	DelayCommand(2.0,LevelMySummon()); 
}