// gui_bhvr_disarm_on
/*
	Behavior script for the character sheet behavior sub-panel
*/
// ChazM 4/26/06
// ChazM 11/9/06 - Examined Creature update 

#include "gui_bhvr_inc"

void main(int iExamined)
{
	SetBehavior(STR_REF_BEHAVIOR_DISARM_TRAPS_ON, iExamined);
}