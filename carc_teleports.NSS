//Teleport room!
//We teleport PC to a random waypoint. PCs must guess the pattern.
//Solution is: 16 Down -> 11 Up -> 3 Right - > finish line!


int Teleport(int nRand, int nSelf)
{
int nRand = d20(1);

if (nRand == nSelf) { nRand = nRand + d12(1); }
if (nRand == 11) { nRand = 11+d8(1); }
if (nRand == 3) { nRand = 3+d6(1); }
if (nRand > 20) {nRand = 3+d6(1);}

return nRand;
}

void main()
{
object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;
int nSelf = GetLocalInt(OBJECT_SELF,"self");
int nRand;

 
if (nSelf == 916) //if 16 down is met (added 9 as prefix to correct triggers)
{ nRand = 11; }
else if (nSelf == 911) //if 11 up is met (added 9 as prefix to correct triggers)
{ nRand = 3; }
else if (nSelf == 93) //if 3 right is met (added 9 as prefix to correct triggers)
{ nRand = 666; }//666 is the final wp

else //none of the above. just random
{ nRand = Teleport(nRand, nSelf); }

//SendMessageToPC(oPC,"Teleporting to "+IntToString(nRand));

string sWP = "carc_coli_tele_"+IntToString(nRand);
location lWP = GetLocation(GetWaypointByTag(sWP));
ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectNWN2SpecialEffectFile("fx_inspire_regeneration_hit"),GetLocation(oPC));
AssignCommand(oPC, ClearAllActions(TRUE));
AssignCommand(oPC,JumpToLocation(lWP));
ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectNWN2SpecialEffectFile("fx_teleport"),oPC);


}