//carc_finale_cutscene 


void FadeEverybody(object oPC);




string sNPC = "carcerum_traductusfin"; //traductus resref
object oLightEmitter1 = GetObjectByTag("carc_fin_lightemit01");
object oLightEmitter2 = GetObjectByTag("carc_fin_lightemit02");
object oLightEmitter3 = GetObjectByTag("carc_fin_lightemit03");
object oCrackle=GetObjectByTag("carc_fin_cracklelight");
location lTarget1 = GetLocation(GetWaypointByTag("carc_fin_target01"));
location lTarget2 = GetLocation(GetWaypointByTag("carc_fin_target02"));
location lTarget3 = GetLocation(GetWaypointByTag("carc_fin_target03"));
location lTarget4 = GetLocation(GetWaypointByTag("carc_fin_target04"));

location lSpawn1 = GetLocation(GetWaypointByTag("carc_fin_spawn01"));
location lSpawn2 = GetLocation(GetWaypointByTag("carc_fin_spawn02"));
location lSpawn3 = GetLocation(GetWaypointByTag("carc_fin_spawn03"));
location lSpawn4 = GetLocation(GetWaypointByTag("carc_fin_spawn04"));

void SpawnHornDevil(location lSpawn,string sTag="c_devilhorn", int nFreeze=0, string sNewTag="")
{
if (sNewTag == "") { sNewTag = sTag; }
object oSpawn = CreateObject(OBJECT_TYPE_CREATURE,sTag,lSpawn,FALSE,sNewTag);
ApplyEffectAtLocation(DURATION_TYPE_INSTANT,
EffectNWN2SpecialEffectFile("sp_meteor_swarm_impact"),lSpawn);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectCutsceneImmobilize(),oSpawn,2.0);

if (nFreeze > 0) 
{ 
//AssignCommand(oSpawn,ActionWait(6.0));
//ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectCutsceneParalyze(),oSpawn, 6.0);
ChangeToStandardFaction(oSpawn,STANDARD_FACTION_COMMONER);
	if (nFreeze >1)
	{
	SetScriptHidden(oSpawn,TRUE,TRUE);
	DelayCommand(1.0,SetScriptHidden(oSpawn,FALSE,FALSE));
	}
}
}
void SpawnMaer(object oSource)
{

object oMaeruloch = CreateObject(OBJECT_TYPE_CREATURE,"carcerum_maeruloch",GetLocation(oSource));;
AssignCommand(oMaeruloch,ActionCastSpellAtLocation(SPELL_WALL_OF_FIRE, lTarget1,METAMAGIC_EXTEND,TRUE,PROJECTILE_PATH_TYPE_DEFAULT,TRUE));
AssignCommand(oMaeruloch,ActionCastSpellAtLocation(SPELL_WALL_OF_FIRE, lTarget2,METAMAGIC_EXTEND,TRUE,PROJECTILE_PATH_TYPE_DEFAULT,TRUE));
AssignCommand(oMaeruloch,ActionCastSpellAtLocation(SPELL_WALL_OF_FIRE, lTarget3,METAMAGIC_EXTEND,TRUE,PROJECTILE_PATH_TYPE_DEFAULT,TRUE));
AssignCommand(oMaeruloch,ActionCastSpellAtLocation(SPELL_WALL_OF_FIRE, lTarget4,METAMAGIC_EXTEND,TRUE,PROJECTILE_PATH_TYPE_DEFAULT,TRUE));

AssignCommand(oMaeruloch,ActionCastSpellAtLocation(SPELL_DELAYED_BLAST_FIREBALL, lTarget1,METAMAGIC_EMPOWER,TRUE,PROJECTILE_PATH_TYPE_DEFAULT,TRUE));
AssignCommand(oMaeruloch,ActionCastSpellAtLocation(SPELL_DELAYED_BLAST_FIREBALL, lTarget2,METAMAGIC_EMPOWER,TRUE,PROJECTILE_PATH_TYPE_DEFAULT,TRUE));
AssignCommand(oMaeruloch,ActionCastSpellAtLocation(SPELL_DELAYED_BLAST_FIREBALL, lTarget3,METAMAGIC_EMPOWER,TRUE,PROJECTILE_PATH_TYPE_DEFAULT,TRUE));
AssignCommand(oMaeruloch,ActionCastSpellAtLocation(SPELL_DELAYED_BLAST_FIREBALL, lTarget4,METAMAGIC_EMPOWER,TRUE,PROJECTILE_PATH_TYPE_DEFAULT,TRUE));

AssignCommand(oMaeruloch,ActionCastSpellAtObject(SPELL_GREATER_FIREBURST, oMaeruloch,METAMAGIC_MAXIMIZE,TRUE,0,PROJECTILE_PATH_TYPE_DEFAULT,TRUE));


ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectCutsceneImmobilize(),oMaeruloch,3.5);
AssignCommand(oMaeruloch,ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));

