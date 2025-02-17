void Key(object oSource)
{
CreateObject(OBJECT_TYPE_ITEM,"carc_key_final",GetLocation(oSource));
}
void main()
{
	object oSource = GetObjectByTag("carc_coliel_bosskeyspawn");
	effect eRay1=EffectNWN2SpecialEffectFile("sp_beshadowed_ray",oSource);//obelisks
	object oPoint1=GetObjectByTag("carc_coliel_bossray01");
	object oPoint2=GetObjectByTag("carc_coliel_bossray02");
object oPoint5=GetObjectByTag("carc_coliel_bossray05");
object oPoint6=GetObjectByTag("carc_coliel_bossray06");
effect eRay3=EffectNWN2SpecialEffectFile("sp_utterdark_ray",oSource);//eyes
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eRay1,oPoint1,12.0);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eRay1,oPoint2,12.0);

DelayCommand(7.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eRay3,oPoint5,5.0));
DelayCommand(7.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eRay3,oPoint6,5.0));

	DelayCommand(12.0,Key(oSource));
	
}