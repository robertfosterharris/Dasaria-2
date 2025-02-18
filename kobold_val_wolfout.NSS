// kobold_val_wolfout

void main()
{
	object oVal = OBJECT_SELF;
	location lLoc = GetLocation(oVal);
	object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);
	object oWolf;
	effect ePoly = EffectVisualEffect(VFX_IMP_POLYMORPH);
	
	
	DestroyObject(oVal);
	ApplyEffectAtLocation(DURATION_TYPE_INSTANT,ePoly,lLoc);
	oWolf = CreateObject(OBJECT_TYPE_CREATURE,"kobold_val_w",lLoc,TRUE);
	AssignCommand( oWolf, ActionAttack(oPC) );
}