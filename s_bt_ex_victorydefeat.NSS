#include "i_battle_setting"

// Victory/Defeat 
// Edit this script to change victory and defeat conditions
void main(){
	
	object oPC = GetFirstPC(FALSE);
	
	// Victory Conditions here
	if( GetIsAnnihilated(oPC, REPUTATION_TYPE_ENEMY) ){
		// Victory Actions
		ShowBattleStat(oPC, "Victory"); //shows a report
		SetBattleActive(FALSE); //set battle inactive
	}
	
	// Defeat Conditions here
	if( GetIsAnnihilated(oPC, REPUTATION_TYPE_FRIEND)
	&&  GetIsAnnihilated(oPC, REPUTATION_TYPE_NEUTRAL) ){
		// Defeat Actions
		ShowBattleStat(oPC, "Defeat"); //shows a report
		SetBattleActive(FALSE); //set battle inactive
	}
}