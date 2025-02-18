// 	lendose_tyrak_tree_od
//	wired 02/26/2010
//	you can chop the thing down
//	instead of doing the sidequest

#include "ginc_partymath"

void main()
{
	object oLHA 	=	GetLastHostileActor();
	effect eWail 	= 	EffectVisualEffect(VFX_HIT_SPELL_WAIL_OF_THE_BANSHEE);
	object oPartyMem= 	GetFirstFactionMember(oLHA);
	int nState		=	GetHighJournalEntry("lendose_phoenix",oLHA);

	if (	(nState	> 0) &&
			(nState	< 4) &&
			(GetHighJournalEntry("lendose_phoenix_shield",oLHA)	== 0)
		)
		{	
			while (GetIsObjectValid(oPartyMem)) 
			{
				if (GetDistanceBetween(oLHA,oPartyMem) < 10.0f)
				{
					AdjustAlignment(oPartyMem, ALIGNMENT_CHAOTIC, 10);
					AdjustAlignment(oPartyMem, ALIGNMENT_EVIL, 10);
				}
					
		        oPartyMem = GetNextFactionMember(oLHA);
		    }
			
			AddJournalQuestEntry("lendose_phoenix",nState+1,oLHA,TRUE);
			AddJournalQuestEntry("lendose_phoenix_shield",1,oLHA,TRUE);
			AddJournalQuestEntry("lendose_tree",2,oLHA,TRUE);
			
			CreateObject(OBJECT_TYPE_ITEM,"lendose_tyrak_phoenix_shield",GetLocation(oLHA));	
		}
	
	ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eWail,GetLocation(OBJECT_SELF));
	ExecuteScript("std_plc_respawn",OBJECT_SELF);	
}