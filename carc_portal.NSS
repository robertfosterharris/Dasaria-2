//simple portal script with vfx
void main()
{
object oPC = GetLastUsedBy();
location lWP = GetLocation(GetWaypointByTag(GetTag(OBJECT_SELF)));
AssignCommand(oPC, ClearAllActions(TRUE));
AssignCommand(oPC,JumpToLocation(lWP));
ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectNWN2SpecialEffectFile("fx_teleport"),GetLocation(oPC));

DelayCommand(0.1,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectNWN2SpecialEffectFile("fx_teleport"),GetLocation(oPC)));
}