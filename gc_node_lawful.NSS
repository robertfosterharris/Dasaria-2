//	GC_NODE_LAWFUL - CHECKS IF THE NODE OWNER'S ALIGNMENT IS LAWFUL
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
	return (GetIsLawful(oCreature));
}