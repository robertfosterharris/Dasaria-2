/*
 
*/
const float SONG_OFFSET = 1.0;

void PlayInstruments(object oBenjamin, object oJacob);
void IdleInstruments(object oBenjamin, object oJacob);

void main()
{
	int nMusicDay;
	int nMusicNight;
	object oArea;
	object oBenjamin;
	object oJacob;
	object oMadelyn;

	oBenjamin = GetObjectByTag("bard_benjamin");
	oJacob = GetObjectByTag("bard_jacob");
	oMadelyn = GetObjectByTag("bard_madelyn");
	oArea = GetArea(oMadelyn);
	nMusicDay = MusicBackgroundGetDayTrack(oArea);
	nMusicNight = MusicBackgroundGetNightTrack(oArea);
	
	PlayCustomAnimation(oBenjamin, "idledrum", 1);
	PlayCustomAnimation(oJacob, "idleguitar", 1);
	SetLocalInt(oMadelyn, "bSinging", 1);
	
	MusicBackgroundSetDelay(oArea, 5000);
	MusicBackgroundChangeDay(oArea, 210);
	MusicBackgroundChangeNight(oArea, 210);
	AmbientSoundSetDayVolume(oArea, 5);
	AmbientSoundSetNightVolume(oArea, 5);
	
	DelayCommand(SONG_OFFSET + 0.0,		AssignCommand(oMadelyn, SpeakString("<i>As I was walking all alane,</i>")));
	DelayCommand(SONG_OFFSET + 5.0,		AssignCommand(oMadelyn, SpeakString("<i>I heard twa corbies making a mane;</i>")));
	DelayCommand(SONG_OFFSET + 10.0,	AssignCommand(oMadelyn, SpeakString("<i>The tane unto the t'other did say,</i>")));
	DelayCommand(SONG_OFFSET + 15.0,	AssignCommand(oMadelyn, SpeakString("<i>Where sall we gang and dine today?</i>")));
	DelayCommand(SONG_OFFSET + 19.0,	AssignCommand(oMadelyn, SpeakString("<i>Where sall we gang and dine today?</i>")));

	DelayCommand(SONG_OFFSET + 24.0,	AssignCommand(oMadelyn, SpeakString("<i>In behint yon auld fail dyke,</i>")));
	DelayCommand(SONG_OFFSET + 25.0, 	PlayInstruments(oBenjamin, oJacob));
	DelayCommand(SONG_OFFSET + 28.0,	AssignCommand(oMadelyn, SpeakString("<i>I wot there lies a new slain knight;</i>")));
	DelayCommand(SONG_OFFSET + 33.0,	AssignCommand(oMadelyn, SpeakString("<i>And naebody kens that he lies there,</i>")));
	DelayCommand(SONG_OFFSET + 39.0,	AssignCommand(oMadelyn, SpeakString("<i>But his hawk, his hound, and lady fair.</i>")));
	DelayCommand(SONG_OFFSET + 43.0,	AssignCommand(oMadelyn, SpeakString("<i>His hawk, his hound, and lady fair.</i>")));

	DelayCommand(SONG_OFFSET + 47.0,	AssignCommand(oMadelyn, SpeakString("<i>His hound is to the hunting gane,</i>")));
	DelayCommand(SONG_OFFSET + 52.0,	AssignCommand(oMadelyn, SpeakString("<i>His hawk to fetch the wild-fowl hame,</i>")));
	DelayCommand(SONG_OFFSET + 57.0,	AssignCommand(oMadelyn, SpeakString("<i>His lady's ta'en another mate,</i>")));
	DelayCommand(SONG_OFFSET + 62.0,	AssignCommand(oMadelyn, SpeakString("<i>So we may mak our dinner sweet.</i>")));
	DelayCommand(SONG_OFFSET + 66.0,	AssignCommand(oMadelyn, SpeakString("<i>We may mak our dinner sweet.</i>")));
	
	DelayCommand(SONG_OFFSET + 71.0,	AssignCommand(oMadelyn, SpeakString("<i>Ye'll sit on his white hause-bane,</i>")));
	DelayCommand(SONG_OFFSET + 75.0,	AssignCommand(oMadelyn, SpeakString("<i>And I'll pike out his bonny blue een;</i>")));
	DelayCommand(SONG_OFFSET + 80.0,	AssignCommand(oMadelyn, SpeakString("<i>Wi ae lock o his gowden hair</i>")));
	DelayCommand(SONG_OFFSET + 85.0,	AssignCommand(oMadelyn, SpeakString("<i>We'll, theek our nest when it grows bare.</i>")));
	DelayCommand(SONG_OFFSET + 89.0,	AssignCommand(oMadelyn, SpeakString("<i>Theek our nest when it grows bare.</i>")));
	
	DelayCommand(SONG_OFFSET + 94.0,	AssignCommand(oMadelyn, SpeakString("<i>Mony a one for him makes mane,</i>")));
	DelayCommand(SONG_OFFSET + 99.0,	AssignCommand(oMadelyn, SpeakString("<i>But nane sall ken where he is gane;</i>")));
	DelayCommand(SONG_OFFSET + 103.0,	AssignCommand(oMadelyn, SpeakString("<i>Oer his white banes, when they are bare,</i>")));
	DelayCommand(SONG_OFFSET + 109.0,	AssignCommand(oMadelyn, SpeakString("<i>The wind sall blaw for evermair.</i>")));
	DelayCommand(SONG_OFFSET + 114.0,	AssignCommand(oMadelyn, SpeakString("<i>The wind sall blaw for evermair.</i>")));
	DelayCommand(SONG_OFFSET + 118.0, 	IdleInstruments(oBenjamin, oJacob));
	
	DelayCommand(SONG_OFFSET + 125.0,	AmbientSoundSetDayVolume(oArea, 30));
	DelayCommand(SONG_OFFSET + 125.0,	AmbientSoundSetNightVolume(oArea, 30));
	DelayCommand(SONG_OFFSET + 125.0,	MusicBackgroundChangeDay(oArea, nMusicDay));
	DelayCommand(SONG_OFFSET + 125.0,	MusicBackgroundChangeNight(oArea, nMusicNight));
	DelayCommand(SONG_OFFSET + 125.0,	DeleteLocalInt(oMadelyn, "bSinging"));
}

void PlayInstruments(object oBenjamin, object oJacob)
{
	PlayCustomAnimation(oBenjamin, "idlefidgetdrum", 1);
	PlayCustomAnimation(oJacob, "playguitar", 1);
}

void IdleInstruments(object oBenjamin, object oJacob)
{
	PlayCustomAnimation(oBenjamin, "idledrum", 1);
	PlayCustomAnimation(oJacob, "idleguitar", 1);
}