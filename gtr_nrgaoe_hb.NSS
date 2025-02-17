// wired feb 2014
// gtr_nrgaoe_hb

void main()
{
	object oParent = GetLocalObject(OBJECT_SELF,"oParent");
	effect eDmg;
	object oPC;
	int iDmgType = GetLocalInt(OBJECT_SELF,"iDmgType");
	int iDmgPwr = GetLocalInt(OBJECT_SELF,"iDmgPwr");
	int iDice = GetLocalInt(OBJECT_SELF,"iDmgDice");
	int iDmg = iDice*iDmgPwr;
	
	// if either of these are invalid, not initialized correctly
	if (iDmgType == 0) 
	{
		DestroyObject(OBJECT_SELF);
		return;	
	}
	if (!GetIsObjectValid(oParent))
	{
		DestroyObject(OBJECT_SELF);
		return;	
	}
	
	eDmg =  EffectDamage(iDmg,DAMAGE_TYPE_FIRE);
	
	oPC = GetFirstInPersistentObject(oParent,OBJECT_TYPE_CREATURE);
	
	while (GetIsObjectValid(oPC))
	{
		if (GetIsPC(oPC))
		{
			ApplyEffectToObject(iDmgType,eDmg,oPC);
		}
	
		GetNextInPersistentObject(oParent,OBJECT_TYPE_CREATURE);
	}
}
