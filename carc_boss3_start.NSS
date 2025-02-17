//Creates shadow clones of all PCs in area
//frac
//#include "nw_i0_generic"
void BuffAndRun(object oClone,object oSource);
void Shadow()
{
object oArea = GetArea(OBJECT_SELF);
object oPCs = GetFirstPC();
int nLoc;
string sLoc = "carc_coliel_shadowspawn_";
while (GetIsObjectValid(oPCs))
{
if (GetIsPC(oPCs))
{
	if (GetArea(oPCs) == oArea)
	{
	nLoc = nLoc+1; 
	if (nLoc > 7) { nLoc = 1; }
	object oClone = CopyObject(oPCs,GetLocation(GetWaypointByTag(sLoc+IntToString(nLoc))),OBJECT_INVALID,"carcerum_shadowclone");
ExecuteScript("nw_c2_bossspawn",oClone);

ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints(oClone)),oClone);

	ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectCutsceneImmobilize(),oClone, 3.0);
	ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectNWN2SpecialEffectFile("fx_animus"),oClone);
	ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectNWN2SpecialEffectFile("sp_shades_summon"),GetLocation(GetWaypointByTag(sLoc+IntToString(nLoc))));
	BuffAndRun(oClone,GetObjectByTag("carc_coliel_shadowmaker"));	
	}
oPCs = GetNextPC();
}
}
}


void main()
{
object oPC = GetEnteringObject();
if (GetLocalInt(OBJECT_SELF,"DO_ONCE")) return;
if (!GetIsPC(oPC)) return;
SetLocalInt(OBJECT_SELF,"DO_ONCE",1);

MusicBattlePlay(GetArea(oPC));

object oSource = GetObjectByTag("carc_coliel_shadowmaker");
effect eRay1=EffectNWN2SpecialEffectFile("sp_beshadowed_ray",oSource);//obelisks
effect eRay3=EffectNWN2SpecialEffectFile("sp_utterdark_ray",oSource);//eyes
effect eRay4=EffectNWN2SpecialEffectFile("sp_lightning_ray",oSource);//buzzzzzzz
effect eBoom1=EffectNWN2SpecialEffectFile("sp_lightning_hit");
effect eBoom2=EffectNWN2SpecialEffectFile("sp_finger_of_death");
object oPoint1=GetObjectByTag("carc_coliel_bossray01");
object oPoint2=GetObjectByTag("carc_coliel_bossray02");
object oPoint3=GetObjectByTag("carc_coliel_bossray03");
object oPoint4=GetObjectByTag("carc_coliel_bossray04");
object oPoint5=GetObjectByTag("carc_coliel_bossray05");
object oPoint6=GetObjectByTag("carc_coliel_bossray06");
object oPoint7=GetObjectByTag("carc_coliel_bossray07");
object oPoint8=GetObjectByTag("carc_coliel_bossray08");
/////////////////////////////////////////////////////////////

ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eRay4,oPoint7,0.2);
DelayCommand(0.3,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eRay4,oPoint7,0.25));
DelayCommand(0.5,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eBoom1,GetLocation(oSource)));
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eRay4,oPoint8,0.2));
DelayCommand(1.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eRay4,oPoint8,0.35));
DelayCommand(1.95,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eRay4,oPoint8,1.0));
DelayCommand(2.95,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eBoom1,GetLocation(oSource)));


DelayCommand(5.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eRay1,oPoint1,17.0));
DelayCommand(6.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eRay1,oPoint3,15.5));
DelayCommand(8.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eRay1,oPoint2,14.0));
DelayCommand(9.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eRay1,oPoint4,12.5));
DelayCommand(11.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eRay3,oPoint5,10.5));
DelayCommand(11.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eRay3,oPoint6,10.5));

DelayCommand(22.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eBoom2,GetLocation(oSource)));
DelayCommand(22.5,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectNWN2SpecialEffectFile("fx_kos_slow_cast"),GetLocation(oSource)));
//around 7-8 seconds to spawn all shadows!
DelayCommand(23.0, Shadow());

}


void BuffAndRun(object oClone,object oSource)
{
SetLocalString(oClone,"DeathScript","carc_boss3_death");
//Counting how many shadows we have...
int nHowMany = GetLocalInt(oSource,"HOW_MANY"); nHowMany = nHowMany+1;
SetLocalInt(oSource,"HOW_MANY",nHowMany);

object oItem = GetFirstItemInInventory(oClone);
while (GetIsObjectValid(oItem))
{
DestroyObject(oItem);
oItem=GetNextItemInInventory(oClone);
}

object oGear = GetItemInSlot(INVENTORY_SLOT_ARMS, oClone);
if(GetIsObjectValid(oGear)) SetDroppableFlag(oGear, FALSE);
oGear = GetItemInSlot(INVENTORY_SLOT_ARROWS, oClone);
if(GetIsObjectValid(oGear)) SetDroppableFlag(oGear, FALSE);
oGear = GetItemInSlot(INVENTORY_SLOT_BELT, oClone);
if(GetIsObjectValid(oGear)) SetDroppableFlag(oGear, FALSE);
oGear = GetItemInSlot(INVENTORY_SLOT_BOLTS, oClone);
if(GetIsObjectValid(oGear)) SetDroppableFlag(oGear, FALSE);
oGear = GetItemInSlot(INVENTORY_SLOT_BOOTS, oClone);
if(GetIsObjectValid(oGear)) SetDroppableFlag(oGear, FALSE);
oGear = GetItemInSlot(INVENTORY_SLOT_BULLETS, oClone);
if(GetIsObjectValid(oGear)) SetDroppableFlag(oGear, FALSE);
oGear = GetItemInSlot(INVENTORY_SLOT_CHEST, oClone);
if(GetIsObjectValid(oGear)) SetDroppableFlag(oGear, FALSE);
oGear = GetItemInSlot(INVENTORY_SLOT_CLOAK, oClone);
if(GetIsObjectValid(oGear)) SetDroppableFlag(oGear, FALSE);
oGear = GetItemInSlot(INVENTORY_SLOT_HEAD, oClone);
if(GetIsObjectValid(oGear)) SetDroppableFlag(oGear, FALSE);
oGear = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oClone);
if(GetIsObjectValid(oGear)) SetDroppableFlag(oGear, FALSE);
oGear = GetItemInSlot(INVENTORY_SLOT_LEFTRING, oClone);
if(GetIsObjectValid(oGear)) SetDroppableFlag(oGear, FALSE);
oGear = GetItemInSlot(INVENTORY_SLOT_NECK, oClone);
if(GetIsObjectValid(oGear)) SetDroppableFlag(oGear, FALSE);
oGear = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oClone);
if(GetIsObjectValid(oGear)) SetDroppableFlag(oGear, FALSE);
oGear = GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oClone);
if(GetIsObjectValid(oGear)) SetDroppableFlag(oGear, FALSE);
int nGP = GetGold(oClone);
TakeGoldFromCreature(nGP,oClone,TRUE);
}