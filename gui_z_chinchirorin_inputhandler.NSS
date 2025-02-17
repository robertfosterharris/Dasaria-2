// Black Rain 2008

#include "z_chinchirorin_include"


void main ( string sInput, string sDealerTag ) {
	int i, iBetIncrementLocal, iMaxBetLocal, iMinBetLocal;
	object oHandler, oDealer, oPC;
	string s, sTotalFrames;
	
	oDealer = GetObjectByTag(sDealerTag);
	oPC = GetLocalObject ( oDealer, "oPlayer" );

	if ( sInput == "start" ) {
		if ( GetGold(oPC) >= ( GetLocalInt ( oDealer, "iCurrentBet" ) * 3 ) ) {
			// clear old messages and rolls
			sTotalFrames = IntToString(iTotalFrames);
			SetGUIObjectHidden ( oPC, "br_chinchirorin", "chinchirorin_notice", TRUE );		
			SetGUIObjectHidden ( oPC, "br_chinchirorin", "chinchirorin_1_" + sTotalFrames + "a", TRUE );
			SetGUIObjectHidden ( oPC, "br_chinchirorin", "chinchirorin_2_" + sTotalFrames + "a", TRUE );
			SetGUIObjectHidden ( oPC, "br_chinchirorin", "chinchirorin_3_" + sTotalFrames + "a", TRUE );
			SetGUIObjectHidden ( oPC, "br_chinchirorin", "chinchirorin_1_frame", TRUE );
			SetGUIObjectHidden ( oPC, "br_chinchirorin", "chinchirorin_2_frame", TRUE );
			SetGUIObjectHidden ( oPC, "br_chinchirorin", "chinchirorin_3_frame", TRUE );		
			
			// disable buttons
			SetGUIObjectDisabled ( oPC, "br_chinchirorin", "chinchirorin_start", TRUE );
			SetGUIObjectDisabled ( oPC, "br_chinchirorin", "chinchirorin_rules", TRUE );			
			SetGUIObjectDisabled ( oPC, "br_chinchirorin", "chinchirorin_quit", TRUE );
			SetGUIObjectDisabled ( oPC, "br_chinchirorin", "chinchirorin_plus", TRUE );		
			SetGUIObjectDisabled ( oPC, "br_chinchirorin", "chinchirorin_minus", TRUE );			
				
			// start a round			
			SetLocalInt ( oDealer, "iScore", 0 );
			SetLocalInt ( oDealer, "iRound", 1 );
			SetLocalInt ( oDealer, "iInPlay", 1 );			
			SetupRoll(oDealer);
		} else {
			SetGUIObjectText ( oPC, "br_chinchirorin", "chinchirorin_notice", -1, "You do not have enough gold to cover this wager" );
			SetGUIObjectHidden ( oPC, "br_chinchirorin", "chinchirorin_notice", FALSE );
		}	
	} else if ( sInput == "roll" ) {
		// clear old messages and rolls
		sTotalFrames = IntToString(iTotalFrames);		
		SetGUIObjectHidden ( oPC, "br_chinchirorin", "chinchirorin_notice", TRUE );		
		SetGUIObjectHidden ( oPC, "br_chinchirorin", "chinchirorin_1_" + sTotalFrames + "a", TRUE );
		SetGUIObjectHidden ( oPC, "br_chinchirorin", "chinchirorin_2_" + sTotalFrames + "a", TRUE );
		SetGUIObjectHidden ( oPC, "br_chinchirorin", "chinchirorin_3_" + sTotalFrames + "a", TRUE );	
		SetGUIObjectHidden ( oPC, "br_chinchirorin", "chinchirorin_1_frame", TRUE );
		SetGUIObjectHidden ( oPC, "br_chinchirorin", "chinchirorin_2_frame", TRUE );
		SetGUIObjectHidden ( oPC, "br_chinchirorin", "chinchirorin_3_frame", TRUE );		
				
		// disable roll button
		SetGUIObjectDisabled ( oPC, "br_chinchirorin", "chinchirorin_roll", TRUE );
		
		// roll lock for idle timer
		SetLocalInt ( oDealer, "iInRoll", 1 );
						
		SetupRoll(oDealer);
	} else if ( sInput == "quit" ) {	
		SetCasinoStatsArrayPlayerStat ( oPC, "Chinchirorin", "Win", GetLocalInt ( oDealer, "iPlayerGoldWon" ) );
		SetCasinoStatsArrayPlayerStat ( oPC, "Chinchirorin", "Lose", GetLocalInt ( oDealer, "iPlayerGoldLost" ) );
		SetCasinoStatsArrayPlayerStat ( oPC, "Chinchirorin", "Time", GetPlayerTimePlayed ( oDealer, 1 ) );
				
		// release dealer and hide timer pane
		SetLocalInt ( oDealer, "iDealerBusy", 0 );
		SetGUIObjectHidden ( oPC, "br_chinchirorin", "timerpane", TRUE );	
			
		// clear old messages and rolls
		sTotalFrames = IntToString(iTotalFrames);		
		SetGUIObjectHidden ( oPC, "br_chinchirorin", "chinchirorin_notice", TRUE );		
		SetGUIObjectHidden ( oPC, "br_chinchirorin", "chinchirorin_1_" + sTotalFrames + "a", TRUE );
		SetGUIObjectHidden ( oPC, "br_chinchirorin", "chinchirorin_2_" + sTotalFrames + "a", TRUE );
		SetGUIObjectHidden ( oPC, "br_chinchirorin", "chinchirorin_3_" + sTotalFrames + "a", TRUE );
		SetGUIObjectHidden ( oPC, "br_chinchirorin", "chinchirorin_1_frame", TRUE );
		SetGUIObjectHidden ( oPC, "br_chinchirorin", "chinchirorin_2_frame", TRUE );
		SetGUIObjectHidden ( oPC, "br_chinchirorin", "chinchirorin_3_frame", TRUE );			
	
		CloseGUIScreen ( oPC, "br_chinchirorin" );
	} else if ( sInput == "plus" ) {
		if ( GetLocalInt ( oDealer, "iBetIncrementLock" ) == 1 ) {
			return;
		}
		SetLocalInt ( oDealer, "iBetIncrementLock", 1 );
		DelayCommand ( 0.02, SetLocalInt ( oDealer, "iBetIncrementLock", 0 ) );
			
		// clear old messages and rolls
		sTotalFrames = IntToString(iTotalFrames);		
		SetGUIObjectHidden ( oPC, "br_chinchirorin", "chinchirorin_notice", TRUE );		
		SetGUIObjectHidden ( oPC, "br_chinchirorin", "chinchirorin_1_" + sTotalFrames + "a", TRUE );
		SetGUIObjectHidden ( oPC, "br_chinchirorin", "chinchirorin_2_" + sTotalFrames + "a", TRUE );
		SetGUIObjectHidden ( oPC, "br_chinchirorin", "chinchirorin_3_" + sTotalFrames + "a", TRUE );
		SetGUIObjectHidden ( oPC, "br_chinchirorin", "chinchirorin_1_frame", TRUE );
		SetGUIObjectHidden ( oPC, "br_chinchirorin", "chinchirorin_2_frame", TRUE );
		SetGUIObjectHidden ( oPC, "br_chinchirorin", "chinchirorin_3_frame", TRUE );			
		
		// check for local override on max bet and increment
		iMaxBetLocal = GetLocalInt ( oDealer, "iMaxBet" );
		if ( iMaxBetLocal == 0 ) {
			iMaxBetLocal = iMaxBet;
		}
		iBetIncrementLocal = GetLocalInt ( oDealer, "iBetIncrement" );
		if ( iBetIncrementLocal == 0 ) {
			iBetIncrementLocal = iBetIncrement;
		}
				
		// check and increase bet if applicable			
		i = GetLocalInt ( oDealer, "iCurrentBet" );			
		if ( i < iMaxBetLocal ) {
			i = i + iBetIncrementLocal;
			SetLocalInt ( oDealer, "iCurrentBet", i );
			SetGUIObjectText ( oPC, "br_chinchirorin", "chinchirorin_bet", -1, IntToString(i) );
		}			
	} else if ( sInput == "minus" ) {
		if ( GetLocalInt ( oDealer, "iBetIncrementLock" ) == 1 ) {
			return;
		}
		SetLocalInt ( oDealer, "iBetIncrementLock", 1 );
		DelayCommand ( 0.02, SetLocalInt ( oDealer, "iBetIncrementLock", 0 ) );
			
		// clear old messages and rolls
		sTotalFrames = IntToString(iTotalFrames);		
		SetGUIObjectHidden ( oPC, "br_chinchirorin", "chinchirorin_notice", TRUE );		
		SetGUIObjectHidden ( oPC, "br_chinchirorin", "chinchirorin_1_" + sTotalFrames + "a", TRUE );
		SetGUIObjectHidden ( oPC, "br_chinchirorin", "chinchirorin_2_" + sTotalFrames + "a", TRUE );
		SetGUIObjectHidden ( oPC, "br_chinchirorin", "chinchirorin_3_" + sTotalFrames + "a", TRUE );
		SetGUIObjectHidden ( oPC, "br_chinchirorin", "chinchirorin_1_frame", TRUE );
		SetGUIObjectHidden ( oPC, "br_chinchirorin", "chinchirorin_2_frame", TRUE );
		SetGUIObjectHidden ( oPC, "br_chinchirorin", "chinchirorin_3_frame", TRUE );		
		
		// check for local override on min bet and increment
		iMinBetLocal = GetLocalInt ( oDealer, "iMinBet" );
		if ( iMinBetLocal == 0 ) {
			iMinBetLocal = iMinBet;
		}
		iBetIncrementLocal = GetLocalInt ( oDealer, "iBetIncrement" );
		if ( iBetIncrementLocal == 0 ) {
			iBetIncrementLocal = iBetIncrement;
		}		
		
		// check and decrease bet if applicable		
		i = GetLocalInt ( oDealer, "iCurrentBet" );
		if ( i > iMinBetLocal ) {
			i = i - iBetIncrementLocal;
			SetLocalInt ( oDealer, "iCurrentBet", i );
			SetGUIObjectText ( oPC, "br_chinchirorin", "chinchirorin_bet", -1, IntToString(i) );
		}	
	} else if ( sInput == "rules" ) {
		// disable buttons
		SetGUIObjectDisabled ( oPC, "br_chinchirorin", "chinchirorin_start", TRUE );
		SetGUIObjectDisabled ( oPC, "br_chinchirorin", "chinchirorin_rules", TRUE );
		SetGUIObjectDisabled ( oPC, "br_chinchirorin", "chinchirorin_quit", TRUE );		
		SetGUIObjectDisabled ( oPC, "br_chinchirorin", "chinchirorin_plus", TRUE );		
		SetGUIObjectDisabled ( oPC, "br_chinchirorin", "chinchirorin_minus", TRUE );			
		
		// set up rules text
		i = GetLocalInt ( oDealer, "iStraightRatio" );
		if ( i == 0 ) {
			i = iStraightRatio;
		}
		s = IntToString(i);
		SetGUIObjectText ( oPC, "br_chinchirorin", "chinchirorin_lowstraight", -1, "- 1-2-3 low straight: lose " + s + "X wager" );
		SetGUIObjectText ( oPC, "br_chinchirorin", "chinchirorin_highstraight", -1, "- 4-5-6 high straight: win " + s + "X wager" );	

		i = GetLocalInt ( oDealer, "iTripleRatio" );
		if ( i == 0 ) {
			i = iTripleRatio;
		}
		s = IntToString(i);
		SetGUIObjectText ( oPC, "br_chinchirorin", "chinchirorin_lowtriple", -1, "- 1-1-1 triple: lose " + s + "X wager" );
		SetGUIObjectText ( oPC, "br_chinchirorin", "chinchirorin_hightriple", -1, "- Any other triple: win " + s + "X wager" );
						
		// show rules pane
		SetGUIObjectHidden ( oPC, "br_chinchirorin", "chinchirorin_rulespane", FALSE );	
	} else if ( sInput == "rules_close" ) {
		// enable buttons
		SetGUIObjectDisabled ( oPC, "br_chinchirorin", "chinchirorin_start", FALSE );
		SetGUIObjectDisabled ( oPC, "br_chinchirorin", "chinchirorin_rules", FALSE );
		SetGUIObjectDisabled ( oPC, "br_chinchirorin", "chinchirorin_quit", FALSE );		
		SetGUIObjectDisabled ( oPC, "br_chinchirorin", "chinchirorin_plus", FALSE );		
		SetGUIObjectDisabled ( oPC, "br_chinchirorin", "chinchirorin_minus", FALSE );	
	
		// hide rules pane
		SetGUIObjectHidden ( oPC, "br_chinchirorin", "chinchirorin_rulespane", TRUE );							
	}
}