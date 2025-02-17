// 2bridges_cartmaster_ud
//::///////////////////////////////////////////////
//:: Default: On User Defined
//:: NW_C2_DEFAULTD
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Determines the course of action to be taken
    on a user defined event.
*/
//:://////////////////////////////////////////////
//:: Created By: Don Moar
//:: Created On: April 28, 2002
//:://////////////////////////////////////////////
void main()
{
    // enter desired behaviour here
	
	int nEvent = GetUserDefinedEventNumber();
	
	switch( nEvent )
	{

		
		case EVENT_HEARTBEAT:
		{
			if (!GetIsInCombat())
			{
				if(!IsInConversation(OBJECT_SELF))
				{	
					if (Random(4) == 0) // reduce chatter to 25%
					{
						SpeakString("Bring out yer dead! *clang, clang, clang*");
						PlayCustomAnimation(OBJECT_SELF, "clapping", 0, 1.0);
					}	
				}
			}
		}
		break;
		
	}

    return;
}