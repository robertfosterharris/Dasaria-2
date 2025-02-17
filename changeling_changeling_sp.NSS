// changeling_changeling_sp

void ActionPhineaSpawn()
{
	object oMarisol = GetNearestObjectByTag("ravenswatch_changeling_marisol");
	if (GetIsObjectValid(oMarisol)) ActionForceFollowObject(oMarisol);
	else DestroyObject(OBJECT_SELF);
}

void main()
{
	DelayCommand(3.0,ActionPhineaSpawn());
}