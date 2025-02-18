// wired 2009/12/06
// turn statues into real creatures when triggered
//
void main()
{
	object oPC = GetEnteringObject();
		
	if (!GetIsPC(oPC)) return;
	
	object oCreature	= 	GetFirstInPersistentObject(OBJECT_SELF);
	effect eRestore		=	EffectVisualEffect(VFX_DUR_SPELL_FLESH_TO_STONE);
	
	while (GetIsObjectValid(oCreature))
	{	
		if (GetTag(oCreature) == "rvnwtch_koalisk_statue")
		{
			ApplyEffectToObject(DURATION_TYPE_INSTANT,eRestore,oCreature);
			CreateObject(OBJECT_TYPE_CREATURE,"rvnwtch_koalisk_live",GetLocation(oCreature),TRUE);
			DestroyObject(oCreature);
		}
		oCreature = GetNextInPersistentObject(OBJECT_SELF);
	}
}