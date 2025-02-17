// gui_d2_examine_renown
// wired 09/19/2010
// OnAdd0=UIObject_Misc_ExecuteServerScript("gui_d2_examine_renown")
//
// wired 6/15/2011 (bio stuff)

#include "ginc_renown"

// use a gui callback to capture the pc's initial bio
void GrabBio(object oPC);

// take the bio stored on the pc and copy it to the journal
void PersistBio(object oPC);

void main()
{
	object oPC = OBJECT_SELF;
	object oTarget = GetPlayerCurrentTarget(oPC);
	object oJournal;
	
	int nFac;
	string sMetaFactionName;
	int nRenown;
	string sRankName;
	
	SetGUIObjectHidden( oPC,"SCREEN_EXAMINE", "EDIT_BIO", TRUE );

	if (GetIsPC(oTarget) || oTarget == OBJECT_SELF)
	{	
		// PLAYER BIO STUFF
		if (oTarget == OBJECT_SELF )
		{
			if (bDEBUG) SendMessageToPC(oPC,"DEBUG: Self Exam");
			
			oJournal = std_journal_get( oPC );
			// this is my first time examining myself
			// store my original bio for future reference
			//
			if (GetLocalString(oJournal,"DESCRIPTION") == "")
			{
				if (bDEBUG) SendMessageToPC(oPC,"DEBUG: No Stored Bio");

				GrabBio(oPC);
				
				// Recast as persistent variable
				DelayCommand( 2.0f, PersistBio(oPC));					
						
			}
			else
			{
				if (bDEBUG) SendMessageToPC(oPC,"DEBUG: Using Stored Bio");
			}
		
			SetGUIObjectHidden( oPC,"SCREEN_EXAMINE", "EDIT_BIO", FALSE );
		}
	
		// METAFACTION/RENOWN STUFF
		nFac = getMetaFaction(oTarget);
		
		if (nFac > 0)
		{		
			sMetaFactionName = getMetaFactionName(nFac);
			nRenown = getPCMetaFactionRenown(oTarget);
			if (nRenown > 24)
			{
				sRankName = getRankName(nFac, nRenown);		
				SetGUIObjectText( oPC, "SCREEN_EXAMINE", "RENOWN_TEXT", 1, "Renown: "+sMetaFactionName+" "+sRankName+"\n");
			}
		}
	}
}


void PersistBio(object oPC)
{
	if (bDEBUG) SendMessageToPC(oPC,"DEBUG: PersistBio");
	
	object oJournal = std_journal_get( oPC );	
	string sBio = GetLocalString(oPC,"DESCRIPTION");	
		
	if (sBio != "")
	{
		SetLocalString(oJournal,"DESCRIPTION",sBio);
	}
	
	if (bDEBUG) SendMessageToPC(oPC,"Bio was: "+sBio);
}

void GrabBio(object oPC)
{
		if (bDEBUG) SendMessageToPC(oPC,"DEBUG: GrabBio");
	
		DisplayGuiScreen(oPC,"SCREEN_EXAMINE_DESCRIPTION", FALSE, "_SCdescription_data.xml");
		int iRandom = Random(20000)+1;
		SetLocalInt( oPC, "CSL_DATACALLBACKDESCRIPTION", iRandom );
		SetLocalGUIVariable(oPC,"SCREEN_EXAMINE_DESCRIPTION", 5, IntToString(iRandom) );
		DelayCommand( 2.0f, DeleteLocalInt( oPC,"CSL_DATACALLBACKDESCRIPTION") );
		
		if (bDEBUG) DelayCommand( 2.0f, SendMessageToPC( oPC, "Bio: "+GetLocalString( oPC, "DESCRIPTION") ) );		
		
		// Recast as persistent variable
		DelayCommand( 2.0f, PersistBio(oPC));
}