// wired 2010/01/16
// ga_delete_char
// 2010/10/08 Wired -- Purge faction renown of PC and faction on suicide

#include "nwnx_character"
#include "ginc_renown"

void main()
{
	object oPC 			=	GetPCSpeaker();
	
	if (!GetIsObjectValid(oPC) || !GetIsPC(oPC)) return;
	
	string sCharName	=	GetName(oPC);
	string sPlayerName	=	GetPCPlayerName(oPC);
	string sCDKey		=	GetPCPublicCDKey(oPC);
	string sBicFileName	=	GetBicFileName(oPC);
	
	SendMessageToPC(oPC,"<i>This is the way the world ends,");
	SendMessageToPC(oPC,"<i>This is the way the world ends,");
	SendMessageToPC(oPC,"<i>Not with a bang, but a whisper.");	
	
	// renown stuff
	setMetaFactionRenown(getMetaFaction(oPC), getMetaFactionRenown(oPC) - getPCMetaFactionRenown(oPC));
	setPCMetaFactionRenown(oPC, 0);

	DelayCommand(1.0,FadeToBlack(oPC,FADE_SPEED_SLOWEST,3.0f,COLOR_WHITE));
		
	DelayCommand(4.0,ArchiveCharacter(oPC));

	WriteTimestampedLogEntry("SUICIDE: Player "+sPlayerName+" ("+sCDKey+") retired character "+sCharName+", "+sBicFileName);
}