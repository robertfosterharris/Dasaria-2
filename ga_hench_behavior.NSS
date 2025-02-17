// wired hardcoded to be 'follow near,' room for future expansion

#include "hench_i0_assoc"
#include "ginc_param_const"

void main(string sTarget, string sMaster, int nCondition, int nNewState)
{
	object oMaster,oHench;

	if (sMaster=="")
		oMaster=(GetPCSpeaker()==OBJECT_INVALID?OBJECT_SELF:GetPCSpeaker());
	else
		oMaster=GetTarget(sMaster);
	oHench =GetTarget(sTarget);

	if (!GetIsObjectValid(oMaster))//tests for safety
	{
		PrintString("ga_henchman_behavior: Couldn't find master: "+sMaster);
		return;
	}
	if (!GetIsObjectValid(oHench))
	{
		PrintString("ga_henchman_behavior: Couldn't find henchman: "+sTarget);
		return;
	}
	
	SetHenchAssociateState(HENCH_ASC_GUARD_DISTANCE_NEAR, TRUE, oHench);
	SetHenchAssociateState(HENCH_ASC_GUARD_DISTANCE_MED, FALSE, oHench);
	SetHenchAssociateState(HENCH_ASC_GUARD_DISTANCE_FAR, FALSE, oHench);
}