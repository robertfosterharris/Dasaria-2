// ga_track_event: track arbitary conversation events to db.
// wired 08/06/2011

#include "d2_sql_log"

void main(string event_code, int int1 = 0, int int2 = 0, string string1 = "", string string2 = "")
{
	object oSource = GetPCSpeaker();
	object oTarget = OBJECT_SELF;
	if (!GetIsObjectValid(oSource)) return;
	
	if (event_code == "") event_code = "NONE";
	
 	trackEvent(oSource,event_code, oTarget, int1, int2, string1, string2);
}