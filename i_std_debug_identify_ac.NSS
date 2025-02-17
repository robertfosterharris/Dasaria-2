/*
*/

void main()
	{
	object oPC;
	object oTarget;
	
	oPC = GetItemActivator();
	oTarget = GetItemActivatedTarget();

	SendMessageToPC( oPC, "Resref: " + GetResRef(oTarget) );
	SendMessageToPC( oPC, "Tag: " + GetTag(oTarget) );
	}		
	
/*
*/