// get input from text box and execute
void main(string sAppearance)
{
	int	nAppearance = StringToInt(sAppearance);	
	object oTarget = GetLocalObject(OBJECT_SELF, "oTarget");
	SendMessageToPC(OBJECT_SELF,"sAppearance was " +sAppearance+ " and nAppearance was " + IntToString(nAppearance));
	SetCreatureAppearanceType(oTarget,nAppearance);	
}