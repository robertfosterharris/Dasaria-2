/* 	Credit: Alhadis
	http://nwn.bioware.com/forums/viewtopic.html?topic=234960&forum=47&sp=135
*/

//* Private function used internally for the PerformActiveVFXStream function. Please do *not*
//use this anywhere else, as potentially strange behaviour could result. Parameters are drawn from
//the master PerformActiveVFXStream function, and this was *never* intended to be used anywhere else
//outside the aforementioned function.
void TraceVFXSequence(int nVFX, object oOrigin, object oTarget, float fSpeed, float fXOffset, float fYOffset, float fZOffset, int nCount, int nIterations);

//* Creates a dynamic VFX-column that streaks from the specified origin towards the targeted
//creature's position. Very expensive on NWN's graphic engine, so please try and keep nVFXType
//simple and instantaneous (e.g., "Personal Impact" VFX are ideal choices, but having massive,
//explosive "Fire and Forget" animations will likely overload NWN's graphics).
// - nVFXType: VFX_* [Only use DURATION_TYPE_INSTANT visual effects]
// - fSpeed: Estimated velocity of the VFX column. This parameter's name is misleading, as
// higher values mean greater delay between iterations. Essentially, the fSpeed value is the
// approximate delay between individual iterations, so an fSpeed value of 0.0 would mean streaking
// towards oTarget instantly, while a 1.0f value would mean a slower acceleration rate.
void PerformActiveVFXStream(int nVFXType, object oTarget, object oOrigin, float fSpeed=0.5f);

void main(string sTrackTag)
{
	object oPC 		= GetPCSpeaker();
	object oTarget 	= GetObjectByTag(sTrackTag);	
	PerformActiveVFXStream(VFX_HIT_SPELL_DIVINATION, oTarget, oPC, 0.25f);
}

void PerformActiveVFXStream(int nVFXType, object oTarget, object oOrigin, float fSpeed=0.05f)
{
	float fXOffset, fYOffset, fZOffset = 0.0;
	effect eVFXSequence = EffectVisualEffect(nVFXType);
	int nCount = 0; 
	float fDelay;   
	
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
	location lLocation = Location(oArea, vNewPosition, 0.0);
	ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFXSequence, lLocation);
	DelayCommand(fDelay, TraceVFXSequence(nVFXType, oTarget, oOrigin, fSpeed, fXOffset, fYOffset, fZOffset, nCount, nIterations));
	fDelay+=fSpeed; //* Update coordinates
	fXOffset-=fXOffsetValue;
	fYOffset-=fYOffsetValue;
	fZOffset-=fZOffsetValue;}
	void TraceVFXSequence(int nVFX, object oOrigin, object oTarget, float fSpeed, float fXOffset, float fYOffset, float fZOffset, int nCount, int nIterations)
	{float fDelay = fSpeed;
	effect eVFXSequence = EffectVisualEffect(nVFX);
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
	location lLocation = Location(oArea, vNewPosition, 0.0);
	
	//**UPDATE~COORDINATES**
	fXOffset -= fXOffsetValue;
	fYOffset -= fYOffsetValue;
	fZOffset -= fZOffsetValue;
	ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFXSequence, lLocation);
	nCount += 1;
	if(nCount < nIterations)
		{DelayCommand(fDelay, TraceVFXSequence(nVFX, oOrigin, oTarget, fSpeed, fXOffset, fYOffset, fZOffset, nCount, nIterations));}
	else if (nCount >= nIterations) return;
}