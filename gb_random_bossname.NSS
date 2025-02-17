// wired 08/21/09 -- Use a Title, Firstname for boss creatures
void SetName();

void main()
{
	DelayCommand(2.0, SetName());
}

void SetName()
{
	
	if (GetGender(OBJECT_SELF) == 1)
	{
		SetLastName(OBJECT_SELF, RandomName()+"a");
	}
	else
	{
		SetLastName(OBJECT_SELF, RandomName());
	}
}