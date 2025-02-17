
void main()
{
    object oPC;
	object oMarlee;
	
	oPC = GetItemActivator();
	oMarlee = GetNearestObjectByTag("daris_marlee");
	
	if (GetIsObjectValid(oMarlee) && (GetLocation(oPC) == GetLocation(oMarlee)))
	{
		SendMessageToPC(oPC, "The person you are calling is temporarily unavailable.  Please try your call again later.  Goodbye!");
	}
	else
	{
		SetLocalLocation(oPC, "lDarisMarleeOath", GetItemActivatedTargetLocation());
		DestroyObject(GetItemActivated());
		ExecuteScript("daris_marlee_oath", oPC);
	}
}