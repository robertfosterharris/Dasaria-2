//	FUNCTIONS USED BY DASARIA'S PLAYER FACTION SYSTEM
//
//	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM	10/26/2008
//
#include "d2_sql"
//
//	RETURNS TRUE IF oPC IS IN sFACTION
//
int GetIsInFaction (object oPC, string sFaction)
{
	int bIsInFaction;
	string sSQL;
	
	bIsInFaction = FALSE;
	
	sSQL = "SELECT * FROM faction_member WHERE faction_member.faction = '" + SQLEncodeSpecialChars(sFaction) + "' AND faction_member.pcid = " + getPCid(oPC);
	SQLExecDirect(sSQL);
	if (SQLGetAffectedRows() > 0 || GetIsDM(oPC)) bIsInFaction = TRUE;
	
	return bIsInFaction;
}
//
//	RETURNS TRUE IF oPC IS THE ADMINISTRATOR OF sFACTION
//
int GetIsFactionAdministrator (object oPC, string sFaction)
{
	int bIsInFaction;
	string sSQL;
	
	bIsInFaction = FALSE;
	
	sSQL = "SELECT * FROM faction_member WHERE faction_member.faction = '" + SQLEncodeSpecialChars(sFaction) + "' AND faction_member.pcid = " + getPCid(oPC) + " AND faction_member.administrator = 1";
	SQLExecDirect(sSQL);
	if (SQLGetAffectedRows() > 0 || GetIsDM(oPC)) bIsInFaction = TRUE;
	
	return bIsInFaction;
}
//
//	BUILDS AND DISPLAYS THE FACTION LIST MENU
//
void showFactionMenu(object oPC)
{
	int bIsDM;
	int nRow;
	string sFaction;
	string sSQL;

	bIsDM = GetIsDM(oPC);
	
	SetLocalString(oPC, "sDasariaMenuHandler", "gui_faction_menu");
	DisplayGuiScreen(oPC, "SCREEN_DASARIA_MENU", FALSE, "dasaria_menu.xml");
	//
	//	BUILD MENU HEADER
	//
	SetGUIObjectText(oPC, "SCREEN_DASARIA_MENU", "MENU_TITLE", -1, "FACTION MANAGEMENT");
	SetGUIObjectText(oPC, "SCREEN_DASARIA_MENU", "MENU_SUBTITLE", -1, "FACTION LIST");
	SetGUITexture(oPC, "SCREEN_DASARIA_MENU", "MENU_ICON", "partysel_icon.tga");
	//
	//	BUILD MENU BODY
	//	
	nRow = 0;
	ClearListBox(oPC, "SCREEN_DASARIA_MENU", "MENU");
	AddListBoxRow(oPC, "SCREEN_DASARIA_MENU", "MENU", IntToString(nRow), "MENU_ITEM_TEXT=ADD FACTION", "MENU_ITEM_ICON=ia_bootplayer.tga", "MENU_ITEM_DATA=FACTION~ADD", "");

	if (bIsDM)
	{
		sSQL = "SELECT faction.faction FROM faction ORDER BY faction.faction";
	}
	else
	{
		sSQL = "SELECT faction.faction FROM faction INNER JOIN faction_member ON faction.faction = faction_member.faction WHERE faction_member.pcid = " + getPCid(oPC) + " ORDER BY faction.faction";
	}		
	SQLExecDirect(sSQL);
	
	while (SQLFetch() == SQL_SUCCESS)
	{
		nRow++;
		sFaction = SQLGetData(1);
		AddListBoxRow(oPC, "SCREEN_DASARIA_MENU", "MENU", IntToString(nRow), "MENU_ITEM_TEXT=" + sFaction, "MENU_ITEM_ICON=ife_captainkeep.tga", "MENU_ITEM_DATA=FACTION~" + sFaction, "");
	}
}
//
//	BUILDS AND DISPLAYS FACTION MEMBER MENU
//
void showFactionMemberMenu(object oPC)
{
	int bIsAdministrator;
	int bIsDM;
	int nRow;
	string sAdministrator;
	string sFaction;
	string sFactionCharacter;
	string sFactionCharacterID;
	string sFactionPlayer;
	string sSQL;

	sFaction = GetLocalString(oPC, "sFaction");
	bIsDM = GetIsDM(oPC);
	SetLocalString(oPC, "sDasariaMenuHandler", "gui_faction_menu");
	DisplayGuiScreen(oPC, "SCREEN_DASARIA_MENU", FALSE, "dasaria_menu.xml");
	//
	//	BUILD MENU HEADER
	//
	SetGUIObjectText(oPC, "SCREEN_DASARIA_MENU", "MENU_TITLE", -1, "FACTION MANAGEMENT");
	SetGUIObjectText(oPC, "SCREEN_DASARIA_MENU", "MENU_SUBTITLE", -1, GetStringUpperCase(sFaction));
	SetGUITexture(oPC, "SCREEN_DASARIA_MENU", "MENU_ICON", "partysel_icon.tga");
	//
	//	BUILD MENU BODY
	//	
	ClearListBox(oPC, "SCREEN_DASARIA_MENU", "MENU");
	nRow = 0;
	AddListBoxRow(oPC, "SCREEN_DASARIA_MENU", "MENU", IntToString(nRow), "MENU_ITEM_TEXT=ADD MEMBER", "MENU_ITEM_ICON=ia_bootplayer.tga", "MENU_ITEM_DATA=FACTION_MEMBER~ADD", "");
	nRow++;
	AddListBoxRow(oPC, "SCREEN_DASARIA_MENU", "MENU", IntToString(nRow), "MENU_ITEM_TEXT=DELETE FACTION", "MENU_ITEM_ICON=ia_banplayer.tga", "MENU_ITEM_DATA=FACTION_MEMBER~DELETE", "");
	nRow++;
	AddListBoxRow(oPC, "SCREEN_DASARIA_MENU", "MENU", IntToString(nRow), "MENU_ITEM_TEXT=BACK", "MENU_ITEM_ICON=b_rotl_normal.tga", "MENU_ITEM_DATA=FACTION_MEMBER~BACK", "");

	sSQL = "SELECT faction_member.faction, faction_member.pcid, pc_data.player_name, pc_data.fname, pc_data.lname, faction_member.administrator FROM faction_member INNER JOIN pc_data ON faction_member.pcid = pc_data.pcid WHERE faction_member.faction = '" + SQLEncodeSpecialChars(sFaction) + "' ORDER BY faction_member.faction, faction_member.administrator DESC , pc_data.fname, pc_data.lname;";

	SQLExecDirect(sSQL);
	while (SQLFetch() == SQL_SUCCESS)
	{
		nRow++;
		sFactionCharacterID = SQLGetData(2);
		sFactionPlayer = SQLGetData(3);
		sFactionCharacter = SQLGetData(4) + " " + SQLGetData(5);
		bIsAdministrator = StringToInt(SQLGetData(6));
		if (bIsAdministrator)
		{
			sAdministrator = "ibt_devout.tga";
		}
		else
		{
			sAdministrator = "ibt_none.tga";		
		}
		AddListBoxRow(oPC, "SCREEN_DASARIA_MENU", "MENU", IntToString(nRow), "MENU_ITEM_TEXT=" + sFactionCharacter + " (" + sFactionPlayer + ")", "MENU_ITEM_ICON=" + sAdministrator, "MENU_ITEM_DATA=FACTION_MEMBER~" + sFactionCharacterID + "~" + sFactionCharacter, "");
	}
}
//
//	BUILDS AND DISPLAYS THE MEMBER ADMINISTRATION MENU
//
void showFactionMemberAdministrationMenu(object oPC)
{
	int bIsDM;
	int nRow;
	string sFactionCharacter;
	string sSQL;

	sFactionCharacter = GetLocalString(oPC, "sFactionCharacter");
	
	bIsDM = GetIsDM(oPC);
	SetLocalString(oPC, "sDasariaMenuHandler", "gui_faction_menu");
	DisplayGuiScreen(oPC, "SCREEN_DASARIA_MENU", FALSE, "dasaria_menu.xml");
	//
	//	BUILD MENU HEADER
	//
	SetGUIObjectText(oPC, "SCREEN_DASARIA_MENU", "MENU_TITLE", -1, "FACTION MANAGEMENT");
	SetGUIObjectText(oPC, "SCREEN_DASARIA_MENU", "MENU_SUBTITLE", -1, GetStringUpperCase(sFactionCharacter));
	SetGUITexture(oPC, "SCREEN_DASARIA_MENU", "MENU_ICON", "partysel_icon.tga");
	//
	//	BUILD MENU BODY
	//	
	ClearListBox(oPC, "SCREEN_DASARIA_MENU", "MENU");
	nRow = 0;
	AddListBoxRow(oPC, "SCREEN_DASARIA_MENU", "MENU", IntToString(nRow), "MENU_ITEM_TEXT=MAKE ADMINISTRATOR", "MENU_ITEM_ICON=ia_bootplayer.tga", "MENU_ITEM_DATA=FACTION_MEMBER_ADMINISTRATION~ADMINISTRATOR", "");
	nRow++;
	AddListBoxRow(oPC, "SCREEN_DASARIA_MENU", "MENU", IntToString(nRow), "MENU_ITEM_TEXT=DELETE MEMBER", "MENU_ITEM_ICON=ia_banplayer.tga", "MENU_ITEM_DATA=FACTION_MEMBER_ADMINISTRATION~DELETE", "");
	nRow++;
	AddListBoxRow(oPC, "SCREEN_DASARIA_MENU", "MENU", IntToString(nRow), "MENU_ITEM_TEXT=BACK", "MENU_ITEM_ICON=b_rotl_normal.tga", "MENU_ITEM_DATA=FACTION_MEMBER_ADMINISTRATION~BACK", "");
}
//
//	BUILDS AND DISPLAYS THE FACTION MEMBER ADD MENU
//
void showFactionMemberAddMenu(object oPC)
{
	int bIsDM;
	int nRow;
	object oPlayer;
	string sFaction;
	string sID;
	string sSQL;

	sFaction = GetLocalString(oPC, sFaction);
	sID = getPCid(oPC);

	bIsDM = GetIsDM(oPC);
	
	SetLocalString(oPC, "sDasariaMenuHandler", "gui_faction_menu");
	DisplayGuiScreen(oPC, "SCREEN_DASARIA_MENU", FALSE, "dasaria_menu.xml");
	//
	//	BUILD MENU HEADER
	//
	SetGUIObjectText(oPC, "SCREEN_DASARIA_MENU", "MENU_TITLE", -1, "FACTION MANAGEMENT");
	SetGUIObjectText(oPC, "SCREEN_DASARIA_MENU", "MENU_SUBTITLE", -1, GetStringUpperCase(sFaction) + " - ADD MEMBER");
	SetGUITexture(oPC, "SCREEN_DASARIA_MENU", "MENU_ICON", "partysel_icon.tga");
	//
	//	BUILD MENU BODY
	//	
	ClearListBox(oPC, "SCREEN_DASARIA_MENU", "MENU");
	nRow = 0;
	AddListBoxRow(oPC, "SCREEN_DASARIA_MENU", "MENU", IntToString(nRow), "MENU_ITEM_TEXT=BACK", "MENU_ITEM_ICON=b_rotl_normal.tga", "MENU_ITEM_DATA=FACTION_MEMBER_BACK", "");

	oPlayer = GetFirstPC();
	while (GetIsObjectValid(oPlayer))
	{
		AddListBoxRow(oPC, "SCREEN_DASARIA_MENU", "MENU", IntToString(nRow), "MENU_ITEM_TEXT=" + GetName(oPlayer), "MENU_ITEM_ICON=ibt_none.tga", "MENU_ITEM_DATA=FACTION_MEMBER_ADD~" + getPCid(oPlayer), "");
		nRow++;
		oPlayer = GetNextPC();
	}
}