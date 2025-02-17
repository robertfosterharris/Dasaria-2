// wired 06/28/2010 make this a generic framework

#include "dasolm_inc"

void main(int nScene, string sWP)
{
	object oPC = GetPCSpeaker();
	object oLeader = GetFactionLeader(oPC);
	int nSoldiersNum = GetLocalInt(oLeader,"LendOL_Soldiers");
	int nSoldiersMax = DasOL_GetMaxAllies(oLeader);
	
	switch (nScene)
	{
		case 1://jumps party to.. (needs gather)
		{
			if (DasOL_CheckPartyGathered(oPC))
			{			
				JumpAlliedParty(oPC,sWP); 
			}		
		}
		break;
		
		case 2://Set Tokens
		{
			DasOL_SetTokens(oPC);
		}
		break;
		
		case 3:// set price
		{
			SendMessageToPC(oPC,"I should have been replaced by dasolm_gc_recruit!");
		}
		break;
		
		case 4: //Infiltration Mission #1: Stealthy
		{
			SendMessageToPC(oPC,"I should have been replaced!");
			JumpAlliedParty(oPC,"lendose_infilt1_stealthwp");
		}
		break;
		
		case 5: //Infiltration Mission #1: Assault
		{
			//SendMessageToPC(oPC,"DEBUG: REMOVE FIRST 2 LINES OF case 5");
			//SetLocalInt(oLeader,"LendOL_Soldiers",nSoldiersMax);
			//remove the above 2 lines
			
			SendMessageToPC(oPC,"I should have been replaced!");
			object oWP = GetWaypointByTag("lendose_infilt1_stealthwp");
			object oArea = GetArea(oWP);
			SetLocalInt(oPC,"Lendose_ASSAULT",1);
			JumpAlliedParty(oPC,"lendose_infilt1_attackwp1");
		}
		break;
		case 6://Infiltration #1: Leave
		{
			SendMessageToPC(oPC,"I should have been replaced!");
			object oArea = GetArea(oPC);
			SetLocalFloat(oArea,"Clearance",60.0);
			
			int nSoldiersNum = GetLocalInt(oLeader,"LendOL_Soldiers");
			
			//How many henchmen still alive? Skip this part if in stealth approach
			if (GetLocalInt(oPC,"Lendose_ASSAULT"))
			{ 
				DasOL_Enc_SetAlliesRemaining(oLeader); 
			
				DasOL_Enc_RemoveAllies(oLeader);
			}
			JumpPartyToArea(oPC,GetWaypointByTag(sWP));
				
			DelayCommand(50.0,SetLocalFloat(oArea,"Clearance",300.0));
		}
		break;
		
		case 7://henchmen rejoin party
		{
			int nDefault = GetMaxHenchmen();
			SetMaxHenchmen(18);
			AddHenchman(oLeader,OBJECT_SELF);
			//SendMessageToPC(GetFirstPC(),"My leader is "+GetName(GetMaster(OBJECT_SELF)));
			DelayCommand(2.0,SetMaxHenchmen(nDefault));
		}
		break;
		case 8://Recruit function
		{
			if (bDEBUG) SendMessageToPC(oPC,"scenes case 8");
			
			DasOL_DoRecruit(oPC);
		}
		break;
		case 9://joined Imperials
		{
			DasOL_SetTokens(oPC);
			break;
		}
		break;
		case 10://joined rebels
		{
			DasOL_SetTokens(oPC);
		}
		break;

	}
}