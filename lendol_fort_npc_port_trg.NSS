// lendol_fort_npc_port_trg

void main()
{
	object oNPC = GetEnteringObject();
	string sWhere = GetLocalString(OBJECT_SELF,"sWhere");
	
	if (!GetIsPC(oNPC))
	{
		JumpToObject(GetObjectByTag(sWhere));
	}
}