/* Encounter spawns with a flashy VFX
	by fractal
Just remember to assign the following variables to the trigger:
resref : Creature resref
num : Number of creatures to spawn
vfx : .sef file to play. Defaults to sp_summon_creature_1
wp : location for spawn
delay : How long till it resets. Defaults to 600 sec (10 minutes)
script : Plugin script in case something else happens
*/
//#include "nw_i0_generic"
void main()
{
object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;
if (GetLocalInt(OBJECT_SELF, "Done")) return;
float fDelay = GetLocalFloat(OBJECT_SELF,"delay"); if (fDelay < 1.0) {fDelay=1200.0;}
SetLocalInt(OBJECT_SELF,"Done",1); DelayCommand(fDelay, DeleteLocalInt(OBJECT_SELF,"Done"));

int iNum = GetLocalInt(OBJECT_SELF,"num");
string sRef = GetLocalString(OBJECT_SELF,"resref");
string sVFX = GetLocalString(OBJECT_SELF,"vfx"); if (sVFX == "") {sVFX == "sp_summon_creature_1";}
location lWP = GetLocation(GetWaypointByTag(GetLocalString(OBJECT_SELF,"wp")));
string sScript = GetLocalString(OBJECT_SELF,"script");

ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectNWN2SpecialEffectFile(sVFX),lWP);


int nCount;
while (nCount < iNum)
{
object oMonster = CreateObject(OBJECT_TYPE_CREATURE,sRef,lWP);
if (GetLocalInt(OBJECT_SELF,"Wait"))
{ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectCutsceneImmobilize(),oMonster, 2.5);}
nCount = nCount+1;
}

if (sScript != "") {ExecuteScript(sScript,OBJECT_SELF);}
}