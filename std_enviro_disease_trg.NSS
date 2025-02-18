/*
*/


#include "std_i0_time"


string kType = "config_type";
string kRespawn = "config_respawn";



void	main()
	{
	object oTrigger = OBJECT_SELF;
	object oPC = GetEnteringObject();
	
	if (!GetIsPC(oPC) ) return;
	
	// Set key for per-player "respawn"
	string concat = GetFirstName(oPC) + GetLastName(oPC);
	string key = "pctimer_" + concat;

	
	// time is hard coded for now.  3 hours
	int elapsed = time_stamp_elapsed( oTrigger, key );
	if ( elapsed < 3 )
		return;	
	time_stamp_set( oTrigger, key);	
	
	
	// This sucks, but whatever
	int nType = -1;	
	string sType = GetLocalString(oTrigger, kType);
	if (sType =="filth fever")
		nType = DISEASE_FILTH_FEVER;
	if (sType =="vermin madness")
		nType = DISEASE_VERMIN_MADNESS;		
	if (sType =="burrow maggots")
		nType = DISEASE_BURROW_MAGGOTS;		
	if ( nType == -1 )
		{
		// Panic: invalid disease
		return;
		}
	
	// Announce disease number
	//SendMessageToPC( oPC, "You got: " + IntToString(nType) );
			
	// Apply effect and visual
	effect eDisease = EffectDisease(nType);
	effect eHit = EffectVisualEffect( VFX_DUR_SPELL_CONTAGION );
	eDisease = EffectLinkEffects( eDisease, eHit );
	//ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDisease, oPC);
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eDisease, oPC);

	
	
	}
	
/*
int DISEASE_BLINDING_SICKNESS            = 0;
int DISEASE_CACKLE_FEVER                 = 1;
int DISEASE_DEVIL_CHILLS                 = 2;
int DISEASE_DEMON_FEVER                  = 3;
//int DISEASE_FILTH_FEVER                  = 4;
int DISEASE_MINDFIRE                     = 5;
int DISEASE_MUMMY_ROT                    = 6;
int DISEASE_RED_ACHE                     = 7;
int DISEASE_SHAKES                       = 8;
int DISEASE_SLIMY_DOOM                   = 9;
int DISEASE_RED_SLAAD_EGGS               = 10;
int DISEASE_GHOUL_ROT                    = 11;
int DISEASE_ZOMBIE_CREEP                 = 12;
int DISEASE_DREAD_BLISTERS               = 13;
//int DISEASE_BURROW_MAGGOTS               = 14;
int DISEASE_SOLDIER_SHAKES               = 15;
////int DISEASE_VERMIN_MADNESS               = 16;
*/