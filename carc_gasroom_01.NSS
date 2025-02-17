void main()
{
object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;
SetLocalInt(oPC,"gassed",1);
}