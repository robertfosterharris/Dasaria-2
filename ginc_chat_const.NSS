/*///////////////////////////////***VERSION***//////////////////////////////////////////

//const string LANG_VERSION = "v2 20120908";
//const string LANG_VERSION = "v2 20120911";
//const string LANG_VERSION = "v2 20121120";
//const string LANG_VERSION = "v2 20130411";
const string LANG_VERSION = "v2 20140202";

////////////////////////////////***LNG 2DA  CONSTANTS***///////////////////////////////
//These relate to the custom DAS_Lang.2DA file - this file stores some strrefs for the language system and
// carries a copy of the language system values from  feat, spell and effecticon 2das - allows the language 
// system to be extended without having to rebuild feat/spell/effections 2das with sequential values
//this is a "good thing"

const string LANG_DAS_2DA  ="das2_lang"; //this is the name of the lang 2da
const string LANG_COL_NAME = "strRef";
const string LANG_COL_DESCRIPT = "Description";
const string LANG_COL_LNG = "Language";
const string LANG_COL_FT = "FeatID";
const string LANG_COL_SID = "SpellID";
const string LANG_COL_SFX = "EffectIcon";
const string LANG_COL_AVL = "Available";
const string LANG_COL_VERBAL = "Verbal";

////////////////////////////////***CHAT LOCAL VARIABLE CONSTANTS - oModule**///////////////////////////////
//These are stored on oModule to manage certain persistant settings for the language system 

const string MOD_LNG_SUPRESS_PARTY_CHAT = "iCHATMOD_PartyChatOff"; //lets DMs suppress party chat, should they want to
const string MOD_LNG_ACTIVE_CHAT = "iCHATMOD_ActiveChatOn"; //lets DM capture talk/shout/whisper while out of range/area of oSender
const string MOD_LNG_ACTIVE_EMOTE = "iCHATMOD_EmotesOn"; //stored on oModule, decides if emote animations are active

////////////////////////////////***CHAT LOCAL VARIABLE CONSTANTS - oJournal & oPC***///////////////////////
//These are stored on oJournal and/or oPC to manage the language system persistant settings
const string STORY_DM ="iStoryDM"; //also stored on oSender - Player Characters with some DM accesses through the onchaat system

const string LANG_DEFAULT = "iLNG_DefaultLanguage"; //what is oSenders default language

const string PC_EMOTE_VERBAL_OFF = "iChat_Emo_Off";
//const string PC_EMOTE_PARTY_OFF = "iChat_Emo_PartyOff";
//const string PC_EMOTE_SOUNDS_OFF = "iChat_SoundsOff";

const string CHAT_MY_EMO_PREFIX = "sLNG_My_Emo_Prefix";
const string CHAT_MY_EMO_SUFFIX = "sLNG_My_Emo_Suffix";
const string CHAT_MY_CHAT_PREFIX = "sLNG_My_Chat_Prefix";
const string CHAT_MY_CHAT_SUFFIX = "sLNG_My_Chat_Suffix";

////////////////////////////////***CHAT LOCAL VARIABLE CONSTANTS - oSender**///////////////////////////////
//These are stored on oSender to manage the language system 

const string LANG_SPOKEN = "sLNG_NowSpoken"; //from Das_lang.2da strRef
const string LANG_SPOKEN_FT = "iLNG_FeatInUse"; //from Das_lang.2da FeatID
const string LANG_SPOKEN_SID = "iLNG_NowSpokenSID"; //from Das_lang.2da SpellID
const string LANG_SPOKEN_SFX = "iLNG_SFX"; //from Das_lang.2da EffectIcon
const string LANG_SPOKEN_2DA_ROW = "iLNG_NowSpokenRow"; //from Das_lang.2da Row value
const string LANG_SPOKEN_VERBAL = "iLNG_Verbal"; // from Das_lang verbal column


