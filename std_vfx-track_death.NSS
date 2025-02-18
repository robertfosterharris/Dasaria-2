//std_vfx-track_death
//General script to generate a placeable in-line between two waypoints. Called on creature death.
//Credit: Alhadis: http://nwn.bioware.com/forums/viewtopic.html?topic=234960&forum=47&sp=135
//Major modifications by Loki
//Version 2.5
//07/30/12
/*
To use, place the following variables on a creature.
DeathScript	 = aw_vfx-track_death
sWP 		 = wp_aw_vfx_target (Invisible creature template to spawn where a creature dies)
iDC			 = 14 (DC of Survival check to discover tracks)

Place the following variables on the waypoint template defined in sWP
sEntrance	 = aw_entrance (Template of placeable used as cave entrance at oOrigin)
sPlaceable	 = aw_track (Placeable template to spawn in a line when creature dies)
oOrigin 	 = wp_aw_vfx_track_dest (Tag of muliple waypoints in area to spawn an entrance placeable)
iWP			 = 4 (Number of nearest oOrigin waypoints to use in selecting random destinations)
*/



void main()
	{
	if (GetGlobalInt("waa_debug")>0) {SendMessageToAllDMs("std_vfx-track_death.NSS Called by " + GetName(OBJECT_SELF));}//Debug 
	object oPC = GetLastKiller();
	int iQuestEntry = GetJournalEntry("aw_quest", oPC);

	if ((iQuestEntry >= 100) || GetIsDM(oPC))
		{
		int iDC = GetLocalInt(OBJECT_SELF, "iDC");
		if (GetGlobalInt("waa_debug")>2) {SendMessageToAllDMs("iDC: " + IntToString(iDC));}//Debug
		
		if (GetIsSkillSuccessful(oPC, SKILL_SURVIVAL, iDC, TRUE))
   			{
			string sWP = GetLocalString(OBJECT_SELF, "sWP");
			if (GetGlobalInt("waa_debug")>2) {SendMessageToAllDMs("sWP: " + sWP);}//Debug
			
			FloatingTextStringOnCreature("You discover a set of tracks leading back in the direction from which this beast approached.", oPC, TRUE);
			
			SetLocalString(CreateObject(OBJECT_TYPE_CREATURE, "c_aw_track", GetLocation(OBJECT_SELF), TRUE, "BodyBag"), "sWP", sWP);
			
			} else
				{
				FloatingTextStringOnCreature("You've killed one of the beasts, but see no indication from which direction this beast may have come.", oPC, TRUE);
				return;
				}
			} else {return;}
	}