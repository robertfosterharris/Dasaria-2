/*
	11/13/06	RFH		CHANGED GETEXITINGOBJECT TO GETENTERINGOBJECT
						CHANGED CONDITIONAL != True instead of == 0
    04/29/07    RFH     DON'T SWEEP - SWEEP ONLY ON AREA EXIT
	03/14/08	RFH		ADDED RAIN CODE
	10/03/09	Wired	Remove orphaned effects
	08/04/10	Wired	Vampire Dayligt Penalties	
		
*/

#include "j4acs_uglyhack"
#include "ginc_effect_util"
#include "ginc_lycan"


void main()
{
	int nRainPower;
	int nRainTrack;
	int nRainTrackVolume;
	object oArea;
	object oObject;
	object oPC;
	object oJournal;
	
	oArea = OBJECT_SELF;
	oPC = GetEnteringObject();
	if (GetIsPC(oPC))
	{
		if (GetLocalInt(oArea, "j4acs_init") != TRUE)
		{
			ugly_area_init(oArea );
			SetLocalInt(oArea, "j4acs_init", TRUE);			
		}
		
		SetLocalInt(oArea, "bAreaEmpty", FALSE);
		
		//	UNDO BUFFBOTS
		if (!GetIsDM(oPC)) RemoveOrphanedEffects( oPC );
		
		// VAMPIRE DAYLIGHT PENALTY ADD / REMOVE
		int nLycan = GetLocalInt(std_journal_get(oPC),"nLycan");
		if ( nLycan == 3) 
		{
			VampPenalty(oPC,oArea);
		}
		
//	
//	TRANSITION TESTING CODE
//
		if (!GetIsDM(oPC))
		{
			SetLocalString(oPC, "LastEntry", GetName(oArea));
			SetLocalInt(oPC, "TransitionState", 2);
		}			
//
//	PLAY GLOBAL WEATHER EFFECTS FOR OUTDOOR / ABOVE GROUND AREAS
//
		nRainPower = GetLocalInt(GetModule(), "raining");
		if (!GetIsAreaInterior(oArea) && GetIsAreaAboveGround(oArea) && GetLocalInt(oArea, "bNoRain") == 0 && nRainPower > 0)
		{
			if (nRainPower == 6) nRainPower = 0;	// TURNED OFF MANUALLY
			switch(nRainPower)
			{
				case 0: nRainTrack = 0; break;		// NO AMBIENT SOUNDS
				case 1: nRainTrack = 135; break;	// al_n2_weather03	RAIN
				case 2: nRainTrack = 135; break;	// al_n2_weather03	RAIN
  				case 3: nRainTrack = 135; break;	// al_n2_weather03	RAIN
				case 4: nRainTrack = 134; break;	// al_n2_weather02	THUNDERSTORM
				case 5: nRainTrack = 134; break;	// al_n2_weather02	THUNDERSTORM
			}
			SetWeather(oArea, WEATHER_TYPE_RAIN, nRainPower);
			nRainTrackVolume = nRainPower * 10;
			AmbientSoundChangeDay(oArea,nRainTrack);
	  		AmbientSoundSetDayVolume(oArea,nRainTrackVolume);
 			AmbientSoundChangeNight(oArea,nRainTrack);
			AmbientSoundSetNightVolume(oArea,nRainTrackVolume);
			AmbientSoundPlay(oArea);
		}	
	}	
}