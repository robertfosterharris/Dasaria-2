//std_vfx-track
//General script to generate a placeable in-line between two waypoints. Called on spawn of c_aw_track creature, from std_vfx-track_death.
//Credit: Alhadis: http://nwn.bioware.com/forums/viewtopic.html?topic=234960&forum=47&sp=135
//Major modifications by Loki
//Version 2.5
//07/30/12
/*
To use, place the following variables on a creature.
DeathScript	 = aw_vfx-track_death
sWP			 = wp_aw_vfx_target (Waypoint template to spawn where a creature dies)

Place the following variables on the waypoint template defined in sWP
sEntrance	 = aw_entrance (Template of placeable used as cave entrance at oOrigin)
sPlaceable	 = aw_track (Placeable template to spawn in a line when creature dies)
sOrigin 	 = wp_aw_vfx_track_dest (Tag of muliple waypoints in area to spawn an entrance placeable)
iWP			 = 4 (Number of nearest oOrigin waypoints to use in selecting random destinations)
*/
	
void TraceVFXSequence(string sPlaceable, object oTarget, object oOrigin, float fSpeed, float fXOffset, float fYOffset, float fZOffset, int nCount, int nIterations, object oTracks);
void PerformActiveVFXStream(string sPlaceable, object oTarget, object oOrigin, float fSpeed=0.5f);

void main()
	{
	if (GetGlobalInt("waa_debug")>0) {SendMessageToAllDMs("std_vfx-track.NSS Called by " + GetName(OBJECT_SELF));}//Debug 
	
	string sWP = GetLocalString(OBJECT_SELF, "sWP");
	if (GetGlobalInt("waa_debug")>2) {SendMessageToAllDMs("sWP: " + sWP);}//Debug
	object oTarget = CreateObject(OBJECT_TYPE_WAYPOINT, sWP, GetLocation(OBJECT_SELF), FALSE, "BodyBag");
	AssignCommand(oTarget, DestroyObject(OBJECT_SELF, 300.f));
	
	string sPlaceable = GetLocalString(oTarget, "sPlaceable");
	string sOrigin = GetLocalString(oTarget, "sOrigin");
	int iWP = GetLocalInt(oTarget, "iWP");
	if (GetGlobalInt("waa_debug")>2) {SendMessageToAllDMs("sPlaceable: " + sPlaceable);}//Debug
	if (GetGlobalInt("waa_debug")>2) {SendMessageToAllDMs("sOrigin: " + sOrigin);}//Debug
	if (GetGlobalInt("waa_debug")>2) {SendMessageToAllDMs("iWP: " + IntToString(iWP));}//Debug
	
	//Find a WP at random from one of (iWP) pre-placed locations.
	object oOrigin = GetObjectByTag(sOrigin, Random(iWP));
	if (GetGlobalInt("waa_debug")>2) {SendMessageToAllDMs("oOrigin: " + GetName(oOrigin));}//Debug
	if (GetGlobalInt("waa_debug")>2) {SendMessageToAllDMs("oTarget: " + GetName(oTarget));}//Debug

	PerformActiveVFXStream(sPlaceable, oTarget, oOrigin, 0.5f);

	}

void PerformActiveVFXStream(string sPlaceable, object oTarget, object oOrigin, float fSpeed=0.05f)
	{
	if (GetGlobalInt("waa_debug")>1) {SendMessageToAllDMs("PerformActiveVFXStream(" + sPlaceable + ", " + GetName(oTarget) + ", " + GetName(oOrigin) + ", " + FloatToString(fSpeed) + ")");}//Debug
	float fXOffset, fYOffset, fZOffset = 0.0;
	int nCount = 0;
	//**TARGETS'S COORDINATION VARIABLES**
	location lTargetLocation = GetLocation(oTarget);
	object oArea = GetAreaFromLocation(lTargetLocation);
	vector vTarget = GetPositionFromLocation(lTargetLocation);

	//**ORIGIN'S COORDINATION VARIABLES**
	location lStartingLocation = GetLocation(oOrigin);
	vector vOrigin = GetPosition(oOrigin);

	//**ARGUEMENT CALCULATION**
	int nIterations = FloatToInt(GetDistanceBetweenLocations(lStartingLocation, lTargetLocation));
	float fDistanceX = (vOrigin.x-vTarget.x)+fXOffset;
	float fDistanceY = (vOrigin.y-vTarget.y)+fYOffset;
	float fDistanceZ = (vOrigin.z-vTarget.z)+fZOffset;
	float fXOffsetValue = (vOrigin.x-vTarget.x)/nIterations;
	float fYOffsetValue = (vOrigin.y-vTarget.y)/nIterations;
	float fZOffsetValue = (vOrigin.z-vTarget.z)/nIterations;
	float fNextXCoordinate = vTarget.x+fDistanceX;
	float fNextYCoordinate = vTarget.y+fDistanceY;
	float fNextZCoordinate = vTarget.z+fDistanceZ;
	vector vNewPosition = Vector(fNextXCoordinate, fNextYCoordinate, fNextZCoordinate);
	location lLocation = Location(oArea, vNewPosition, atan(fYOffsetValue/fXOffsetValue));
	//CreateObject(OBJECT_TYPE_PLACEABLE, sPlaceable, lLocation, TRUE);
	object oTracks = OBJECT_SELF;
	//* Update coordinates
	fXOffset-=fXOffsetValue;
	fYOffset-=fYOffsetValue;
	fZOffset-=fZOffsetValue;
	TraceVFXSequence(sPlaceable, oTarget, oOrigin, fSpeed, fXOffset, fYOffset, fZOffset, nCount, nIterations, oTracks);
	}

