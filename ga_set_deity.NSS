//	SETS THE SPEAKERS DEITY TO sDEITY
//
void main(string sDeity)
{
	object oPC;
	
	oPC = (GetPCSpeaker()==OBJECT_INVALID?OBJECT_SELF:GetPCSpeaker());
	SetDeity(oPC, sDeity);
}