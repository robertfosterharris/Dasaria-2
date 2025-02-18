// lendol_grove_ambush

#include "dasolm_inc"

void main()
{
	object oPC = GetPCSpeaker();
	int nMeta = getMetaFaction(oPC);
	
	string sGroupName = "lendose_ol_grove_enemies";
	string sArcherTemplate;
	string sSwordsTemplate;
	string sHalberdTemplate;
	
	switch (nMeta)
	{
		case 1:  // i'm varanite, enemy is canite
			sArcherTemplate		= "lndol_3_archer";
			sHalberdTemplate 	= "lndol_3_halberd";
			sSwordsTemplate	 	= "lndol_3_swordsman";	
			
		break;		
		case 2: // i'm rebel,enemy is canite
			sArcherTemplate 	= "lndol_3_archer";
			sHalberdTemplate 	= "lndol_3_halberd";
			sSwordsTemplate 	= "lndol_3_swordsman";
		break;
		
		case 3: // i'm canite, enemy is varanite
			sArcherTemplate 	= "lndol_1_archer";
			sHalberdTemplate 	= "lndol_1_halberd";
			sSwordsTemplate 	= "lndol_1_swordsman";
		break;
		
		default:
			SendMessageToPC(oPC,"Something terrible happened.");
	}
	
	GroupSpawnAtWaypoint(sGroupName,sArcherTemplate,"grove_ambush1",2);
	GroupSpawnAtWaypoint(sGroupName,sSwordsTemplate,"grove_ambush2",2);
	GroupSpawnAtWaypoint(sGroupName,sHalberdTemplate,"grove_ambush3",2);
	GroupSpawnAtWaypoint(sGroupName,sArcherTemplate,"grove_ambush4",3);
	GroupSpawnAtWaypoint(sGroupName,sSwordsTemplate,"grove_ambush5",3);
}