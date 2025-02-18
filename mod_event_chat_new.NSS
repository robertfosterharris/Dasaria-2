//const int DMFI_PCLANGUAGES_ENABLED = TRUE;	set to FALSE in dmfi_inc_const
//dmfi_inc_langexe - DMFI_BuildChoosenList edited

//28-8-12 temp change to line 45 set iLNG_MOD_ActiveChatOn to true permanently...
#include "ginc_chat_funct"


//Main Function
int StartingConditional(object oSender, object oTarget, int nChannel, string sMessage)
{

	////DECLEAR VARS////
	object oJournal, oVoiceThrowTarget;
	
	//Mod vars
	int iLNG_MOD_ActiveChatOn, iLNG_MOD_PartyChatOff, iLNG_MOD_EmotesOn;

	//oJournal & oPC vars
	int iLNG_DM_ActiveChatOn, iLNG_DM_PartyChatOff, iLNG_PC_EmotesOn;	
	int iLanguageVerbal, iLanguageSpoken, iLanguageFeatInUse, iLanguageNowSpokenSID, iDefaultLanguage;
	
	string sLNG_PC_FontStart, sLNG_PC_FontEnd;
	string sLNG_PC_EmoteSymbolStart, sLNG_PC_EmoteSymbolEnd;
	string sTellFix;
	//Function vars
	int iSendChatMessage; //used to control SendMessage
	int iIsStaffDM , iIsStoryDM, iIsStaff; //Determines privilages
	int iChannel_To_Use;
	int iCheck_oJournal;
	int iIs_PC_Silenced;
	int iShowFloat;
	float fMax_Channel_Range;
		
	string sChatCommandSymbol, sNewMessage, sShowFloat;

	//// ?WHO IS USING CHAT? ////

	iIsStaffDM = GetIsStaffDM(oSender);
	iIsStoryDM = GetIsStoryDM(oSender);
	iIsStaff = GetIsStaff(oSender);

	//// !Get Module Vars! ////
	
	iLNG_MOD_PartyChatOff = GetLocalInt(GetModule(),MOD_LNG_SUPRESS_PARTY_CHAT);

//9/912 remove	iLNG_MOD_ActiveChatOn = GetLocalInt(GetModule(),MOD_LNG_ACTIVE_CHAT);
	iLNG_MOD_ActiveChatOn = TRUE;

	//emotes to come
	iLNG_MOD_EmotesOn = GetLocalInt(GetModule(),MOD_LNG_ACTIVE_EMOTE);
	
		
	//// !BASIC CHECKS! ////
	
	//Break flag, once this set to FALSE the rest of the code sections isn't processed
	iSendChatMessage = TRUE;


	//"Clean up" sMessage - prune any white space and start and end of string
	sNewMessage = StringTrim(sMessage);
	
	//Get the first two characters from sMessage, used for commands and ventriloquism checks
	//(convert the substring to lowercase to keep checks simple
	sChatCommandSymbol = GetStringLowerCase(GetSubString(sNewMessage, 0, 2));


	
	//// !CHAT COMMAND CODE! ////
	// Fires First
	
	if ( GetSubString(sChatCommandSymbol, 0, 1) == CHAT_COMMAND_SYMBOL && iSendChatMessage == TRUE)
	{
		iSendChatMessage = FALSE;
		Dasaria2_Chat_Commands( oSender, oTarget, nChannel, sNewMessage, iIsStaffDM , iIsStoryDM, iIsStaff);
	}

	//// !OCC Check! ////
	// Just color the text orange and send on the selected channel 
	

	if(FindSubString(sNewMessage, CHAT_OOC_SYMBOL1)!=-1 && iSendChatMessage == TRUE || FindSubString(sNewMessage, CHAT_OOC_SYMBOL2)!=-1  && iSendChatMessage == TRUE || FindSubString(sNewMessage, CHAT_OOC_SYMBOL3)!=-1  && iSendChatMessage == TRUE || FindSubString(sNewMessage, CHAT_OOC_SYMBOL4)!=-1  && iSendChatMessage == TRUE )
	{	
		iSendChatMessage = FALSE;	
				
		if(GetIsDM(oSender)  && nChannel == CHAT_MODE_TELL || GetIsDMPossessed(oSender) && nChannel == CHAT_MODE_TELL)
		{
			sTellFix = CLR_SERVER + GetName(oSender) + " : " + CLR_END + CLR_TELL + " [Tell] " + CLR_OOC + sMessage + CLR_END;
//9/9/12			SendChatMessage(OBJECT_INVALID, oTarget, CHAT_MODE_SERVER, sTellFix);
			SendChatMessage(oSender, oTarget, CHAT_MODE_TELL, sTellFix);								
		}
		
		SendChatMessage(oSender,oTarget, nChannel, CLR_OOC + sNewMessage + CLR_END );
		
		SendOOCChatToDMs(oSender, sNewMessage, nChannel, iLNG_MOD_ActiveChatOn );

	}

	

	
	//// !Get oJournal Vars! ////
	
	//If this is false then check oJournal for values else they are stored on oPC
	//(only checked if oPC !oDM)
	oJournal = std_journal_get( oSender );	
	iCheck_oJournal = GetLocalInt(oSender, GET_LNG_VARS);

	if(!iCheck_oJournal)
	{
		
		sLNG_PC_EmoteSymbolStart = GetLocalString(oJournal, CHAT_MY_EMO_PREFIX);
		if(sLNG_PC_EmoteSymbolStart==""){sLNG_PC_EmoteSymbolStart = CHAT_EMOTE_SYMBOL;}
		sLNG_PC_EmoteSymbolEnd = GetLocalString(oJournal, CHAT_MY_EMO_SUFFIX);
		if(sLNG_PC_EmoteSymbolEnd==""){sLNG_PC_EmoteSymbolEnd = CHAT_EMOTE_SYMBOL;}
		sLNG_PC_FontStart = GetLocalString(oJournal, CHAT_MY_CHAT_SUFFIX);
		iLNG_PC_EmotesOn = GetLocalInt(oJournal, PC_EMOTE_VERBAL_OFF);

		//Then Set on oPC
		
		SetLocalString(oSender, CHAT_MY_EMO_PREFIX, sLNG_PC_EmoteSymbolStart);
		SetLocalString(oSender, CHAT_MY_EMO_SUFFIX, sLNG_PC_EmoteSymbolEnd);
		SetLocalString(oSender, CHAT_MY_CHAT_SUFFIX, sLNG_PC_FontStart);
		SetLocalInt(oSender, PC_EMOTE_VERBAL_OFF, iLNG_PC_EmotesOn);

		SetLocalInt(oSender, GET_LNG_VARS, TRUE);
	}
	
	////!Get oPC vars!////
	
	iLanguageVerbal = GetLocalInt(oSender, LANG_SPOKEN_VERBAL);
	iLanguageSpoken = GetLocalInt(oSender, LANG_SPOKEN_2DA_ROW);
	iLanguageFeatInUse = GetLocalInt(oSender,LANG_SPOKEN_FT);
	iLanguageNowSpokenSID = GetLocalInt(oSender,LANG_SPOKEN_SID);
	
	sLNG_PC_EmoteSymbolStart = GetLocalString(oSender, CHAT_MY_EMO_PREFIX);
	sLNG_PC_EmoteSymbolEnd = GetLocalString(oSender, CHAT_MY_EMO_SUFFIX);
	sLNG_PC_FontStart = GetLocalString(oSender, CHAT_MY_CHAT_SUFFIX);
	if(sLNG_PC_FontStart == "") {sLNG_PC_FontStart = "null";}
	
	iLNG_PC_EmotesOn = GetLocalInt(oSender, PC_EMOTE_VERBAL_OFF);
	
	
	
	if(iLanguageSpoken == 0) //in other words a language hasn't been selected yet
	{
	
		iLanguageSpoken = GetDefaultLanguage(oJournal, oSender);
	//	SetToDefaultLanguage(oSender, iLanguageNowSpokenSID, iLanguageSpoken);
	
	
		SetToDefaultLanguage(oSender, 0, iLanguageSpoken);	
	 
	}
	

	
// >> Ventriloquism code

	//send in party mode	
	if ( sChatCommandSymbol == CHAT_VENTRILO_SYMBOL5  && iSendChatMessage == TRUE && iIsStaffDM && iIsStoryDM  ) 
	{
//		iSendChatMessage = FALSE;
//		sNewMessage = sPruneVentriloSymbol(sNewMessage);		
//		oVoiceThrowTarget = oSender ;	
		
//		string sFinalCleanChatMessage = sGlueMessage(oSender, oVoiceThrowTarget, CHAT_OUTPUT_PLAIN_TXT, iLanguageSpoken, TRUE, nChannel, "null", "null", sLNG_PC_EmoteSymbolStart , sLNG_PC_EmoteSymbolEnd  );
//		string sFinalObfuscatedChatMessage = sGlueMessage(oSender, oVoiceThrowTarget, CHAT_OUTPUT_OBSF_TXT, iLanguageSpoken, FALSE,  nChannel, "null", "null", sLNG_PC_EmoteSymbolStart , sLNG_PC_EmoteSymbolEnd  );
		
//		SendChatMessage(OBJECT_INVALID, oTarget, CHAT_MODE_SERVER , sFinalObfuscatedChatMessage );
//		if( GetHasFeat( iGetLanguageSpoken_Feat(oSender), oTarget) && fDistanceToVoiceThrower <= fMax_Channel_Range || GetIsStoryDM(oTarget) && fDistanceToVoiceThrower <= fMax_Channel_Range || GetIsStaffDM (oTarget) && fDistanceToVoiceThrower <= fMax_Channel_Range )
//		{
//			SendChatMessage(OBJECT_INVALID, oTarget, CHAT_MODE_SERVER , sFinalCleanChatMessage );					
//		}

		
		
	//	SetLocalString(oVoiceThrowTarget,LANG_SPOKEN,GetLocalString(oSender,LANG_SPOKEN));
	//	SendLocalChatMessageFunction( oSender, oVoiceThrowTarget, oTarget, nChannel, iChannel_To_Use,  iLanguageSpoken, iLNG_MOD_ActiveChatOn, fMax_Channel_Range,  iIs_PC_Silenced, sLNG_PC_FontStart, sLNG_PC_FontEnd );
	
		
					
	}
	
	if ( sChatCommandSymbol == CHAT_VENTRILO_SYMBOL6  && iSendChatMessage == TRUE && iIsStaffDM || sChatCommandSymbol == CHAT_VENTRILO_SYMBOL6  && iSendChatMessage == TRUE &&  iIsStoryDM || sChatCommandSymbol == CHAT_VENTRILO_SYMBOL7 && iSendChatMessage == TRUE && iIsStaffDM || sChatCommandSymbol == CHAT_VENTRILO_SYMBOL7  && iSendChatMessage == TRUE &&  iIsStoryDM) 
	{
		iSendChatMessage = FALSE;
		iShowFloat = FALSE;
		sShowFloat = "Public ";
		oVoiceThrowTarget = GetPlayerCurrentTarget( oSender );	
				
		if(sChatCommandSymbol == CHAT_VENTRILO_SYMBOL7 ) 
		{
			iShowFloat = TRUE;
			sShowFloat = "Private ";
		}

		sNewMessage = sPruneVentriloSymbol(sNewMessage);
		FloatingTextStringOnCreature(sNewMessage, oVoiceThrowTarget, iShowFloat, 7.0);
		sInform_oSenderDM(oSender, sShowFloat+"Floating Message on "+GetName(oTarget)+ ": " + sMessage);		
	}
	//
	
	if ( sChatCommandSymbol == CHAT_VENTRILO_SYMBOL1  && iSendChatMessage == TRUE || sChatCommandSymbol == CHAT_VENTRILO_SYMBOL2  && iSendChatMessage == TRUE  || sChatCommandSymbol == CHAT_VENTRILO_SYMBOL3  && iSendChatMessage == TRUE  ||sChatCommandSymbol == CHAT_VENTRILO_SYMBOL4  && iSendChatMessage == TRUE )
	{
		iSendChatMessage = FALSE;

		//Prune off the Ventriloquim symbols from sMessage
		sNewMessage = sPruneVentriloSymbol(sNewMessage);	

		//Who is the voice throw target
		oVoiceThrowTarget = GetPlayerCurrentTarget( oSender );		
		
		//Set iChannel_To_use for ventriloquim - overides earlier iChannel_To_use 
		//Even DMs are set to TALK if SHOUTING while using ventriloquim
		if(sChatCommandSymbol == CHAT_VENTRILO_SYMBOL1 && nChannel == CHAT_MODE_SHOUT )
		{
			iChannel_To_Use = CHAT_MODE_TALK;
		}
		else
		{
			iChannel_To_Use = nChannel;
		}
		if(sChatCommandSymbol == CHAT_VENTRILO_SYMBOL2) { nChannel = CHAT_MODE_TALK;iChannel_To_Use = CHAT_MODE_TALK; }
		if(sChatCommandSymbol == CHAT_VENTRILO_SYMBOL3) { nChannel = CHAT_MODE_SHOUT; iChannel_To_Use = CHAT_MODE_TALK; }
		if(sChatCommandSymbol == CHAT_VENTRILO_SYMBOL4) { nChannel = CHAT_MODE_WHISPER; iChannel_To_Use = CHAT_MODE_WHISPER; }
			
		//Set range oVoiceThrowTarget Can be heard at - note uses nChannel not iChannel_To_use
		fMax_Channel_Range = fGetTalkRange(nChannel);
				
		//Check if oVoiceTarget is silenced
		iIs_PC_Silenced = CheckForSilence(oVoiceThrowTarget, iLanguageVerbal );
		
		//NOTE for real script remove sNewMessage = !!!!
		sNewMessage =  sBalanceEmotes( oSender, sNewMessage, sLNG_PC_EmoteSymbolStart, sLNG_PC_EmoteSymbolEnd);
		
		if(!iIsStaffDM && !iIsStoryDM)
		{
			//PC ventriloquism rules
			//PCs can only target their henchmen, familiars & companions
			
			if ( GetIsObjectValid( oVoiceThrowTarget ) && GetObjectType( oVoiceThrowTarget ) == OBJECT_TYPE_CREATURE && oVoiceThrowTarget != oSender )
			{
				if(GetMaster(oVoiceThrowTarget) == oSender || oVoiceThrowTarget == GetHenchman(oSender) || (GetIsPossessedFamiliar(oSender) && oVoiceThrowTarget == GetMaster(oSender)))
				{
					//CHAT_VENTRILO VALID TARGET
					SetLocalString(oVoiceThrowTarget,LANG_SPOKEN,GetLocalString(oSender,LANG_SPOKEN));
					SendLocalChatMessageFunction( oSender, oVoiceThrowTarget, oTarget, nChannel, iChannel_To_Use,  iLanguageSpoken, iLNG_MOD_ActiveChatOn, fMax_Channel_Range,  iIs_PC_Silenced, sLNG_PC_FontStart, sLNG_PC_FontEnd );
					AddLanguageFeatToNPC(oSender, oVoiceThrowTarget, iIsStaffDM, iIsStoryDM, GetLocalString(oSender,LANG_SPOKEN) , GetLocalInt(oSender,LANG_SPOKEN_FT) );

				}	
				else
				{
					//send invalid target message
					SendChatErrorMessage(oSender, CHAT_PC_INVALID_TARGET);			
				}
	
			}
			else
			{
				//send invalid target message
				SendChatErrorMessage(oSender, CHAT_PC_INVALID_TARGET);
			}
		}
	
		else{
			//DM rules ventriloquism rules below
			//DMs can only anything except PC (but be nice if it's a PC or PC familiar etc)
			if ( GetIsObjectValid( oVoiceThrowTarget ) && oVoiceThrowTarget != oSender )
			{
					SetLocalString(oVoiceThrowTarget,LANG_SPOKEN,GetLocalString(oSender,LANG_SPOKEN));
					SendLocalChatMessageFunction( oSender, oVoiceThrowTarget, oTarget, nChannel, iChannel_To_Use,  iLanguageSpoken, iLNG_MOD_ActiveChatOn, fMax_Channel_Range,  iIs_PC_Silenced, sLNG_PC_FontStart, sLNG_PC_FontEnd );
					AddLanguageFeatToNPC(oSender, oVoiceThrowTarget, iIsStaffDM, iIsStoryDM, GetLocalString(oSender,LANG_SPOKEN) , GetLocalInt(oSender,LANG_SPOKEN_FT) );
			}
			else
			{
				//DM has selected and invalid target - or doesn't have a target selected - silly billy
				SendChatErrorMessage(oSender,CHAT_DM_INVALID_TARGET);
			}
		}		
	}	
	
	
// Ordinary speaking code below

	if (iSendChatMessage == TRUE )
	{	

		oVoiceThrowTarget = oSender;
		iIs_PC_Silenced = CheckForSilence(oSender, iLanguageVerbal, iIsStaffDM, iIsStoryDM );
		iChannel_To_Use = nChannel;
		
		sNewMessage =  sBalanceEmotes( oSender, sNewMessage, sLNG_PC_EmoteSymbolStart, sLNG_PC_EmoteSymbolEnd);
		
		switch(nChannel)
		{
				case CHAT_MODE_TALK:
				
				if(GetIsPC(oSender)  && iSendChatMessage == TRUE )
				{
					iSendChatMessage = FALSE;
					fMax_Channel_Range = CHAT_RANGE_TALK;
					SendLocalChatMessageFunction( oSender, oVoiceThrowTarget, oTarget, nChannel, iChannel_To_Use,  iLanguageSpoken, iLNG_MOD_ActiveChatOn, fMax_Channel_Range,  iIs_PC_Silenced, sLNG_PC_FontStart, sLNG_PC_FontEnd );
				}
					
			break;
			
			case CHAT_MODE_SHOUT:
				
				if( GetIsDM(oSender)|| iIsStoryDM )
				{

					SendChatMessage(oSender, oTarget, CHAT_MODE_SHOUT, sNewMessage);
					iSendChatMessage = FALSE;					
				}
			
			/*	else(GetIsPC(oSender) && iSendChatMessage == TRUE )
				{
					iSendChatMessage = FALSE;
					fMax_Channel_Range = CHAT_RANGE_SHOUT;
					iChannel_To_Use = iSetShoutChannel( nChannel, iIsStaffDM, iIsStoryDM );
					SendLocalChatMessageFunction( oSender, oVoiceThrowTarget, oTarget, nChannel, iChannel_To_Use,  iLanguageSpoken, iLNG_MOD_ActiveChatOn, fMax_Channel_Range,  iIs_PC_Silenced, sLNG_PC_FontStart, sLNG_PC_FontEnd );
				}
			*/	
			break;
			
			case CHAT_MODE_WHISPER:
						
				if(GetIsPC(oSender) && iSendChatMessage == TRUE )
				{
					iSendChatMessage = FALSE;				
					fMax_Channel_Range = CHAT_RANGE_WHISPER;
					SendLocalChatMessageFunction( oSender, oVoiceThrowTarget, oTarget, nChannel, iChannel_To_Use,  iLanguageSpoken, iLNG_MOD_ActiveChatOn, fMax_Channel_Range,  iIs_PC_Silenced, sLNG_PC_FontStart, sLNG_PC_FontEnd );
	
				}
			break;
			
			case CHAT_MODE_TELL: 
				if(GetIsPC(oSender) && iSendChatMessage == TRUE )
				{		
					iSendChatMessage = FALSE;
					// Comments to check DM tell issue
					
					if(GetIsDM(oSender)  || GetIsDMPossessed(oSender))
					{
						sTellFix = CLR_SERVER + GetName(oSender) + " : " + CLR_END + CLR_TELL + " [Tell] " + sMessage + CLR_END;
						SendChatMessage(OBJECT_INVALID, oTarget, CHAT_MODE_SERVER, sTellFix);					
					}
					//For PCs, will also echo to DMs as a tell...
					SendChatMessage(oSender,oTarget,CHAT_MODE_TELL,sMessage);					
				}
			break;
			
			case CHAT_MODE_SERVER: 
				if(GetIsPC(oSender) && iSendChatMessage == TRUE )
				{			
					iSendChatMessage = FALSE;			
					//no special tricks here either, at this time.
					SendChatMessage(oSender,oTarget,CHAT_MODE_SERVER,sMessage);
				}
			break;
			
			case CHAT_MODE_PARTY:
				if(GetIsPC(oSender) && iSendChatMessage == TRUE )
				{
					iSendChatMessage = FALSE;
					SendPartyChatMessageFunction( oSender, oVoiceThrowTarget, oTarget, nChannel, iLanguageSpoken, iLNG_MOD_PartyChatOff,  iIs_PC_Silenced, sLNG_PC_FontStart, sLNG_PC_FontEnd )	;
				}
				
			break;
			
			case CHAT_MODE_SILENT_SHOUT:
				if(GetIsPC(oSender) && iSendChatMessage == TRUE )
				{			
					iSendChatMessage = FALSE;		
					//Send to players logged in with DM Client
//					SendChatMessage(oSender,oTarget,CHAT_MODE_SILENT_SHOUT,sMessage);	//commenting out to remove double tell event (I hope)
				
					//Echo to oSender if they are not a DM.
					if(GetIsPC(oSender)&& iIsStaffDM == FALSE )
					{
						SendChatMessage(OBJECT_INVALID,oSender,CHAT_MODE_SERVER, CLR_DM + CHAT_SENT_TO_DMS + sMessage + CLR_END);
					}
					
					oTarget = GetFirstPC();
					
					while(oTarget != OBJECT_INVALID)
					{
						if(GetIsStoryDM(oTarget) == TRUE && GetIsStaffDM(oTarget) != TRUE)
						{
							SendChatMessage(OBJECT_INVALID,oTarget,CHAT_MODE_SERVER, CLR_SERVER + GetName(oSender)+ CLR_END + CLR_DM + CHAT_SENT_TO_DMS +  sMessage + CLR_END);
						}
					
						GetNextPC();
					}
					
				}

			
			break;
			
			default:
			iSendChatMessage = FALSE;
			//we should never end up here!!
			break;
		}
		
	}	
	// we also shouldn't end up here...
	return iSendChatMessage; 
}