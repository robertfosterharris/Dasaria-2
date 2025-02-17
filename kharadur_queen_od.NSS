//kharadur_queen_od

void DoEeet()
{
	int i;
	
	for (i = 1; i < 6; i ++)
	{
		CreateObject(OBJECT_TYPE_CREATURE,"c_spidgiant",GetLocation(OBJECT_SELF),FALSE);
	} 
}
void main()
{
	effect eVis = EffectVisualEffect(VFX_HIT_AOE_LIGHTNING);
	ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eVis,GetLocation(OBJECT_SELF));
	DelayCommand(2.0,DoEeet());
}