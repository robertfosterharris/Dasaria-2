// gui_timer_update
// DM Loki
// Version 1.0
// Displays countdown on active GUI window for PnP script.
// 06/12/12


void main()
{
	int nTimeLeft = GetLocalInt(OBJECT_SELF, "GUITimer_TimeLeft");
	int nRight = nTimeLeft % 60;
	int nLeft = nTimeLeft / 60;
	string sLeft = IntToString(nLeft);
	string sRight = IntToString(nRight);
	if(GetStringLength(sRight) == 1)
	{
		sRight = "0" + sRight;
	}
	
	string sTimeLeft = sLeft + " : " + sRight;
	SetGUIObjectText(OBJECT_SELF, "SCREEN_TIMER", "TIMER_TIMER", -1, sTimeLeft);
}