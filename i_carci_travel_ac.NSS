//Recall Stone
//Ports PC to target
//Ath
void main()
{
object oPC = GetItemActivator();
location loc = GetItemActivatedTargetLocation();

effect eTeleport = EffectNWN2SpecialEffectFile("fx_teleport");
ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eTeleport, GetLocation(oPC));

AssignCommand(oPC,ClearAllActions());
AssignCommand(oPC, JumpToLocation(loc));
ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eTeleport, loc);
}