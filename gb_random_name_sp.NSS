//	ON SPAWN - GIVE CREATURE RANDOM NAME
//
//	ROBERT HARRIS	03/07/2008	ROBERTHARRIS@ROBERTHARRIS.COM
//  Wired 10/09/2008 Girl names
void SetName();

void main()
{
	DelayCommand(2.0, SetName());
}

void SetName()
{
	
	if (GetGender(OBJECT_SELF) == 1)
	{
		SetFirstName(OBJECT_SELF, RandomName()+"a");
	}
	else
	{
		SetFirstName(OBJECT_SELF, RandomName());
	}
	SetLastName(OBJECT_SELF, RandomName());
}