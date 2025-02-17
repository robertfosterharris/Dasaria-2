// gui_d2_charscrn_renown
// wired 09/19/2010
// UIObject_Misc_ExecuteServerScript("gui_d2_charscrn_renown")

#include "ginc_renown"

void main()
{
	object oPC = OBJECT_SELF;	
	object oViewer = GetControlledCharacter(OBJECT_SELF);
	string sSCREEN = "SCREEN_CHARACTER";

	int nRenown;
	int nRank;
	int nNextLevel;		
	int nNeededToLevel;
	int nProgressToLevel;
	string sMetaFactionName;	
	string sRankName;
	string sTexture;	
	float fPos;

	int _bDEBUG = FALSE;
	
	if (GetIsDM(OBJECT_SELF) || GetIsDMPossessed(OBJECT_SELF))
	{
		oPC 	= GetPlayerCurrentTarget(OBJECT_SELF);
		
		if (GetIsPC(oPC) && GetIsObjectValid(oPC))
		{
			sSCREEN = "SCREEN_CREATUREEXAMINE"; 			
		}
		else
		{
			return;
		}
	}
	else
	{
		// why? because...
		oPC = OBJECT_SELF;
	}
	
	if (_bDEBUG == TRUE) SendMessageToPC(oPC,"gui_d2_charscrn_renown IS RUNNING!");
	
	int nFac = getMetaFaction(oPC);
	
	if (nFac > 0)
	{
		sMetaFactionName 	= getMetaFactionName(nFac);
		nRenown 			= getPCMetaFactionRenown(oPC);
		sRankName 			= getRankName(nFac, nRenown);
		nRank 				= getRank(nRenown);
		nNextLevel 			= getMinRenownFromRank(nRank+1);// RENOWN_TEXT Denominator (Renown/Next Level)
		nNeededToLevel		= getNeededToLevel(nRank);		// RENOWN_PROGRESS Denominator: How many points are needed to get from rank n to rank n+1? 
		
		// special case					
		if (nRenown < 1)
		{
			fPos = 0.0;
		}
		// special case	
		if (nRenown >= 500)
		{
			fPos = 100.0;
		}		
		else
		{			
			// RENOWN_PROGRESS Numerator: My current renown, less everything I needed to get the last level
			nProgressToLevel	= nRenown - getMinRenownFromRank(nRank);
			
			// Calc % Complete Position	
			fPos 				= IntToFloat(nProgressToLevel) / IntToFloat(nNeededToLevel);
		}
		
		
		switch (nFac)
		{
			case 1:
				sTexture = "ig_hu_redknight.tga";
			break;
			case 2:
				sTexture = "ife_CT_divinewrath.tga";
			break;
			case 3:
				sTexture = "ig_hu_velsharoon.tga";
			break;
		}
	}
	else
	{
		sMetaFactionName = "Undeclared";
		sTexture = "is_identify.tga";
		nRenown = 0;
		fPos = 0.0;
		sRankName = "";
	}
	
	/*
	SetGUIObjectText( oPC, "SCREEN_CHARACTER", "METAFACTION_TEXT", 1, "Rebel Warrior"); 
	SetGUITexture( oPC, "SCREEN_CHARACTER", "METAFACTION_ICON", "ife_CT_divinewrath.tga" );
	SetGUIObjectText( oPC, "SCREEN_CHARACTER", "RENOWN_TEXT", 1, "Renown (372/400)");	
	SetGUIProgressBarPosition( oPC, "SCREEN_CHARACTER", "RENOWN_PROGRESS", 0.5 );
	*/
	
	SetGUIObjectText( oViewer, sSCREEN, "METAFACTION_TEXT", 1,  sMetaFactionName+" "+sRankName); 
	SetGUITexture( oViewer, sSCREEN, "METAFACTION_ICON", sTexture );
	
	SetGUIObjectText( oViewer, sSCREEN, "RENOWN_TEXT", 1, "Renown ("+IntToString(nRenown)+"/"+IntToString(nNextLevel)+")");	
	SetGUIProgressBarPosition( oViewer, sSCREEN, "RENOWN_PROGRESS", fPos );
}