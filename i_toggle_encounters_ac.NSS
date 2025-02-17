// Toggles every encounter in dm's area and tells the DMs about it.
// Found on Bioware Boards, Fixed for NWN2 by Wired
void ToggleEncountersInArea(object oDM)
{
   int i = 1;
   object oEncounter = GetNearestObject( OBJECT_TYPE_ENCOUNTER, oDM );
   while ( GetIsObjectValid( oEncounter ) )
   {
      if (GetEncounterActive( oEncounter ))
      {
         // disable the encounter and flag as dm disabled
         SetEncounterActive( 0, oEncounter );
         SetLocalInt(oEncounter, "DM_DISABLED", 1);
         SendMessageToAllDMs( "Encounter " + GetName(oEncounter) + " in " + GetName( GetArea( oDM ) ) +
            " switched off by " + GetName( oDM ));
      }
      // if the encounter is disabled, check to see if a dm disabled it
      else if (GetLocalInt(oEncounter, "DM_DISABLED"))
      {
         // re-enable the encounter and clear the dm flag
         SetEncounterActive( 1, oEncounter );
         SetLocalInt(oEncounter, "DM_DISABLED", 0);
         SendMessageToAllDMs( "Encounter " + GetName(oEncounter) + " in " + GetName( GetArea( oDM ) ) +
            " switched on by " + GetName( oDM ));
      }
      // otherwise, the encounter is disabled and we leave it that way
      oEncounter = GetNearestObject( OBJECT_TYPE_ENCOUNTER, oDM, ++i);
   }
}
void main()
{
   object oDM = GetItemActivator();
   if (!GetIsDM(oDM)) return;
   // Toggle encounters not already deactivated
   ToggleEncountersInArea(oDM);
}