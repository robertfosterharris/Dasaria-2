//	ON USER DEFINED - ISMAY'S COMMENTS ON THE UNDEAD
//
//	10/03/2012	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM
//
#include "std_i0_time"

void ismayPerceive();
void MakeComment(string sComment, string sCommentFlag);

void main()
{
    int iEvent = GetUserDefinedEventNumber();

    switch (iEvent)
	{
		case EVENT_HEARTBEAT: 			// 1001
			break;	

		case EVENT_PERCEIVE: 			// 1002
			ismayPerceive();
			break;	

		case EVENT_END_COMBAT_ROUND: 	// 1003
			break;	

		case EVENT_DIALOGUE:		 	// 1004
			break;	

		case EVENT_ATTACKED: 			// 1005
			break;	

		case EVENT_DAMAGED: 			// 1006
			break;
	
		case EVENT_DISTURBED: 			// 1008
			break;	

		case EVENT_SPELL_CAST_AT: 		// 1011
			break;	
	}
}

void ismayPerceive()
{
	object oNPC;
	
	oNPC = GetLastPerceived();
	
	if (GetLastPerceptionSeen() && GetIsEnemy(oNPC))
	{
		switch (GetAppearanceType(oNPC))
		{
			//	GHAST
			case 74:
				MakeComment("Do not let that disease ridden ghast bite you.  You risk becoming one of them if infected.", "bGhastComment1");
				MakeComment("Brace yourself.  The stench of a ghast can be overwhelming.", "bGhastComment2");
				MakeComment("One scratch from a ghast can be paralytic, so be careful.", "bGhastComment3");
			break;
			
			//	MUMMY
			case 58:
				MakeComment("That mummy's wrappings are extremely flammable.  Use fire against them if you can.", "bMummyComment1");
				MakeComment("Beware, a mummy's curse can only be broken by powerful magics.", "bMummyComment2");
				MakeComment("Steel yourself against despair my friends!", "bMummyComment3");
			break;

			//	SKELETON
			case 537:
				MakeComment("That skeleton's bones will turn a blade.  Bash it's skull in with something blunt!", "bSkeletonComment1");
				MakeComment("Do not use cold against that skeleton.  They are immune to it.", "bSkeletonComment2");
			break;
			
			//	WRAITH
			case 187:
				MakeComment("Damn incorporeal wraiths, those are going to be hard to hit.  Now would be a good time for magic!", "bWraithComment1");
				MakeComment("Those wraiths can drain your life force with a touch, so be careful.", "bWraithComment2");
			break;

			//	ZOMBIE
			case 198:
				MakeComment("Zombies are big lumbering masses of flesh.  They take to a knife like butter.", "bZombieComment1");
			break;
		}
	}
}
void MakeComment(string sComment, string sCommentFlag)
{
	if (GetLocalInt(OBJECT_SELF, sCommentFlag) == 0 && time_stamp_seconds_elapsed(OBJECT_SELF, "nLastComment") > 180)
	{
		DelayCommand(2.0f, SpeakString(sComment));
		SetLocalInt(OBJECT_SELF, sCommentFlag, 1);
		time_stamp_seconds_set(OBJECT_SELF, "nLastComment");
	}
}