const string SUPRESS_PARTY_CHAT_DM = "iLNG_SupPartyChat_DM"; //also stored on oModule, lets DMs suppress party chat, should they want to
const string ACTIVE_CHAT_DM = "iLNG_ActiveChat_DM"; //also stored on oModule, lets DM capture talk/shout/whisper while out of range/area
const string ACTIVE_EMOTE_DM = "iLNG_ActiveEmote_DM"; //stored on oModule, lets DM capture talk/shout/whisper while out of range/area


const string GET_LNG_VARS = "iLNG_Get_Vars"; // used to detirmine whether its necessary to check oJournal for LNG vars

const string LANG_DEBUG = "iDebug_On";


////////////////////////////////***EMOTE INDEX CONSTANTS***///////////////////////////////


const string EMOTE_SUBSTRING = "sEmoteSubString_";
const string EMOTE_INDEX = "iEmoteIndex";
const string EMOTE_LOC = "lEmoteLocation";
const string EMOTE_POSE = "iEmotePosture";
const string EMO_NULL ="null"; //seems empty strings ("") are now passed as "0" --so use emo_null!

const string CHAT_SUBSTRING = "sChatSubString_";
const string CHAT_INDEX = "iChatIndex";
////////////////////////////////***CHAT COMMAND CONSTANTS***///////////////////////////////

const string CHAT_VENTRILO_SYMBOL1 = ">>";
const string CHAT_VENTRILO_SYMBOL2 = ">t";
const string CHAT_VENTRILO_SYMBOL3 = ">s";
const string CHAT_VENTRILO_SYMBOL4 = ">w";
const string CHAT_VENTRILO_SYMBOL5 = ">p";
const string CHAT_VENTRILO_SYMBOL6 = ">*";
const string CHAT_VENTRILO_SYMBOL7 = ">@";

const string CHAT_COMMAND_SYMBOL = "!";
const string CHAT_OOC_SYMBOL1 = "((";
const string CHAT_OOC_SYMBOL2 = "))";
const string CHAT_OOC_SYMBOL3 = "//";
const string CHAT_OOC_SYMBOL4 = "\\";
const string CHAT_EMOTE_SYMBOL = "*";

////////////////////////////////***CHAT TALK VOLUME & RANGE CONSTANTS***///////////////////////////////
/*
nChannel constants
CHAT_MODE_TALK = 1
CHAT_MODE_SHOUT = 2
CHAT_MODE_WHISPER = 3
CHAT_MODE_TELL = 4
CHAT_MODE_SERVER = 5
CHAT_MODE_PARTY = 6
CHAT_MODE_SILENT_SHOUT = 14
*/

//const string CHAT_MODE_CONSTANT = "iChat_Channel";

//const int TALKVOLUME_INVALID = 99;


const float CHAT_RANGE_TALK = 20.00;
const float CHAT_RANGE_WHISPER = 3.00;
const float CHAT_RANGE_SHOUT = 50.0;

const int CHAT_OUTPUT_EMOTES_ONLY = 1;
const int CHAT_OUTPUT_PLAIN_TXT = 2;
const int CHAT_OUTPUT_PLAIN_TXT_WHISPER = 4;
const int CHAT_OUTPUT_PLAIN_TXT_YELL = 8;
const int CHAT_OUTPUT_OBSF_TXT = 16;
const int CHAT_OUTPUT_OBSF_TXT_YELL = 32;
const int CHAT_OUTPUT_OBSF_TXT_YELL_R = 64;

////////////////////////////////***CLR (color) CONSTANTS**///////////////////////////////
//These are here simply to make the scripts cleaner and more readable, and to make the colors
//changeable on the fly.

const string CLR_TALK = "<color=White>"; //Talk colour
const string CLR_WHISPER = "<color=Gray>"; //Whisper colour
const string CLR_SHOUT = "<color=Yellow>"; //Shout colour
const string CLR_TELL = "<color=Lime>"; //Tell colour
const string CLR_DM = "<color=Cyan>"; //DM colour
const string CLR_PARTY = "<color=Salmon>"; //Party colour
const string CLR_OOC = "<color=Orange>"; //OOC colour
const string CLR_EMOTE = "<color=PaleGoldenRod>"; //Emote colour
const string CLR_SERVER = "<color=LightPink>"; //Server messages
const string CLR_PC_CHAT_MESSAGE = "<color=Purple>"; //
const string CLR_END = "</color>";
const string CLR_NEWLINE = "\n";
const string CLR_SPACE = " ";

