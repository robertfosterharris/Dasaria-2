// event_nex_speech
// wired 01/11/08
// in case there's not enough staff...

#include "ginc_group"

// assign SetFacing() to each member in group, ignore noise
void GroupSetFacing(string sGroupName, float fDegrees)
{
	object oMember = GetFirstInGroup(sGroupName);
	while (GetIsObjectValid(oMember) == TRUE)
	{
		AssignCommand(oMember, SetFacing(fDegrees));
		oMember = GetNextInGroup(sGroupName);
	}
}

void main()
{
	location lNobles1 = GetLocation(GetNearestObjectByTag("POST_TalonWarlord01"));
	location lNobles2 = GetLocation(GetNearestObjectByTag("POST_TalonWarlord010"));
	location lJerome = GetLocation(GetNearestObjectByTag("arena_jerome"));
	location lSavhanna = GetLocation(GetNearestObjectByTag("POST_event_nex_savhanna"));
	
	object oGov = CreateObject(OBJECT_TYPE_CREATURE,"event_nex_nathan_verkethed",lNobles1);
	CreateObject(OBJECT_TYPE_CREATURE,"TalonWarlord01",lNobles1);
	CreateObject(OBJECT_TYPE_CREATURE,"TalonWarlord01",lNobles2,FALSE,"TalonWarlord010");

	
	GroupSpawnAtWaypoint("commoners","cear_commoner01","WP_Commoners1",1);
	GroupSpawnAtWaypoint("commoners","cear_commoner02","WP_Commoners1",1);
	GroupSpawnAtWaypoint("commoners","cear_commoner03","WP_Commoners1",1);
	GroupSpawnAtWaypoint("commoners","cear_commoner04","WP_Commoners1",1);
	GroupSpawnAtWaypoint("commoners","cear_commoner05","WP_Commoners2",1);
	GroupSpawnAtWaypoint("commoners","cear_commoner06","WP_Commoners2",1);
	GroupSpawnAtWaypoint("commoners","cear_commoner07","WP_Commoners2",1);
	GroupSpawnAtWaypoint("commoners","cear_commoner08","WP_Commoners2",1);
	GroupSpawnAtWaypoint("commoners","cear_commoner09","WP_Commoners2",1);
	GroupSpawnAtWaypoint("commoners","cear_commoner01","WP_Commoners3",1);
	GroupSpawnAtWaypoint("commoners","cear_commoner02","WP_Commoners3",1);
	GroupSpawnAtWaypoint("commoners","cear_commoner03","WP_Commoners3",1);
	GroupSpawnAtWaypoint("commoners","cear_commoner04","WP_Commoners3",1);
	GroupSpawnAtWaypoint("commoners","cear_commoner05","WP_Commoners3",1);
	GroupSpawnAtWaypoint("commoners","cear_commoner06","WP_Commoners4",1);
	GroupSpawnAtWaypoint("commoners","cear_commoner07","WP_Commoners4",1);
	GroupSpawnAtWaypoint("commoners","cear_commoner08","WP_Commoners4",1);
	GroupSpawnAtWaypoint("commoners","cear_commoner09","WP_Commoners4",1);
	
	GroupWander("commoners",TRUE);	
	
	GroupSpawnAtWaypoint("nobles","cear_noble_01","POST_TalonWarlord01",1);
	GroupSpawnAtWaypoint("nobles","cear_noble_02","POST_TalonWarlord01",1);
	GroupSpawnAtWaypoint("nobles","cear_noble_03","POST_TalonWarlord01",1);
	GroupSpawnAtWaypoint("nobles","cear_noble_04","POST_TalonWarlord01",1);
	GroupSpawnAtWaypoint("nobles","cear_noble_05","POST_TalonWarlord01",1);
	GroupSpawnAtWaypoint("nobles","cear_noble_06","POST_TalonWarlord01",1);
	GroupSpawnAtWaypoint("nobles","cear_noble_07","POST_TalonWarlord010",1);
	GroupSpawnAtWaypoint("nobles","cear_noble_08","POST_TalonWarlord010",1);
	GroupSpawnAtWaypoint("nobles","cear_noble_09","POST_TalonWarlord010",1);
	GroupSpawnAtWaypoint("nobles","cear_noble_10","POST_TalonWarlord010",1);
	GroupSpawnAtWaypoint("nobles","cear_noble_11","POST_TalonWarlord010",1);
	GroupSpawnAtWaypoint("nobles","cear_noble_12","POST_TalonWarlord010",1);
	
	DestroyObject(GetNearestObjectByTag("arena_jerome"));
	CreateObject(OBJECT_TYPE_CREATURE,"arena_jerome0",lJerome);
	
	DestroyObject(GetNearestObjectByTag("arena_marius"));
	DestroyObject(GetNearestObjectByTag("arena_zenia"));
	DestroyObject(GetNearestObjectByTag("arena_avers"));	
	
	CreateObject(OBJECT_TYPE_CREATURE,"event_nex_savhanna",lSavhanna);	
	
	object oArea = GetArea(oGov);
	MusicBackgroundStop(oArea);
	MusicBackgroundChangeDay(oArea,TRACK_THEME_ARIBETH1);
	MusicBackgroundChangeNight(oArea,TRACK_THEME_ARIBETH1);
	MusicBackgroundPlay(oArea);	
	DelayCommand(20.0,GroupSetFacing("nobles", 180.0));
}