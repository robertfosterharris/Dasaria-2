//Spawn System Version 2

#include "std_persist_i0"
#include "std_i0_misc"

const int DASARIA_SPAWN_VERBOSE_LOGGING = 0;
const int DASARIA_SPAWN_UPPERBOUND =	 25;
//increase this interger to add spawnpoints, easy
const string DASARIA_SPAWN_GUI_SCREEN = "DasariaSpawnLocation_New";
const string DASARIA_SPAWN_GUI_SCREEN_XML = "dasariaspawnlocation_new.xml";
const string DASARIA_SPAWN_GUI_LISTBOX_SPAWNPOINTS = "LISTBOX_SPAWNPOINTS";
const string DASARIA_SPAWN_GUI_TICKBOX_TEXT ="TXT_DASARIA_SPAWN_LOC";
const string DASARIA_SPAWN_GUI_JUMP_BUTTON ="JUMPBUTTON";
const string DASARIA_SPAWN_GUI_JUMP_ON_BUTTON ="Move to Location \n";
const string DASARIA_SPAWN_GUI_JUMP_OFF_BUTTON ="Starting location after next Reset \n";
const string DASARIA_SPAWN_GUI_TARGET_WPX  = "SPAWN_WP_";
const string DASARIA_SPAWN_GUI_SELECTED_WP_TO_SPAWN_AT  = "PCS_SELECTED_WP";
const string DASARIA_SPAWN_GUI_ALT_WP_NAME = "sAlt_WP_Name";
const string DASARIA_SPAWN_GUI_JUMP_STATUS = "iJumpStatus";
//const string TARGET_WP0  = "SPAWN_WP_00";



const int DASARIA_SPAWN_WP1_KNOW = 			16;
const int DASARIA_SPAWN_WP2_KNOW = 			32;
const int DASARIA_SPAWN_WP3_KNOW = 			64;
const int DASARIA_SPAWN_WP4_KNOW = 			128;
const int DASARIA_SPAWN_WP5_KNOW = 			256;
const int DASARIA_SPAWN_WP6_KNOW = 			512;
const int DASARIA_SPAWN_WP7_KNOW = 			1024;
const int DASARIA_SPAWN_WP8_KNOW = 			2048;
const int DASARIA_SPAWN_WP9_KNOW = 			4096;
const int DASARIA_SPAWN_WP10_KNOW = 		8192;
const int DASARIA_SPAWN_WP11_KNOW = 		16384;
const int DASARIA_SPAWN_WP12_KNOW = 		32768;
const int DASARIA_SPAWN_WP13_KNOW = 		65536;
const int DASARIA_SPAWN_WP14_KNOW =			131072;
const int DASARIA_SPAWN_WP15_KNOW = 		262144;
const int DASARIA_SPAWN_WP16_KNOW = 		524288;
const int DASARIA_SPAWN_WP17_KNOW = 		1048576;
const int DASARIA_SPAWN_WP18_KNOW = 		2097152;
const int DASARIA_SPAWN_WP19_KNOW = 		4194304;
const int DASARIA_SPAWN_WP20_KNOW = 		8388608;


//=====================Functions========================




void svl(object oPC, string sMessage)
{
	if(DASARIA_SPAWN_VERBOSE_LOGGING==1)
	{
		if (GetIsStaff(oPC)== TRUE) 
		{
			SendMessageToPC(oPC, sMessage);
		}
	}
}


//BEGIN sConstruct_WPString
//used to construct the WP names - spawn waypoints have a mandatory naming convention
string  sConstruct_WP_TAG_String(int iWP)
{
string sPaddedWaypoint;

	if(iWP<10)
	{
		sPaddedWaypoint = DASARIA_SPAWN_GUI_TARGET_WPX+ "0" + IntToString(iWP);
	}
	else{
		sPaddedWaypoint =  DASARIA_SPAWN_GUI_TARGET_WPX + IntToString(iWP);
	}

return sPaddedWaypoint;
}//END sConstruct_WPString


