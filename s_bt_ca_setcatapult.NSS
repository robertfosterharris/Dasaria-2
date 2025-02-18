#include "i_battle_setting"

// Setup Catapult for sArmy
// put 0 in everything to cancel
//
// iF : Cool Down time (in rounds)
// iN : No of projectile
// iD : Damage (how many d6)
// iDC: Save DC
void main(string sArmy, int iF, int iN, int iD, int iDC){
	if( iN > 0 ){
		SetCatapult(sArmy, iF, iN, iD, iDC);
	}else{
		// 0 Projectile is as good as no catapult
		DeleteCatapult(sArmy);
	}
}