//	ACTION - ESCALATE THE PCS LEGAL STATUS 
//
//	SET THE PCS CURRENT LEGAL STATUS
//	0 - CLEAR LEGAL STATUS
//	1 - CHARACTER IS CHARGED WITH A CRIME
//	2 - A WARRENT IS ISSUED FOR THE CHARACTER
//
//	IF YOU WANT THE CHARACTER CHARGED WITH A CRIME, SET LEGAL STATUS TO 0
//	IF YOU WANT TO ISSUE A WARRANT FOR THE CHARACTER, SET THE LEGAL STATUS TO 1
//	IF YOU WANT TO CLEAR THE CHARACTER, SET THE LEGAL STATUS TO 2
//
//	11/30/07	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM
//
#include "ginc_das_jail"
#include "ginc_param_const"

void main(int nLegalStatus)
{
	object oCriminal;
	object oGuard;
	string sCriminal;
	string sGuard;
	
	oGuard = GetTarget(sGuard, TARGET_OWNER);
	oCriminal = (GetPCSpeaker()==OBJECT_INVALID?OBJECT_SELF:GetPCSpeaker());
	SetLocalInt(oCriminal, "nLegalStatus", nLegalStatus);
	
	if (GetIsPC(oCriminal))
	{
		switch (nLegalStatus)
		{
			case LEGAL_STATUS_CLEAR:
				issueIndictment(oCriminal, oGuard);
				break;
			case LEGAL_STATUS_INDICTMENT:
				issueWarrant(oCriminal, oGuard);
				break;
			default:
				issueResolved(oCriminal);
				break;
		}
	}
}