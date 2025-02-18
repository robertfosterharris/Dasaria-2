//	WAYPOINT SCRIPT
//
//	NOTES:
//	StandardRedirectorNode:		THIS FUNCTION TELLS THE NPC TO HIDE FOR A CERTAIN AMOUNT OF TIME
//								BEFORE CHANGING CLOTHES AND WALKING WAYPOINTS AGAIN.
//	StandardRoadNetworkNode:	THIS FUNCTION SENDS THE NPC TO A WAYPOINT PICKED RANDOMLY FROM A LIST.
//								IF THE ONLY WAYPOINT AVAILABLE IS THE CURRENT WAYPOINT,
//								THE NPC IS SENT TO THE REDIRECTOR NODE SPECIFIED.
//
#include "ginc_wp"
//
//	HAVE A CONVERSATION WITH THE NEAREST NPC
//
void TalkWithClerk();
//
//	MAIN
//
void main()
{
	int iCurrentWP = GetCurrentWaypoint();

    switch (iCurrentWP)
    {
//	
//		ENTRANCE
//		GIVE THE NPC A RANDOM NAME
//		WAIT 15 TO 45 SECONDS BEFORE SPAWNING HIM AT WAYPOINT 01
//	
        case 1:
			SetFirstName(OBJECT_SELF, RandomName());
			SetLastName(OBJECT_SELF, RandomName());
            StandardRedirectorNode("01", IntToFloat(Random(30) + 15));
            break;
//			
//		RECEPTION DESK
//		TALK WITH THE RECEPTIONIST
//		THEN WALK TO A RANDOM OFFICE FROM THE LIST ("05,06,07,08")
//		
        case 2:
			TalkWithClerk();
            StandardRoadNetworkNode("05,06,07,08", 1);
            break;
//
//		WAITING ROOM ONE
//		PLAY A RANDOM ANIMATION FOR 0-30 SECONDS
//		THEN WALK TO A RANDOM OFFICE FROM THE LIST ("05,06,07,08")
//
         case 3:
		 	ActionPlayAnimation(RandomPauseAnim(),IntToFloat(Random(10) + 20));
            StandardRoadNetworkNode("05,06,07,08", 1);
            break;
//
//		WAITING ROOM TWO
//		PLAY A RANDOM ANIMATION FOR 0-30 SECONDS
//		THEN WALK TO A RANDOM OFFICE FROM THE LIST ("05,06,07,08")
//
         case 4:
		 	ActionPlayAnimation(RandomPauseAnim(),IntToFloat(Random(10) + 20));
            StandardRoadNetworkNode("05,06,07,08", 1);
            break;
//
//		OFFICE ONE
//		PLAY A RANDOM ANIMATION FOR 0-30 SECONDS
//		THEN WALK TO A RANDOM WAYPOINT FROM THE LIST ("02,03,04,09")
//		RECEPTIONIST, WAITING ROOM ONE, WAITING ROOM TWO, OR EXIT
//
         case 5:
			TalkWithClerk();		 
            StandardRoadNetworkNode("02,03,04,09", 1);
            break;
//
//		OFFICE TWO
//		PLAY A RANDOM ANIMATION FOR 0-30 SECONDS
//		THEN WALK TO A RANDOM WAYPOINT FROM THE LIST ("02,03,04,09")
//		RECEPTIONIST, WAITING ROOM ONE, WAITING ROOM TWO, OR EXIT
//
         case 6:
			TalkWithClerk();		 
            StandardRoadNetworkNode("02,03,04,09", 1);
            break;
//
//		OFFICE THREE
//		PLAY A RANDOM ANIMATION FOR 0-30 SECONDS
//		THEN WALK TO A RANDOM WAYPOINT FROM THE LIST ("02,03,04,09")
//		RECEPTIONIST, WAITING ROOM ONE, WAITING ROOM TWO, OR EXIT
//
         case 7:
			TalkWithClerk();		 
            StandardRoadNetworkNode("02,03,04,09", 1);
            break;
//
//		OFFICE FOUR
//		PLAY A RANDOM ANIMATION FOR 0-30 SECONDS
//		THEN WALK TO A RANDOM WAYPOINT FROM THE LIST ("02,03,04,09")
//		RECEPTIONIST, WAITING ROOM ONE, WAITING ROOM TWO, OR EXIT
//
         case 8:
			TalkWithClerk();		 
            StandardRoadNetworkNode("02,03,04,09", 1);
            break;
//
//		EXIT
//		SPECIFYING THE CURRENT WAYPOINT ENSURES THE NPC WILL RETURN TO THE STANDARD REDIRECTOR NODE
//
         case 9:
            StandardRoadNetworkNode("09", 1);
            break;
     }
}
//
//	START A CONVERSATION WITH THE NEAREST NPC
//
void TalkWithClerk()
{
	object oOther;
	oOther = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC);
	if (GetIsObjectValid(oOther) && !IsBusy(oOther))
	{
		InitiateConversation(oOther);
    	MutualGreeting(oOther);
    	TypicalTalk(oOther);
    	TypicalTalk(oOther);
    	MutualGreeting(oOther);
	}
}