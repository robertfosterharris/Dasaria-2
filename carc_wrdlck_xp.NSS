//This is simply where you plug in your XP award if you wish to award some at all.
// -frac

//giving 200xp to all party for Carcerum/Dasaria. -frac

void main()
{
object oPC = GetPCSpeaker();

object oMember = GetFirstFactionMember(oPC,TRUE);
	while (GetIsObjectValid(oMember))
	{
		if (!GetLocalInt(oMember,"carc_wrdlck_solve"))
		{ GiveXPToCreature(oMember, 200);
		SetLocalInt(oMember,"carc_wrdlck_solve",1); }
	oMember=GetNextFactionMember(oPC,TRUE);
	}
	
	
	if (!GetLocalInt(oPC,"carc_wrdlck_solve"))
	{ GiveXPToCreature(oPC, 200);
	SetLocalInt(oPC,"carc_wrdlck_solve",1); }
}