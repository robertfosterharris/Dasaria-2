// n_newspaper
// Chemical Agent
// Version 1.4
// Script which places latest issue of newspaper into user's inventory
// Activates upon use of a newspaper dispenser
// Reads sPaper and iPageMax from self to determine which variables to write on the created object
// 07/08/12

void main()
{
if (GetGlobalInt("paper_debug")>0) {SendMessageToAllDMs("n_newspaper.NSS Called by " + GetName(OBJECT_SELF));}//Debug

object oPC = GetLastUsedBy();

if (GetGlobalInt("paper_debug")>2) {SendMessageToAllDMs("oPC: " + GetName(oPC));}//Debug

string sPaper = GetLocalString(OBJECT_SELF,"sPaper");
int iPageMax = GetLocalInt(OBJECT_SELF,"iPageMax");

if (GetGlobalInt("paper_debug")>2) {SendMessageToAllDMs("sPaper: " + sPaper);}//Debug
if (GetGlobalInt("paper_debug")>2) {SendMessageToAllDMs("iPageMax: " + IntToString(iPageMax));}//Debug

object oPaper = CreateItemOnObject("PSC_NEWSPAPER_CSTAR",oPC,1,"newspaper",1);
SetLocalString(oPaper,"sPaper",sPaper);
SetLocalInt(oPaper,"iPageMax",iPageMax);

}