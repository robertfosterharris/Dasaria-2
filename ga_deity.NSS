//Wired 01/25/09
//ga_deity

void main(string sDeity)
{
	object oTarget = GetLocalObject(OBJECT_SELF,"deity_switch_player");		
	SetDeity(oTarget,sDeity);
}