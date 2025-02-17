// i_wand_olm_hench_ac
//
/*
	Use this on a player to grant them free henchmen according to the Dasaria OLM rules.
	If the player does not belong to a metafaction, the wand will default to granting
	them Varanite henchmen.
	
	This isn't sophisticated at all, it just gives them max henchmen
	
	NOTE: Henchmen join the player's faction.  So if this is used
	outside the OLM area, ALL the henchment will be of the 'player' group and won't 
	auto-attack eachother unless directed to do so by a player.
*/

#include "dasolm_inc"
#include "x0_i0_position"


void WandSpecialSpawnAllies(object oPC);

void main()
{
	if (!GetIsDM(GetItemActivator())) return;
	
	object oPC			= GetItemActivatedTarget();
	WandSpecialSpawnAllies(oPC);	
}

void WandSpecialSpawnAllies(object oPC)
{
	if (!GetIsObjectValid(oPC) || !GetIsPC(oPC) ) return;
	
	int nSoldiersNum 	= DasOL_GetMaxAllies(oPC);
	int nMetaFaction 	= getMetaFaction(oPC);
	
	int nCount; 
	int nSwordC=0; 
	int nArchC=0;
	int nHalbC=0;	
	int nDefaultHenchmen;
	string sRef;
	string sMetaFaction;
	int nSwords; 
	int nArchers; 
	int nHalberds;
	float fDelSpawn;
	object oHench;
	
	if (nMetaFaction < 1) { nMetaFaction = 1; }	// default to Varanite
	sMetaFaction = IntToString(nMetaFaction);

	SetLocalInt(oPC,"LendOL_Soldiers",nSoldiersNum);
		
	nSwords = FloatToInt(IntToFloat(nSoldiersNum) * 0.5); //50% swordsmen
	nArchers = FloatToInt(IntToFloat(nSoldiersNum) * 0.3); //30% archers
	nHalberds = FloatToInt(IntToFloat(nSoldiersNum) * 0.2); //20% polearms
	
	if (bDEBUG)
	{
		SendMessageToPC(oPC,IntToString(nSoldiersNum)+" soliders: "
			+IntToString(nSwords)+ " swords, "
			+IntToString(nArchers)+ " archers, "
			+IntToString(nHalberds)+ " halberds.");
	}
	
	while (nCount < nSoldiersNum)
	{
		if (nSwordC < nSwords)
		{
			sRef = "lndol_"+sMetaFaction+"_swordsman";
			nSwordC++;
			fDelSpawn = 0.5;
		}
		else if (nArchC < nArchers)
		{
			sRef = "lndol_"+sMetaFaction+"_archer";
			nArchC++;
			fDelSpawn = 1.0;
		}
		else 
		{
			sRef = "lndol_"+sMetaFaction+"_halberd";		
			fDelSpawn = 1.5;
		}
	
		oHench = CreateObject(OBJECT_TYPE_CREATURE,sRef,CalcSafeLocation(oPC,GetBehindLocation(oPC),3.0f,FALSE,FALSE));
		SetMaxHenchmen(18);
		HenchmanAdd(oPC,oHench,TRUE,TRUE);
		SetLocalObject(oHench,"oMaster",oPC);
		SetAssociateState(NW_ASC_MODE_STAND_GROUND,TRUE,oHench);
		
		nCount++;
	}	
}