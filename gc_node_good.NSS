//	GC_NODE_GOOD - CHECKS IF THE NODE OWNER'S ALIGNMENT IS GOOD
//
//	ROBERT HARRIS	05/15/2015	ROBERTHARRIS@ROBERTHARRIS.COM
//
#include "ginc_alignment"
	
int StartingConditional()
{
	object oCreature;
	string sTag;
	
	sTag = GetNodeSpeaker();
	if (sTag == "")
	{
		oCreature = GetPCSpeaker();
	}
	else
	{
		oCreature = GetNearestObjectByTag(sTag);
	}
	return (GetIsGood(oCreature));
}