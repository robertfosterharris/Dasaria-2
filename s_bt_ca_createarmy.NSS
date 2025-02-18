#include "i_battle_setting"
// -------------------------------------------------------
// Create a new army (Overwrites army with the same name)
//
// sArmy : Army Name
// iFct  : which faction the army belongs to
// iRsrv : how many troops the army has in total
// iLmt	 : how many troops the army can command at one time
//
// e.g. CreateArmy("Enemy", 0, 100, 10); 
// creates an Enemy army with 100 men and attacks in waves of 10
//
// note: must call AddSoldier afterward to add soldier type
// into the army.
void main(string sArmy, int iFct, int iRsrv, int iLmt){
	CreateArmy(sArmy, iFct, iRsrv, iLmt);
}