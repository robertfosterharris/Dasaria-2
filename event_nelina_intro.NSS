// event_nelina_intro
void main()
{
    object oSpeaker = GetNearestObjectByTag("event_magnus_counselor");
    string sLine1 = "*Strikes iron-shod heel three times against the boardwalks* Ladies and Gentlemen, Citizens of the Empire, Thralls!";
    string sLine2 = "All hail Empress Nelina, Consort of his Imperial Majesty Marcus IV, symbol of the unified Empire, Governor of the Imperial Province of Dasaria, Supreme Dictator and Imperator Vicarius in the East, daughter of Kallindra, daughter of Sabrina, daughter of Sarah, daughter of Berand, Son of Jared, son of Oraan, son of Bethany, daughter of Caldor, son of Liran, son of Belan, son of Siril: The first king of Dasaria.";
   
        AssignCommand(oSpeaker,SpeakString(sLine1, TALKVOLUME_SHOUT));
        DelayCommand(5.0,AssignCommand(oSpeaker,SpeakString(sLine2, TALKVOLUME_SHOUT)));
}