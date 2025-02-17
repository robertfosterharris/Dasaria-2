//Put this script OnEnter
void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

object oTarget;
oTarget = GetObjectByTag("c_gargoyle_statue");

effect eEffect;
eEffect = GetFirstEffect(oTarget);
while (GetIsEffectValid(eEffect))
   {
   if (GetEffectType(eEffect)==EFFECT_TYPE_PETRIFY) RemoveEffect(oTarget, eEffect);
   eEffect = GetNextEffect(oTarget);
   

ChangeToStandardFaction(oTarget, STANDARD_FACTION_HOSTILE); 

SetPlotFlag(oTarget, FALSE);

}

AssignCommand(oTarget, ActionAttack(oPC));



}