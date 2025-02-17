// event_2b_army
// Automate a Kor Army

#include "ginc_group"

void main()
{
	object oDest1 = GetNearestObjectByTag("event_2b_hills");
	object oDest2 = GetNearestObjectByTag("event_2b_road");
	object oDest3 = GetNearestObjectByTag("event_2b_village");

	// party one - 3 gimps, 2 braves, 1 druid
	GroupSpawnAtWaypoint("kor1","wired_gimp_kor_warrior","kor_entry1",3);
	GroupSpawnAtWaypoint("kor1","wired_reanim_kor_brave","kor_entry1",2);
	GroupSpawnAtWaypoint("kor1","wired_reanim_kor_shaman","kor_entry1",1);
	GroupActionMoveToObject("kor1",oDest1,TRUE,1.0f);
	
	//party two - 2 gimps, 2 skirmishers, 1 sorc
	GroupSpawnAtWaypoint("kor2","wired_gimp_kor_warrior","kor_entry2",2);
	GroupSpawnAtWaypoint("kor2","wired_reanim_kor_skirmisher","kor_entry2",2);
	GroupSpawnAtWaypoint("kor2","wired_reanim_kor_sorc","kor_entry2",1);	
	GroupActionMoveToObject("kor2",oDest2,TRUE,1.0f);
	
	//party three - four gimps and a subchief
	GroupSpawnAtWaypoint("kor3","wired_gimp_kor_warrior","kor_entry3",4);
	GroupSpawnAtWaypoint("kor3","wired_reanim_kor_subchief","kor_entry3",1);
	GroupActionMoveToObject("kor3",oDest3,TRUE,1.0f);
		

}