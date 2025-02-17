//gui_ph_follow

void main()
{
	object oWP = GetLocalObject(OBJECT_SELF,"oDest");
	object oOwner = GetLocalObject(OBJECT_SELF,"oOwner");
	
	RemoveFromParty(OBJECT_SELF);
	DelayCommand(0.5,AddToParty(OBJECT_SELF,oOwner));
	
	
	if (GetIsObjectValid(oWP))
	{
		DelayCommand(3.0f,JumpToObject(oWP));
	}
}