// i_faction_om_leader_ac
// faction leader item for OM
// creates faction item on targeted player

void main()
{
	object oTarget = 	GetItemActivatedTarget();
	effect eVis 	= 	EffectVisualEffect(VFX_DUR_WAUKEEN_HALO);
	CreateItemOnObject("faction_om_item",oTarget,1);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVis,oTarget,240.0f);
}