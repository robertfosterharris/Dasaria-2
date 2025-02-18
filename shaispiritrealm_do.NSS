int GetArmorPenalty(object oPC)
{


	object oArmor;
	object oShield;
	
	int iArmor = 0;
	int iShield = 0;
	
	int iArmourPenalty = 0;
	
	oArmor = GetItemInSlot (INVENTORY_SLOT_CHEST, oPC);
	oShield = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC) ;
	
	if(oArmor != OBJECT_INVALID)
	{
		iArmor = GetArmorRulesType(oArmor);
	
		switch(iArmor)
		{
			case 0://Cloth
				iArmourPenalty = iArmourPenalty;
			break;
			case 1://ClothPadded
				iArmourPenalty = iArmourPenalty;
			break;
			case 2://Leather
				iArmourPenalty = iArmourPenalty;
			break;
			case 3://LeatherStudded
				iArmourPenalty = iArmourPenalty - 1;
			break;
			case 4://ChainShirt
				iArmourPenalty = iArmourPenalty -2;
			break;
			case 5://Scale
				iArmourPenalty = iArmourPenalty -4;
			break;
			case 6://Banded
				iArmourPenalty = iArmourPenalty -6;
			break;										
			case 7://Half-Plate
				iArmourPenalty = iArmourPenalty -7;
			break;		
			case 8://Full-Plate
				iArmourPenalty = iArmourPenalty -6;
			break;		
			case 12://Hide
				iArmourPenalty = iArmourPenalty -3;
			break;
			case 13://Chainmail
				iArmourPenalty = iArmourPenalty -5;
			break;		
			case 14://Breastplate
				iArmourPenalty = iArmourPenalty -4;
			break;	
			case 15://Splint
				iArmourPenalty = iArmourPenalty -7;
			break;	
			case 16://Mithral_ChainShirt
				iArmourPenalty = iArmourPenalty;
			break;	
			case 17://Mithral_Scale
				iArmourPenalty = iArmourPenalty -2;
			break;	
			case 18://Mithral_Banded
				iArmourPenalty = iArmourPenalty -4;
			break;	
			case 19://Mithral_Half-Plate
				iArmourPenalty = iArmourPenalty -5;
			break;	
			case 20://Mithral_Full-Plate
				iArmourPenalty = iArmourPenalty -4;
			break;	
			case 21://Mithral_Chainmail
				iArmourPenalty = iArmourPenalty -3;
			break;	
			case 22://Mithral_Breastplate
				iArmourPenalty = iArmourPenalty -2;
			break;	
			case 23://Mithral_Splint
				iArmourPenalty = iArmourPenalty -5;
			break;	
			default:
			break;			
		}
	}		
	if(GetBaseItemType(oShield) == BASE_ITEM_SMALLSHIELD || GetBaseItemType(oShield) == BASE_ITEM_LARGESHIELD || GetBaseItemType(oShield) == BASE_ITEM_TOWERSHIELD )
	{
		iShield= GetArmorRulesType(oShield);
		switch(iShield)
		{
			case 9: //Small_Shield
				iArmourPenalty = iArmourPenalty -1;
			break;
			case 10: //Large_Shield
				iArmourPenalty = iArmourPenalty -2;
			break;
			case 11: //Tower_Shield
				iArmourPenalty = iArmourPenalty -10;
			break;						
			default:
			break;	
		}		
	}
	return iArmourPenalty;
}

int GetClassLevel_Bonus(object oPC)
{
	int iLvlBonus = 0;
				
	iLvlBonus = iLvlBonus + GetLevelByClass(CLASS_TYPE_ROGUE , oPC);
	iLvlBonus = iLvlBonus + GetLevelByClass(CLASS_TYPE_SHADOWDANCER , oPC);
	iLvlBonus = iLvlBonus + GetLevelByClass(CLASS_TYPE_SHADOWTHIEFOFAMN , oPC);
	iLvlBonus = iLvlBonus + GetLevelByClass(CLASS_TYPE_ASSASSIN , oPC);
	iLvlBonus = iLvlBonus + GetLevelByClass(CLASS_TYPE_ARCANETRICKSTER , oPC);
	iLvlBonus = iLvlBonus + GetLevelByClass(CLASS_TYPE_SWASHBUCKLER , oPC);
	iLvlBonus = iLvlBonus + ( GetLevelByClass(CLASS_TYPE_BARD , oPC)/ 3 );
	iLvlBonus = iLvlBonus + ( GetLevelByClass(CLASS_TYPE_HARPER , oPC)/ 2 );
	iLvlBonus = iLvlBonus + ( GetLevelByClass(CLASS_TYPE_RANGER , oPC)/ 2 );
	iLvlBonus = iLvlBonus + ( GetLevelByClass(CLASS_TYPE_BARBARIAN , oPC)/ 2 );
	iLvlBonus = iLvlBonus + ( GetLevelByClass(CLASS_TYPE_FRENZIEDBERSERKER , oPC)/ 2 );
	iLvlBonus = iLvlBonus + ( GetLevelByClass(CLASS_TYPE_SHIFTER , oPC)/ 3 );
	iLvlBonus = iLvlBonus + ( GetLevelByClass(CLASS_TYPE_SPIRIT_SHAMAN , oPC)/ 3 );

		
	return iLvlBonus;
}






