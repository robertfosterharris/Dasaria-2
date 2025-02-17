//
//	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM	1/09/2007
//
//	GUARDS SPAWN IN A SPECIFIED LOCATIONS AND WALK TO ALARM.
//
//	STRING SPAWNPOINT = TAG OF THE WAYPOINTS WHERE THE GUARD SHOULD SPAWN IN.
//	STRING GUARDTAG = RESREF OF THE GUARD TO SPAWN IN.
//	STRING SOUNDFILE = NAME OF ALARM SOUND TO PLAY.
//	STRING MESSAGE = MESSAGE TO DISPLAY WHEN ALARM IS SOUNDED.
//	FLOAT TIMEOUT = RESPAWN TIMEOUT IN SECONDS.
//	STING TIMEOUTMESSAGE = MESSAGE TO PLAY WHILE IN TIMEOUT.
//
void main()
{
	int iSub;
	object oAlarm;
	object oGuard;
	object oPC;
	object oSpawnPoint;
	string sGuard;
	string sSpawnPoint;
	
	oAlarm = OBJECT_SELF;
	oPC = GetLastUsedBy();
	
	if (!GetLocalInt(OBJECT_SELF, "Triggered"))
	{
		SetLocalInt(OBJECT_SELF, "Triggered", TRUE);
		sSpawnPoint = GetLocalString(OBJECT_SELF, "SpawnPoint");
		sGuard = GetLocalString(OBJECT_SELF, "GuardTag");
		iSub = 0;

		oSpawnPoint = GetObjectByTag(sSpawnPoint, iSub);
		while(GetIsObjectValid(oSpawnPoint))
		{
			oGuard = CreateObject(OBJECT_TYPE_CREATURE, sGuard, GetLocation(oSpawnPoint));
			if (GetIsObjectValid(oGuard)) AssignCommand(oGuard, ActionForceMoveToObject(oAlarm));
			oSpawnPoint = GetObjectByTag(sSpawnPoint, ++iSub);
		}

		FloatingTextStringOnCreature(GetLocalString(OBJECT_SELF, "Message"), oPC);
		PlaySound(GetLocalString(OBJECT_SELF, "SoundFile"));
		DelayCommand(GetLocalFloat(OBJECT_SELF, "Timeout"), SetLocalInt(OBJECT_SELF, "Triggered", FALSE));
	}
	else
	{	
		FloatingTextStringOnCreature(GetLocalString(OBJECT_SELF, "TimeoutMessage"), oPC);
	}		
}