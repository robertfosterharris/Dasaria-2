// wired 1/2/08
// brigands_immortali_warn_oe
// onenter event to fire assassins vs. brigands for event
void main()
{
	object oPC = GetEnteringObject();	
	if (GetIsPC(oPC))
	{
		string sPCName = GetStringLowerCase(GetName(oPC));
		if (FindSubString("robert_the blackheartedisabella quickrhode wraighzephismergohannah coldkillerrobert blackwilliam dearbornsythe",sPCName) != -1)
		{ 
			if (GetLocalInt(oPC,"warned") !=1)
			{
				// send the warning
				string sMessage = "You feel the eyes of the Immortali upon you.  Tread lightly, <i>Brigand</i>, they could be anywhere!";
				DisplayMessageBox( oPC, 0, sMessage);
				// mark them warned
				SetLocalInt(oPC,"warned",1);
			}
		}
	}
}