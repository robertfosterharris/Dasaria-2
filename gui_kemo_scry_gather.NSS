#include "kemo_scry_includes"
#include "std_i0_misc"

void main()
{
	string sPCName; string sPCNamePVP; string sPCNamePVPNeg; string sPCNamePVPCap;
	string sPlayerName;
	string sPCArea;
	string sPCLevel;
	string sPCClass;
	string sPCLFG;
	string sPCAFK;
	string sPCDND;
	string sDM;
	
	object oPC = OBJECT_SELF;
	object oList;
	
	string sRow;
	string sTextFields;
	int iListTotal = 0; int iListVisible = 0;
	string sListTotals;
	int iPVP;
	
	string sScreenName = "KEMO_SCRY_PANEL";
	string sListBox = "KEMO_SCRY_LIST";
	
	ClearListBox(oPC,sScreenName,sListBox);

	oList = GetFirstPC();
	while (GetIsObjectValid(oList))
	{
		iListTotal++;
		if (GetLocalInt(oList,"Scry_Anon") != 1 || GetIsDM(oPC) || GetIsStaff(oPC))   // wired staff ignores anonymity
		{
			iListVisible++;
			iPVP = GetLocalInt(oList,"Scry_PVP");
			switch (iPVP)
			{
				case 0: sPCName = GetName(oList); sPCNamePVP = ""; sPCNamePVPNeg = ""; sPCNamePVPCap = ""; break;
				case 1: sPCName = ""; sPCNamePVP = GetName(oList); sPCNamePVPNeg = ""; sPCNamePVPCap = ""; break;
				case 2: sPCName = ""; sPCNamePVP = ""; sPCNamePVPNeg = GetName(oList); sPCNamePVPCap = ""; break;
				case 3: sPCName = ""; sPCNamePVP = ""; sPCNamePVPNeg = ""; sPCNamePVPCap = GetName(oList); break;
			}
			sPlayerName = GetPCPlayerName(oList);
			sPCArea = AreaRename(GetName(GetArea(oList)));	// wired chaged GetTag to GetName
			sPCLevel = IntToString(GetHitDice(oList));

			if (GetIsDM(oList)) sDM = "[DM]"; else sDM = "";
			if (GetIsDM(oPC) && GetLocalInt(oList,"Scry_Anon") == 1) sDM = sDM+"*";

			if (GetLocalInt(oList,"Scry_LFG") == 1)  sPCLFG = "LFG";
			else sPCLFG = "";
			if (GetLocalInt(oList,"Scry_AFK") == 1) sPCAFK = "AFK";
			else sPCAFK = "";
			if (GetLocalInt(oList,"Scry_DND") == 1) sPCDND = "DND";
			else sPCDND = "";


			sRow = "ScryRow"+IntToString(iListVisible);
			sTextFields = "KEMO_SCRY_NAME="+sPCName+";" +
				"KEMO_SCRY_NAME_PVP="+sPCNamePVP+";" +
				"KEMO_SCRY_NAME_PVP_NEG="+sPCNamePVPNeg+";" +
				"KEMO_SCRY_NAME_PVP_CAP="+sPCNamePVPCap+";" +
				"KEMO_SCRY_PLAYER="+sPlayerName+";" +
				"KEMO_SCRY_AREA="+sPCArea+";" +
				"KEMO_SCRY_LEVEL="+sPCLevel+";" +
				"KEMO_SCRY_LFGAFK="+sPCLFG+sPCAFK+sPCDND+";" +
				"KEMO_SCRY_DM="+sDM;
			AddListBoxRow(oPC,sScreenName,sListBox,sRow,sTextFields,"","","");
		}
		oList = GetNextPC();
	}
	sListTotals = "Showing " + IntToString(iListVisible) + " out of " + IntToString(iListTotal);
	SetGUIObjectText(oPC,sScreenName,"KEMO_SCRY_TOTALS",-1,sListTotals);
}