//	ONUSERDEFINED SCRIPT - KILLS VAMPIRES WHEN HIT WITH MAGIC SPOON
//
//	01/28/2007	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM
//
void main()
{
	int nEvent;
	object oPC;
	
	nEvent = GetUserDefinedEventNumber();
	switch(nEvent)
	{
		case EVENT_DAMAGED:
		{
			oPC = GetLastAttacker();
			if(GetTag(GetLastWeaponUsed(oPC)) == "vq_it_spoon")
			{
				SetImmortal(OBJECT_SELF, FALSE);
				ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(TRUE), OBJECT_SELF);
			}
			else
			{
				FloatingTextStringOnCreature("Use the spoon, " + GetFirstName(oPC) + ".", oPC, FALSE, 2.0, 4294967295, 4294967295, 0.4, [0.0,0.0,1.0]);
			}
		}
		break;
	}
}