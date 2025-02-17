// never let a gladiator cross this barrier
void main( )
{
	object oEnterer = GetEnteringObject();
	string sTag = GetTag(oEnterer);
	if (sTag == "BlueFighter")
	{
		DestroyObject(oEnterer);
	}
	else
	{
	// clear my reputation with gladiators
		object oPig = GetObjectByTag("blue_pig");
		ClearPersonalReputation(oEnterer,oPig);	
	}
}