//event_wired_trebuchet_hb
//fire on players!
void main()
{
	// slow it down
	int nRand = Random(6); 
	if ( nRand == 0 )
	{
		object oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
		ActionCastSpellAtObject(SPELL_FIREBALL, oTarget, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_BALLISTIC_LAUNCHED, TRUE);
	}
}