////////////////////////////////***CHAT ERROR MESSAGES***///////////////////////////////

const string CHAT_PC_INVALID_TARGET = "You may only speak through familiars, animal companions, or henchmen.";
const string CHAT_DM_INVALID_TARGET = "The target you have selected appears to be invalid.";
const string CHAT_DM_INVALID_PC_TARGET =  "This is a player controlled character. You may not speak on behalf of player characters.";
const string CHAT_DM_PC_NPC =  "The character you are speaking through is a Player or Player's NPC, please be considerate.";
const string CHAT_SILENCE_MESSAGE = " can not speak due to a slience effect";

const string CHAT_INVALID_CHANNEL ="Error: SendChatMessageFunction - invalid channel. Please report this error on the Dasaria 2 forums";
const string CHAT_INVALID_CHANNEL2 = "Error: SendLocalChatMessageFunction - invalid channel. Please report this error on the Dasaria 2 forums";
const string CHAT_OBFUSCATE_ERROR = "Error: sObfuscateChatString: An error has occured, please report this on the Dasaria forums.";


////////////////////////////////***LANGUAGE (LNG) CONSTANTS**///////////////////////////////

//int referered to are the row values in the dasaria language 2da file
const int LNG_COMMON_D = 1;
const int LNG_ELF_RIAN = 2;
const int LNG_ELF_IRYROD = 3;
const int LNG_DWARF_MODERN = 4;
const int LNG_DWARF_DUNK = 5;
const int LNG_DWARF_ANCIENT = 6;
const int LNG_RELLIAN =	7;
const int LNG_DARISH = 8;
const int LNG_CUHANNAN = 9;
const int LNG_KAOLISK =	10;
const int LNG_EXODONIAN = 11;
const int LNG_DAWN_TONGUE =	12;
const int LNG_FIENDISH = 13;
const int LNG_GNOME_DUR = 14;
const int LNG_KOR = 15;
const int LNG_VOKK = 16;
const int LNG_SHAI = 17;
const int LNG_TAHNAI = 18;
const int LNG_GIANT_D	 = 19;
const int LNG_DRAGON_D = 20;
const int LNG_GNOLL_D	 =21;
const int LNG_FAYE	 =22;
const int LNG_GOBLIN_D =	23;
const int LNG_ANJIRAN = 24;
const int LNG_KOBOLD_D = 25;
const int LNG_JILYN = 26;
const int LNG_TRAILSIGN	= 27;
const int LNG_DRUID_D = 28;
const int LNG_SCOUTSIGN = 29;
const int LNG_KALEM = 30;
const int LNG_NITRIAD = 31;
const int LNG_BARAAN = 32;

//Feat value of COMMON_D
const int LNG_FEAT_COMMON_D = 2923;

//////////////////////////////////Miscellaneous/////////////////////////////////

const string CHAT_SHOUT_ID = " *Shouting* ";
const string CHAT_SHOUT_RANGE_ID = " [Shouting] ";
const string CHAT_LNG_TALK_ID = " [Speaking ";
const string CHAT_LNG_SHOUT_ID = " [Shouting ";
const string CHAT_LNG_WHISPER_ID =  " [Whispering ";
const string CHAT_SENT_TO_DMS = " [Sent to DMs]: ";
const string CHAT_CLOSEBRACKET = "] ";