//BEGIN sGet_NameorWaypoint
//
string sGet_NameorWaypoint( string sTARGET_WP_TAG )
{
	object oWP;
	object oArea;
	string sNameorWPName;
	string sNameToReturn;
	
	oWP = GetObjectByTag(sTARGET_WP_TAG);
	sNameorWPName = GetLocalString(oWP, DASARIA_SPAWN_GUI_ALT_WP_NAME);
	
	if(sNameorWPName == "")
	{
		oArea = GetArea(oWP);
		sNameToReturn = GetName(oArea);
	
		if(oArea == OBJECT_INVALID )
		{
			sNameToReturn = "Unassigned Waypoint";
		}
	}
	else{
		sNameToReturn = GetLocalString(oWP, DASARIA_SPAWN_GUI_ALT_WP_NAME );
	}
	
	return sNameToReturn;
}//END sGet_NameorWaypoint


void RetroFit(object oJournal, object oPC)
{
	int iNoLocLoop;
	int iKNOWLoop;
	int iStartHere = DASARIA_SPAWN_WP1_KNOW;
	int iDasariaSpawnK = GetLocalInt(oJournal, "iDasariaSpawnK");
	
	string sWP;

	if(iDasariaSpawnK > 0)
	{		

		if (iDasariaSpawnK & DASARIA_SPAWN_WP1_KNOW ){SetLocalString(oJournal, sConstruct_WP_TAG_String(1), sConstruct_WP_TAG_String(1));}
		if (iDasariaSpawnK & DASARIA_SPAWN_WP2_KNOW ){SetLocalString(oJournal, sConstruct_WP_TAG_String(2), sConstruct_WP_TAG_String(2));}
		if (iDasariaSpawnK & DASARIA_SPAWN_WP3_KNOW ){SetLocalString(oJournal, sConstruct_WP_TAG_String(3), sConstruct_WP_TAG_String(3));}
		if (iDasariaSpawnK & DASARIA_SPAWN_WP4_KNOW ){SetLocalString(oJournal, sConstruct_WP_TAG_String(4), sConstruct_WP_TAG_String(4));}
		if (iDasariaSpawnK & DASARIA_SPAWN_WP5_KNOW ){SetLocalString(oJournal, sConstruct_WP_TAG_String(5), sConstruct_WP_TAG_String(5));}
		if (iDasariaSpawnK & DASARIA_SPAWN_WP6_KNOW ){SetLocalString(oJournal, sConstruct_WP_TAG_String(6), sConstruct_WP_TAG_String(6));}
		if (iDasariaSpawnK & DASARIA_SPAWN_WP7_KNOW ){SetLocalString(oJournal, sConstruct_WP_TAG_String(7), sConstruct_WP_TAG_String(7));}
		if (iDasariaSpawnK & DASARIA_SPAWN_WP8_KNOW ){SetLocalString(oJournal, sConstruct_WP_TAG_String(8), sConstruct_WP_TAG_String(8));}
		if (iDasariaSpawnK & DASARIA_SPAWN_WP9_KNOW ){SetLocalString(oJournal, sConstruct_WP_TAG_String(9), sConstruct_WP_TAG_String(9));}
		if (iDasariaSpawnK & DASARIA_SPAWN_WP10_KNOW ){SetLocalString(oJournal, sConstruct_WP_TAG_String(10), sConstruct_WP_TAG_String(10));}
		if (iDasariaSpawnK & DASARIA_SPAWN_WP11_KNOW ){SetLocalString(oJournal, sConstruct_WP_TAG_String(11), sConstruct_WP_TAG_String(11));}
		if (iDasariaSpawnK & DASARIA_SPAWN_WP12_KNOW ){SetLocalString(oJournal, sConstruct_WP_TAG_String(12), sConstruct_WP_TAG_String(12));}
		if (iDasariaSpawnK & DASARIA_SPAWN_WP13_KNOW ){SetLocalString(oJournal, sConstruct_WP_TAG_String(13), sConstruct_WP_TAG_String(13));}
		if (iDasariaSpawnK & DASARIA_SPAWN_WP14_KNOW ){SetLocalString(oJournal, sConstruct_WP_TAG_String(14), sConstruct_WP_TAG_String(14));}
		if (iDasariaSpawnK & DASARIA_SPAWN_WP15_KNOW ){SetLocalString(oJournal, sConstruct_WP_TAG_String(15), sConstruct_WP_TAG_String(15));}
		if (iDasariaSpawnK & DASARIA_SPAWN_WP16_KNOW ){SetLocalString(oJournal, sConstruct_WP_TAG_String(16), sConstruct_WP_TAG_String(16));}
		if (iDasariaSpawnK & DASARIA_SPAWN_WP17_KNOW ){SetLocalString(oJournal, sConstruct_WP_TAG_String(17), sConstruct_WP_TAG_String(17));}
		if (iDasariaSpawnK & DASARIA_SPAWN_WP18_KNOW ){SetLocalString(oJournal, sConstruct_WP_TAG_String(18), sConstruct_WP_TAG_String(18));}
		if (iDasariaSpawnK & DASARIA_SPAWN_WP19_KNOW ){SetLocalString(oJournal, sConstruct_WP_TAG_String(19), sConstruct_WP_TAG_String(19));}
		if (iDasariaSpawnK & DASARIA_SPAWN_WP20_KNOW ){SetLocalString(oJournal, sConstruct_WP_TAG_String(20), sConstruct_WP_TAG_String(20));}
	
		SetLocalInt(oJournal, "iDasariaSpawnK", 0);		
	}
}
//
//BEGIN Display_DasariaSpawnGUI
//Display the GUI

