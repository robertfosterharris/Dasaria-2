//
//	ON HEARTBEAT: COHORT
//
//	ROBERT HARRIS	04/30/2015	ROBERTHARRIS@ROBERTHARRIS.COM
//
#include "std_i0_cohort"
#include "ginc_henchman"

void main()
{
	int nCohortCurrentXP;
	int nCohortAdjustXP;
	int nLeaderCurrentXP;
	int nIntervalPay;
	int nIntervalXP;
	int nPay;
	object oCreature;
	object oPC;
	string sStatus;
	
	oCreature = OBJECT_SELF;
	oPC = GetLocalObject(oCreature, "oPC");
	
	//
	//	IF THERE HAS BEEN A CHANGE IN THE COHORTS ALIVE / DEAD STATUS, UPDATE DATABASE.
	//
	sStatus = COHORT_STATUS_ALIVE;
	
	if (sStatus != GetLocalString(oCreature, "sLastStatus")) 
	{
		SaveCohort(oCreature, sStatus);
	}
	
	SetLocalString(oCreature, "sLastStatus", sStatus);
	
	//
	//	COHORT'S LEADER IS PRESENT
	//
	if (GetIsObjectValid(oPC))
	{
		nIntervalXP = GetLocalInt(oCreature, "nIntervalXP") + 1;
		nIntervalPay = GetLocalInt(oCreature, "nIntervalPay") + 1;
		
		//
		//	EVERY TWO MINUTES AWARD XP
		//
		if (nIntervalXP == 20)
		{
			nCohortCurrentXP = GetXP(oCreature);
			nLeaderCurrentXP = GetXP(oPC);
			//
			//	AWARD THE COHORT SOME XP
			//
			if (nLeaderCurrentXP == 191500)
			{
				nCohortAdjustXP = 30 + d20();
			}
			//
			//	AWARD THE COHORT A PERCENTAGE OF HIS LEADER'S EARNED XP
			//
			else
			{
				nCohortAdjustXP = nLeaderCurrentXP - GetLocalInt(oCreature, "nLeaderPreviousXP");
			}

			if (nCohortAdjustXP != 0)
			{
				nCohortAdjustXP = nCohortAdjustXP * GetHitDice(oCreature) / GetHitDice(oPC);
				SendMessageToPC(oPC, "Your cohort earned " + IntToString(nCohortAdjustXP) + " XP.");
				SetXP(oCreature, nCohortCurrentXP + nCohortAdjustXP);
			}
			
			SetLocalInt(oCreature, "nLeaderPreviousXP", nLeaderCurrentXP);
			SaveCohort(oCreature);
			nIntervalXP = 0;
		}
		//
		//	EVERY THIRTY TWO MINUTES PAY COHORT
		//
		if (nIntervalPay == 1)
		{
			nPay = GetHitDice(oCreature) * 64;
			if (GetGold(oPC) > nPay)
			{
				SendMessageToPC(oPC, "Paying your cohort...");
				TakeGoldFromCreature(nPay, oPC, TRUE, TRUE);
			}
			else
			{
				SendMessageToPC(oPC, "You cannot afford your cohort.");
				DestroyCohort(oCreature);
			}
			
			nIntervalPay = 1 - 320;
		}
		
		SetLocalInt(oCreature, "nIntervalXP", nIntervalXP);
		SetLocalInt(oCreature, "nIntervalPay", nIntervalPay);

		//
		//	REJOIN MY LEADER (IF COHORT DIED AND WAS RAISED FOR EXAMPLE OR COHORT WAS JUST SPAWNED)
		//
		
		if (!GetIsHenchman(oPC, oCreature))
		{
			SetMaxHenchmen(GetMaxHenchmen() + 1);
			AddHenchman(oPC);
			SetMaxHenchmen(GetMaxHenchmen() - 1);
		}
	}
	//
	//	COHORT'S LEADER IS MISSING
	//
	else
	{
		DestroyCohort(oCreature);
	}
}