//////////////////////////////////EMO CONSTANTS/////////////////////////////////
const string CHAT_EMO_A = "angrily attention";
const string CHAT_EMO_B = "begs bellows bites bows";
const string CHAT_EMO_C = "cheerfuly cheerfully cheers chuckles chuggs claps clapses clutches clutching collapses cooks cooking cowers cries crys crying curtseys";
const string CHAT_EMO_D = "dances dejectedly digs drains drinks ducks drops drunk drunkenly dusts";
const string CHAT_EMO_E = "ease eats eating";
const string CHAT_EMO_F = "falls fidgets flirts flirtfully forcefully";
const string CHAT_EMO_G = "gasps gets grabs grins ground";
const string CHAT_EMO_H = "hammers hips hits head holds";
const string CHAT_EMO_I = "intimidate intimidatingly";
const string CHAT_EMO_J = "jumps";
const string CHAT_EMO_K = "kicks knights knocked";
const string CHAT_EMO_L = "laughs lays lies looks";
const string CHAT_EMO_M = "meditates mocks mockingly";
const string CHAT_EMO_N = "nervously nods";
const string CHAT_EMO_O = "";
const string CHAT_EMO_P = " picks plays pleads pleading points prays punches"; //pauses
const string CHAT_EMO_Q = "";
const string CHAT_EMO_R = "reads reaches raises";
const string CHAT_EMO_S = "sadly screams searches shouts shovels shrugs shys sips sighs sits skims slump smiles softly staggers stands standsup stirs sways swings";
const string CHAT_EMO_T = "takes taps tastes taunts tauntingly threat tired tiredly threateningly throws touches";
const string CHAT_EMO_U = "uses";
const string CHAT_EMO_V = "";
const string CHAT_EMO_W = "waves";
const string CHAT_EMO_X = "";
const string CHAT_EMO_Y = "yawns yells";
const string CHAT_EMO_Z = "";


//////////////////////////////////EMO POSTURES/////////////////////////////////

const int EMO_POS_STANDING = 0;
const int EMO_POS_SEATED = 1;
const int EMO_POS_KNEEL = 2;
const int EMO_POS_SIT_GROUND = 3;
const int EMO_POS_PRONE = 4;






//////////////////////////////////COMMANDS/////////////////////////////////
// *************************** CONSTANTS ***************************************

const string CMD_ABCDE_PC_A = "!appraise <i>###/t/p</i> !bluff <i>###/t/p</i> !concentration <i>###/t/p</i> !craftalchemy <i>###/t/p</i> !craftarmor <i>###/t/p</i> !crafttrap <i>###/t/p</i> !craftweapon <i>###/t/p</i> ";
const string CMD_ABCDE_PC_B = "!diplomacy <i>###/t/p</i> !disabledevice <i>###/t/p</i> ";
const string CMD_FGHIJ_PC_A = "!healskill <i>###/t/p</i> !help !heritage !hide <i>###/t/p</i> !intimidate <i>###/t/p</i> ";
const string CMD_KLMNO_PC_A = "!listen <i>###/t/p</i> !lore <i>###/t/p</i> !lng !language <i>default/emote/XemoteX/pick</i> !movesilently <i>###/t/p</i> !openlock <i>###/t/p</i> ";
const string CMD_PQRST_PC_A = "!parry <i>###/t/p</i> !perform <i>###/t/p</i> !ride <i>###/t/p</i> !scry !search <i>###/t/p</i> !sensemotive <i>###/t/p</i> !settrap <i>###/t/p</i> !sleightofhand <i>###/t/p</i> !speaklanguage <i>###/t/p</i> ";
const string CMD_PQRST_PC_B = "!spellcraft <i>###/t/p</i> !spot <i>###/t/p</i> !survival <i>###/t/p</i> !taunt <i>###/t/p</i> !tumble <i>###/t/p</i>  "; 
const string CMD_UVWXYZ_PC_A = "!usemagicdevice <i>###/t/p</i> ";

