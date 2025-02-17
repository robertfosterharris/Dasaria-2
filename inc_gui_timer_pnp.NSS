//------------------------------------------------------------------------------
// Include file for the GUI Timer mini-system
//------------------------------------------------------------------------------
/*
	How the timer works:
	The timer GUI is a simple text object which sits at the top of the player's
	screen and displays two lines of text (one for a title, the other for the
	time). It is actually run by the below script routines, which decrement the
	timer's value each second.
	
	To begin the timer:
	Use StartTimer(). You will need to specify the player to run the timer for,
	how long, in seconds, you want the timer to last for, a script to be called
	when/if the timer ends and, optionally, the variables use to run the timer
	and its displayed text.
	
	To pause the timer:
	You need to set a variable, the name of which is specified in StartTimer(),
	to 2. Calling PauseTimer() will do this for you. ResumeTimer() will resume
	it.
	
	To end the timer:
	You need to set a variable, the name of which is specified in StartTimer(),
	to TRUE. This will cause the timer to end on its next iteration. Calling
	EndTimer() will do this for you.
	Alternatively, you can end the timer instantly with ClearUpTimer(). If you
	simply wish to remove the GUI, but leave all the variables used intact (for
	example, if you wish to temporarily remove the timer), you can call
	CloseTimer().
	
	Notes:
	 o 	StartTimer() should be called by the PC or, preferably, by an area or
	 	the module. This is because it repeatedly decrements the value of the
		timer, and so if run by an object which gets destroyed, the timer will
		stop working.
	
	 o	You may wish to end the timer if the player dies, by using the module's
		OnPlayerDeath script.
	
	 o	Text space for the title is limited to 500 pixels (just under ~30
	 	characters I think), though you can modify the XML file to adjust for
		longer titles if you really need to. This is more than sufficient for
		short messages like "Time Remaining:", however.
		
	 o	The variable with the name GUI_TIMER_VARNAME_OPEN (defaults to
	 	"GUITimer_Open") stored whether or not the timer is running or not.
		This should never be changed manually, unless you also open or close the
		timer manually (i.e. with DisplayGuiScreen() or CloseGUIScreen()).
		Otherwise the system could continue to decrease the value of the timer
		even when the timer is closed (better to hide the GUI if you want to do
		this).
*/
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Constants
//------------------------------------------------------------------------------

const string GUI_TIMER_XML = "pnptimer.xml";
const string GUI_TIMER_SCREEN_NAME = "SCREEN_TIMER";
const string GUI_TIMER_TEXT_NAME = "TIMER_TEXT";
const string GUI_TIMER_TEXT_DEFAULT = "Time Remaining";
const string GUI_TIMER_VARNAME_TIMEVAR = "GUITimer_TimeVar";
const string GUI_TIMER_VARNAME_STOPVAR = "GUITimer_StopVar";
const string GUI_TIMER_VARNAME_OPEN = "GUITimer_Open"; //Do not manually change this variable

//------------------------------------------------------------------------------
// Function prototypes
//------------------------------------------------------------------------------

//Begins the timer for oPC. Note that oPC can have only one timer active at
//once.
// nTimeInSeconds - What it says. So four minutes would be 240.
// sEndScript - The script to be run (by oPC) when/if the timer hits 0. Note
//		that at this point, the timer will also be removed.
// oPC - The player who will see the timer.
// sTimerText - The text shown above the timer (defaults to "Time Remaining").
// sStopVar - The name of a variable which, if set to TRUE on oPC, will cause
//		the timer to stop (within the next second). If it equals 2,	the timer
//		will continue to run, but will not go down (it will be paused).
//		Note that you can alternatively call EndTimer() or ClearUpTimer().
// sTimeVar - The variable which stores the current number of seconds revaining.
//		By changing the value of this variable, you can increase/decrease the
//		timer manually.
void StartTimer(int nTimeInSeconds, string sEndScript = "", object oPC = OBJECT_SELF, string sTimerText = "", string sStopVar = "GUITimer_StopVar", string sTimeVar = "GUITimer_TimeLeft");


//Tells oPC's timer to stop on the next iteration. This is just a wrapper for
//setting the correct variable on oPC (see StartTimer()).
void EndTimer(object oPC);


//Pauses the timer for oPC. Note that if you have just set the timer to close on
//its next iteration, this will cause it to pause *instead* of closing.
void PauseTimer(object oPC);


//Resumes the timer for oPC. Note that if you have just set the timer to close on
//its next iteration, this will prevent that.
void ResumeTimer(object oPC);


//Closes the timer for oPC. You can make the timer close itself by calling
//EndTimer() or by setting a variable on oPC (see StartTimer()), but if you wish
//to do it manually (for example, if you don't want the variables to be cleaned
//up), use this function.
void CloseTimer(object oPC);


//Closes the timer for oPC and cleans up all related variables. This is done
//automatically by the timer if you stop it using EndTimer(), but if you want to
//do it instantly, you can use this function.
void ClearUpTimer(object oPC);


//Adjusts oPC's timer by nAdjust.
void AdjustTimer(object oPC, int nAdjust);


//Returns whether oPC has a timer currently active. Note that the timer is
//considered active if the GUI is open - it may or may not be paused.
int IsTimerActive(object oPC);


//------------------------------------------------------------------------------
// Function definitions
//------------------------------------------------------------------------------

