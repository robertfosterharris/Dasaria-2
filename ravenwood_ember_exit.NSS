void main()
{
	object oArea = OBJECT_SELF;
	object oPC = GetExitingObject();
    
	if (GetIsPC(oPC))
    {
		SetPlotFlag(oPC,FALSE);
	}

	ExecuteScript("j4acs_ha_exit",OBJECT_SELF);
}