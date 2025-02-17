void main()
{
	object oPC = OBJECT_SELF;
	
	int iStrBonus = GetLocalInt(oPC, "iStrBonus" );
	int iClimb_DC = GetLocalInt(oPC, "Placable_Action_DC" );
	int iClimb_Enc = GetLocalInt(oPC, "iClimb_Enc" );
	int iClassLevel_Bonus = GetLocalInt(oPC, "iClassLevel_Bonus" );
	int iArmor_Penalty = GetLocalInt(oPC, "iArmor_Penalty"  );
	object oClimb_Target = GetLocalObject(oPC, "Placable_Action_Target" );
	object oClimb_Target_Fall = GetLocalObject(oPC, "Placable_Action_Target_Fall" );
	int iSkillResult;
	int iDamage = 0;
	int iSkillResultFinal; 
	
	string sStrBonus = IntToString(iStrBonus);
	string sClimb_DC = IntToString(iClimb_DC);
	string sClimb_Enc = IntToString(iClimb_Enc);
	string sArmor_Penalty = IntToString(iArmor_Penalty);
	string sClassLevel_Bonus = IntToString(iClassLevel_Bonus);
	effect eFallingDamage;
		
	int iModifiers = iStrBonus + iClassLevel_Bonus + iClimb_Enc + iClassLevel_Bonus;

	
	iSkillResult = d20(1);

	
	if(iSkillResult == 1)
	{
		iDamage = d6(8);	
	}
	else
	{
		iSkillResultFinal = iSkillResult+iModifiers;
	}
	
	if(iSkillResultFinal <= ( iClimb_DC - 5))
	{
		iDamage = d6(4);		
	}
	
	if(iDamage > 0)
	{
	SendMessageToPC( oPC, "<color=Cyan>CLIMBING CHECK FAIL: "+IntToString(iSkillResult)+" + "+IntToString(iModifiers)+" vs Climb DC "+IntToString(iClimb_DC));

		eFallingDamage = EffectDamage(iDamage, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL );
		AssignCommand(oPC, ActionJumpToObject(oClimb_Target_Fall, FALSE));
		
		AssignCommand(GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oPC, 1),ActionJumpToObject(oClimb_Target_Fall, FALSE));
		AssignCommand(GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC, 1),ActionJumpToObject(oClimb_Target_Fall, FALSE));
		
		DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, eFallingDamage, oPC));	
		DelayCommand(1.1, AssignCommand(oPC, ActionPlayAnimation( ANIMATION_FIREFORGET_COLLAPSE , 1.0)));		
	}
	else
	{
		SendMessageToPC( oPC, "<color=Cyan>CLIMBING CHECK SUCCESS: "+IntToString(iSkillResult)+" + "+IntToString(iModifiers)+" vs Climb DC "+IntToString(iClimb_DC));
		AssignCommand(oPC, ActionJumpToObject(oClimb_Target, FALSE));
		
		AssignCommand(GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oPC, 1),ActionJumpToObject(oClimb_Target, FALSE));
		AssignCommand(GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC, 1),ActionJumpToObject(oClimb_Target, FALSE));
	
	}

	
	DeleteLocalInt(oPC, "iStrBonus" );
	DeleteLocalInt(oPC, "Placable_Action_DC" );
	DeleteLocalInt(oPC, "iClimb_Enc" );
	DeleteLocalInt(oPC, "iClassLevel_Bonus" );
	DeleteLocalInt(oPC, "iArmor_Penalty"  );
	DeleteLocalObject(oPC, "Placable_Action_Target" );
	DeleteLocalObject(oPC, "Placable_Action_Target_Fall" );
	
}