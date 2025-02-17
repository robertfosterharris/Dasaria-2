// 	GA_CHECK_VAR_GOLD
//
//	TAKES A VARIABLE AMOUNT OF GOLD FROM THE SPEAKER
//
//	sVariable	=	THE NAME OF LOCAL INT VARIABLE CONTAINING THE AMOUNT OF GOLD TO CHECK
//
//	ROBERT HARRIS	05/02/2015	ROBERTHARRIS@ROBERTHARRIS.COM
//

int StartingConditional(string sVariable)
{
	object oPC;
	
	oPC = GetPCSpeaker();
	
	if (GetGold(oPC) >= GetLocalInt(oPC, sVariable)) return TRUE;

	return FALSE;
}