//This script assigns a different (random) riddle once the PC enters the area.
//This will only fire once. This is done so that we don't always get the same riddle 
//once the server resets. -frac

// !!!IMPORTANT!!
/* MAKE SURE nRandom corresponds with the nRandom in "carc_wrdlck_newrid"
   They must be the same integer/random/dice or this wont make use of all available riddles! */

void main()
{
if (GetLocalInt(OBJECT_SELF, "DO_ONCE")) return;
else
{
object oDoor = GetObjectByTag("carc_wordlock_door1");

int nRandom = d8(1); 
SetLocalInt(oDoor, "RiddleCount", nRandom);
		
AssignCommand(oDoor, ExecuteScript("carc_wrdlck_newrid", oDoor));
SetLocalInt(OBJECT_SELF,"DO_ONCE",1);
}
}