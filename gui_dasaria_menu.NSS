//	DEFAULT HANDLER FOR DASARIA_MENU.XML
//
//	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM	04/26/2009
//
void main(string sValue)
{
//	SendMessageToPC(OBJECT_SELF, "gui_dasaria_menu selection: " + sValue);
	SetLocalString(GetOwnedCharacter(OBJECT_SELF), "sDasariaMenuSelection", sValue);
	ExecuteScript(GetLocalString(GetOwnedCharacter(OBJECT_SELF), "sDasariaMenuHandler"), OBJECT_SELF);
}