void TraceVFXSequence(string sPlaceable, object oTarget, object oOrigin, float fSpeed, float fXOffset, float fYOffset, float fZOffset, int nCount, int nIterations, object oTracks)
	{
	if (GetGlobalInt("waa_debug")>1) {SendMessageToAllDMs("TraceVFXSequence(" + sPlaceable + ", " + GetName(oTarget) + ", " + GetName(oOrigin) + ", " + FloatToString(fSpeed) + ", " + FloatToString(fXOffset) + ", " + FloatToString(fYOffset) + ", " + FloatToString(fZOffset) + ", " + IntToString(nCount) + ", " + IntToString(nIterations) + ", " + GetName(oTracks) + ")");}//Debug
	float fDelay = fSpeed;
	location lStartingLocation = GetLocation(oOrigin);
	object oArea = GetAreaFromLocation(lStartingLocation);
	vector vOrigin = GetPositionFromLocation(lStartingLocation);
	location lTargetLocation = GetLocation(oTarget);
	vector vTarget = GetPosition(oTarget);
	int nIterations = FloatToInt(GetDistanceBetweenLocations(lStartingLocation, lTargetLocation));
	float fDistanceX=(vTarget.x-vOrigin.x)+fXOffset;
	float fDistanceY=(vTarget.y-vOrigin.y)+fYOffset;
	float fDistanceZ=(vTarget.z-vOrigin.z)+fZOffset;
	float fXOffsetValue=(vTarget.x-vOrigin.x)/nIterations;
	float fYOffsetValue=(vTarget.y-vOrigin.y)/nIterations;
	float fZOffsetValue=(vTarget.z-vOrigin.z)/nIterations;
	float fNextXCoordinate=vOrigin.x+fDistanceX;
	float fNextYCoordinate=vOrigin.y+fDistanceY;
	float fNextZCoordinate=vOrigin.z+fDistanceZ;
	vector vNewPosition = Vector(fNextXCoordinate, fNextYCoordinate, fNextZCoordinate);
	location lLocation = Location(oArea, vNewPosition, atan(fYOffsetValue/fXOffsetValue));

	//**UPDATE~COORDINATES**
	fXOffset -= fXOffsetValue;
	fYOffset -= fYOffsetValue;
	fZOffset -= fZOffsetValue;

	//Get new z-axis coord for ground level
	AssignCommand(oTracks, ActionJumpToLocation(lLocation));
	vector vCreatureGround = GetPositionFromLocation(CalcSafeLocation(oTracks, lLocation, 1.f, FALSE, FALSE));
	if (GetGlobalInt("waa_debug")>2) {SendMessageToAllDMs("vCreatureGround( " + FloatToString(vCreatureGround.x) + FloatToString(vCreatureGround.y) + FloatToString(vCreatureGround.z) + ")");}//Debug
	vector vNewPositionGround = Vector(fNextXCoordinate, fNextYCoordinate, vCreatureGround.z);
	if (GetGlobalInt("waa_debug")>2) {SendMessageToAllDMs("vNewPositionGround( " + FloatToString(vNewPositionGround.x) + FloatToString(vNewPositionGround.y) + FloatToString(vNewPositionGround.z) + ")");}//Debug
	location lLocationGround = Location(oArea, vNewPositionGround, atan(fYOffsetValue/fXOffsetValue));
	//effect eDur = EffectNWN2SpecialEffectFile("tracks_canine");
	//eDur = SupernaturalEffect(eDur);
	//ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eDur, lLocationGround, 30.f);
	object oTrack = CreateObject(OBJECT_TYPE_PLACEABLE, sPlaceable, lLocationGround, TRUE, "BodyBag");
	AssignCommand(oTrack, DestroyObject(OBJECT_SELF, 60.f));
	nCount += 1;
	if (GetGlobalInt("waa_debug")>2) {SendMessageToAllDMs("nCount: " + IntToString(nCount));}//Debug

	if(nCount < nIterations)
		{
		DelayCommand(fDelay, TraceVFXSequence(sPlaceable, oTarget, oOrigin, fSpeed, fXOffset, fYOffset, fZOffset, nCount, nIterations, oTracks));
		} else if (nCount >= nIterations)
				{
				if (GetGlobalInt("waa_debug")>2) {SendMessageToAllDMs("nCount >= nIterations");}//Debug
				string sEntrance = GetLocalString(oTarget, "sEntrance");
				object oEntrance = CreateObject(OBJECT_TYPE_PLACEABLE, sEntrance, GetLocation(oOrigin), TRUE, "BodyBag");
				AssignCommand(oEntrance, DestroyObject(OBJECT_SELF, 300.f));
				AssignCommand(oTracks, DestroyObject(oTracks, 1.f));
				return;
				}
	}