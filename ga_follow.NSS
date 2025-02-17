// wired 11/09/2007
// NPC follows for fDuration seconds
void main(float fDuration)
{	
	object oPC = GetPCSpeaker();
	ActionForceFollowObject(oPC);
	DelayCommand(fDuration, ClearAllActions());
	DelayCommand(fDuration, SpeakString("*Stopping* Something's not right here.  Where are you going?"));

}