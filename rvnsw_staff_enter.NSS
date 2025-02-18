// wired 09/18/08
// put an effect on the staff when a culnite walks here
void main()
{
	object oPC = GetEnteringObject();
	string sPCDeity = GetStringUpperCase(GetDeity(oPC));
	if (sPCDeity == "CULNUL (NERGAL)")
	{
		// do stuff
		object oStaff = GetNearestObjectByTag("rvnw_dreadlichstaff");
		if (GetIsObjectValid(oStaff))
		{
			effect eFlame = EffectVisualEffect(VFX_DUR_FIRE);
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eFlame,oStaff,90.0f);
		}
	}
}