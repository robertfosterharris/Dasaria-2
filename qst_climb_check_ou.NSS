#include "qst_climb_down_ou"
void reset_rope(object oPC);
void main()
{
	object oPC = GetLastUsedBy();
	object oPole = OBJECT_SELF;
	int isRopeSet = GetLocalInt(oPole, "isRopeSet");
	
	if (isRopeSet == FALSE) {
	
		// rope isnt already set, so check to see if the PC has a rope.
		object oRope = GetItemPossessedBy(oPC, "length_of_rope");
		// if PC has rope, then use it.
		if(oRope != OBJECT_INVALID) {
			AssignCommand(GetModule(), DelayCommand(60.0,
     			  reset_rope(oPC)));
			
			 AssignCommand(oPC, PlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0,5.0));
			FloatingTextStringOnCreature("You tie one end of the rope you found to the pole.", oPC);
			SetLocalInt(oPole, "isRopeSet", TRUE);
			DestroyObject(oRope);
		} else {
			FloatingTextStringOnCreature("Perhaps you need to find something to lower yourself down with?", oPC);
			SetLocalInt(oPole, "isRopeSet", FALSE);
		}
	} else {
		// rope is already there so PC can climb down.
		FloatingTextStringOnCreature("There is a rope tied here.  Carefully, you start to descend.", oPC);
		DelayCommand(3.0, climb_down());
		AssignCommand(oPC, PlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0,5.0));
	}
}

void reset_rope(object oPC) {
	object oPole = GetNearestObjectByTag("broken_floor_rod", oPC);
	SetLocalInt(oPole, "isRopeSet", FALSE);
}