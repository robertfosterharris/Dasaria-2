/*

	Area OnEnter - apply ghostly visiage for dreamworld

	2006/12/10		jhr4n
		Initial revision
    04/30/2007  RFH     ADDED CALL TO GLOBAL ON ENTER SCRIPT
*/


void main( ) 
{ 
        
    object oArea = OBJECT_SELF; 
    object oPC = GetEnteringObject(); 
 
    if (GetIsPC(oPC))
    {
        effect eHit = EffectVisualEffect( VFX_DUR_SPELL_GHOSTLY_VISAGE ); 
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eHit, oPC);
    }           
    ExecuteScript("j4acs_ha_enter", oArea);    
} 

/*
*/