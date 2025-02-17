//This script assigns a different (random) riddle once the door has been opened. 
//frac, Feb 2008
#include "carc_wrdlck_inc"

//TO ADD NEW RIDDLES:
/*///////////////////////
1: Following the examples below, just add a new 
  "else if (nCount == X)" line with your riddle and it's solution.

2: Change the RiddleCount variable on the door to the new max number of riddles.

3: Edit line 50 of this script and change d8(1) to the proper Random or dice function.

4: Check the script "carc_wrdlck_begin02" if you edited the above.
///////////////////////*/
void main()
{
    int nCount = GetLocalInt(OBJECT_SELF, "RiddleCount");
    string sRiddle, sSolution;
    //if (nCount == 8) { nCount = 0; } //ensure that the max integer turns to riddle #0
    
    if (nCount == 1) {
        sRiddle = "<i>Every creature in the world has seen it||But to their dying day they'll never see the same one again</i>";
        sSolution = "yesterday";
    } else if (nCount == 2) {
        sRiddle = "<i>It can pierce the best armor||And make swords crumble with a rub||Yet for all its power||It cannot harm a club</i>";
        sSolution = "rust";
    } else if (nCount == 3) {
        sRiddle = "<i>It doesnt live within a house||Nor does it live without||Most will use it when they come in||And again when they go out</i>";
        sSolution = "door";
    } else if (nCount == 4) {
        sRiddle = "<i>Look in my face I am somebody||Look at my back and I am nobody</i>";
        sSolution = "mirror";
    } else if (nCount == 5) {
        sRiddle = "<i>Walk on the living||They don't even mumble||Step on the dead||They mutter and grumble</i>";
        sSolution = "leaves";
    } else if (nCount == 6) {
        sRiddle = "<i>This marvelous thing||Though it sounds absurd||Contains all our letters||But is only a word</i>";
        sSolution = "alphabet";
    } else if (nCount == 7) {
		sRiddle = "<i>Black when bought||Red when used||Grey when thrown away</i>";
		sSolution = "coals";
	} else if (nCount == 8) {
		sRiddle = "<i>Brought to the table||Cut and served||Never eaten</i>";
		sSolution = "cards";
	}

    AssignRiddle(OBJECT_SELF, sSolution, sRiddle);
	ResetRiddle(OBJECT_SELF);
	int nRandom = d8(1); 
	//int nRandom = Random(nCount)+1; //Here you must input a Random function using the RiddleCount var + 1.
	    SetLocalInt(OBJECT_SELF, "RiddleCount", nRandom);
		
	//the executed script below was the module's default handler to close&lock doors
	// after X seconds:
	//ExecuteScript("rbu_doorlock", OBJECT_SELF);
	DelayCommand(59.9,
	AssignCommand(OBJECT_SELF, SetLocked(OBJECT_SELF,TRUE)));
	DelayCommand(60.0,
	AssignCommand(OBJECT_SELF, ActionCloseDoor(OBJECT_SELF)));
}