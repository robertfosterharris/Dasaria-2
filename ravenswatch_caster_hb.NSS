// caster battle heartbeat -- beats watching the combat log
void main()
{
 // they needed separate tags to be properly destroyed by another script, choose opponent
 string sOpponentTag = "ravenswatch_caster2";
 if (GetTag(OBJECT_SELF) == "ravenswatch_caster2")
 {
 	sOpponentTag = "ravenswatch_caster1";
 }
 object oOpponent = GetNearestObjectByTag(sOpponentTag);
 
 if (!GetIsInCombat())
 {
	int nRandom=Random(4);
	if (nRandom==0)
	{
		object oCaster = GetNearestObjectByTag(sOpponentTag);
		ActionCastFakeSpellAtObject(SPELL_FIREBALL,oCaster,PROJECTILE_PATH_TYPE_BALLISTIC);
		PlayCustomAnimation (oOpponent, "*damage01",0,1.0);
		PlayVoiceChat (VOICE_CHAT_PAIN1,oOpponent);
	} 
	else if (nRandom==1)
	{
		object oCaster = GetNearestObjectByTag(sOpponentTag);
		ActionCastFakeSpellAtObject(SPELL_LIGHTNING_BOLT,oCaster,PROJECTILE_PATH_TYPE_BALLISTIC);
		PlayCustomAnimation (oOpponent, "*damage01",0,1.0);
		PlayVoiceChat (VOICE_CHAT_PAIN1,oOpponent);
	}
	else
	{
		ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT);
	}
  }
}