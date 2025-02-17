//No restzone compability in Dasaria..
//Gotta improvise. Rest timers should be added here.
//-frac

void main()
{
object oPC = GetLastUsedBy();
if (GetIsInCombat(oPC)) return;
if (!GetIsPC(oPC)) return;
//AssignCommand(oPC, ActionRest(1));

//check this possibility later:
SendMessageToPC(oPC,"Resting...");
ForceRest(oPC);
PlayCustomAnimation(oPC,"kneelidle",1,6.0);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectCutsceneParalyze(),oPC,5.9);
DelayCommand(5.9,SendMessageToPC(oPC,"Done resting."));

}