const string CMD_ABCDE_STAFF_A = "!appraise <i>###/t/p</i> !bluff <i>###/t/p</i> !concentration <i>###/t/p</i> !craftalchemy <i>###/t/p</i> !craftarmor <i>###/t/p</i> !crafttrap <i>###/t/p</i> !craftweapon <i>###/t/p</i> ";
const string CMD_ABCDE_STAFF_B = "!debug !diplomacy <i>###/t/p</i> !disabledevice <i>###/t/p</i> ";
const string CMD_FGHIJ_STAFF_A = "!feats !healskill <i>###/t/p</i> !help !heritage !hide <i>###/t/p</i> !intimidate <i>###/t/p</i> ";
const string CMD_KLMNO_STAFF_A = "!listen <i>###/t/p</i> !lore <i>###/t/p</i> !lng !language <i>default/emote/XemoteX/pick</i> !movesilently <i>###/t/p</i> !openlock <i>###/t/p</i> ";
const string CMD_PQRST_STAFF_A = "!parry <i>###/t/p</i> !perform <i>###/t/p</i> !ride <i>###/t/p</i> !scry !search <i>###/t/p</i> !sensemotive <i>###/t/p</i> !settrap <i>###/t/p</i> ";
const string CMD_PQRST_STAFF_B = "!sleightofhand <i>###/t/p</i> !speaklanguage <i>###/t/p</i> !spellcraft <i>###/t/p</i> !spot <i>###/t/p</i> !survival <i>###/t/p</i>  !taunt <i>###/t/p</i> !tumble <i>###/t/p</i>"; 
const string CMD_UVWXYZ_STAFF_A = "!usemagicdevice <i>###/t/p</i> !vars <i>a</i>  !version ";

const string CMD_ABCDE_STORY_DM_A = "!addhench <i>xxx</i> !aioff <i>all</i> !aion !appraise <i>###/t/p</i> !appear <i>###</i> !appraise <i>###/t/p</i> !back !bluff <i>###/t/p</i> !boot !canite !cdkey !chat !clean <i>m/l/h</i> !come !commoner !concentration <i>###/t/p</i> !craftalchemy <i>###/t/p</i> !craftarmor <i>###/t/p</i> !crafttrap <i>###/t/p</i> !craftweapon <i>###/t/p</i> ";
const string CMD_ABCDE_STORY_DM_B = "!damage <i>###</i> !debug !defender !desc !deity !destroy !diplomacy <i>###/t/p</i> !disabledevice <i>###/t/p</i> !dmg <i>###</i> !dmgo !eos ";
const string CMD_FGHIJ_STORY_DM_A = "!feats !free !freeze <i>0/off</i> !gettag !givefeat <i>###</i> !heal !healskill <i>###/t/p</i> !help !hide <i>###/t/p</i> !hostile !imperial !intimidate <i>###/t/p</i> !invis <i>0/off</i> !jail ";
const string CMD_KLMNO_STORY_DM_A = "!kill !listen <i>###/t/p</i> !look !lore <i>###/t/p</i> !lng !language <i>default/emote/XemoteX/fontX/pick</i> !moditem !morph <i>###</i> !motd <i>xxx</i> !movesilently <i>###/t/p</i> !neutral !openlock <i>###/t/p</i> ";
const string CMD_PQRST_STORY_DM_A = "!pardon !parry <i>###/t/p</i> !partychat !partyjump !partyxp <i>###</i> !perform <i>###/t/p</i> !raise <i>all</i> !rebel !removefeat <i>###</i> !rename <i>xxx</i> !renown <i>###</i> !rest <i>/all</i> !rez <i>/all</i> !rezarea !ride <i>###/t/p</i> !scry !search <i>###/t/p</i> !sendurl <i>xxx</i> !sensemotive <i>###/t/p</i> !setdetect <i>###</i> !setdisarm <i>###</i> !settrap <i>###/t/p</i> !setunlock <i>###</i> ";
const string CMD_PQRST_STORY_DM_B = "!shrink !sleightofhand <i>###/t/p</i> !spawn <i>xxx</i> !speaklanguage <i>###/t/p</i> !spellcraft <i>###/t/p</i> !spot <i>###/t/p</i> !survival <i>###/t/p</i> !taunt <i>###/t/p</i> !tumble <i>###/t/p</i> !togencs !togolm ";
const string CMD_UVWXYZ_STORY_DM_A = "!unvis !usemagicdevice <i>###/t/p</i> !vars <i>a</i> !version !where !xp <i>###</i> !zombie ";

