
// sp_setlanguage
/*
	Description: Drives the custom language system through the use of custom history feats
	
*/
// RW 21-06-2011

#include "ginc_chat_funct"


void main()
{

	object oSender = GetControlledCharacter(OBJECT_SELF);
	object oJournal = std_journal_get(oSender);
	
	int iDefaultLanguage; 
	int iLanguageNowSpoken, iLanguageNowSpokenSID, iLanguageToSpeakSID, iLanguageFeatInUse, iLanguageSpellEffectRow, iLanguageVerbal;
	
	effect eSpeakLanguage;
	
	string sLanguageSpoken;
	int iLanguageSpoken;
	
	iLanguageToSpeakSID = GetSpellId();
	iLanguageNowSpokenSID = GetLocalInt(oSender, LANG_SPOKEN_SID);
	iLanguageFeatInUse = GetSpellFeatId();
	
	if(GetIsStaffDM(oSender) || GetIsStoryDM(oSender))
	{
		iDefaultLanguage = LNG_COMMON_D; //Default Language for DMs is always Common
	}
	else
	{
		iDefaultLanguage = GetDefaultLanguage(oJournal, oSender); //needs to be written at creation, or later
	}

	
	if(iLanguageNowSpokenSID == iLanguageToSpeakSID)
	{
		//let you toggle off a language without having to find your default language
		SetToDefaultLanguage(oSender, iLanguageNowSpokenSID, iDefaultLanguage);
	}
	else
	{
		//lets you toggle to a new language
		SetLanguageDetails(oSender, iLanguageNowSpokenSID, iLanguageToSpeakSID, iLanguageFeatInUse);
	}
	sLanguageSpoken = GetLocalString(oSender,LANG_SPOKEN);
	SendMessageToPC(oSender,CLR_SERVER+"You are now speaking "+ sLanguageSpoken+ CLR_END);

}








