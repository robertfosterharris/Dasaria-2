#include "ginc_lycan"

void main()
{
	object oDM = GetItemActivator();
	if (!GetIsDM(oDM)) return;
	
	object oPC = GetItemActivatedTarget(); 

	if (GetLocalInt(	std_journal_get( oPC ),"nLycan") > 0)
	{
		SendMessageToAllDMs(GetName(oDM)+" has cured "+GetName(oPC)+" of lycantropy");
		CureLycan(oPC);
	}
	else
	{
		SendMessageToAllDMs(GetName(oPC)+" has been made a werewolf by "+GetName(oDM)+".");
		MakeLycan(oPC,1);
	}
}