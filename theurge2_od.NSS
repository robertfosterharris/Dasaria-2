// theurge2_od
//
#include "ginc_partymath"
#include "x0_i0_spells"
void main()
{

	object oMember;
	object oPC = GetLastKiller();
	object oTower = GetObjectByTag("theurge_tower");
	object oFire;
	object oFireSound = GetObjectByTag("theurge_fire_sound");
	object oRuin1;
	object oRuin2;
	object oExit;
	object oItem;
	object oArea = GetArea(oPC);
	location lTower = GetLocation(oTower);
	int nEntry = GetHighJournalEntry("tristan_theurge",oPC);
	effect eKnock = EffectKnockdown();
	effect eDIE = EffectNWN2SpecialEffectFile("fx_teleport");
	
	ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eDIE,GetLocation(OBJECT_SELF));
	
	if (GetIsObjectValid(GetMaster(oPC)) == TRUE)
	{
            oPC = GetMaster(oPC);
	}		

	if ( nEntry == 4)
	{			
		AddJournalQuestEntry("tristan_theurge",6,oPC,TRUE);
	}
	
	oItem = GetFirstObjectInShape(SHAPE_SPHERE,RADIUS_SIZE_LARGE,GetLocation(OBJECT_SELF),FALSE,OBJECT_TYPE_ITEM);
	while (GetIsObjectValid(oItem))
	{
		DestroyObject(oItem);
		oItem = GetNextObjectInShape(SHAPE_SPHERE,RADIUS_SIZE_LARGE,GetLocation(OBJECT_SELF),FALSE,OBJECT_TYPE_ITEM);
	}
	
	// To get companions/henchmen, we need to do two
	// loops of the faction, a TRUE and a FALSE loop
	oMember = GetFirstFactionMember(oPC,TRUE);
	while (GetIsObjectValid(oMember) == TRUE)
	{
		// petrified players won't jump
		RemoveAnySpellEffects(SPELL_FLESH_TO_STONE, oMember);
		BlackScreen(oPC);
		AssignCommand(oMember,JumpToObject(GetObjectByTag("wp_theurge_escape")));	
		FadeFromBlack(oPC, FADE_SPEED_SLOW);
		DelayCommand(2.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eKnock,oPC));
	
		oMember = GetNextFactionMember(oPC,TRUE);
	}

	oMember = GetFirstFactionMember(oPC,FALSE);
	while (GetIsObjectValid(oMember) == TRUE)
	{
		RemoveAnySpellEffects(SPELL_FLESH_TO_STONE, oMember);
		AssignCommand(oMember,JumpToObject(GetObjectByTag("wp_theurge_escape")));
		DelayCommand(2.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eKnock,oPC));
			
		oMember = GetNextFactionMember(oPC,FALSE);
	}
	
	//AssignCommand(oPC,JumpToObject(GetObjectByTag("wp_theurge_escape")));
	
	effect eDeath = EffectDeath();
	effect eSpecDeath = EffectLinkEffects(eDeath,EffectVisualEffect(860));
	
	// destroy any henchmen still around, we don't want them 
	// walking around up there in the air
	DestroyObject(GetNearestObjectByTag("theurge_sorc"));
	DestroyObject(GetNearestObjectByTag("theurge_sorc"));
	
	// lock the exit door, we don't want people 
	// walking out into space now, do we?
	oExit = GetObjectByTag("theurge_roof_exit");
	SetLocked(oExit,TRUE);
	AssignCommand(oArea,DelayCommand(300.0,SetLocked(oExit,FALSE)));	
	
	// destroy unneeded respawnables
	ApplyEffectToObject(DURATION_TYPE_INSTANT,eDeath,GetObjectByTag("theurge_portal"));
	ApplyEffectToObject(DURATION_TYPE_INSTANT,eDeath,GetObjectByTag("theurge_plates"));
	ApplyEffectToObject(DURATION_TYPE_INSTANT,eDeath,GetObjectByTag("theurge_grate"));
	ApplyEffectToObject(DURATION_TYPE_INSTANT,eDeath,GetObjectByTag("theurge_ladder1"));
	ApplyEffectToObject(DURATION_TYPE_INSTANT,eDeath,GetObjectByTag("theurge_ladder2"));
	ApplyEffectToObject(DURATION_TYPE_INSTANT,eDeath,GetObjectByTag("theurge_pulley"));
	ApplyEffectToObject(DURATION_TYPE_INSTANT,eDeath,GetObjectByTag("theurge_enter_door"));
	ApplyEffectToObject(DURATION_TYPE_INSTANT,eDeath,GetObjectByTag("theurge_grate"));
		
	// special effects for tower destruction
	ApplyEffectToObject(DURATION_TYPE_INSTANT,eSpecDeath,oTower);
	AssignCommand(GetObjectByTag("theurge_soundplay1"),PlaySound("as_na_rockfallg1"));
	ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_HIT_SPELL_FLAMESTRIKE),lTower);
	oRuin1 = CreateObject(OBJECT_TYPE_PLACEABLE,"theurge_ruins1",GetLocation(GetObjectByTag("wp_theurge_ruin1")));
	oRuin2 = CreateObject(OBJECT_TYPE_PLACEABLE,"theurge_ruins2",GetLocation(GetObjectByTag("wp_theurge_ruin2")));
	ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_SPELL_HIT_EARTHQUAKE),lTower);
		
	// remenants burn for five mins or so
	ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,EffectNWN2SpecialEffectFile("fx_blazing_fire_lg"),lTower,240.0);
	SoundObjectPlay(oFireSound);
	AssignCommand(oArea,DelayCommand(240.0,SoundObjectStop(oFireSound)));
	AssignCommand(oArea,DelayCommand(280.0,DestroyObject(oRuin1)));
	AssignCommand(oArea,DelayCommand(280.0,DestroyObject(oRuin2)));
		
}