DelayCommand(2.0,AssignCommand(oMaeruloch,ActionSpeakString("<color=#E0B855><b>SOME KIND OF THREAT!")));


ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectImmunity(IMMUNITY_TYPE_DEATH)),oMaeruloch);
ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectImmunity(IMMUNITY_TYPE_FEAR)),oMaeruloch);

}

void main(int nScene)
{
switch (nScene)
{
case 1: //start
{
if (GetJournalEntry("carcerum_journal", GetPCSpeaker()) == 11)
{ sNPC = "carcerum_jeremusfin"; } //If PCs sided with Traductus, spawn Jeremus
object oTraduc = GetObjectByTag(sNPC);
PlayCustomAnimation(oTraduc,"worship",1);
}
break;

case 2: //boom! Maeruloch shows up.
{
if (GetJournalEntry("carcerum_journal", GetPCSpeaker()) == 11)
{ sNPC = "carcerum_jeremusfin"; } //If PCs sided with Traductus, spawn Jeremus
object oTraduc = GetObjectByTag(sNPC);

ApplyEffectToObject(DURATION_TYPE_INSTANT,
EffectNWN2SpecialEffectFile("fx_silver_shard_shield"),oTraduc);
ApplyEffectAtLocation(DURATION_TYPE_INSTANT,
EffectNWN2SpecialEffectFile("fx_kos_slow_cast"),GetLocation(oLightEmitter1));
DelayCommand(4.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectNWN2SpecialEffectFile("fx_silver_shard_shield"),oTraduc));
DelayCommand(7.0,SetLightActive(oCrackle,FALSE));
DelayCommand(5.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectNWN2SpecialEffectFile("sp_wail_of_banshee"),oTraduc));
DelayCommand(6.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectNWN2SpecialEffectFile("fx_silver_shard_shield"),oTraduc));
DelayCommand(8.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectNWN2SpecialEffectFile("fx_silver_shard_shield"),GetLocation(oTraduc)));
DelayCommand(7.9,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectNWN2SpecialEffectFile("sp_mswarm_lrg_imp"),GetLocation(oTraduc)));
DelayCommand(7.5,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectNWN2SpecialEffectFile("sp_meteor_swarm_impact"),oTraduc));
DelayCommand(7.5, SetPlotFlag(oTraduc,FALSE));

DelayCommand(8.1,SetScriptHidden(oTraduc,TRUE,TRUE));
DelayCommand(8.0,ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectNWN2SpecialEffectFile("fx_gate_small"),oLightEmitter2));
DelayCommand(8.1,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectNWN2SpecialEffectFile("sp_frightful_doom"),GetLocation(oLightEmitter2)));

DelayCommand(8.2,SpawnMaer(oLightEmitter2));

DelayCommand(8.5,SpawnHornDevil(lSpawn1,"c_devilhorn",0,"carcerum_maeraid01"));
DelayCommand(9.7,SpawnHornDevil(lSpawn3,"c_devilhorn",0,"carcerum_maeraid02"));
DelayCommand(10.9,SpawnHornDevil(lSpawn2,"c_devilhorn",0,"carcerum_maeraid03"));
DelayCommand(11.1,SpawnHornDevil(lSpawn4,"c_devilhorn",0,"carcerum_maeraid04"));

