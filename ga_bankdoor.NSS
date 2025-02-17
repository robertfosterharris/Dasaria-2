// ga_bankdoor
// a little trickery to make it harder to exploit persistent chests in the bank
// wired 10/10/2007
void main()
{
	object oPC = GetPCSpeaker();
	// set a variable on the PC that lets the door know to admit them
	// the guard himself should know if the room is occupied
	SetLocalInt(oPC,"authuser",1);
	// strip after 5 minutes
	DelayCommand(300.0, DeleteLocalInt(oPC, "authuser"));
}