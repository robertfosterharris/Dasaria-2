void main()
{
object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;


if (GetLocalInt(OBJECT_SELF,"IgnoreHIPS"))
{
	if (GetActionMode(oPC,ACTION_MODE_STEALTH))
	{
		SetActionMode(oPC,ACTION_MODE_STEALTH,0);
		SendMessageToPC(oPC,"You cannot sneak through here!");
	}
}

else
{
	if (GetActionMode(oPC,ACTION_MODE_STEALTH))
	{	
		if ((!GetHasFeat(FEAT_HIDE_IN_PLAIN_SIGHT,oPC)) ||
		(!GetHasFeat(FEAT_HIDE_IN_PLAIN_SIGHT_OUTDOORS,oPC)))
		{
		SetActionMode(oPC,ACTION_MODE_STEALTH,0);
		SendMessageToPC(oPC,"You cannot sneak through here!");
		}
	}
}
}