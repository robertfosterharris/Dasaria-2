// lendol_negotiator_sp
// when i spawn, spawn my prisoner with me
//

#include "dasolm_inc"

void main()
{

	if (bDEBUG) SendMessageToPC(GetFirstPC(),"RUNNING NEG_SP");
	
	string sTemplate;
	string sResRef = GetResRef(OBJECT_SELF);
	
	if (sResRef  == "lendol_negotiator_varanite") sTemplate = "lendol_prisoner_canite";
	if (sResRef  == "lendol_negotiator_rebel") sTemplate = "lendol_prisoner_canite";
	if (sResRef  == "lendol_negotiator_canite") sTemplate = "lendol_prisoner_rebel";
	
	CreateObject(OBJECT_TYPE_CREATURE,sTemplate,GetLocation(GetObjectByTag("POST_grove_prisoner")),FALSE);
}