// gui_dasolm_party_validate
// If either the invited oPC -OR- someone else 
// in the party is on the OLM and in a different
// faction, break oPC out of the Party

#include "dasolm_inc"

void main()
{
	// nb: object self is the clicker of the OK button
	object oPC = OBJECT_SELF; 
	DasOL_ValidateParty(oPC);
}