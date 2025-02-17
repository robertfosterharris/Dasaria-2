// event_gov_speak
void main()
{
    object oSpeaker = GetNearestObjectByTag("nelina");
    object oCounselor = GetNearestObjectByTag("event_magnus_counselor");
    string sLine1 = "*Looks out over the crowd, her eyes burgeoning with wetness*  My people!";
    string sLine2 = "I am overwhelmed to look upon the land of my forebearers once again. *pauses*";
    string sLine3 = "Long time I have dwelt in the West, but all through these wild and tumultuous years of change, my thoughts have been ever with you.";
    string sLine4 = "For fifty years these lands have not known war. *Seems to look you directly in the eye* Now, an ancient menace threatens the peace and security of our great nation once again.";
    string sLine5 = "Our ancient enemy has been stirring in the darkness, his evil will forever looking eastward and plotting vengeance on both the Houses of Dairamik and Siril.";
    string sLine6 = "Now we see his long-laid plans begin to unfold. The armies of his allies have overwhelmed the cities of Northern Dasaria, and their iron group slowly strangles Cear from the cities of the heartland.  The very dead rise up from the earth in order to serve him!  He must be stopped, or civilization will be forever ended in these lands.";
    string sLine7 = "*Resolutely* Victory will be difficult and great sacrifices will be asked of all of you.  But we can prevail. Twice he has been defeated and sent back into the darkness from which he came.  Now, our two houses united will seek to unbind him forever from this world.";
    string sLine8 = "But we have been taken unaware by the enemy's treachery.  Dasaria now stands divided and surrounded by his servants.  We must strike back swiftly, lest we be forever overwhelmed. *pauses*";
    string sLine9 = "Your beloved Emperor sends me with seven hundred ships and ten thousand legionnaires with which to sieze back the Penninsula.  A second fleet makes landfall in Gulashir as we speak.  Though the enemy hold the high ground, and the road will be long and ardous, we have begun the Defense of Dasaria!";
    string sLine10 = "*Shouts over the crowd* Will you fight for the glory of the Varanite Empire and do great deeds for your Emperor? Or will you fade away into the coming darkness?  Dasarians, be steadfast! We must stand against this wicked tide together!";
    string sLine11 = "All Hail Nelina! All Hail Marcus! All Hail the Empire!";

    AssignCommand(oSpeaker,SpeakString(sLine1, TALKVOLUME_SHOUT));
    DelayCommand(10.0,AssignCommand(oSpeaker,SpeakString(sLine2, TALKVOLUME_SHOUT)));
    DelayCommand(20.0,AssignCommand(oSpeaker,SpeakString(sLine3, TALKVOLUME_SHOUT)));
    DelayCommand(30.0,AssignCommand(oSpeaker,SpeakString(sLine4, TALKVOLUME_SHOUT)));
    DelayCommand(40.0,AssignCommand(oSpeaker,SpeakString(sLine5, TALKVOLUME_SHOUT)));
    DelayCommand(50.0,AssignCommand(oSpeaker,SpeakString(sLine6, TALKVOLUME_SHOUT)));   
    DelayCommand(60.0,AssignCommand(oSpeaker,SpeakString(sLine7, TALKVOLUME_SHOUT)));   
    DelayCommand(70.0,AssignCommand(oSpeaker,SpeakString(sLine8, TALKVOLUME_SHOUT)));   
    DelayCommand(80.0,AssignCommand(oSpeaker,SpeakString(sLine9, TALKVOLUME_SHOUT)));   
    DelayCommand(90.0,AssignCommand(oSpeaker,SpeakString(sLine10, TALKVOLUME_SHOUT)));
    DelayCommand(100.0,AssignCommand(oCounselor,SpeakString(sLine11, TALKVOLUME_SHOUT)));
}