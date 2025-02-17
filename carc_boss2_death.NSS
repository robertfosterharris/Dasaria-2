void main()
{
object oSource1=GetObjectByTag("carc_abelis_oblsk_src01");
SetLocalInt(oSource1,"BOSS_DEAD",1);
    effect eEffect = GetFirstEffect(OBJECT_SELF);
    while(GetIsEffectValid(eEffect))
    {
      RemoveEffect(OBJECT_SELF, eEffect);
      eEffect = GetNextEffect(OBJECT_SELF);
    }
ExecuteScript("nw_c2_default7",OBJECT_SELF);
}