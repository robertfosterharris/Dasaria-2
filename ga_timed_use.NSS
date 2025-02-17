// ga_timed_use
// wired 09/19/08
// make object usable for f Seconds
void main(string sPlaceable, float fSecs)
{
	object oPlaceable = GetObjectByTag(sPlaceable);
	SetUseableFlag(oPlaceable, TRUE);
	DelayCommand(fSecs, SetUseableFlag(oPlaceable, FALSE));
}