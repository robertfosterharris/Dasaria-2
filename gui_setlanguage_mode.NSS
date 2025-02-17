// gui_setlanguage_mode

#include "ginc_chat_funct"

void main(string sLanguageToSpeakSID, string sLanguageFeatInUse)
{
	object oSender = OBJECT_SELF;
	object oJournal = std_journal_get(oSender);	

	int iDefaultLanguage; 
	int iLanguageNowSpoken, iLanguageNowSpokenSID, iLanguageToSpeakSID, iLanguageFeatInUse, iLanguageSpellEffectRow, iLanguageVerbal;
	
	effect eSpeakLanguage;
	
	string sLanguageSpoken;
	int iLanguageSpoken;	
	
	//	SendMessageToPC(oSender,"Languages GUI modes do");
	//	SendMessageToPC(oSender,"iLanguageToSpeakSID #"+ sLanguageToSpeakSID+"#");
	iLanguageToSpeakSID = StringToInt(sLanguageToSpeakSID);	
	//	SendMessageToPC(oSender,"iLanguageFeatInUse #"+ sLanguageFeatInUse+"#");
	iLanguageFeatInUse =  StringToInt(sLanguageFeatInUse);	

	iLanguageNowSpokenSID = GetLocalInt(oSender, LANG_SPOKEN_SID);
	//	SendMessageToPC(oSender,"iLanguageNowSpokenSID #"+ IntToString(iLanguageFeatInUse)+"#");	

	
	if(GetIsStaffDM(oSender) || GetIsStoryDM(oSender))
	{
		iDefaultLanguage = LNG_COMMON_D; //Default Language for DMs is always Common
	}
	else
	{
		iDefaultLanguage = GetDefaultLanguage(oJournal, oSender); //needs to be written at creation, or later
	}

	
	//lets you toggle to a new language
	SetLanguageDetails(oSender, iLanguageNowSpokenSID, iLanguageToSpeakSID, iLanguageFeatInUse);

	sLanguageSpoken = GetLocalString(oSender,LANG_SPOKEN);
	SendMessageToPC(oSender,CLR_SERVER+"You are now speaking "+ sLanguageSpoken+ CLR_END);

}