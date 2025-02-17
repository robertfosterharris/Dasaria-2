/*

	Area OnExit - apply ghostly visiage for dreamworld

	2006/12/10		jhr4n
		Initial revision
    04/30/2007  RFH     ADDED CALL TO GLOBAL EXIT SCRIPT        
		
*/


void main( )
{
	object oArea = OBJECT_SELF;
	object oPC = GetEnteringObject();
	
	effect e = GetFirstEffect(oPC);
	while (GetIsEffectValid(e))
	{
		if (GetEffectCreator(e) == oArea) RemoveEffect(oPC, e);
		e = GetNextEffect(oPC);
	}
    ExecuteScript("j4acs_ha_exit", oArea);
}


/*
*/