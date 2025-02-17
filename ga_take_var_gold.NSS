// 	GA_TAKE_VAR_GOLD
//
//	TAKES A VARIABLE AMOUNT OF GOLD FROM THE SPEAKER
//
//	sVariable	=	THE NAME OF LOCAL INT VARIABLE CONTAINING THE AMOUNT OF GOLD TO TAKE
//
//	ROBERT HARRIS	05/02/2015	ROBERTHARRIS@ROBERTHARRIS.COM
//

void main(string sVariable)
{
	object oPC;
	
	oPC = GetPCSpeaker();
	
    TakeGoldFromCreature(GetLocalInt(oPC, sVariable), oPC);
}