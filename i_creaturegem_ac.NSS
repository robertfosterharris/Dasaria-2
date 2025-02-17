// i_creaturegem_ac
// Recreates creature stored with i_soulmirror_ac
// 05/28/12 - Fixed henchman script to overwrite default event handlers.
#include "ginc_henchman"

void main()
{
    object oPC      = GetItemActivator();
    object oItem    = GetItemActivated();
    location lTarget = GetItemActivatedTargetLocation();
	location lPC = GetLocation(oPC);
	
   //Create creature from stored resref
   object oCreature = CreateObject(OBJECT_TYPE_CREATURE, GetLocalString(oItem, "_resref"), lTarget, FALSE, "");
     
   //Begin Modification of Target
   SetCreatureAppearanceType(oCreature, GetLocalInt(oItem, "_appearance"));
   SetDescription(oCreature, " "); 
   SetFirstName(oCreature, GetLocalString(oItem, "_name"));
   SetBaseAbilityScore(oCreature, 0, GetLocalInt(oItem, "_Str"));
   SetBaseAbilityScore(oCreature, 1, GetLocalInt(oItem, "_Dex"));
   SetBaseAbilityScore(oCreature, 2, GetLocalInt(oItem, "_Con"));
   SetBaseAbilityScore(oCreature, 3, GetLocalInt(oItem, "_Int"));
   SetBaseAbilityScore(oCreature, 4, GetLocalInt(oItem, "_Wis"));
   SetBaseAbilityScore(oCreature, 5, GetLocalInt(oItem, "_Cha"));
   
   //Bind target to activating player if _hench = 1
   if ( GetLocalInt(oItem, "_hench") == 1)  {
   HenchmanAdd(oPC,oCreature,1,1);
   }
}