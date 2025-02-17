// ga_textentry

void main()
{
	object oPC = GetPCSpeaker();	
	DisplayInputBox (oPC, 0, "Type Free Response", "gui_text_entry_ok", "gui_text_entry_cancel",TRUE, "", 0, "", 0, "", "");
}