//	ON SPAWN - HAVE CREATURES PLAY ANIMATION LOOP AFTER SPAWNING
//
//	REQUIRED CREATURE VARIABLES
//	SpawnScript	= gb_animate_sp
//
//	07/30/08	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM
//
#include "x0_i0_anims"

void Animate(object oCreature);

void main()
{
	object oCreature;
	
	oCreature = OBJECT_SELF;
	SetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS, FALSE);
   	SetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS, FALSE);
	SetSpawnInCondition(NW_FLAG_PERCIEVE_EVENT, TRUE);
	SetBumpState(oCreature, BUMPSTATE_UNBUMPABLE);
	SetAnimationCondition(NW_ANIM_FLAG_CONSTANT);
	SetOrientOnDialog(oCreature, FALSE);
//	ClearAllActions(TRUE);
//	DelayCommand(10.0, ActionDoCommand(Animate(oCreature)));
}

void Animate(object oCreature)
{
	PlayCustomAnimation(oCreature, GetLocalString(oCreature, "sAnimation"), 1);
}