void  Display_DasariaSpawnGUI(object oPC, int iJumpToLocationDisabled=0 )
{

	object oJournal = std_journal_get( oPC );
	
	int iTestLoop;
	int iNo_of_SpawnpointsKnown;
	int iJumpStatus = GetLocalInt(oPC,DASARIA_SPAWN_GUI_JUMP_STATUS);
	
	string sSpawnDescription;
	string sVariables;

	string WayPointTag;
	string WayPointTag_Test;

	string WayPointToJumpTo;
	string WayPointToJumpTo_Name;
		
	string WP0 = sConstruct_WP_TAG_String(0);
	
	//svl(oPC,"TMP ginc1: Display_DasariaSpawnGUI BEGIN");
	//svl(oPC,"TMP ginc1: iJumpToLocationDisabled = "+IntToString(iJumpToLocationDisabled));
	//svl(oPC,"TMP ginc1:DASARIA_SPAWN_GUI_SELECTED_WP_TO_SPAWN_AT = #"+GetLocalString(oJournal,DASARIA_SPAWN_GUI_SELECTED_WP_TO_SPAWN_AT )+"#");			
	
	
	
	
	DisplayGuiScreen(oPC,DASARIA_SPAWN_GUI_SCREEN,FALSE,DASARIA_SPAWN_GUI_SCREEN_XML);	
	
	
	
	RetroFit(oJournal, oPC);
	
	//Set the Misty Vale WP if it doesn't exist - New Character
	if (GetLocalString(oJournal, WP0 ) == "")
	{
		SetLocalString(oJournal, WP0, sConstruct_WP_TAG_String(0));
		SetLocalString(oJournal, DASARIA_SPAWN_GUI_SELECTED_WP_TO_SPAWN_AT, sConstruct_WP_TAG_String(0));
		
	}
	
	WayPointToJumpTo = GetLocalString(oJournal, DASARIA_SPAWN_GUI_SELECTED_WP_TO_SPAWN_AT);
	WayPointToJumpTo_Name = "Start at "+ sGet_NameorWaypoint(WayPointToJumpTo);
	
	//svl(oPC,"VERBOSE: Display_DasariaSpawnGUI Clear List Boxes");
	ClearListBox(oPC, DASARIA_SPAWN_GUI_SCREEN, DASARIA_SPAWN_GUI_LISTBOX_SPAWNPOINTS); 
	

	for(iTestLoop = 0; iTestLoop <= DASARIA_SPAWN_UPPERBOUND; iTestLoop++)
	{
		//svl(oPC,"VERBOSE: iTestLoop BEGIN #"+IntToString(iTestLoop)+"#");
		WayPointTag = sConstruct_WP_TAG_String(iTestLoop);
		//svl(oPC,"VERBOSE: Display_DasariaSpawnGUI WayPointTag#"+WayPointTag+"#");
		WayPointTag_Test = GetLocalString(oJournal, WayPointTag );
		//svl(oPC,"VERBOSE: Display_DasariaSpawnGUI WayPointTag_Test#"+WayPointTag_Test+"#");
		
		if(WayPointTag == WayPointTag_Test)
		{
			//svl(oPC,"VERBOSE: Display_DasariaSpawnGUI WayPointTag == WayPointTag_Test");		
			sSpawnDescription =  "TXT_DASARIA_SPAWN_LOC=" + sGet_NameorWaypoint( WayPointTag );	
			//svl(oPC,"TMP: Display_DasariaSpawnGUI Add sSpawnDescription = #"+sSpawnDescription+"#");
						
			sVariables = "1=0;2=" + IntToString(iTestLoop);
			
			sVariables = sVariables +";3=" + WayPointTag;
			
			//svl(oPC,"TMP: Display_DasariaSpawnGUI sVariables = #"+sVariables+"#");						
		
			AddListBoxRow(oPC, "DasariaSpawnLocation_New", "LISTBOX_SPAWNPOINTS", "Row" + IntToString(iTestLoop), sSpawnDescription, "", sVariables, ""  ); 
		}
	}

	WayPointToJumpTo_Name = DASARIA_SPAWN_GUI_JUMP_ON_BUTTON+ sGet_NameorWaypoint(WayPointToJumpTo);
	SetGUIObjectText(oPC,DASARIA_SPAWN_GUI_SCREEN,DASARIA_SPAWN_GUI_JUMP_BUTTON,-1, WayPointToJumpTo_Name);

	if(iJumpStatus == 2)
	{
		WayPointToJumpTo_Name = DASARIA_SPAWN_GUI_JUMP_OFF_BUTTON+ sGet_NameorWaypoint(WayPointToJumpTo);
		SetGUIObjectText(oPC,DASARIA_SPAWN_GUI_SCREEN,DASARIA_SPAWN_GUI_JUMP_BUTTON,-1, WayPointToJumpTo_Name);
		SetGUIObjectDisabled(oPC, DASARIA_SPAWN_GUI_SCREEN,DASARIA_SPAWN_GUI_JUMP_BUTTON, 1);	
	
	}

}




