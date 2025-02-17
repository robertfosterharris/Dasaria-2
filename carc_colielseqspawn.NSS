//#include "nw_i0_generic"
#include "x0_i0_position"
void Spawn(string sRef, string sVFX, location lWP)
{
object oSource = GetObjectByTag("carc_coliel_seqspawner");
lWP = GetRandomLocation(GetArea(OBJECT_SELF),oSource,2.0);
object oMonster = CreateObject(OBJECT_TYPE_CREATURE,sRef,lWP);
ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectNWN2SpecialEffectFile(sVFX),lWP);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectCutsceneImmobilize(),oMonster, 1.5);
}

void main()
{
object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;
if (GetLocalInt(OBJECT_SELF, "Done")) return;
SetLocalInt(OBJECT_SELF,"Done",1); 
DelayCommand(1800.0, DeleteLocalInt(OBJECT_SELF,"Done")); 

string sVFX = "sp_summon_creature_1";
location lWP; //= GetLocation(GetWaypointByTag("whatever"));
string sRef = "carcerum_druagoth02";

SetLocked(GetObjectByTag("carc_coliel_battroom_exit"),TRUE);
//Wave 1
Spawn(sRef,sVFX,lWP);
Spawn(sRef,sVFX,lWP);

//Wave 2 (1 dru warrior)
DelayCommand(6.0,Spawn(sRef,sVFX,lWP));

//Wave 3 (huge elementals)
//sRef = "c_elmwatergreater";
//DelayCommand(12.0,Spawn(sRef,sVFX,lWP));
sRef = "c_elmairgreater";
DelayCommand(12.0,Spawn(sRef,sVFX,lWP));

//Wave 4 (imps)
sRef = "c_imp";
DelayCommand(18.0,Spawn(sRef,sVFX,lWP));
DelayCommand(18.0,Spawn(sRef,sVFX,lWP));
DelayCommand(18.0,Spawn(sRef,sVFX,lWP));
DelayCommand(18.0,Spawn(sRef,sVFX,lWP));
DelayCommand(18.0,Spawn(sRef,sVFX,lWP));
DelayCommand(18.0,Spawn(sRef,sVFX,lWP));

//Wave 5 (iron golem)
sRef = "c_irongol";
DelayCommand(24.0,Spawn(sRef,sVFX,lWP));

//Wave 6 (huge elementals)
sRef = "c_elmfiregreater";
DelayCommand(30.0,Spawn(sRef,sVFX,lWP));
//sRef = "c_elmearthgreater";
//DelayCommand(30.0,Spawn(sRef,sVFX,lWP));

//Wave 7 (2 dru warriors)
sRef = "carcerum_druagoth02";
DelayCommand(36.0,Spawn(sRef,sVFX,lWP));
//DelayCommand(36.0,Spawn(sRef,sVFX,lWP));

//Wave 8 (2 dru archers)
sRef = "carcerum_druagoth01";
DelayCommand(42.0,Spawn(sRef,sVFX,lWP));
DelayCommand(42.0,Spawn(sRef,sVFX,lWP));

//Wave 9 (imps)
sRef = "c_imp";
DelayCommand(48.0,Spawn(sRef,sVFX,lWP));
DelayCommand(48.0,Spawn(sRef,sVFX,lWP));
DelayCommand(48.0,Spawn(sRef,sVFX,lWP));
DelayCommand(48.0,Spawn(sRef,sVFX,lWP));
//DelayCommand(48.0,Spawn(sRef,sVFX,lWP));

//Wave 10 (Lochtus)
sRef = "carcerum_lochtus01";
sVFX = "sp_shades_summon";
DelayCommand(60.0,Spawn(sRef,sVFX,lWP));
DelayCommand(68.0,SetLocked(GetObjectByTag("carc_coliel_battroom_exit"),FALSE));
}