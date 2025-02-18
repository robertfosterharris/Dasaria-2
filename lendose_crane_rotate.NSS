// wired 2010/04/04
// initial heading is 45.0000038
//
// rotate 90 degree each time PC pulls lever
//
#include "ginc_reflection"
#include "ginc_partymath"

void main()
{
	object oPC = GetLastUsedBy();
	object oCrane = GetNearestObjectByTag("lendose_kobblenort_crane");
	object oCauldron = GetNearestObjectByTag("lendose_kobblenort_cauldron");
	int nCurFacing = GetLocalInt(oCrane,"nCurFacing");
	string sQuestName = "lendose_toystore";
	int nJournalEntry = GetHighJournalEntry(sQuestName,oPC);
	int nItems = GetNumItems(oCauldron,"lendose_kobblenort_metal_itm") + GetNumItems(oCauldron,"n2_crft_ingiron");
	effect eFire = EffectVisualEffect(VFX_DUR_FIRE);
	effect eDeath = EffectDeath();
	
	if (nCurFacing == 0)
	{
		nCurFacing = nCurFacing+90;
		SetLocalInt(oCrane,"nCurFacing",nCurFacing);	
		PlaySound(DEF_ROTATION_SOUND);
		AssignCommand(oCrane,InterpolatedRotation(90.0, 3.0, 20));
		PlaySound("pl_windmill_idle02");
		FloatingTextStringOnCreature("With a groan, the crane rotates 90 degrees counterclockwise.",oPC,TRUE);

		// are we on the quest?		
		// does the cauldron contain 25 units of ore?
		// cauldron should have a disturbed event
		if (  nItems>24 && nJournalEntry == 5 )
		{
			// update journal
			AddJournalQuestEntry(sQuestName,6,oPC,TRUE);
			//ApplyEffectToObject(DURATION_TYPE_PERMANENT,eMove,oCauldron,60.0f);
			DelayCommand(2.0f,FloatingTextStringOnCreature("The crane comes to rest before the massive cauldron its hook sliding into perfect alignment with a slot in the side of the cauldron.  In such close proximity to the furnace, the iron ore begins to soften.",oPC,TRUE));
			DelayCommand(3.0f,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eFire,oCauldron,10.0f));
			
			object oItem = GetFirstItemInInventory(oCauldron);
			while ( GetIsObjectValid(oItem))
			{
			 	SetPlotFlag(oItem,FALSE);
				DestroyObject( oItem );
				oItem = GetNextItemInInventory(oCauldron);
			}			
		}
		else
		{
			FloatingTextStringOnCreature("The crane comes to rest before the massive cauldron. It leans every so slightly off level in this position as if it were calibrated to bear a much heavier load.",oPC,TRUE);
		}
		return;		
	}
	
	// new position is 360
	if (nCurFacing == 90)
	{
	
		nCurFacing = 0;
		SetLocalInt(oCrane,"nCurFacing",nCurFacing);	
		PlaySound(DEF_ROTATION_SOUND);
		AssignCommand(oCrane,InterpolatedRotation(270.0, 3.0, 40));
		PlaySound("pl_windmill_idle02");
		FloatingTextStringOnCreature("With a groan, the crane rotates 270 degrees counterclockwise.",oPC,TRUE);
	
		int nJournalEntry = GetHighJournalEntry(sQuestName,oPC);
		if ( nJournalEntry == 6 )
		{
			AddJournalQuestEntry(sQuestName,7,oPC,TRUE);
			ApplyEffectToObject(DURATION_TYPE_INSTANT,eDeath,oCauldron);
			DelayCommand(3.0f,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eFire,GetNearestObjectByTag("lendose_kobblenort_mold"),10.0f));
			DelayCommand(3.0f,FloatingTextStringOnCreature("The crane comes into position above the mold.",oPC,TRUE));
		}
		else
		{
			FloatingTextStringOnCreature("The crane returns to position above the platform.",oPC,TRUE);
		}
	}	
}