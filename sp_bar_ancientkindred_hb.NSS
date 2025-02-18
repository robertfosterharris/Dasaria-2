/*
Ancient Kindred HB

Type of Feat: Heritage
Prerequisite: Baraanman Heritage. Character Level 12.
Specifics: The Baraanmen have an ancient accord with the Dwarves. Such is the trust that they have for your people that they have shared some of their secret defensive techniques.
When he needs to, the Baraanman can become a stalwart bastion of defense. In this defensive stance, a Baraanman gains phenomenal strength and durability but he cannot move from the spot he is defending. He gains the following benefits:
 +2 Strength
 +4 Constitution
 +2 resistance bonus on all saves
 +4 dodge bonus to AC
This ability can be used 1/day for every Baraanman heritage feat possessed.
 Use: Selected

*/
#include "x0_i0_position"
#include "ginc_custom_races"
#include "ginc_chat_const"
#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
	object oHB_device = OBJECT_SELF;
	object oPC = GetFirstPC();			
	
	string oCreator =  GetLocalString(oHB_device,  "oCreator" );
	string sTestString;
	location lCreatorLocation = GetLocalLocation(oHB_device, "lCreatorLocation" );
	location lTestLocation;
	effect eTestEffect;
	
	while (GetIsObjectValid(oPC) == TRUE)
  	{
	 	
		
		if( GetName(oPC)+GetPCPlayerName(oPC)  ==  oCreator )
		{
			lTestLocation = GetLocation(oPC);
			
			if( lTestLocation != lCreatorLocation)
			{
				effect eTestEffect = GetFirstEffect(oPC);

				while (GetIsEffectValid(eTestEffect))
				{
					if (GetEffectSpellId(eTestEffect)== SPELLID_HRTG_PT_BAR_ANCIENTKINDRED)
				   	{      
						RemoveEffect(oPC, eTestEffect);
					}
				   eTestEffect=GetNextEffect(oPC);
				}
				SendMessageToPC(oPC, CLR_SERVER+"ends defensive stance."+CLR_END);		
				DestroyObject(oHB_device, 3.0);
			}
			
			break;
		} 
   
      oPC = GetNextPC();
   }

	


}