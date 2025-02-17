#include "ginc_faction"

void main(string sFaction)
{
	string sSQL;
	
	sSQL = "INSERT INTO faction VALUES ('" + SQLEncodeSpecialChars(sFaction) + "', '" + SQLEncodeSpecialChars(GetPCPublicCDKey(OBJECT_SELF)) + "')";
	SQLExecDirect(sSQL);	
	if (SQLGetAffectedRows() > 0)
	{
		SendMessageToPC(OBJECT_SELF,"SUCCESS: Faction added.");
		sSQL = "INSERT INTO faction_member VALUES ('" + SQLEncodeSpecialChars(sFaction) + "', " + getPCid(OBJECT_SELF) + ", 1)";
		SQLExecDirect(sSQL);
		if (SQLGetAffectedRows() > 0)
		{
			SendMessageToPC(OBJECT_SELF,"SUCCESS: Faction administrator added.");
		}
			else
		{
			SendMessageToPC(OBJECT_SELF,"ERROR: Failed to add faction administrator.");
		}
	}
		else
	{
		SendMessageToPC(OBJECT_SELF,"ERROR: Failed to add faction.");
	}
	
	showFactionMenu(OBJECT_SELF);
}