// pande_exit
// destroy power shards
// oPC is executing this
//
void main()
{
	object oPC = OBJECT_SELF;
	int n;
	object oPlc;

	oPlc = GetNearestObjectByTag("power_shard",oPC,n);
	n = 1;
    
    while (GetIsObjectValid(oPlc))
    {
     	DestroyObject (oPlc);
		n++;
		oPlc = GetNearestObjectByTag("power_shard",oPC,n);
	}

}