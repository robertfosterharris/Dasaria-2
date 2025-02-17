// gui_newspaper
// Chemical Agent
// Version 1.3
// GUI callback to populate newspaper graphic.
// Name of the paper is passed as local:0
// Current page is passed as local:2
// Maximum page number is passed as local:3
// 06/26/12

void main(string sPaper = "", string sCase = "", string sPage = "", string sPageMax = "")
{
if (GetGlobalInt("paper_debug")>0) {SendMessageToAllDMs("gui_newspaper.NSS Called by " + GetName(OBJECT_SELF));}//Debug

object oPC = OBJECT_SELF;
string sImage = sPaper;
int iPage;

if (GetGlobalInt("paper_debug")>2) {SendMessageToAllDMs("sPaper: " + sPaper);}//Debug
if (GetGlobalInt("paper_debug")>2) {SendMessageToAllDMs("sCase: " + sCase);}//Debug

int iCase = StringToInt(sCase);
int iPageMax = StringToInt(sPageMax);

if (GetGlobalInt("paper_debug")>2) {SendMessageToAllDMs("iCase: " + IntToString(iCase));}//Debug
if (GetGlobalInt("paper_debug")>2) {SendMessageToAllDMs("sPage: " + sPage);}//Debug
if (GetGlobalInt("paper_debug")>2) {SendMessageToAllDMs("iPageMax: " + IntToString(iPageMax));}//Debug


switch (iCase)
	{
	case 1 : //Reserved
	if (GetGlobalInt("paper_debug")>1) {SendMessageToAllDMs("Case 1 Fire");}//Debug
	break;
	
	case 2 : //Reserved
	if (GetGlobalInt("paper_debug")>1) {SendMessageToAllDMs("Case 2 Fire");}//Debug	
	break;
		
	case 3 : //Open and populate the interior page on a forward move.
	if (GetGlobalInt("paper_debug")>1) {SendMessageToAllDMs("Case 3 Fire");}//Debug
	DisplayGuiScreen(oPC, "SCREEN_PAPER_FULL", FALSE, "paper_full.xml");
	if (GetGlobalInt("paper_debug")>2) {SendMessageToAllDMs("sPage: " + sPage);}//Debug
	iPage = 1 + StringToInt(sPage);
	if (iPage > iPageMax)
		{iPage = 1;}
	sPage = IntToString(iPage);
	sImage = sPaper + "_text_" + sPage + ".tga";
	if (GetGlobalInt("paper_debug")>2) {SendMessageToAllDMs("sImage: " + sImage);}//Debug
	SetGUITexture(oPC, "SCREEN_PAPER_FULL", "TEXT_IMAGE", sImage);

	SetLocalGUIVariable(oPC, "SCREEN_PAPER_FULL", 0, sPaper);		
	SetLocalGUIVariable(oPC, "SCREEN_PAPER_FULL", 2, sPage);
	SetLocalGUIVariable(oPC, "SCREEN_PAPER_FULL", 3, sPageMax);
	break;
	
	case 4 : //Open and populate the interior page on a backwards move.
	if (GetGlobalInt("paper_debug")>1) {SendMessageToAllDMs("Case 4 Fire");}//Debug
	DisplayGuiScreen(oPC, "SCREEN_PAPER_FULL", FALSE, "paper_full.xml");

	if (GetGlobalInt("paper_debug")>2) {SendMessageToAllDMs("sPage: " + sPage);}//Debug
	iPage = StringToInt(sPage) - 1;
	if (iPage <= 1)
		{iPage = 1;}
	sPage = IntToString(iPage);
	sImage = sPaper + "_text_" + sPage + ".tga";

	if (GetGlobalInt("paper_debug")>2) {SendMessageToAllDMs("sImage: " + sImage);}//Debug
	SetGUITexture(oPC, "SCREEN_PAPER_FULL", "TEXT_IMAGE", sImage);

	sPage = IntToString(iPage);
	SetLocalGUIVariable(oPC, "SCREEN_PAPER_FULL", 0, sPaper);		
	SetLocalGUIVariable(oPC, "SCREEN_PAPER_FULL", 2, sPage);
	SetLocalGUIVariable(oPC, "SCREEN_PAPER_FULL", 3, sPageMax);
	break;
	
	default : //None of the above happens.
	if (GetGlobalInt("paper_debug")>1) {SendMessageToAllDMs("Default Case Statement Fire");}//Debug
	}
}