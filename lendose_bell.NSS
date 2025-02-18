void main()
{
object oPC = GetLastUsedBy();
	if (GetLocalInt(OBJECT_SELF,"Used")) 
	{
	SendMessageToPC(oPC,"The bell is already ringing!");
	return;
	}
SetLocalInt(OBJECT_SELF,"Used",1);
object oArea = GetArea(oPC);
object oBell = GetObjectByTag("fracafort_belltower");
SoundObjectPlay(oBell);
AssignCommand(OBJECT_SELF,ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
object oTarget = GetFirstPC();
	while (GetIsObjectValid(oTarget))
	{
		if (GetArea(oTarget) == oArea)
		{
		SendMessageToPC(oTarget,"You hear the bell tower's ring echo throughout the keep!");
		}
	oTarget = GetNextPC();
	}
DelayCommand(9.9,AssignCommand(OBJECT_SELF,ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE)));
DelayCommand(10.0,DeleteLocalInt(OBJECT_SELF,"Used"));
}