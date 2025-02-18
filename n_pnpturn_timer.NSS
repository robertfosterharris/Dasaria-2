// n_pnpturn_timer
// Version 1.0
// Calls iCase 1 for n_pnpturn when timer gui runs out without action from PC.

// wired 02/13/2012 commented out addscriptparameters, neeed to speak with loki
// about where this is called from, can't find it.

void main()
{
//Call n_pnpturn and set iCase to correct value from timer.
SendMessageToAllDMs("n_pnpturn Fire");//Debug

//AddScriptParameterInt(1);
//AddScriptParameterInt(0);
//AddScriptParameterInt(0);
ExecuteScript("n_pnpturn", OBJECT_SELF);
	
}