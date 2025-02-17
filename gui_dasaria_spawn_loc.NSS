#include "ginc_spawnsystem"


//=====================MAIN=================7=========== 

/*
Open GUI = 						iMenuSelection: 0
select a location available = 	iMenuSelection: 1
JumpToLocation Button = 		iMenuSelection: 150
CloseButton = 					iMenuSelection: 500

*/


void main(string sMenuSelection, string sVar2, string sVar3)
{
	object oPC;
	object oJournal;
	object oTargetWP;
	object oAreaPC;
	object oAreaTargetWP;
	
	
	int iMenuSelection, iVar2,iVar3;
		
	
	int iDasaria_Spawn_Upperbound;//max waypoints
	int iJumpToLocationDisabled; //local int stored/read from oPC
	
	
	int iTargetWP;
	int iOptionSelected;
	int iWPID;
	int iMenuSelection_stdfix;
	
	//For the teleport spell/code
	int iTokenLoop;
	int iCustomToken = 1800;	
	int iCustomTokenR;
	string WayPointTag;
	string WayPointTag_Test;
	string sTokenName;
	//
	
	string sWPID;
	string sPreferredWP_Tag;
	string sAboutText;
	
	location lPerferredWP;
	
	//Get the PC 
	oPC = OBJECT_SELF; //assumes GUI active
	
	//svl(oPC,"VERBOSE:ON");
	//svl(oPC,"VERBOSE: sMenuSelection = #"+sMenuSelection+"#");
	//svl(oPC,"VERBOSE: sVar2 = #"+sVar2+"#");
	//svl(oPC,"VERBOSE: sVar3 = #"+sVar3+"#");
	
	iMenuSelection = StringToInt(sMenuSelection);
	
	
	//Get Local vars
	oJournal = std_journal_get( oPC );
	
	
	iDasaria_Spawn_Upperbound = (DASARIA_SPAWN_UPPERBOUND);
	iJumpToLocationDisabled = GetLocalInt(oPC,DASARIA_SPAWN_GUI_JUMP_STATUS);
	
	//svl(oPC,"TMP: iJumpToLocationDisabled = "+IntToString(iJumpToLocationDisabled));
	
	
	switch(iMenuSelection)
		{
			case 0:
			//svl(oPC,"TMP:OPEN GUI");
			//svl(oPC,"TMP: iJumpToLocationDisabled = "+IntToString(iJumpToLocationDisabled));						
			//svl(oPC,"TMP:DASARIA_SPAWN_GUI_SELECTED_WP_TO_SPAWN_AT = #"+GetLocalString(oJournal,DASARIA_SPAWN_GUI_SELECTED_WP_TO_SPAWN_AT )+"#");			
			
			Display_DasariaSpawnGUI(oPC);
		
			break;
		
			case 1:
			//svl(oPC,"TMP:Update a selected spawn point");
			//svl(oPC,"TMP: iJumpToLocationDisabled = "+IntToString(iJumpToLocationDisabled));
			//svl(oPC,"TMP:DASARIA_SPAWN_GUI_SELECTED_WP_TO_SPAWN_AT = #"+GetLocalString(oJournal,DASARIA_SPAWN_GUI_SELECTED_WP_TO_SPAWN_AT )+"#");			

			SetLocalString(oJournal, DASARIA_SPAWN_GUI_SELECTED_WP_TO_SPAWN_AT, sVar3);	
			CloseGUIScreen(oPC,DASARIA_SPAWN_GUI_SCREEN);
			Display_DasariaSpawnGUI( oPC, 1 );
			break;
		
		
			case 150:
			//svl(oPC,"TMP:JUMPSELECTED");
			//svl(oPC,"TMP: iJumpToLocationDisabled = "+IntToString(iJumpToLocationDisabled));
			//svl(oPC,"TMP:DASARIA_SPAWN_GUI_SELECTED_WP_TO_SPAWN_AT = #"+GetLocalString(oJournal,DASARIA_SPAWN_GUI_SELECTED_WP_TO_SPAWN_AT )+"#");			
			
			if(iJumpToLocationDisabled != 2)
			{
			 	oAreaPC = GetArea(oPC);
			
				sPreferredWP_Tag = GetLocalString(oJournal,DASARIA_SPAWN_GUI_SELECTED_WP_TO_SPAWN_AT );
				oAreaTargetWP = GetArea(GetObjectByTag(sPreferredWP_Tag));
				if(oAreaPC == oAreaTargetWP)
				{
					SendMessageToPC(oPC, "You are already at "+ sGet_NameorWaypoint(sPreferredWP_Tag));
				}
				else{
					SendMessageToPC(oPC, "Moving you to "+ sGet_NameorWaypoint(sPreferredWP_Tag));				
					lPerferredWP = GetLocation(GetObjectByTag(sPreferredWP_Tag));
					CloseGUIScreen(oPC,DASARIA_SPAWN_GUI_SCREEN);
					JumpToLocation(lPerferredWP);
					SetLocalInt(oPC, DASARIA_SPAWN_GUI_JUMP_STATUS, 2);	
					
				}
			}	
			else{
				SendMessageToPC(oPC, "You are unable to move your character at this time.");
			}	
					
			
			
			
			break;
		
			case 500:
			//svl(oPC,"TMP:CLOSE SELECTED");
			//svl(oPC,"TMP: iJumpToLocationDisabled = "+IntToString(iJumpToLocationDisabled));
			//svl(oPC,"TMP:DASARIA_SPAWN_GUI_SELECTED_WP_TO_SPAWN_AT = #"+GetLocalString(oJournal,DASARIA_SPAWN_GUI_SELECTED_WP_TO_SPAWN_AT )+"#");			
						
			CloseGUIScreen(oPC,DASARIA_SPAWN_GUI_SCREEN);
			break;
			
			
		}	

}


