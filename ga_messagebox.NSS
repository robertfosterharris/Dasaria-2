// ga_messagebox
// send a popup message to player
// wired 02/24/08
void main(string sMessage, int bParty = FALSE)
{
   object oPC = GetPCSpeaker();    
   if (bParty == TRUE)
   {	   
	   object oPlayer = GetFirstFactionMember(oPC);   
	   while (GetIsObjectValid(oPlayer))
		{
			DisplayMessageBox(oPlayer,0,sMessage,"","",FALSE,"SCREEN_MESSAGEBOX_DEFAULT",0,"Ok",0,"Cancel");	
			
			oPlayer = GetNextFactionMember(oPC);
		}
	}
	else
	{
		// just send to oPC
		DisplayMessageBox(oPC,0,sMessage,"","",FALSE,"SCREEN_MESSAGEBOX_DEFAULT",0,"Ok",0,"Cancel");	
	}   
   
} 