DelayCommand(11.2,DestroyObject(oTraduc));
}
break;
case 3://Abelis power up 1...
{
//
SetLightActive(oCrackle,TRUE);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectNWN2SpecialEffectFile("sp_invisibility_purge"),oLightEmitter2,30.0);
ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectNWN2SpecialEffectFile("fx_silver_shard_shield"),GetLocation(oLightEmitter3));
DelayCommand(4.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectNWN2SpecialEffectFile("fx_silver_shard_shield"),GetLocation(oLightEmitter3)));
}
break;
case 4://Abelis shows up!
{
object oAbelis = CreateObject(OBJECT_TYPE_CREATURE,"carcerum_abelis",GetLocation(oLightEmitter2));
ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectNWN2SpecialEffectFile("sp_noxious_doom"),GetLocation(oLightEmitter2));
DelayCommand(1.5,AssignCommand(oAbelis,ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT)));
ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectImmunity(IMMUNITY_TYPE_DEATH)),oAbelis);
ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectImmunity(IMMUNITY_TYPE_FEAR)),oAbelis);

}
break;
case 5://bunch of aids spawn around Abelis
{
//rebel lochti?
DelayCommand(2.0,SpawnHornDevil(lSpawn1,"c_devilhorn",1,"carcerum_abelisaid1"));
DelayCommand(6.0,SpawnHornDevil(lSpawn4,"c_fiend",1,"carcerum_abelisaid2"));
DelayCommand(4.0,SpawnHornDevil(lSpawn3,"c_devilhorn",1,"carcerum_abelisaid3"));
DelayCommand(4.0,SetLightActive(oCrackle,FALSE));
}
break;
case 6://Coliel shows up
{
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectNWN2SpecialEffectFile("sp_invisibility_purge"),oLightEmitter2,30.0);
ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectNWN2SpecialEffectFile("fx_silver_shard_shield"),GetLocation(oLightEmitter3));
DelayCommand(4.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectNWN2SpecialEffectFile("fx_silver_shard_shield"),GetLocation(oLightEmitter3)));
SetLightActive(oCrackle,TRUE);
}
break;
case 7://colispawn
{
object oColiel = CreateObject(OBJECT_TYPE_CREATURE,"carcerum_coliel",GetLocation(oLightEmitter2));
ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectNWN2SpecialEffectFile("sp_hellrime_doom"),GetLocation(oLightEmitter2));
ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectNWN2SpecialEffectFile("fx_balor_fire_explosion"),GetLocation(oLightEmitter2));
DelayCommand(0.5,AssignCommand(oColiel,ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT)));
ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectImmunity(IMMUNITY_TYPE_DEATH)),oColiel);
ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectImmunity(IMMUNITY_TYPE_FEAR)),oColiel);
SetPlotFlag(oColiel,TRUE);

}
break;
case 8://coli roars+power surge
{
object oColiel = GetObjectByTag("carcerum_coliel");
DelayCommand(0.5,AssignCommand(oColiel,ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT)));
//DelayCommand(1.0,AssignCommand(oColiel,ActionCastFakeSpellAtObject(SPELL_FINGER_OF_DEATH,oColiel)));
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectNWN2SpecialEffectFile("fx_kos_slow_cast"),oColiel));
}
break;
case 9://coli summons friends
{
DelayCommand(0.5,AssignCommand(GetObjectByTag("carcerum_coliel"),ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT)));
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectCutsceneImmobilize(),GetObjectByTag("carcerum_coliel"), 6.0);
SpawnHornDevil(lSpawn1,"c_devilhorn",2,"carcerum_coliaid1");
DelayCommand(2.5,SpawnHornDevil(lSpawn4,"c_fiend",2,"carcerum_coliaid2"));
DelayCommand(5.0,SpawnHornDevil(lSpawn2,"c_devilhorn",2,"carcerum_coliaid3"));
DelayCommand(6.5,SpawnHornDevil(lSpawn3,"c_fiend",2,"carcerum_coliaid4"));

DelayCommand(7.5,SetLightActive(oCrackle,FALSE));

DelayCommand(2.0,SpawnHornDevil(lSpawn1,"c_imp",2,"carcerum_coliimp1"));
DelayCommand(4.0,SpawnHornDevil(lSpawn2,"c_imp",2,"carcerum_coliimp2"));
DelayCommand(6.0,SpawnHornDevil(lSpawn3,"c_imp",2,"carcerum_coliimp3"));
DelayCommand(8.0,SpawnHornDevil(lSpawn4,"c_imp",2,"carcerum_coliimp4"));
}
break;

case 10://kaboom!
{
//
location lLoc = GetLocation(GetWaypointByTag("carc_finale_endboom1"));
ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectNWN2SpecialEffectFile("fx_kos_death_fx"),lLoc);
lLoc = GetLocation(GetWaypointByTag("carc_finale_endboom2"));
ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectNWN2SpecialEffectFile("fx_kos_death_fx"),lLoc);
lLoc = GetLocation(GetWaypointByTag("carc_finale_endboom3"));
ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectNWN2SpecialEffectFile("fx_kos_death_fx"),lLoc);
lLoc = GetLocation(GetWaypointByTag("carc_finale_endboom4"));
ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectNWN2SpecialEffectFile("fx_kos_death_fx"),lLoc);
lLoc = GetLocation(GetWaypointByTag("carc_fin_traducspn"));
ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectNWN2SpecialEffectFile("fx_kos_death_fx"),lLoc);

PlaySound("cs_kos_death", TRUE);

DelayCommand(10.0,FadeEverybody(GetPCSpeaker()));
DelayCommand(12.0,RemoveEffect(oLightEmitter2,EffectNWN2SpecialEffectFile("fx_gate_small")));

DelayCommand(16.0,JumpPartyToArea(GetPCSpeaker(),GetWaypointByTag("carc_outside")));
SetLocalInt(GetPCSpeaker(),"CarcQuestCompletedSuccess",1);
}
break;

case 11://portal jump to finale..
{
object oPC = GetPCSpeaker();
JumpPartyToArea(oPC,GetWaypointByTag("carc_finale_entry"));
}
break;
case 12://Entrance
{
object oPC = GetPCSpeaker();
JumpPartyToArea(oPC,GetWaypointByTag("carc_entryway"));
}
break;
}
}

void FadeEverybody(object oPC)
{
object oMember = GetFirstFactionMember(oPC,TRUE);
	while (GetIsObjectValid(oMember))
	{
	FadeToBlack(oMember,3.5,10.0);	
	oMember = GetNextFactionMember(oPC,TRUE);
	}
}