const string CMD_ABCDE_STAFF_DM_A = "!addhench <i>xxx</i> !aioff <i>all</i> !aion !appraise <i>###/t/p</i> !appear <i>###</i> !appraise <i>###/t/p</i> !back !bluff <i>###/t/p</i> !boot !canite !cdkey !chat !clean <i>m/l/h</i> !come !commoner !concentration <i>###/t/p</i> !craftalchemy <i>###/t/p</i> !craftarmor <i>###/t/p</i> !crafttrap <i>###/t/p</i> !craftweapon <i>###/t/p</i> ";
const string CMD_ABCDE_STAFF_DM_B = "!damage <i>###</i> !debug !defender !desc !deity !destroy !diplomacy <i>###/t/p</i> !disabledevice <i>###/t/p</i> !dmg <i>###</i> !dmgo !eos ";
const string CMD_FGHIJ_STAFF_DM_A = "!feats !free !freeze <i>0/off</i> !gettag !givefeat <i>###</i> !heal !healskill <i>###/t/p</i> !help !hide <i>###/t/p</i> !hostile !imperial !intimidate <i>###/t/p</i> !invis <i>0/off</i> !jail ";
const string CMD_KLMNO_STAFF_DM_A = "!kill !listen <i>###/t/p</i> !look !lore <i>###/t/p</i> !lng !language <i>default/emote/XemoteX/fontX/pick</i> !moditem !morph <i>###</i> !motd <i>xxx</i> !movesilently <i>###/t/p</i> !neutral !openlock <i>###/t/p</i> ";
const string CMD_PQRST_STAFF_DM_A = "!pardon !parry <i>###/t/p</i> !partychat !partyjump !partyxp <i>###</i> !perform <i>###/t/p</i> !raise <i>all</i> !rebel !removefeat <i>###</i> !rename <i>xxx</i> !renown <i>###</i> !rest <i>/all</i> !rez <i>/all</i> !rezarea !ride <i>###/t/p</i> !scry !search <i>###/t/p</i> !sendurl <i>xxx</i> !sensemotive <i>###/t/p</i> !setdetect <i>###</i> !setdisarm <i>###</i> !setskill !settrap <i>###/t/p</i> ";
const string CMD_PQRST_STAFF_DM_B = "!setunlock <i>###</i> !shrink !sleightofhand <i>###/t/p</i> !spawn <i>xxx</i> !speaklanguage <i>###/t/p</i> !spellcraft <i>###/t/p</i> !spot <i>###/t/p</i> !survival <i>###/t/p</i> !taunt <i>###/t/p</i> !tumble <i>###/t/p</i> !togencs !togolm  ";
const string CMD_UVWXYZ_STAFF_DM_A = "!unvis !usemagicdevice <i>###/t/p</i> !vars <i>a</i> !version !where !xp <i>###</i> !zombie ";

// *************************** CONSTANTS ***************************************


