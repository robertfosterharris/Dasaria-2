// wired 2008-01-19
// i_dmwand_featswitch_ac
void main()
{
    object oDM     = GetItemActivator();
    object oItem    = GetItemActivated();
    object oTarget  = GetItemActivatedTarget();
    location lTarget = GetItemActivatedTargetLocation();

	// Only DMs may use these
	if ( !GetIsDM(oDM) )
		return;

	
	SetLocalObject(oDM,"oTarget", oTarget);
		
	DisplayInputBox (	oDM,
						-1,
						"Enter 2 feats in this format: ####,####",
						"gui_dmwand_featswitch_ok", 
						"",
						TRUE,
						"",
						0,
						"",
						0,
						"",
						""	);
}