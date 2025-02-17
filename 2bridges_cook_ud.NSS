// 2bridges_cook_ud
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
				PlayCustomAnimation(OBJECT_SELF, "cooking01", 1, 1.0);
			}
		}
		break;
		
	}

    return;
}