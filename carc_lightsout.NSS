//Dispels light spell
void main()
{
object oPC = GetEnteringObject();
if (GetIsDM(oPC)) return;
effect eEff = GetFirstEffect(oPC);
while (GetIsEffectValid(eEff))
{
if (GetEffectType(eEff) == EFFECT_TYPE_VISUALEFFECT)
{ if (GetEffectSpellId(eEff) == SPELL_LIGHT)
{ RemoveEffect(oPC,eEff); 
SendMessageToPC(oPC,"<color=#C1AB89>[ Your light spell is suddenly snuffed out. ]");} }
eEff = GetNextEffect(oPC);
}
}