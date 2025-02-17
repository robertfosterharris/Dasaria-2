// event_nelina_spawn
#include "x0_i0_position"
void main()
{
    location lTarget = GetLocation(GetWaypointByTag("WP_NELINA_SPAWN"));
    object oNelina = CreateObject(OBJECT_TYPE_CREATURE, "nelina", lTarget, TRUE);
   
	location lCons = GetLocation(GetWaypointByTag("WP_CONS_SPAWN"));
    object oMagnus_Counselor = CreateObject(OBJECT_TYPE_CREATURE, "event_magnus_counselor", lCons, TRUE);  
	
	location lMagnus = GetLocation(GetWaypointByTag("WP_MAGNUS_SPAWN"));
    object oMagnus1 = CreateObject(OBJECT_TYPE_CREATURE, "event_magnus1", lMagnus, TRUE);
	object oMagnus2 = CreateObject(OBJECT_TYPE_CREATURE, "event_magnus2", lMagnus, TRUE);	
	object oMagnus3 = CreateObject(OBJECT_TYPE_CREATURE, "event_magnus3", lMagnus, TRUE);    

	location lTalon1 = GetLocation(GetWaypointByTag("WP_TALON1_SPAWN"));
	object oTalon1 = CreateObject(OBJECT_TYPE_CREATURE, "talon_honorguard_melee1", lTalon1, TRUE);       
	object oTalon4 = CreateObject(OBJECT_TYPE_CREATURE, "talon_honorguard_monk1", lTalon1, TRUE);
	
	location lTalon2 = GetLocation(GetWaypointByTag("WP_TALON2_SPAWN"));	
	object oTalon2 = CreateObject(OBJECT_TYPE_CREATURE, "talon_honorguard_melee2", lTalon2, TRUE);       
	object oTalon5 = CreateObject(OBJECT_TYPE_CREATURE, "talon_honorguard_monk2", lTalon2, TRUE);    
	
	location lTalon3 = GetLocation(GetWaypointByTag("WP_TALON3_SPAWN"));	
	object oTalon3 = CreateObject(OBJECT_TYPE_CREATURE, "talon_honorguard_melee2", lTalon3, TRUE);       
	
	location lTalon4 = GetLocation(GetWaypointByTag("WP_TALON4_SPAWN"));	
	object oTalon6 = CreateObject(OBJECT_TYPE_CREATURE, "talon_honorguard_monk2", lTalon4, TRUE);
   
}