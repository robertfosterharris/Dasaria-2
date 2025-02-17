void doSplit();
int GetDamageByType(int iType);
int GetPhysicalDamage();

void main()
{
    int iEvent = GetUserDefinedEventNumber();

    switch (iEvent)
	{
		case EVENT_HEARTBEAT: 	// 1001
			break;	

		case EVENT_PERCEIVE: 	// 1002
			break;	

		case EVENT_END_COMBAT_ROUND: 	// 1003
			break;	

		case EVENT_DIALOGUE: 	// 1004
			break;	

		case EVENT_ATTACKED: 	// 1005
			break;	

		case EVENT_DAMAGED: 	// 1006
			doSplit();
			break;
	
		case EVENT_DISTURBED: 	// 1008
			break;	

		case EVENT_SPELL_CAST_AT: 	// 1011
			break;	
	}

}
//
//	SLASHING AND PIERCING WEAPONS AND ELECTRICAL ATTACKS DEAL NO DAMAGE TO A OCHRE JELLY. 
//	INSTEAD THE CREATURE SPLITS INTO TWO IDENTICAL JELLIES, EACH WITH HALF OF THE ORIGINAL’S CURRENT HIT POINTS (ROUND DOWN). 
//	A JELLY WITH 10 HIT POINTS OR LESS CANNOT BE FURTHER SPLIT AND DIES IF REDUCED TO 0 HIT POINTS.
//
void doSplit()
{
	float fX;
	float fY;
	float fZ;
	int nCurrentHP;
	object oSplit;

	if ((GetDamageByType(DAMAGE_TYPE_ELECTRICAL) > 0 || GetDamageByType(DAMAGE_TYPE_PIERCING) > 0 || GetDamageByType(DAMAGE_TYPE_SLASHING) > 0) && GetCurrentHitPoints(OBJECT_SELF) > 10)
	{
		SetScale(OBJECT_SELF, GetScale(OBJECT_SELF, SCALE_X) / 2.0, GetScale(OBJECT_SELF, SCALE_Y) / 2.0, GetScale(OBJECT_SELF, SCALE_Z) / 2.0);
		ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(GetCurrentHitPoints(OBJECT_SELF) / 2, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL, TRUE), OBJECT_SELF);
		
		oSplit = CreateObject(OBJECT_TYPE_CREATURE, GetResRef(OBJECT_SELF), GetLocation(OBJECT_SELF));
		SetScale(oSplit, GetScale(OBJECT_SELF, SCALE_X), GetScale(OBJECT_SELF, SCALE_Y), GetScale(OBJECT_SELF, SCALE_Z));
		ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(GetMaxHitPoints(OBJECT_SELF) - GetCurrentHitPoints(OBJECT_SELF), DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL, TRUE), oSplit);
	}
}
//
//	REPLACES GETDAMAGEDEALTYBYTYPE WHICH DOES NOT PROPERLY HANDLE PHYSICAL DAMAGE.
//	RETURNS AMOUNT OF DAMAGE OR -1 IF NO DAMAGE OF THE SPECIFIED TYPE OCCURED.
//
int GetDamageByType(int nDamageType)
{
	int nDamage = -1;
	
	if (nDamageType == DAMAGE_TYPE_BLUDGEONING || nDamageType == DAMAGE_TYPE_PIERCING || nDamageType == DAMAGE_TYPE_SLASHING)
	{
		
		switch (GetWeaponType(GetLastWeaponUsed(GetLastDamager())))
		{
			case WEAPON_TYPE_BLUDGEONING:
				if (nDamageType == DAMAGE_TYPE_BLUDGEONING)	nDamage = GetPhysicalDamage();
			break;
			
			case WEAPON_TYPE_PIERCING:
				if (nDamageType == DAMAGE_TYPE_PIERCING) nDamage = GetPhysicalDamage();
			break;
			
			case WEAPON_TYPE_PIERCING_AND_SLASHING:
				if (nDamageType == DAMAGE_TYPE_PIERCING || nDamageType == DAMAGE_TYPE_SLASHING)	nDamage = GetPhysicalDamage() / 2;
			break;
			
			case WEAPON_TYPE_SLASHING:
				if (nDamageType == DAMAGE_TYPE_SLASHING) nDamage = GetPhysicalDamage();
			break;
		}
	}
	else
	{
		nDamage = GetDamageDealtByType(nDamageType);
	}
	
	if (nDamageType == DAMAGE_TYPE_ALL) nDamage = GetTotalDamageDealt();
	
	return nDamage;
}
//
//		CALCULATES TOTAL PHYSICAL DAMAGE (BLUDGEONING, PIERCING, SLASHING)
//
int GetPhysicalDamage()
{
	int nDamage;
	
	nDamage = GetTotalDamageDealt();
	
	if (GetDamageDealtByType(DAMAGE_TYPE_ACID) 			> 0) nDamage -= GetDamageDealtByType(DAMAGE_TYPE_ACID);
	if (GetDamageDealtByType(DAMAGE_TYPE_COLD) 			> 0) nDamage -= GetDamageDealtByType(DAMAGE_TYPE_COLD);
	if (GetDamageDealtByType(DAMAGE_TYPE_DIVINE) 		> 0) nDamage -= GetDamageDealtByType(DAMAGE_TYPE_DIVINE);
	if (GetDamageDealtByType(DAMAGE_TYPE_ELECTRICAL) 	> 0) nDamage -= GetDamageDealtByType(DAMAGE_TYPE_ELECTRICAL);
	if (GetDamageDealtByType(DAMAGE_TYPE_FIRE)			> 0) nDamage -= GetDamageDealtByType(DAMAGE_TYPE_FIRE);
	if (GetDamageDealtByType(DAMAGE_TYPE_MAGICAL) 		> 0) nDamage -= GetDamageDealtByType(DAMAGE_TYPE_MAGICAL);
	if (GetDamageDealtByType(DAMAGE_TYPE_NEGATIVE) 		> 0) nDamage -= GetDamageDealtByType(DAMAGE_TYPE_NEGATIVE);
	if (GetDamageDealtByType(DAMAGE_TYPE_PIERCING)	 	> 0) nDamage -= GetDamageDealtByType(DAMAGE_TYPE_POSITIVE);
	if (GetDamageDealtByType(DAMAGE_TYPE_SONIC) 		> 0) nDamage -= GetDamageDealtByType(DAMAGE_TYPE_SONIC);
	
	return nDamage;
}