//////////
/*
0	AliceBlue	F0F8FF
1	AntiqueWhite	FAEBD7
2	Aqua	00FFFF
3	Aquamarine	7FFFD4
4	Azure	F0FFFF
5	Beige	F5F5DC
6	Bisque	FFE4C4
7	Black	0
8	BlanchedAlmond	FFEBCD
9	Blue	0000FF
10	BlueViolet	8A2BE2
11	Brown	A52A2A
12	BurlyWood	DEB887
13	CadetBlue	5F9EA0
14	Chartreuse	7FFF00
15	Chocolate	D2691E
16	Coral	FF7F50
17	CornflowerBlue	6495ED
18	Cornsilk	FFF8DC
19	Crimson	DC143C
20	Cyan	00FFFF
21	DarkBlue	00008B
22	DarkCyan	008B8B
23	DarkGoldenRod	B8860B
24	DarkGray	A9A9A9
25	DarkGreen	6400
26	DarkKhaki	BDB76B
27	DarkMagenta	8B008B
28	DarkOliveGreen	556B2F
29	DarkOrange	FF8C00
30	DarkOrchid	9932CC
31	DarkRed	8B0000
32	DarkSalmon	E9967A
33	DarkSeaGreen	8FBC8F
34	DarkSlateBlue	483D8B
35	DarkSlateGray	2F4F4F
36	DarkTurquoise	00CED1
37	DarkViolet	9400D3
38	DeepPink	FF1493
39	DeepSkyBlue	00BFFF
40	DimGray	696969
41	DodgerBlue	1E90FF
42	Feldspar	D19275
43	FireBrick	B22222
44	FloralWhite	FFFAF0
45	ForestGreen	228B22
46	Fuchsia	FF00FF
47	Gainsboro	DCDCDC
48	GhostWhite	F8F8FF
49	Gold	FFD700
50	GoldenRod	DAA520
51	Gray	808080
52	Green	8000
53	GreenYellow	ADFF2F
54	HoneyDew	F0FFF0
55	HotPink	FF69B4
56	IndianRed	CD5C5C
57	Indigo	4B0082
58	Ivory	FFFFF0
59	Khaki	F0E68C
60	Lavender	E6E6FA
61	LavenderBlush	FFF0F5
62	LawnGreen	7CFC00
63	LemonChiffon	FFFACD
64	LightBlue	ADD8E6
65	LightCoral	F08080
66	LightCyan	E0FFFF
67	LightGoldenRodYellow	FAFAD2
68	LightGrey	D3D3D3
69	LightGreen	90EE90
70	LightPink	FFB6C1
71	LightSalmon	FFA07A
72	LightSeaGreen	20B2AA
73	LightSkyBlue	87CEFA
74	LightSlateBlue	8470FF
75	LightSlateGray	778899
76	LightSteelBlue	B0C4DE
77	LightYellow	FFFFE0
78	Lime	00FF00
79	LimeGreen	32CD32
80	Linen	FAF0E6
81	Magenta	FF00FF
82	Maroon	800000
83	MediumAquaMarine	66CDAA
84	MediumBlue	0000CD
85	MediumOrchid	BA55D3
86	MediumPurple	9370D8
87	MediumSeaGreen	3CB371
88	MediumSlateBlue	7B68EE
89	MediumSpringGreen	00FA9A
90	MediumTurquoise	48D1CC
91	MediumVioletRed	C71585
92	MidnightBlue	191970
93	MintCream	F5FFFA
94	MistyRose	FFE4E1
95	Moccasin	FFE4B5
96	NavajoWhite	FFDEAD
97	Navy	80
98	OldLace	FDF5E6
99	Olive	808000
100	OliveDrab	6B8E23
101	Orange	FFA500
102	OrangeRed	FF4500
103	Orchid	DA70D6
104	PaleGoldenRod	EEE8AA
105	PaleGreen	98FB98
106	PaleTurquoise	AFEEEE
107	PaleVioletRed	D87093
108	PapayaWhip	FFEFD5
109	PeachPuff	FFDAB9
110	Peru	CD853F
111	Pink	FFC0CB
112	Plum	DDA0DD
113	PowderBlue	B0E0E6
114	Purple	800080
115	Red	FF0000
116	RosyBrown	BC8F8F
117	RoyalBlue	4.17E+04
118	SaddleBrown	8B4513
119	Salmon	FA8072
120	SandyBrown	F4A460
121	SeaGreen	2E8B57
122	SeaShell	FFF5EE
123	Sienna	A0522D
124	Silver	C0C0C0
125	SkyBlue	87CEEB
126	SlateBlue	6A5ACD
127	SlateGray	708090
128	Snow	FFFAFA
129	SpringGreen	00FF7F
130	SteelBlue	4682B4
131	Tan	D2B48C
132	Teal	8080
133	Thistle	D8BFD8
134	Tomato	FF6347
135	Turquoise	40E0D0
136	Violet	EE82EE
137	VioletRed	D02090
138	Wheat	F5DEB3
139	White	FFFFFF
140	WhiteSmoke	F5F5F5
141	Yellow	FFFF00
142	YellowGreen	9ACD32
143	Text	C0C0C0
144	TextPositive	0DFEF8
145	TextNegative	FB2D2D
146	TextNeutral	DEDEDE
147	ItemUseable	FFFFFF
148	ItemNotUseable	FF0000
149	Unidentified	00FFFF
150	HotbarText	BCBCBC
151	HotbarDisabled	666666


152	HotbarItmNoUse	FF0000