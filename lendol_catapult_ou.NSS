// lendol_catapult_ou
#include "catapult_boulder_throw"

void main()
{
	int nNth = 1;
	int bFired	= 0;
	object oPC = GetLastUsedBy();
	object oEnemy;
	location lLoc;	
	
	oEnemy = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, CREATURE_ALIVE_TRUE, oPC, nNth,CREATURE_TYPE_IS_ALIVE, CREATURE_ALIVE_TRUE, CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY);
	while (GetIsObjectValid(oEnemy))
	{
		float fDist		=	GetDistanceBetween(OBJECT_SELF,oEnemy);
					
		if (GetIsEnemy(oEnemy,oPC) && fDist <=45.7)
		{
			if(fDist >= 3.0)
			{
				catapultThrow(oPC,OBJECT_SELF,GetLocation(oEnemy));
				bFired = 1;
				SetUseableFlag(OBJECT_SELF,FALSE);
				DelayCommand(3.0f,SetUseableFlag(OBJECT_SELF,TRUE));
				DelayCommand(3.0f,PlaySound("as_cv_winch1"));
				return;
			}
		}
		nNth++;
		oEnemy = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, CREATURE_ALIVE_TRUE, oPC, nNth,CREATURE_TYPE_IS_ALIVE, CREATURE_ALIVE_TRUE, CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY);
	}
	
	if (bFired == 0)
	{
		SendMessageToPC(oPC,"No valid targets in range");
	}
}