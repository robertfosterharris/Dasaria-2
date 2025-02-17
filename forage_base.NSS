// forage base
// 2008/12/28 wired removed alchemy, added a chance for lore at survival DC+10
void main()
{
	object oPC = GetLastUsedBy();	
	AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 1.0f));
	
	int iSurvival = GetLocalInt(OBJECT_SELF, "iSurvival");
	if (iSurvival == 0)
		iSurvival = 15;
	/*
	int iAlchemy = GetLocalInt(OBJECT_SELF, "iAlchemy");
	if (iAlchemy == 0)
		iAlchemy = 15;
	*/
	int iLore = iSurvival+10;
	
	int iStack = 1;
	string sForage = GetLocalString(OBJECT_SELF, "sForage");
	string sProduce = GetLocalString(OBJECT_SELF, "sProduce");
	
	if (sProduce == "produce_reeds")
	{
		iStack = 10;
	}
		
	if (GetIsSkillSuccessful(oPC, SKILL_SURVIVAL, iSurvival) 
	|| GetIsSkillSuccessful(oPC, SKILL_LORE, iLore)
	)
	{
			CreateItemOnObject(sProduce, oPC, iStack);
			SendMessageToPC(oPC, "You successfully forage the " + sForage);
			FloatingTextStringOnCreature("This " + sForage + " should be useful!", oPC);
			GiveXPToCreature(oPC, 10);
			PlaySound("as_na_leafmove3");
	}
	else
	{
		SendMessageToPC(oPC, "You fail to gather the " + sForage + " correctly and the plant is wasted");
		FloatingTextStringOnCreature("Curses! I'll have to find another source!", oPC);
	}
		
	DestroyObject(OBJECT_SELF, 0.5);	
}