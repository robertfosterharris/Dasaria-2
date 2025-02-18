//ph_ga_open
//
// wired 2012/07/14  shouldn't be this hard to open a container
//

void main()
{
	object oPC = (GetPCSpeaker());
	DelayCommand(1.0, AssignCommand(oPC, ActionInteractObject(OBJECT_SELF)));
	DelayCommand(1.05, DisplayGuiScreen(oPC, "SCREEN_CONTAINER_DEFAULT", TRUE, "container.XML", TRUE));
}