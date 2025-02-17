//:: Scales puzzle
//:: by fractal, May 2008
//:: PC must place 100 lbs of weight on the scales for the door to open.


//CLEANUP AND RECYCLE FUNCTION
void Cleanup(object oContainer)
{
object oItem = GetFirstItemInInventory(oContainer);
while (GetIsObjectValid(oItem))
{
if (GetTag(oItem) == "carc_rockL") { DestroyObject(oItem); }
if (GetTag(oItem) == "carc_rockS") { DestroyObject(oItem); }
if (GetTag(oItem) == "carc_rockH") { DestroyObject(oItem); }
oItem = GetNextItemInInventory(oContainer);
}
if (GetTag(oContainer) == "carc_rockscontainer1")
{
CreateItemOnObject("carc_rockH", oContainer);
CreateItemOnObject("carc_rockL", oContainer);
}

if (GetTag(oContainer) == "carc_rockscontainer2")
{
CreateItemOnObject("carc_rockS", oContainer);
}

if (GetTag(oContainer) == "carc_rockscontainer3")
{
CreateItemOnObject("carc_rockS", oContainer);
}

if (GetTag(oContainer) == "carc_rockscontainer4")
{
CreateItemOnObject("carc_rockS", oContainer);
CreateItemOnObject("carc_rockH", oContainer);
}
if (GetTag(oContainer) == "carc_rockscontainer5")
{
CreateItemOnObject("carc_rockL", oContainer);
}
}


//MAIN FUNCTION
void main()
{
object oPC = GetLastClosedBy();
object oItem = GetFirstItemInInventory(OBJECT_SELF);
int nWeight; int nSum = 0;
while (GetIsObjectValid(oItem))
{
nWeight = GetWeight(oItem);
nSum = nSum + nWeight;
oItem = GetNextItemInInventory(OBJECT_SELF);
}
if ((nSum > 980) && (nSum < 1030))
{
AssignCommand(OBJECT_SELF, 
ActionSpeakString("<i>The scales reach near perfect balance.</i>"));
DelayCommand(1.0,AssignCommand(OBJECT_SELF, 
ActionSpeakString("<i>The heavy door slides open.</i>")));

object oDoor = GetObjectByTag("carc_scalesdoor");
SetLocked(oDoor, FALSE);
AssignCommand(oDoor, ActionOpenDoor(oDoor));
object oRubble = GetObjectByTag("carc_rockscontainer1");
object oRubble2 = GetObjectByTag("carc_rockscontainer2");
object oRubble3 = GetObjectByTag("carc_rockscontainer3");
object oRubble4 = GetObjectByTag("carc_rockscontainer4");
object oRubble5 = GetObjectByTag("carc_rockscontainer5");
Cleanup(OBJECT_SELF);
Cleanup(oRubble); Cleanup(oRubble2); Cleanup(oRubble3); Cleanup(oRubble4); Cleanup(oRubble5);

		//Award XP
		if (!GetLocalInt(oPC, "sarbr_scales_xp"))
		{
		GiveXPToCreature(oPC, 200);
		SetLocalInt(oPC, "sarbr_scales_xp", 1);
		}
		object oMember = GetFirstFactionMember(oPC, TRUE);
		while (GetIsObjectValid(oMember))
		{
		if (!GetLocalInt(oMember, "sarbr_scales_xp"))
		{
		GiveXPToCreature(oMember, 200);
		SetLocalInt(oMember, "sarbr_scales_xp", 1);
		}
		oMember = GetNextFactionMember(oPC, TRUE);
		}
		//end award XP
}

if (nSum < 1)
{ return; }
if (nSum > 1030)
{
AssignCommand(OBJECT_SELF, 
ActionSpeakString("<i>The scales shift, tipping in favor of your accumulated weight.</i>"));
}
if ((nSum < 980) && (nSum > 1))
{
AssignCommand(OBJECT_SELF, 
ActionSpeakString("<i>The scales shift, tipping in favor of the mourning statue.</i>"));
}
//SendMessageToPC(oPC, "DEBUG: Weight is: " + IntToString(nSum));

}