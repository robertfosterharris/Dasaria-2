// morell_slave_dancer_ud
// wrapper for gb_animate_ud
//
void main()
{

	if (GetLocalInt(OBJECT_SELF,"dance") == 1)
	{
		ExecuteScript("gb_animate_ud",OBJECT_SELF);
	}
}