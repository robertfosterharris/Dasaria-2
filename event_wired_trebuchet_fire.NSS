//event_wired_trebuchet_fire
//fire on enemies
void main()
{
	object oPlayer = GetPCSpeaker();
	object oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oPlayer, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
	ActionCastSpellAtObject(SPELL_FIREBALL, oTarget, METAMAGIC_MAXIMIZE, TRUE, 0, PROJECTILE_PATH_TYPE_BALLISTIC_LAUNCHED, TRUE);
}