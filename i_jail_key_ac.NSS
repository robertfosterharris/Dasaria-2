//	ITEM ON ACTIVATE
//	EACH USE THIS ITEM ON A CHARACTER ESCALATES THE CHARACTERS CRIMINAL STATUS
//	0 - CLEAR LEGAL STATUS
//	1 - CHARACTER IS CHARGED WITH A CRIME
//	2 - A WARRENT IS ISSUED FOR THE CHARACTER
//
//	02/06/07	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM
//
#include "ginc_das_jail"

void main()
{
	int nLegalStatus;
	object oCriminal;
	object oGuard;
	string sCriminal;
	string sGuard;
	
	oCriminal = GetItemActivatedTarget();
	oGuard = GetItemActivator();
	if (GetIsPC(oCriminal))
	{
		nLegalStatus = GetLocalInt(oCriminal, "nLegalStatus");
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