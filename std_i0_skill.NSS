int GetIsSkillSuccessfulPrivate(object oPC, int nSkill, int nDC);
int	skill_get_fromname( string sSkill );
int	skill_modifier_ability( int nSkill );
int	skill_check_silent( object oCreature, int nSkill, int nDC );
//
//	PERFORM SKILL CHECK
//	DISPLAY RESULTS ONLY IF SUCCESSFUL
//
int GetIsSkillSuccessfulPrivate(object oPC, int nSkill, int nDC)
{
	int bIsSkillSuccessfulPrivate;
	int nD20;
	int nSkillRank;
	string sSkill;

	nD20 = d20();
	nSkillRank = GetSkillRank(nSkill, oPC);
	if(nSkillRank + nD20 >= nDC)
	{
		switch (nSkill)
		{
			case SKILL_CONCENTRATION:
				sSkill = "Concentration";
				break;
			case SKILL_DISABLE_TRAP:
				sSkill = "Disable Trap";
				break;
			case SKILL_DISCIPLINE:
				sSkill = "Discipline";
				break;
			case SKILL_HEAL:
				sSkill = "Heal";
				break;
			case SKILL_HIDE:
				sSkill = "Hide";
				break;
			case SKILL_LISTEN:
				sSkill = "Listen";
				break;
			case SKILL_LORE:
				sSkill = "Lore";
				break;
			case SKILL_MOVE_SILENTLY:
				sSkill = "Move Silently";
				break;
			case SKILL_OPEN_LOCK:
				sSkill = "Open Lock";
				break;
			case SKILL_PARRY:
				sSkill = "Parry";
				break;
			case SKILL_PERFORM:
				sSkill = "Perform";
				break;
			case SKILL_DIPLOMACY:
				sSkill = "Diplomacy";
				break;
			case SKILL_SLEIGHT_OF_HAND:
				sSkill = "Sleight of Hand";
				break;
			case SKILL_SEARCH:
				sSkill = "Search";
				break;
			case SKILL_SET_TRAP:
				sSkill = "Set Trap";
				break;
			case SKILL_SPELLCRAFT:
				sSkill = "Spellcraft";
				break;
			case SKILL_SPOT:
				sSkill = "Spot";
				break;
			case SKILL_TAUNT:
				sSkill = "Taunt";
				break;
			case SKILL_USE_MAGIC_DEVICE:
				sSkill = "Use Magic Device";
				break;
			case SKILL_APPRAISE:
				sSkill = "Appraise";
				break;
			case SKILL_TUMBLE:
				sSkill = "Tumble";
				break;
			case SKILL_CRAFT_TRAP:
				sSkill = "Craft Trap";
				break;
			case SKILL_BLUFF:
				sSkill = "Bluff";
				break;
			case SKILL_INTIMIDATE:
				sSkill = "Intimidate";
				break;
			case SKILL_CRAFT_ARMOR:
				sSkill = "Craft Armor";
				break;
			case SKILL_CRAFT_WEAPON:
				sSkill = "Craft Weapon";
				break;
			case SKILL_CRAFT_ALCHEMY:
				sSkill = "Craft Alchemy";
				break;
			case SKILL_RIDE:
				sSkill = "Ride";
				break;
			case SKILL_SURVIVAL:
				sSkill = "Survival";
				break;
		}
		SendMessageToPC(oPC, "<color=cyan>" + GetName(oPC) + "</c><color=blue> : " + sSkill + " *success* : (" + IntToString(nD20) + " + " + IntToString(nSkillRank) + " = " + IntToString(nSkillRank+nD20) + " vs. DC " + IntToString(nDC) + ")</c>");
		FloatingTextStringOnCreature(sSkill + ": *success*", oPC, FALSE, 2.0, 4294967295, 4294967295, 0.4, [0.0,0.0,1.0]);
		bIsSkillSuccessfulPrivate = TRUE;
	}
	else
	{
		bIsSkillSuccessfulPrivate = FALSE;
	}
	return bIsSkillSuccessfulPrivate;
}

int		skill_get_fromname( string sSkill )
{

	if ( sSkill == "listen" )
		return SKILL_LISTEN;
	if ( sSkill == "spot" )
		return SKILL_SPOT;
	if ( sSkill == "lore" )
		return SKILL_LORE;
		
	return -1;
}

// Get ability modifier by skill (easier way?)	
int 	skill_modifier_ability( int nSkill )
	{
	switch ( nSkill )
		{
		case SKILL_LORE:
			return ABILITY_INTELLIGENCE;
		
		case SKILL_SPOT:
			return ABILITY_WISDOM;
			
		case SKILL_LISTEN:
			return ABILITY_WISDOM;			
		}
	
	// PANIC!  This is really bad
			
	return 0;
	}

int		skill_check_silent( object oCreature, int nSkill, int nDC )
	{
	int mod;
	int roll = d20();	

	// Calculate modifer based on skill?
	mod = GetSkillRank( nSkill, oCreature );
		
	/*
	// Currently this only works with trained skills
	if (mod == -1)
		{
		SendMessageToPC( oCreature, "Debug: Contact j4.  std_i0_skill - Silent skillcheck failed");
		return FALSE;
		}
	*/

	// Construct debug string.
	//string message = "Skill Check: ";
	string message = "Skill Check(";
	message += IntToString(nSkill);
	message += "): ";
	message += IntToString( roll );
	message += " + ";
	message += IntToString(mod);
	message += " vs. DC ";
	message += IntToString( nDC );
	
			
	if ( roll + mod < nDC )
		{
		//SendMessageToPC( oCreature, message + "  ...Failure!");
		return FALSE;	
		}
	
	SendMessageToPC( oCreature, message + "  ...Success!");
	return TRUE;
	}