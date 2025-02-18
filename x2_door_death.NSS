void spawn(string sName, location lLocation, string sTag)
{
CreateObject(OBJECT_TYPE_PLACEABLE, sName, lLocation, FALSE, sTag);
}


void main()
{
	int iRespawnTime = GetLocalInt(OBJECT_SELF, "iRespawnTime");
	int iDefaultTime = GetLocalInt(GetModule(), "iRespawnTime");
	string sTag = GetTag(OBJECT_SELF);
	if(iRespawnTime == 0)
		{
		SetLocalInt(OBJECT_SELF,"iRespawnTime", iDefaultTime);
		iRespawnTime = GetLocalInt(OBJECT_SELF, "iRespawnTime");
			if(iRespawnTime == 0)
			{
			SetLocalInt(OBJECT_SELF,"iRespawnTime", 120);
			iRespawnTime = GetLocalInt(OBJECT_SELF, "iRespawnTime");
			}
		}
	SetLocalLocation(OBJECT_SELF, "lRespawnLocation", GetLocation(OBJECT_SELF));

	if (iRespawnTime >= 0)
	{
	float fRespawnTime = IntToFloat(iRespawnTime);
	string sRespawnName = GetResRef(OBJECT_SELF);
	location lRespawnLocation = GetLocalLocation(OBJECT_SELF, "lRespawnLocation");
	AssignCommand(GetModule(),DelayCommand(fRespawnTime, spawn(sRespawnName,lRespawnLocation, sTag)));
	}

}