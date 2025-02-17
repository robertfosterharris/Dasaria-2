// dasolm_hench_de

#include "dasolm_inc"

void main()
{
	object oMaster = GetMaster(OBJECT_SELF);
	int nSoldiersNum; 	
	
	// why is this neccessary because apparently it is?
	if (!GetIsObjectValid(oMaster))
	{
		oMaster = GetLocalObject(OBJECT_SELF,"oMaster");
	}
	
	if (GetIsObjectValid(oMaster))
	{
		nSoldiersNum = GetLocalInt(oMaster,"LendOL_Soldiers");
		if (nSoldiersNum > 0)
		{
			SetLocalInt(oMaster,"LendOL_Soldiers",nSoldiersNum-1);
		}
		else
		{
			SetLocalInt(oMaster,"LendOL_Soldiers",0);
		}
	}
}