//Private function for StartTimer().
//Repeatedly lowers the timer value by one each second.
void DecTimer(object oPC, string sTimeVar, string sEndScript, string sStopVar)
{
	if(!GetLocalInt(oPC, GUI_TIMER_VARNAME_OPEN))
	{
		return;
	}
	
	int n = GetLocalInt(oPC, sTimeVar);
	if(!n)
	{
		ExecuteScript(sEndScript, oPC);
		ClearUpTimer(oPC);
		return;
	}
	
	int nStop = GetLocalInt(oPC, sStopVar);
	if(nStop == 1)
	{
		ClearUpTimer(oPC);
		return;
	}
	
	if(nStop != 2)
	{
		n--;
	}
	
	SetLocalInt(oPC, sTimeVar, n);
	DelayCommand(1.0, DecTimer(oPC, sTimeVar, sEndScript, sStopVar));
}


//Begins the timer for oPC. Note that oPC can have only one timer active at
//once.
// nTimeInSeconds - What it says. So four minutes would be 240.
// sEndScript - The script to be run (by oPC) when/if the timer hits 0. Note
//		that at this point, the timer will also be removed.
// sStopVar - The name of a variable which, if set to TRUE on oPC, will cause
//		the timer to stop (within the next second). If it equals 2,	the timer
//		will continue to run, but will not go down (it will be paused).
//		Note that you can alternatively call EndTimer() or ClearUpTimer().
// oPC - The player who will see the timer.
// sTimeVar - The variable which stores the current number of seconds revaining.
//		By changing the value of this variable, you can increase/decrease the
//		timer manually.
void StartTimer(int nTimeInSeconds, string sEndScript = "", object oPC = OBJECT_SELF, string sTimerText = "", string sStopVar = "GUITimer_StopVar", string sTimeVar = "GUITimer_TimeLeft")
{
	SetLocalInt(oPC, GUI_TIMER_VARNAME_OPEN, TRUE);
	
	SetLocalString(oPC, GUI_TIMER_VARNAME_STOPVAR, sStopVar);
	SetLocalString(oPC, GUI_TIMER_VARNAME_TIMEVAR, sTimeVar);
	SetLocalInt(oPC, "GUITimer_TimeLeft", nTimeInSeconds);
	DisplayGuiScreen(oPC, GUI_TIMER_SCREEN_NAME, FALSE, GUI_TIMER_XML);
	
	if(sTimerText == "")
	{
		sTimerText = GUI_TIMER_TEXT_DEFAULT;
	}
	
	SetGUIObjectText(oPC, GUI_TIMER_SCREEN_NAME, GUI_TIMER_TEXT_NAME, -1, sTimerText);	
	DelayCommand(1.0, DecTimer(oPC, sTimeVar, sEndScript, sStopVar));
}


//Tells oPC's timer to stop on the next iteration. This is just a wrapper for
//setting the correct variable on oPC (see StartTimer()).
void EndTimer(object oPC)
{
	SetLocalInt(oPC, GetLocalString(oPC, GUI_TIMER_VARNAME_STOPVAR), 1);
}


//Pauses the timer for oPC. Note that if you have just set the timer to close on
//its next iteration, this will cause it to pause *instead* of closing.
void PauseTimer(object oPC)
{
	SetLocalInt(oPC, GetLocalString(oPC, GUI_TIMER_VARNAME_STOPVAR), 2);
}


//Resumes the timer for oPC. Note that if you have just set the timer to close on
//its next iteration, this will prevent that.
void ResumeTimer(object oPC)
{
	SetLocalInt(oPC, GetLocalString(oPC, GUI_TIMER_VARNAME_STOPVAR), FALSE);
}


//Closes the timer for oPC. You can make the timer close itself by calling
//EndTimer() or by setting a variable on oPC (see StartTimer()), but if you wish
//to do it manually (for example, if you don't want the variables to be cleaned
//up), use this function.
void CloseTimer(object oPC)
{
	SetLocalInt(oPC, GUI_TIMER_VARNAME_OPEN, FALSE);
	CloseGUIScreen(oPC, GUI_TIMER_SCREEN_NAME);
}


//Closes the timer for oPC and cleans up all related variables. This is done
//automatically by the timer if you stop it using EndTimer(), but if you want to
//do it instantly, you can use this function.
void ClearUpTimer(object oPC)
{
	SetLocalInt(oPC, GUI_TIMER_VARNAME_OPEN, FALSE);
	CloseGUIScreen(oPC, GUI_TIMER_SCREEN_NAME);
	
	string sStopVar = GetLocalString(oPC, GUI_TIMER_VARNAME_STOPVAR);
	string sTimeVar = GetLocalString(oPC, GUI_TIMER_VARNAME_TIMEVAR);
	DelayCommand(0.5, DeleteLocalString(oPC, GUI_TIMER_VARNAME_STOPVAR));
	DelayCommand(0.5, DeleteLocalString(oPC, GUI_TIMER_VARNAME_TIMEVAR));
	DelayCommand(0.5, DeleteLocalInt(oPC, sStopVar));
	DelayCommand(0.5, DeleteLocalInt(oPC, sTimeVar));
}


//Adjusts oPC's timer by nAdjust.
void AdjustTimer(object oPC, int nAdjust)
{
	string sTimeVar = GetLocalString(oPC, GUI_TIMER_VARNAME_TIMEVAR);
	int n = GetLocalInt(oPC, sTimeVar);
	
	n += nAdjust;
	if(!n)
	{
		n = 0;
	}
	
	SetLocalInt(oPC, sTimeVar, n);
}


//Returns whether oPC has a timer currently active. Note that the timer is
//considered active if the GUI is open - it may or may not be paused.
int IsTimerActive(object oPC)
{
	return GetLocalInt(oPC, GUI_TIMER_VARNAME_OPEN);
}