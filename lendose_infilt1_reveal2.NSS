void main()
{
object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

	if (GetActionMode(oPC,ACTION_MODE_STEALTH))
	{
		SetActionMode(oPC,ACTION_MODE_STEALTH,0);
	}
	
effect eEffect = GetFirstEffect(oPC);
while (GetIsEffectValid(eEffect))
{
if (GetEffectType(eEffect) == EFFECT_TYPE_INVISIBILITY)
{ RemoveEffect(oPC,eEffect); }
eEffect = GetNextEffect(oPC);
}

		SendMessageToPC(oPC,"You trigger the trap, revealing your location!");
}