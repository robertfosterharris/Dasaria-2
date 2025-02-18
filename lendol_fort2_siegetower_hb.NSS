// lendol_fort2_siegetower_hb

#include "dasolm_inc"


void main()
{
	//int nEvent = GetUserDefinedEventNumber();
	object oPC = GetFirstPC();
	
	//switch( nEvent )
	//{
		//case EVENT_HEARTBEAT:
		//{
			if (bDEBUG == TRUE) SendMessageToPC(oPC,GetTag(OBJECT_SELF)+" is having a heartbeat.");				
			string sGroupName = "lendose_ol_fort_enemies";
			object oDest = GetObjectByTag("POST_"+GetTag(OBJECT_SELF));
			string sSpawn =	GetLocalString(OBJECT_SELF,"sSpawn");
			int nSpawned = GetLocalInt(OBJECT_SELF,"nSpawned");
			int nTick = GetLocalInt(OBJECT_SELF, "tick");
			int nMax = 6;
			int nArrived = GetLocalInt(OBJECT_SELF,"nArrived");
			float fDest;
		
			if (nArrived == 0)
			{
				fDest = GetDistanceToObject(oDest);
				if (fDest >= 1.0f)
				{
					if (bDEBUG == TRUE) SendMessageToPC(oPC,GetTag(OBJECT_SELF)+" is "+FloatToString(fDest)+" away from its post and is moving there.");	
					ActionMoveToObject(oDest,TRUE,0.25f);
				}
				else
				{
					if (bDEBUG == TRUE) SendMessageToPC(oPC,GetTag(OBJECT_SELF)+" has reached its destination and is immobilzing itself");
					SetLocalInt(OBJECT_SELF,"nArrived",1);
					SetOrientOnDialog(OBJECT_SELF, FALSE);
					ClearAllActions(TRUE);
					ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectCutsceneImmobilize(),OBJECT_SELF);
					SetCommandable(FALSE,OBJECT_SELF);
				}
			}
			
			if (nArrived == 1)
			{		
				SetLocalInt(OBJECT_SELF, "tick", nTick + 1);
				if (bDEBUG == TRUE) SendMessageToPC(oPC,GetTag(OBJECT_SELF)+" tick is "+IntToString(nTick));
				if (nTick % 5 == 0)				//	EVERY 5 ROUNDS (30 SECONDS)
				{	
					nSpawned++;
					if (bDEBUG == TRUE) SendMessageToPC(oPC,GetTag(OBJECT_SELF)+" is spawning #"+IntToString(nSpawned));
					SetLocalInt(OBJECT_SELF,"nSpawned",nSpawned);
					GroupSpawnAtWaypoint(sGroupName,sSpawn,GetTag(OBJECT_SELF)+"_board",1);
					//GroupOnDeathExecuteCustomScript(sGroupName,"lendol_fort2_siege_end");
				}
				
				if (nSpawned == nMax)
				{
					if (bDEBUG == TRUE) SendMessageToPC(oPC,GetTag(OBJECT_SELF)+" has reached the maximum # of spawns and will now destroy itself.");
					ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDeath(),OBJECT_SELF);
				}
			}
		//}heartbeat
	//}switch
}