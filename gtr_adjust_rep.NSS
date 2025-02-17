//	gtr_adjust_rep
//	wired 06/20/2009
//		
//	Adjusts a PC's Personal Reputation to Otherwise-Hostile
//	Creatures based on the PC's Faction Membership
//
//	Tag of sNPCFaction MUST exist on a properly-factioned creature in ~faction
//

#include "ginc_faction"

void main()
{
	object oPC = GetEnteringObject();
	string sPCFaction 	=	GetLocalString(OBJECT_SELF,"sPCFaction");
	int nTargetRep;
	int nCurRep;
	string sNPCFaction;	
	object oMember;
	
	if (!GetIsPC(oPC) || !GetIsInFaction(oPC, sPCFaction) )
	return;	
	
	sNPCFaction	=	GetLocalString(OBJECT_SELF,"sNPCFaction");
	nTargetRep	=	GetLocalInt(OBJECT_SELF,"nTargetRep");
	nCurRep		=	GetReputation(oMember,oPC);		
	oMember		=	GetObjectByTag(sNPCFaction);

/*
	if (!GetIsObjectValid(oMember)) 
	{
		SendMessageToPC(oPC,"INVALID OBJECT!"); 
		return; 
	}
	else
	{
			SendMessageToPC(oPC,"Member: "+GetName(oMember));
	}
	SendMessageToPC(oPC,"Current Rep with Member: "+IntToString(nCurRep));		
	SendMessageToPC(oPC,"sNPCFaction: "+sNPCFaction);
	SendMessageToPC(oPC,"nTargetRep: "+IntToString(nTargetRep));
				
	if  (nCurRep == nTargetRep)	
	{ 
		//SendMessageToPC(oPC,"Same Rep Do Nothing");	
		return;
	}
*/
	
	// adjust up
	if  (nCurRep < nTargetRep)
	{
		//SendMessageToPC(oPC,"nCurRep "+IntToString(nCurRep)+" < nTargetRep "+IntToString(nTargetRep)+" Adjust Up");
		
		AdjustReputation(oPC, oMember,100) ;
		
		nCurRep		=	GetReputation(oMember, oPC);	
		//SendMessageToPC(oPC,"Rep with Member: "+IntToString(nCurRep));
	}
	
	// adjust down 
	if  (nCurRep > nTargetRep)
	{
		//SendMessageToPC(oPC,"Adjust Down");
		AdjustReputation(oPC,oMember, nCurRep - nTargetRep);
	}	

}