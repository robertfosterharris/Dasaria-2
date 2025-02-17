/*/Spellcraft checks made to identify magical traps
//:: remember:
//:: 1) VarInt called DC = DC to beat
//:: 2) Trigger must have unique tag
//:: 3) VarString called MSG = Feedback message on success */
//-frac

void main()
{
object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;
string sTag = GetTag(OBJECT_SELF);
if (GetLocalInt(oPC,sTag)) return;
SetLocalInt(oPC,sTag,1);
int nDC = GetLocalInt(OBJECT_SELF,"DC");
string sMsg = GetLocalString(OBJECT_SELF,"MSG");

	if (GetSkillRank(SKILL_SPELLCRAFT,oPC,TRUE) > 0)
	{
		if (GetIsSkillSuccessful(oPC, SKILL_SPELLCRAFT,nDC,TRUE))
		{
		SendMessageToPC(oPC,"<color=#C1AB89>"+sMsg);
		}
	}
}