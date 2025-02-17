// i_newspaper_ac
// Chemical Agent
// Version 1.3
// General script which activates GUI upon use of the newspaper object.
// Reads sPaper from object to determine which paper to load.
// 06/26/12

void main()
{
if (GetGlobalInt("paper_debug")>0) {SendMessageToAllDMs("i_newspaper_ac.NSS Called by " + GetName(OBJECT_SELF));}//Debug

object oPC = GetItemActivator();
object oItem = GetItemActivated();

string sPaper = GetLocalString(oItem,"sPaper");
int iPageMax = GetLocalInt(oItem,"iPageMax");

if (GetGlobalInt("paper_debug")>2) {SendMessageToAllDMs("sPaper: " + sPaper);}//Debug

if (iPageMax != 1)
	{
	string sImage = sPaper + "_text_1.tga";
	if (GetGlobalInt("paper_debug")>2) {SendMessageToAllDMs("sImage: " + sImage);}//Debug
	DisplayGuiScreen(oPC, "SCREEN_PAPER_FULL", FALSE, "paper_full.xml");
	SetGUITexture(oPC, "SCREEN_PAPER_FULL", "TEXT_IMAGE", sImage);
	SetLocalGUIVariable(oPC, "SCREEN_PAPER_FULL", 0, sPaper);
	SetLocalGUIVariable(oPC, "SCREEN_PAPER_FULL", 2, "1");
	SetLocalGUIVariable(oPC, "SCREEN_PAPER_FULL", 3, IntToString(iPageMax));
	} else
		{
		DisplayGuiScreen(oPC, "SCREEN_PAPER_SINGLE", FALSE, "paper_single.xml");
		string sImage = sPaper + "_text_1.tga";
		if (GetGlobalInt("paper_debug")>2) {SendMessageToAllDMs("sImage: " + sImage);}//Debug		
		SetGUITexture(oPC, "SCREEN_PAPER_SINGLE", "TEXT_IMAGE", sImage);
		SetLocalGUIVariable(oPC, "SCREEN_PAPER_SINGLE", 0, sPaper);
		SetLocalGUIVariable(oPC, "SCREEN_PAPER_SINGLE", 2, "1");
		}
	
}