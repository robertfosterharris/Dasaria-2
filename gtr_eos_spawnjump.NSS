// jump EOS to an alternate location

#include "std_faction_i0"
//#include "ginc_lycan"

void main()
{
		object oTarget = GetEnteringObject();
		
		if (!GetIsPC(oTarget) || !GetIsObjectValid(oTarget)) return;
		
		object oWP = GetWaypointByTag("WP_EOS_SPAWN");
		string sFaction = "cearguard";
		int nRep = 1;
		if ( 
			std_reputation_get( oTarget, sFaction ) == nRep
			//	|| GetLocalInt(std_journal_get( oTarget ),"werewolf") == 1
			)
		{
			if(!GetIsObjectValid(oTarget))
			{
				SendMessageToPC(oTarget, "Destination waypoint is not valid!");
			}
		   	else
			{
				if (GetLocalInt(oTarget,"EOS_ENTERED") != 1)
				{
					SendMessageToPC(oTarget, "Re-routed to safe zone.");					
					SetLocalInt(oTarget,"EOS_ENTERED",1);
					//ActionWait(2.0);
					AssignCommand(oTarget, JumpToObject(oWP));
				}
			}
		}		
}