// showTGA_cl
// wired 2012/06/24
// display an arbitrary TGA in a popup GUI
// assumes width=485 height=645

void main()
{
	int bDEBUG = FALSE;
	
	object oPC = GetLastUsedBy();
	string sTexture = GetLocalString(OBJECT_SELF,"sTexture");
	
	if (bDEBUG) SendMessageToPC(oPC,"showTGA Running!");
	if (bDEBUG) SendMessageToPC(oPC,"Object will use "+sTexture+".");
	
	DisplayGuiScreen( oPC, "SHOW_TGA", FALSE, "showTGA2.xml");
	DelayCommand(0.5,SetGUITexture( oPC, "SHOW_TGA", "TGA_BACKGROUND", sTexture ));
}