void main()
{
	object oTarget = OBJECT_SELF;
	object oPC = GetLastUsedBy();
	
	string sAction = GetLocalString(oTarget, "Placable_Action");
	object oDoor_Target;
	
	int iStrBonus;
	string sStrBonus;
	int iClimb_DC;
	string sClimb_DC;
	int iClimb_Enc;
	string sClimb_Enc;
	int iArmor_Penalty;
	string sArmor_Penalty;
	int iClassLevel_Bonus;
	string sClassLevel_Bonus;
	object oClimb_Target;
	object oClimb_Target_Fall;
	string sClimbMessageString;
	
	string sTeleport_Target;
	

	
	if(sAction == "DOOR")
	{

		
		oDoor_Target = GetObjectByTag(GetLocalString(oTarget, "Placable_Action_Target"));
		
	
		if(!GetIsInCombat(oPC))
		{
				SendMessageToPC(oPC, "You pass into the darkness of the tunnel.");
			AssignCommand(oPC, ActionJumpToObject(oDoor_Target, FALSE));
			
			AssignCommand(GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oPC, 1),ActionJumpToObject(oDoor_Target, FALSE));
			AssignCommand(GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC, 1),ActionJumpToObject(oDoor_Target, FALSE));
			
		}
		else
		{
			SendMessageToPC(oPC, "You are in combat, you can't flee at this time.");
		}
	
	}
	
	if(sAction == "CLIMB")
	{


		if(!GetIsInCombat(oPC))
		{
			iStrBonus = GetAbilityModifier(ABILITY_STRENGTH, oPC);
			sStrBonus = IntToString(iStrBonus);
			iClimb_DC = GetLocalInt( oTarget, "Placable_Action_DC");
			sClimb_DC = IntToString(iClimb_DC);
			iClimb_Enc = 0 - GetEncumbranceState(oPC) ;
			sClimb_Enc = IntToString(iClimb_Enc);
			iArmor_Penalty = GetArmorPenalty(oPC);
			sArmor_Penalty = IntToString(iArmor_Penalty);
			iClassLevel_Bonus = GetClassLevel_Bonus(oPC);
			sClassLevel_Bonus = IntToString(iClassLevel_Bonus);
			oClimb_Target = GetObjectByTag(GetLocalString(oTarget, "Placable_Action_Target"));	
			oClimb_Target_Fall = GetObjectByTag(GetLocalString(oTarget, "Placable_Action_Target_Fall"));				
			
			SetLocalObject(oPC, "Placable_Action_Target", oClimb_Target );
			SetLocalObject(oPC, "Placable_Action_Target_Fall", oClimb_Target_Fall );
			SetLocalInt(oPC, "Placable_Action_DC", iClimb_DC );
			SetLocalInt(oPC, "iStrBonus", iStrBonus );			
			SetLocalInt(oPC, "iClimb_Enc",  iClimb_Enc );
			SetLocalInt(oPC, "iArmor_Penalty", iArmor_Penalty  );
			SetLocalInt(oPC, "iClassLevel_Bonus", iClassLevel_Bonus );						
						
			sClimbMessageString = "<color=Gold>CLIMBING CHECK</color> \n Climb DC = "+sClimb_DC+"\n Strength ("+sStrBonus+") + Class Level Bonus ("+sClassLevel_Bonus+") + Armour Penalty ("+sArmor_Penalty+") + Encumbrance Penalty ("+sClimb_Enc+")";
		
			DisplayMessageBox(oPC,0,sClimbMessageString, "gui_shai_climb", "", TRUE, "SCREEN_MESSAGEBOX_DEFAULT" ,0, "OK",0, "Cancel");		

		}
		else
		{
			SendMessageToPC(oPC, "You can't climb at this time.");
		}	
	
	}
	
	if(sAction == "TELEPORT")
	{
		
	
		if(WillSave(oPC, 15))
		{
				oDoor_Target = GetObjectByTag(GetLocalString(oTarget, "Placable_Action_Target"));
				ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMONDRAGON), oPC);
				AssignCommand(oPC, ActionJumpToObject(oDoor_Target, FALSE));
			
				AssignCommand(GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oPC, 1),ActionJumpToObject(oDoor_Target, FALSE));
				AssignCommand(GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC, 1),ActionJumpToObject(oDoor_Target, FALSE));
			
						
		}
		else{
			SendMessageToPC(oPC, "You are unable to bend the Totem to your will");
		}
	


	}




}