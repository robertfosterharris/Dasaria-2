// April 2005
// B G P Hughes
// Area transition within the same area that takes associates

void main()
{
  object oClicker = GetClickingObject();
  object oTarget = GetTransitionTarget(OBJECT_SELF);

  SetAreaTransitionBMP(AREA_TRANSITION_RANDOM);

  AssignCommand(oClicker,JumpToObject(oTarget));

object oPC = GetClickingObject();
 //lines added for henchmen: B W-Husey 26th February 2003
//location loidDest = GetLocation(GetWaypointByTag("WP_InnUpstairs"));
 object oAssociate1 = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oPC);
 object oAssociate2 = GetAssociate(ASSOCIATE_TYPE_DOMINATED, oPC);
 object oAssociate3 = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oPC);
 object oAssociate4 = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC);
 object oAssociate5 = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC,1);
 object oAssociate6 = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC,2);
 object oAssociate7 = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC,3);
 object oAssociate8 = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC,4);
 AssignCommand(oAssociate1, JumpToObject(oTarget));
 AssignCommand(oAssociate2, JumpToObject(oTarget));
 AssignCommand(oAssociate3, JumpToObject(oTarget));
 AssignCommand(oAssociate4, JumpToObject(oTarget));
 AssignCommand(oAssociate5, JumpToObject(oTarget));
 AssignCommand(oAssociate6, JumpToObject(oTarget));
 AssignCommand(oAssociate7, JumpToObject(oTarget));
 AssignCommand(oAssociate8, JumpToObject(oTarget));
}