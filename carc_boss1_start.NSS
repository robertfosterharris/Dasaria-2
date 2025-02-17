//Boss fight begins
void DePlotOrbs()
{
object oOrb = GetObjectByTag("carc_mrlochorb_1red");
SetPlotFlag(oOrb,FALSE);
oOrb = GetObjectByTag("carc_mrlochorb_2red");
SetPlotFlag(oOrb,FALSE);
oOrb = GetObjectByTag("carc_mrlochorb_3red");
SetPlotFlag(oOrb,FALSE);
oOrb = GetObjectByTag("carc_mrlochorb_1blu");
SetPlotFlag(oOrb,FALSE);
oOrb = GetObjectByTag("carc_mrlochorb_2blu");
SetPlotFlag(oOrb,FALSE);
oOrb = GetObjectByTag("carc_mrlochorb_3blu");
SetPlotFlag(oOrb,FALSE);
}
void SpawnLocht(string sRef, string sLoc)
{
location lWP = GetLocation(GetWaypointByTag(sLoc));
object oMonster = CreateObject(OBJECT_TYPE_CREATURE,sRef,lWP);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectCutsceneImmobilize(),oMonster, 5.0);
ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectNWN2SpecialEffectFile("sp_shades_summon"),lWP);
}

void main()
{
object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;
if (GetLocalInt(OBJECT_SELF,"Done")) return;
SetLocalInt(OBJECT_SELF,"Done",1);
MusicBattleChange(GetArea(oPC),116);
MusicBattlePlay(GetArea(oPC));

DelayCommand(5.0,DePlotOrbs());
location lWP = GetLocation(GetWaypointByTag("carcerum_mrloch_bossspawn"));
DelayCommand(7.0,
ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectNWN2SpecialEffectFile("fx_kos_cast"),lWP));
DelayCommand(7.0,PlaySound("sff_wilting",TRUE));
DelayCommand(10.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectNWN2SpecialEffectFile("fx_kos_teleport"),lWP));

//CreateObject(OBJECT_TYPE_CREATURE,"carcerum_bossguardian01",lWP);

string sLoc = "carc_mrloch_bossfght1_spn3";
string sRef = "carcerum_lochtus01";
DelayCommand(5.5,SpawnLocht(sRef,sLoc));
sLoc = "carc_mrloch_bossfght1_spn4"; 
DelayCommand(6.75,SpawnLocht(sRef,sLoc));
sLoc = "carc_mrloch_bossfght1_spn7"; 
DelayCommand(8.0,SpawnLocht(sRef,sLoc));
sLoc = "carcerum_mrloch_bossspawn";
sRef = "carcerum_bossguardian01";
DelayCommand(10.5,SpawnLocht(sRef,sLoc));
}