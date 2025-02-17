// 2bridges_siegequest
// take out the siege engine and crew!
#include "ginc_group"
void main ()
{
	// first one
	SpawnCreaturesInGroupAtWP(2,"kor_sorc","siegecrew","WP_siegecrew");
	SpawnCreaturesInGroupAtWP(1,"kor_subchief","siegecrew","WP_siegecrew");	
	SpawnCreaturesInGroupAtWP(1,"c_beardire","siegecrew","WP_siegecrew");
	object oEngine = GetNearestObjectByTag("2bridges_siegeengine");
	if (!GetIsObjectValid(oEngine))
	{
		location bLoc = GetLocation(GetObjectByTag("WP_siegeengine"));
		object oEngine = CreateObject(OBJECT_TYPE_PLACEABLE,"2bridges_siegeengine",bLoc);
	}
	
	// second one
	SpawnCreaturesInGroupAtWP(2,"kor_sorc","siegecrew","WP_siegecrew2");
	SpawnCreaturesInGroupAtWP(1,"kor_subchief","siegecrew","WP_siegecrew2");	
	object oEngine2 = GetNearestObjectByTag("2bridges_siegeengine2");
	if (!GetIsObjectValid(oEngine2))
	{
		location bLoc = GetLocation(GetObjectByTag("WP_siegeengine2"));
		object oEngine2 = CreateObject(OBJECT_TYPE_PLACEABLE,"2bridges_siegeengine",bLoc,FALSE,"2bridges_siegeengine2");
	}	
}