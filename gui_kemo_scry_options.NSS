#include "kemo_scry_includes"
#include "std_persist_i0"

void main(string sOption)
{
	object oPC = OBJECT_SELF;
	object oJournal;
	
		int iAnon = GetLocalInt(oPC,"Scry_Anon");
		int iAFK = GetLocalInt(oPC,"Scry_AFK");
		int iLFG = GetLocalInt(oPC,"Scry_LFG");
		int iDND = GetLocalInt(oPC,"Scry_DND");
		int iPVP = GetLocalInt(oPC,"Scry_PVP");
		
	if (sOption == "0") //Anon
	{
		oJournal = std_journal_get( oPC );
	
		if (iAnon == 1)
		{
			SetLocalInt(oPC,"Scry_Anon",0);
			SetLocalInt(oJournal,"Scry_Anon",0);
			SetGUIObjectText(oPC,"KEMO_SCRY_PANEL","KEMO_SCRY_ANON",-1,"Go Anon");
		}
		else
		{
			SetLocalInt(oPC,"Scry_Anon",1);
			SetLocalInt(oJournal,"Scry_Anon",1);
			SetGUIObjectText(oPC,"KEMO_SCRY_PANEL","KEMO_SCRY_ANON",-1,"Go Visible");
		}
	}
	
	if (sOption == "1") //LFG
	{
		if (iLFG == 1)
		{
			SetLocalInt(oPC,"Scry_LFG",0);
			SetGUIObjectText(oPC,"KEMO_SCRY_PANEL","KEMO_SCRY_LFG",-1,"Start LFG");
		}
		else
		{
			SetLocalInt(oPC,"Scry_LFG",1);
			SetGUIObjectText(oPC,"KEMO_SCRY_PANEL","KEMO_SCRY_LFG",-1,"End LFG");
			SetLocalInt(oPC,"Scry_AFK",0);
			SetGUIObjectText(oPC,"KEMO_SCRY_PANEL","KEMO_SCRY_AFK",-1,"Go AFK");
			SetLocalInt(oPC,"Scry_DND",0);
			SetGUIObjectText(oPC,"KEMO_SCRY_PANEL","KEMO_SCRY_DND",-1,"Do Not Disturb");
		}
	}
	
	if (sOption == "2") //AFK
	{
		if (iAFK == 1)
		{
			SetLocalInt(oPC,"Scry_AFK",0);
			SetGUIObjectText(oPC,"KEMO_SCRY_PANEL","KEMO_SCRY_AFK",-1,"Go AFK");
		}
		else
		{
			SetLocalInt(oPC,"Scry_AFK",1);
			SetGUIObjectText(oPC,"KEMO_SCRY_PANEL","KEMO_SCRY_AFK",-1,"End AFK");
			SetLocalInt(oPC,"Scry_LFG",0);
			SetGUIObjectText(oPC,"KEMO_SCRY_PANEL","KEMO_SCRY_LFG",-1,"Start LFG");
			SetLocalInt(oPC,"Scry_DND",0);
			SetGUIObjectText(oPC,"KEMO_SCRY_PANEL","KEMO_SCRY_DND",-1,"Do Not Disturb");
		}
	}
	if (sOption == "3") //DND
	{
		if (iDND == 1)
		{
			SetLocalInt(oPC,"Scry_DND",0);
			SetGUIObjectText(oPC,"KEMO_SCRY_PANEL","KEMO_SCRY_DND",-1,"Do Not Disturb");
		}
		else
		{
			SetLocalInt(oPC,"Scry_DND",1);
			SetGUIObjectText(oPC,"KEMO_SCRY_PANEL","KEMO_SCRY_DND",-1,"Make Available");
			SetLocalInt(oPC,"Scry_AFK",0);
			SetGUIObjectText(oPC,"KEMO_SCRY_PANEL","KEMO_SCRY_AFK",-1,"Go AFK");
			SetLocalInt(oPC,"Scry_LFG",0);
			SetGUIObjectText(oPC,"KEMO_SCRY_PANEL","KEMO_SCRY_LFG",-1,"Start LFG");
		}
	}
	if (sOption =="4" && KEMO_USE_CAPTURE) //PVP with capture
	{
		switch (iPVP)
		{
			case 0: SetLocalInt(oPC,"Scry_PVP",1);
					SetGUIObjectText(oPC,"KEMO_SCRY_PANEL","KEMO_SCRY_PVP",-1,"PVP Negotiable");
					break;
			case 1: SetLocalInt(oPC,"Scry_PVP",2);
					SetGUIObjectText(oPC,"KEMO_SCRY_PANEL","KEMO_SCRY_PVP",-1,"No PVP");
					break;
			case 2: SetLocalInt(oPC,"Scry_PVP",3);
					SetGUIObjectText(oPC,"KEMO_SCRY_PANEL","KEMO_SCRY_PVP",-1,"PVP OK");
					break;
			case 3: SetLocalInt(oPC,"Scry_PVP",0);
					SetGUIObjectText(oPC,"KEMO_SCRY_PANEL","KEMO_SCRY_PVP",-1,"PVP Capture OK");
					break;
		}
	}
	if (sOption =="4" && !KEMO_USE_CAPTURE) //PVP with capture
	{
		switch (iPVP)
		{
			case 0: SetLocalInt(oPC,"Scry_PVP",1);
					SetGUIObjectText(oPC,"KEMO_SCRY_PANEL","KEMO_SCRY_PVP",-1,"PVP Negotiable");
					break;
			case 1: SetLocalInt(oPC,"Scry_PVP",2);
					SetGUIObjectText(oPC,"KEMO_SCRY_PANEL","KEMO_SCRY_PVP",-1,"No PVP");
					break;
			case 2: SetLocalInt(oPC,"Scry_PVP",0);
					SetGUIObjectText(oPC,"KEMO_SCRY_PANEL","KEMO_SCRY_PVP",-1,"PVP OK");
					break;
		}
	}
	ExecuteScript("gui_kemo_scry_gather",oPC);
}