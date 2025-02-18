//
//	GLOBAL ACTION SCRIPT - REST WAS SELECT FROM THE REST MENU
//

#include "ginc_custom_races"


string	kRest = "std_request_rest";

void main()
{
	
	object oPC;
	
	oPC = OBJECT_SELF;
	
	SetLocalInt(oPC, kRest, 1);
	AssignCommand(oPC, ActionRest());
	
	MarkHertiageFeatsAsRested(oPC);
	DelayCommand(6.0, ResetHertitageFeatUses(oPC));
	
}