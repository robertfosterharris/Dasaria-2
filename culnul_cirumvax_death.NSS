#include "ginc_misc"
#include "ginc_journal"
#include "ginc_faction"
void main()
{
	object oPC = GetLastHostileActor();
	int nEntry = GetJournalEntry("talonroad_culnul",oPC);
	effect eWail = EffectVisualEffect(VFX_HIT_SPELL_WAIL_OF_THE_BANSHEE);
	location lLoc = GetLocation(OBJECT_SELF);
	
	if  (GetIsInFaction(oPC,"The Harbingers of Culnul"))
	{
		object oItem = GetFirstItemInInventory(OBJECT_SELF);
		while (GetIsObjectValid(oItem))
		{
			SetDroppableFlag(oItem,FALSE);
			oItem = GetNextItemInInventory(OBJECT_SELF);
		}	
	}	
	
	switch (nEntry)
	{			
		case 8:		AddJournalQuestEntry("talonroad_culnul",9,oPC,TRUE); break;
		
		case 20:	AddJournalQuestEntry("talonroad_culnul",22,oPC,TRUE);
					//ForceExit("talonroad_eloria_kinskerr", "talonroad_cunul_enter_wp", TRUE);
					//RewardPartyQuestXP(oPC, "talonroad_culnul");
					break;
		case 21:	AddJournalQuestEntry("talonroad_culnul",23,oPC,TRUE); 
					//ForceExit("talonroad_eloria_kinskerr", "talonroad_cunul_enter_wp", TRUE);
					//RewardPartyQuestXP(oPC, "talonroad_culnul");
					break;
	}
	SpeakString("I shall rise again in his service!",TALKVOLUME_TALK);
	CreateObject(OBJECT_TYPE_CREATURE,"culnul_cirumvax_risen",lLoc,TRUE);
	ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eWail,lLoc);	
}