// kobold_npc_trigger
// wired 09/22/11
// a pseudo-encounter

#include "ginc_partymath"
#include "std_i0_misc"

void main()
{
	object oPC = GetEnteringObject();
	if (!GetIsPC(oPC)) return;
	
	int bDEBUG = FALSE;
	int bTRUE = FALSE;
	
	if (bDEBUG) SendMessageToPC(oPC,"DEBUG: Running kobold_npc_trigger");
	
	object oTrigger = OBJECT_SELF;
	object oNPC;
	
	string sNPC = GetLocalString(oTrigger,"sNPC");
	if (bDEBUG) SendMessageToPC(oPC,"DEBUG: Found tag "+sNPC+", looking for wp_"+sNPC+"_sp");
	location lLoc = GetLocation(GetObjectByTag("wp_"+sNPC+"_sp"));
	if (bDEBUG && !GetIsLocationValid(lLoc)) SendMessageToPC(oPC,"DEBUG: Bad location");
	
	// PC is on the quest and hasn't encountered this NPC yet, everybody's in-level, npc doesn't already exist in area
	if (GetJournalEntry("kobold_king",oPC) == 5 && GetJournalEntry(sNPC,oPC) == 0 && PartyLevelCheck(oPC, 6, 9 ) ) bTRUE = TRUE;
	
	if (GetIsStaff(oPC) &&  GetLocalInt(oPC,"bBuilderOverrideLevelCheck") == TRUE) bTRUE = TRUE;
	
	if (bTRUE)
	{
		oNPC = GetNearestObjectByTag(sNPC);
		
		if ( GetIsObjectValid(oNPC) )
		{
			SendMessageToPC(oPC,"<i>It seems that someone else has already rescued "+GetFirstName(oNPC)+", and they're probably still nearby.");
		}
		else
		{
			AddJournalQuestEntry(sNPC,1,oPC,TRUE);
			CreateObject(OBJECT_TYPE_CREATURE,sNPC,lLoc,TRUE);	
		}
	}
	else
	{
		if (bDEBUG) SendMessageToPC(oPC,"DEBUG: Did not meet criteria.");
	}
}