//====

void ManageDasariaSpawnEnter(object oPC)

// add to the areas oncliententer script
{
	object oJournal = std_journal_get( oPC );
	object oPCArea;
	object oPerferredWPArea;
	object oMistyWPArea;

	
	location lPerferredWP;
	
	string sPreferredWP_Tag;		
	string sMistyWP_Tag = sConstruct_WP_TAG_String(0);
	
 	int iJumpToLocationDisabled = GetLocalInt(oPC,DASARIA_SPAWN_GUI_JUMP_STATUS);
	
	if(!GetIsPC(oPC))return;

	//svl(oPC,"TMP oe1: ManageDasariaSpawnEnter");	
	//svl(oPC,"TMP oe1: TARGET_WP0 #"+GetLocalString(oJournal, sMistyWP_Tag )+"#");
	//svl(oPC,"TMP oe1: DASARIA_SPAWN_GUI_SELECTED_WP_TO_SPAWN_AT = #"+GetLocalString(oJournal,DASARIA_SPAWN_GUI_SELECTED_WP_TO_SPAWN_AT )+"#");			
	
	if (GetLocalString(oJournal, sMistyWP_Tag ) == "")
	{
		SetLocalString(oJournal, sConstruct_WP_TAG_String(0), sConstruct_WP_TAG_String(0));
		SetLocalString(oJournal, DASARIA_SPAWN_GUI_SELECTED_WP_TO_SPAWN_AT, sConstruct_WP_TAG_String(0));
		RetroFit(oJournal, oPC);
	}		

	//svl(oPC,"TMP oe2: TARGET_WP0 #"+GetLocalString(oJournal,sConstruct_WP_TAG_String(0))+"#");
	//svl(oPC,"TMP oe2: DASARIA_SPAWN_GUI_SELECTED_WP_TO_SPAWN_AT = #"+GetLocalString(oJournal,DASARIA_SPAWN_GUI_SELECTED_WP_TO_SPAWN_AT )+"#");			
	
			
	if(iJumpToLocationDisabled==0)
	//If its the PCs first log in since reset this will be 0;
	{
	
		oPCArea = GetArea(oPC);
		oMistyWPArea = GetArea(GetObjectByTag(sMistyWP_Tag));
		sPreferredWP_Tag = GetLocalString(oJournal, DASARIA_SPAWN_GUI_SELECTED_WP_TO_SPAWN_AT);
		oPerferredWPArea = GetArea(GetObjectByTag(sPreferredWP_Tag)); 

		if(oPCArea == oMistyWPArea)
		{
			//svl(oPC,"TMP: ManageDasariaSpawnEnter > oPCArea == oMistyWPArea");
			//PC is in the Misty
			if(oPCArea == oPerferredWPArea)
			{
				//svl(oPC,"TMP: ManageDasariaSpawnEnter > oMistyWPArea > oPCArea == oPerferredWPArea ");			
				//stop - this is their preferred area
				SetLocalInt(oPC,DASARIA_SPAWN_GUI_JUMP_STATUS,1);
			}
			else{
			
				//svl(oPC,"TMP: ManageDasariaSpawnEnter > oMistyWPArea > oPCArea != oPerferredWPArea #"+sPreferredWP_Tag+"#");
				//svl(oPC,"TMP: DASARIA_SPAWN_GUI_SELECTED_WP_TO_SPAWN_AT = #"+sPreferredWP_Tag+"#");			
				//svl(oPC, "Send Message To PC: Moving you to "+ sGet_NameorWaypoint(sPreferredWP_Tag));	
				SendMessageToPC(oPC, "Moving you to "+ sGet_NameorWaypoint(sPreferredWP_Tag));
				lPerferredWP = GetLocation(GetObjectByTag(sPreferredWP_Tag));
				
				AssignCommand(oPC, ClearAllActions(TRUE));
				AssignCommand(oPC, JumpToLocation(lPerferredWP));
			}
		}
		
		if(oPCArea == oPerferredWPArea && oPCArea != oMistyWPArea )
		{
				SetLocalInt(oPC,DASARIA_SPAWN_GUI_JUMP_STATUS,1);		
		}
		
		
	}
	//else - assume we're done
	
}



void ManageDasariaSpawnExit(object oPC)
// add to the areas onclientexit script
{
	object oJournal = std_journal_get( oPC );
 	int iJumpToLocationDisabled = GetLocalInt(oPC,DASARIA_SPAWN_GUI_JUMP_STATUS);
	
	if(iJumpToLocationDisabled == 1 ) //|| took this out iJumpToLocationDisabled == 0
	{
  		SetLocalInt(oPC,DASARIA_SPAWN_GUI_JUMP_STATUS,2);	
	}
	CloseGUIScreen(oPC,DASARIA_SPAWN_GUI_SCREEN);
}

