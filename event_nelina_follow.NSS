// event_nelina_follow
void followTree(object oLeader)
{
    ClearAllActions();
    ActionForceFollowObject(oLeader);
}
void main()
{
    object oLeader = GetNearestObjectByTag("nelina");
   
    object oTalon1 = GetNearestObjectByTag("talon_honorguard_melee1");
    object oTalon2 = GetNearestObjectByTag("talon_honorguard_melee2");
    object oTalon3 = GetNearestObjectByTag("talon_honorguard_melee3");
	object oTalon4 = GetNearestObjectByTag("talon_honorguard_monk1");
    object oTalon5 = GetNearestObjectByTag("talon_honorguard_monk2");
    object oTalon6 = GetNearestObjectByTag("talon_honorguard_monk3");	
    object oMagnus1 = GetNearestObjectByTag("event_magnus1");
    object oMagnus2 = GetNearestObjectByTag("event_magnus2");
    object oMagnus3 = GetNearestObjectByTag("event_magnus3");
    object oCounselor = GetNearestObjectByTag("event_magnus_counselor");   
   
    // one follows the leader
    AssignCommand(oTalon1,followTree(oLeader));
    AssignCommand(oCounselor,followTree(oLeader));
    AssignCommand(oMagnus1,followTree(oLeader));
	AssignCommand(oTalon4,followTree(oLeader));
    // two follows one
    AssignCommand(oTalon2,followTree(oTalon1));
	AssignCommand(oTalon5,followTree(oTalon1));
    AssignCommand(oMagnus2,followTree(oMagnus1));   
    // three follows two
    AssignCommand(oTalon3,followTree(oTalon2));
	AssignCommand(oTalon6,followTree(oTalon2));
    AssignCommand(oMagnus3,followTree(oMagnus2));
}