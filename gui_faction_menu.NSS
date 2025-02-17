#include "ginc_faction"
#include "x0_i0_stringlib"

void main()
{
	object oPC;
	string sFaction;
	string sFactionCharacter;
	string sFactionCharacterID;
	string sMenu;
	string sSelection1;
	string sSelection2;
	string sSQL;

	//
	//	RETRIEVE DATA FROM MENU SELECTION
	//
	sMenu = GetTokenByPosition(GetLocalString(OBJECT_SELF, "sDasariaMenuSelection"), "~", 0);
	sSelection1 = GetTokenByPosition(GetLocalString(OBJECT_SELF, "sDasariaMenuSelection"), "~", 1);
	sSelection2 = GetTokenByPosition(GetLocalString(OBJECT_SELF, "sDasariaMenuSelection"), "~", 2);

	//
	//	RETRIEVE DATA FROM OBJECT VARIABLES
	//
	sFaction = GetLocalString(OBJECT_SELF, "sFaction");
	sFactionCharacter = GetLocalString(OBJECT_SELF, "sFactionCharacter");
	sFactionCharacterID = GetLocalString(OBJECT_SELF, "sFactionCharacterID");
	
	//
	//	CLOSE THE MENU
	//
	CloseGUIScreen(OBJECT_SELF, "SCREEN_DASARIA_MENU");

	//
	//	PROCESS MENU SELECTION
	//

	//
	//	HANDLE FACTION MENU SELECTION
	//
	if (sMenu == "FACTION")
	{
		if (sSelection1 == "ADD")
		{
			DisplayInputBox(OBJECT_SELF, 0, "Enter Faction Name:", "gui_faction_add_ok");
		}
		else
		{
			SetLocalString(OBJECT_SELF, "sFaction", sSelection1);
			showFactionMemberMenu(OBJECT_SELF);
		}
	}

	//
	//	HANDLE FACTION MEMBER MENU SELECTION
	//	
	if (sMenu == "FACTION_MEMBER")
	{
		if (sSelection1 == "ADD")
		{
			showFactionMemberAddMenu(OBJECT_SELF);
		}
		if (sSelection1 == "DELETE")
		{
			if (GetIsFactionAdministrator(OBJECT_SELF, sFaction))
			{
				sSQL = "DELETE FROM faction WHERE faction.faction = '" + SQLEncodeSpecialChars(sFaction) + "'";
				SQLExecDirect(sSQL);
				if (SQLGetAffectedRows() > 0)
				{
					SendMessageToPC(OBJECT_SELF, "SUCCESS: Faction deleted.");
				}
				else
				{
					SendMessageToPC(OBJECT_SELF, "ERROR: Failed to delete faction.");
				}
			}
			showFactionMenu(OBJECT_SELF);
		}
		if (sSelection1 == "BACK")
		{
			showFactionMenu(OBJECT_SELF);
		}		
		if (sSelection1 != "ADD" && sSelection1 != "DELETE" && sSelection1 != "BACK")
		{
			SetLocalString(OBJECT_SELF, "sFactionCharacterID", sSelection1);
			SetLocalString(OBJECT_SELF, "sFactionCharacter", sSelection2);
			showFactionMemberAdministrationMenu(OBJECT_SELF);
		}
	}

	//
	//	HANDLE FACTION MEMBER ADMINISTRATION MENU SELECTION
	//	
	if (sMenu == "FACTION_MEMBER_ADMINISTRATION")
	{
		if (sSelection1 == "ADMINISTRATOR")
		{
			if (GetIsFactionAdministrator(OBJECT_SELF, sFaction))
			{
				sSQL = "UPDATE faction_member SET faction_member.administrator = 1 WHERE faction_member.faction = '" + SQLEncodeSpecialChars(sFaction) + "' AND faction_member.pcid = " + sFactionCharacterID;
				SQLExecDirect(sSQL);
				if (SQLGetAffectedRows() > 0)
				{
					SendMessageToPC(OBJECT_SELF, "SUCCESS: Administrative rights granted.");
				}
			}
			else
			{
				SendMessageToPC(OBJECT_SELF, "ERROR: Insufficient privilege.");
			}
			showFactionMemberMenu(OBJECT_SELF);
		}
		if (sSelection1 == "DELETE")
		{
			if (GetIsFactionAdministrator(OBJECT_SELF, sFaction) || (getPCid(OBJECT_SELF) == sFactionCharacterID))
			{
				sSQL = "SELECT * FROM faction_member WHERE faction_member.faction = '" + SQLEncodeSpecialChars(sFaction) + "'";
				SQLExecDirect(sSQL);
				if (SQLGetAffectedRows() == 1)
				{
					sSQL = "DELETE FROM faction WHERE faction.faction = '" + SQLEncodeSpecialChars(sFaction) + "'";
					SQLExecDirect(sSQL);
					if (SQLGetAffectedRows() > 0)
					{
						SendMessageToPC(OBJECT_SELF, "SUCCESS: Faction deleted.");
					}
					else
					{
						SendMessageToPC(OBJECT_SELF, "ERROR: Failed to delete faction.");
					}
					showFactionMenu(OBJECT_SELF);
				}
				else
				{
					sSQL = "DELETE FROM faction_member WHERE faction_member.faction = '" + SQLEncodeSpecialChars(sFaction) + "' AND faction_member.pcid = " + sFactionCharacterID;
					SQLExecDirect(sSQL);
					if (SQLGetAffectedRows() > 0)
					{
						SendMessageToPC(OBJECT_SELF, "SUCCESS: Faction member deleted.");
					}
					else
					{
						SendMessageToPC(OBJECT_SELF, "ERROR: Failed to delete faction member.");
					}
					showFactionMemberMenu(OBJECT_SELF);
				}
			}
			else
			{
				SendMessageToPC(OBJECT_SELF, "ERROR: Insufficient privilege.");
				showFactionMemberMenu(OBJECT_SELF);
			}
		}
		if (sSelection1 == "BACK")
		{
			showFactionMemberMenu(OBJECT_SELF);
		}		
	}

	//
	//	HANDLE FACTION MEMBER ADD MENU SELECTION
	//	
	if (sMenu == "FACTION_MEMBER_ADD")
	{
		sSQL = "INSERT INTO faction_member VALUES ('" + SQLEncodeSpecialChars(sFaction) + "', " + SQLEncodeSpecialChars(sSelection1) + ", 0)";
		SQLExecDirect(sSQL);
		if (SQLGetAffectedRows() > 0)
		{
			SendMessageToPC(oPC, "SUCCESS: Faction member added.");
		}
		else
		{
			SendMessageToPC(oPC, "ERROR: SQL - Failed to add faction member.");
		}
		showFactionMemberMenu(OBJECT_SELF);
	}
	if (sMenu == "FACTION_MEMBER_BACK")
	{
		showFactionMemberMenu(OBJECT_SELF);
	}
}