// event_nelina_jump
void main()
{
	object oNelina = GetNearestObjectByTag("nelina");
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
	
	object oWP = GetNearestObjectByTag("WP_Trades_from_Docks");
	
	AssignCommand(oNelina,ActionJumpToObject(oWP));
	AssignCommand(oTalon1,ActionJumpToObject(oWP));
	AssignCommand(oTalon2,ActionJumpToObject(oWP));	
	AssignCommand(oTalon3,ActionJumpToObject(oWP));	
	AssignCommand(oTalon4,ActionJumpToObject(oWP));	
	AssignCommand(oTalon5,ActionJumpToObject(oWP));
	AssignCommand(oTalon6,ActionJumpToObject(oWP));
	AssignCommand(oMagnus1,ActionJumpToObject(oWP));
	AssignCommand(oMagnus2,ActionJumpToObject(oWP));
	AssignCommand(oMagnus3,ActionJumpToObject(oWP));
	AssignCommand(oCounselor,ActionJumpToObject(oWP));	
}