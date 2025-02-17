// i_soulmirror_ac
// Grabs current target of "Unique Power" item and writes attributes to a book placed in inv
// Recreates creature if book is used as target
void main()
{
    object oPC      = GetItemActivator();
    object oItem    = GetItemActivated();
    object oTarget  = GetItemActivatedTarget();
    location lTarget = GetItemActivatedTargetLocation();
	location lPC = GetLocation(oPC);
	string nTargetName = GetName(oTarget);
	string sTargetTag = GetTag(oTarget);
	
//Check if target is creature gem, recreate if so
if( sTargetTag == "creaturegem"  )   {
   //Create creature from stored resref
   object oCreature = CreateObject(OBJECT_TYPE_CREATURE, GetLocalString(oTarget, "_resref"), lPC, FALSE, "");
     
   //Begin Modification of Target
   SetCreatureAppearanceType(oCreature, GetLocalInt(oTarget, "_appearance")); 
   SetFirstName(oCreature, GetLocalString(oTarget, "_name"));
   SetDescription(oTarget, " ");
   SetBaseAbilityScore(oCreature, 0, GetLocalInt(oTarget, "_Str"));
   SetBaseAbilityScore(oCreature, 1, GetLocalInt(oTarget, "_Dex"));
   SetBaseAbilityScore(oCreature, 2, GetLocalInt(oTarget, "_Con"));
   SetBaseAbilityScore(oCreature, 3, GetLocalInt(oTarget, "_Int"));
   SetBaseAbilityScore(oCreature, 4, GetLocalInt(oTarget, "_Wis"));
   SetBaseAbilityScore(oCreature, 5, GetLocalInt(oTarget, "_Cha"));
  
             
   return;
   }

//If object is creature, start creation process 
int objtype = GetObjectType(oTarget);  
if ( objtype == 1)  {
//If object is not a creature book, create new book from target
object oSoulGem = CreateItemOnObject("nw_creaturegem", oPC, 1);

//Begin pulling data from oTarget and writing to the book
string TargetName = GetName(oTarget);
SetFirstName(oSoulGem, TargetName);
SetLocalString(oSoulGem, "_resref", GetResRef(oTarget));
SetLocalInt(oSoulGem, "_appearance", GetAppearanceType(oTarget));
SetLocalString(oSoulGem, "_name", TargetName);
SetLocalInt(oSoulGem, "_Str", GetAbilityScore(oTarget, 0, TRUE));
SetLocalInt(oSoulGem, "_Dex", GetAbilityScore(oTarget, 1, TRUE));
SetLocalInt(oSoulGem, "_Con", GetAbilityScore(oTarget, 2, TRUE));
SetLocalInt(oSoulGem, "_Int", GetAbilityScore(oTarget, 3, TRUE));
SetLocalInt(oSoulGem, "_Wis", GetAbilityScore(oTarget, 4, TRUE));
SetLocalInt(oSoulGem, "_Cha", GetAbilityScore(oTarget, 5, TRUE));
SetLocalInt(oSoulGem, "_hench", 0);
return;
}
SendMessageToPC(oPC,"The mirror only works on living things!");
}