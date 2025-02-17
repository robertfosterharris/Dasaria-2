//Shadow death script.
//Decreases the HOW_MANY varint on oSource by 1
//When it reaches 0 then booya jackpot.





void main()
{
object oSource = GetObjectByTag("carc_coliel_shadowmaker");
int nHowMany = GetLocalInt(oSource,"HOW_MANY"); nHowMany = nHowMany-1;
SetLocalInt(oSource,"HOW_MANY",nHowMany);
	if (GetLocalInt(oSource,"HOW_MANY") < 1)
	{
	ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectNWN2SpecialEffectFile("sp_finger_of_death"),GetLocation(oSource));
	ExecuteScript("carc_boss3_death2",oSource);
	}

}