// lendol_fort2_siegetower_de
// wired 2010-08-23
// explodes and leaves a 'corpse'
//
//
void main()
{
	//object oTower = CreateObject(OBJECT_TYPE_PLACEABLE,"lendol_tower_wreckage",GetLocation(OBJECT_SELF));
	//DelayCommand(30.f,DestroyObject(oTower));
	
	effect eExplode = EffectNWN2SpecialEffectFile("fx_balor_fire_explosion");
	ApplyEffectToObject(DURATION_TYPE_INSTANT,eExplode,OBJECT_SELF);
}