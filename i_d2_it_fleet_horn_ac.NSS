//	ON ACTIVATED - CALL CERULEAN FLEET REINFORCEMENTS TO THE BATTLE FIELD
//	GIVES THE TARGET A NUMBER OF CERULEAN FLEET HENCHMEN BASED ON RANK
//
//	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM	02/07/2007
//
#include "x0_i0_position"

void summonReinforcements(object oTarget, int nReinforcements, location lSpawnPoint);

void main()
{
	float fFacing;
	int nReinforcements;
	location lSpawnPoint;
	object oActivator;
	object oDoor;
	object oReinforcement;
	object oTarget;
	vector vDoor;
	
	SetMaxHenchmen(3);	
	oActivator = GetItemActivator();
	oTarget = GetItemActivatedTarget();
	//
	//	DETERMINE NUMBER OF REINFORCEMENTS TO SUMMON BASED ON RANK
	//
	if (FindSubString(GetName(oTarget), "Commodore") > -1) nReinforcements = 3;
	if (FindSubString(GetName(oTarget), "Captain") > -1) nReinforcements = 3;
	if (FindSubString(GetName(oTarget), "Lieutenant") > -1) nReinforcements = 2;
	if (FindSubString(GetName(oTarget), "Ensign") > -1) nReinforcements = 2;
	if (FindSubString(GetName(oTarget), "Corporal") > -1) nReinforcements = 1;
	if (FindSubString(GetName(oTarget), "Constable") > -1) nReinforcements = 1;

	if (GetIsPC(oTarget) && (GetHenchman(oTarget) == OBJECT_INVALID) && (nReinforcements > 0))
	{
		//
		//	DETERMINE REINFORCEMENT SPAWN POINT - EITHER INFRONT OF NEAREST OR AT TARGET LOCATION
		//
		oDoor = GetNearestObjectToLocation(OBJECT_TYPE_DOOR, GetLocation(oTarget));
		if (GetIsObjectValid(oDoor))
		{
			vDoor = GetPosition(oDoor);
			fFacing = GetFacing(oDoor) + 225.0;
			if (fFacing > 360.0) fFacing = fFacing - 360.0;
			lSpawnPoint = Location(GetArea(oDoor), GetChangedPosition(vDoor, 1.5, fFacing), fFacing);
			if (!GetLocked(oDoor)) DelayCommand(5.0, AssignCommand(oDoor, ActionOpenDoor(oDoor)));
		}
		else
		{
			lSpawnPoint = GetLocation(oTarget);
		}
		//
		//	MAKE IT HAPPEN
		//		
		AssignCommand(oActivator, PlaySound("as_pl_horngood1"));
		AssignCommand(oActivator, ActionSpeakString("<i>*Raises a horn and sounds it. The note is clear and powerful.*</i>"));
		DelayCommand(6.0, summonReinforcements(oTarget, nReinforcements, lSpawnPoint));
	}
	else
	{
		SendMessageToPC(oActivator, "Invalid Target.");
	}
}

void summonReinforcements(object oTarget, int nReinforcements, location lSpawnPoint)
{
	int nLevel;
	int nLevelCount;
	int nReinforcementCount;
	object oReinforcement;

	for (nReinforcementCount = 0; nReinforcementCount < nReinforcements; nReinforcementCount++)
	{
		oReinforcement = CreateObject(OBJECT_TYPE_CREATURE, "cfleet_npc_reinforcement", lSpawnPoint, TRUE);
		if (GetIsObjectValid(oReinforcement))
		{
			AddHenchman(oTarget, oReinforcement);
			nLevel = GetTotalLevels(oTarget, FALSE) - 2;
			for (nLevelCount = 1; nLevelCount < nLevel; nLevelCount++)
			{
				LevelUpHenchman(oReinforcement, CLASS_TYPE_INVALID, TRUE, GetLevelUpPackage(oReinforcement));
			}
			ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectACIncrease(nLevel / 5, AC_ARMOUR_ENCHANTMENT_BONUS), oReinforcement);
			ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectACIncrease(nLevel / 5, AC_DEFLECTION_BONUS), oReinforcement);
			ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectACIncrease(nLevel / 5, AC_DODGE_BONUS), oReinforcement);
			ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectACIncrease(nLevel / 5, AC_NATURAL_BONUS), oReinforcement);
			ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectACIncrease(nLevel / 5, AC_SHIELD_ENCHANTMENT_BONUS), oReinforcement);
			ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectAttackIncrease(nLevel / 5), oReinforcement);
			ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectDamageIncrease(nLevel / 5, DAMAGE_TYPE_SLASHING), oReinforcement);
			AssignCommand(oReinforcement, ActionMoveToObject(oTarget, TRUE));
		}
	}
}