#include "rw_coinage"

void main( string sInput )

{
			object oPC = OBJECT_SELF;
			
			if(!GetIsPC(oPC)) return;
			
			object oCash;
			object oCoins;
			location lTarget = GetLocalLocation(oPC,"lDropGold");
			int iPC_CurrentGold;
			int iPC_DropGold;			
			
			float fDist;
			
			
			iPC_CurrentGold = GetGold(oPC);
						
			iPC_DropGold = StringToInt( sInput);
			
			//0 gold check
			if(iPC_DropGold < 1)
			{
			SendMessageToPC(oPC, "You need to enter a valid amount of gold to drop: action cancelled");
			return;
			}
			
			//more gold than you have check
			if(iPC_DropGold > iPC_CurrentGold )
			{
			SendMessageToPC(oPC, "You don't have that much gold: action cancelled");
			return;
			}

			//more gold than can fit in a stack of gold check
			if(iPC_DropGold > 50000 )
			{
			SendMessageToPC(oPC, "You cannot drop more than 50,000 at a time: action cancelled");
			return;
			}
			
			//you've moved about a lot check
			fDist = GetDistanceBetweenLocations(GetLocation(oPC), lTarget);
			if(fDist > 5.0)
			{
			SendMessageToPC(oPC, "You are to far away to drop the gold there: action cancelled");
			return;
			}
			
			TakeGoldFromCreature(iPC_DropGold,oPC,TRUE,TRUE);
			
			//hmmm losing gold this way doesn't cause an unacquire event - so we use
			
			CalculateGoldWeight(oPC);

			if(	iPC_DropGold > 10000)
			{		
			oCash = CreateObject (OBJECT_TYPE_PLACEABLE,"rw_coinpile_l",lTarget);
			}
			else if (iPC_DropGold > 100)
			{
			oCash = CreateObject (OBJECT_TYPE_PLACEABLE,"rw_coinpile_m",lTarget);
			}
			else
			{
			oCash = CreateObject (OBJECT_TYPE_PLACEABLE,"rw_coinpile_s",lTarget);
			}	
			
			
			oCoins = CreateItemOnObject( "nw_it_gold001", oCash, iPC_DropGold ); 

}