// pande_oce
// create power shards
// oPC is executing this
//
void main()
{
	int n = 1;
	object oPC = OBJECT_SELF;
	object oWP = GetNearestObjectByTag("wp_shard",oPC,n);
	
	while (GetIsObjectValid(oWP))
	{
		CreateObject(OBJECT_TYPE_PLACEABLE,"power_shard",GetLocation(oWP),FALSE);
		n++;
		oWP = GetNearestObjectByTag("wp_shard",oPC,n);
	}
}