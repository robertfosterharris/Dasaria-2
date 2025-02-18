// wired 03/10/2013  add spirit shaman and favored soul to list of spellcasters

int GetIsSpellCaster(object oPC)
{
    int nCount, nClass;
    for(nCount=1; nCount<=4; nCount++) {
        nClass = GetClassByPosition(nCount, oPC);
        switch(nClass) {
            case CLASS_TYPE_BARD:
            case CLASS_TYPE_CLERIC:
            case CLASS_TYPE_DRUID:
            case CLASS_TYPE_PALADIN:
            case CLASS_TYPE_RANGER:
            case CLASS_TYPE_SORCERER:
			case CLASS_TYPE_SPIRIT_SHAMAN:
			case CLASS_TYPE_FAVORED_SOUL:
            case CLASS_TYPE_WIZARD: return TRUE;
        }
    }
    return FALSE;
}

void DecrementSpells(object oPC)
{
	string sSpells = GetLocalString(oPC, "Spells");
	int i;
	string sTemp;
	while(sSpells != "")
	{
		i = FindSubString(sSpells, ":");
	 	if (i < 1){break;}
	 	sTemp = GetStringLeft(sSpells, i);
	 	sSpells = GetStringRight(sSpells, GetStringLength(sSpells)-(i+1));
	 	//SendMessageToPC(oPC, "Spell Deleted: "+sTemp);		
	 	DecrementRemainingSpellUses(oPC, StringToInt(sTemp));
	}
	SendMessageToPC(oPC, "Spellbook Calibrated");
}