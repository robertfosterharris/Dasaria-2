//rvnw_mandrake_oo
void main()
{
	if (
		(!GetIsNight() ) ||
		(!GetHasSpellEffect(SPELL_BLINDNESS_AND_DEAFNESS,OBJECT_SELF))
		//&& !GetHasSpellEffect(SPELL_REMOVE_CURSE,OBJECT_SELF)
		)
	{
		DestroyObject(GetFirstItemInInventory());
		ActionCastSpellAtLocation(SPELL_WAIL_OF_THE_BANSHEE, GetLocation(OBJECT_SELF), METAMAGIC_MAXIMIZE, TRUE);
		DestroyObject(OBJECT_SELF);
	}
	// otherwise, we're cool
}