// ********************************************************************************
// rbm_wordlock
/*
    Wordlock / Riddle Creator
	Based on Merle's old system
	Disfigured, transformed, butchered and raped for NWN2
	by fractal @ February 2008

    Creates Wordlock (riddle-based letter combination locks) for doors and
    placeables.

    Place this script on the OnUse script for placeables or the OnFailToOpen for
    doors. Then set the following string variables on the object (to place
    variables, right-click on the object and select Variables):
       solution         The solution to the riddle. The solution can be no
                        longer than ten letters.
       riddle           The text of the riddle. To make new lines, use "||"
                        (without the quotes). You can have up to ten lines.
       stage1           The first stage of letters in the wordlock combination.
                        The stages are optional. If you do not use them, then the
                        script will make random letters for 4 - 6 stages.
       stage2           The second stage.
       stage3           The third stage. You can have up to 10 stages. Make sure
                        that it is possible to spell out the solution using the
                        letters in the different stages.
    Also make sure to set the object to Plot, Locked, and Key Required.

    Any questions? Contact me at fractaldx@gmail.com (MSN and/or Email)

*/
// ********************************************************************************

#include "carc_wrdlck_inc"

void main()
{
    object oPC;

    // ************************************************************
    // Check to see if this object is already opened or being used
    // by someone else.
    // ************************************************************
    if (GetLocked(OBJECT_SELF)) {
        if (GetObjectType(OBJECT_SELF) == OBJECT_TYPE_DOOR) {
            oPC = GetClickingObject();
        } else {
            oPC = GetLastUsedBy();
        }
        if (!GetIsPC(oPC)) {
            return;
        }
        if (!IsInConversation(OBJECT_SELF)) {
            SetLocalString(OBJECT_SELF, "CurrentUser", GetName(oPC));
        } else {
            SendMessageToPC(oPC, GetLocalString(OBJECT_SELF, "CurrentUser") + " is already using the lock on this chest.");
            return;
        }
    } else {
        return;
    }


    // ************************************************************
    // Find out how many tumblers to display.
    // ************************************************************
    string sSolution = GetLocalString(OBJECT_SELF, "solution");
    int nLength = GetStringLength(sSolution);
    if (nLength == 0) { // no solution given, just open
        DelayCommand(10.0, SetLocked(OBJECT_SELF, FALSE));
        SetLocalInt(OBJECT_SELF, "Solved", TRUE);
        if (GetObjectType(OBJECT_SELF) == OBJECT_TYPE_PLACEABLE) {
            PlayAnimation(ANIMATION_PLACEABLE_OPEN);
        } else {
            ActionOpenDoor(OBJECT_SELF);
        }
		
		DelayCommand(2.0, DeleteLocalInt(OBJECT_SELF, "Solved"));
    }

    string sNum;
    if (nLength == 1) {
        sNum = "one";
    } else if (nLength == 2) {
        sNum = "two";
    } else if (nLength == 3) {
        sNum = "three";
    } else if (nLength == 4) {
        sNum = "four";
    } else if (nLength == 5) {
        sNum = "five";
    } else if (nLength == 6) {
        sNum = "six";
    } else if (nLength == 7) {
        sNum = "seven";
    } else if (nLength == 8) {
        sNum = "eight";
    } else if (nLength == 9) {
        sNum = "nine";
    } else if (nLength == 10) {
        sNum = "ten";
    }
    SetCustomToken(1799, sNum);

    // ************************************************************
    // Check to make sure the stages exist. Create our own if not.
    // ************************************************************
    if (GetLocalString(OBJECT_SELF, "stage1") == "") {
        int nNumStages = Random(3) + 4; // Create 4 to 6 stages
        string sStage;
        int nStageCount = 1;
        int nLtrCount;
        string sLetter;
        // Create the different stages out of random letters
        while (nStageCount <= nNumStages) {
            sStage = "";
            nLtrCount = 1;
            while (nLtrCount <= nLength) {
                sLetter = RandomLetter();
                /*
                while (sLetter == GetStringLowerCase(GetSubString(sSolution, nLtrCount - 1, 1))) {
                    sLetter = RandomLetter();
                } */
                // Make sure that the letters don't duplicate in different stages
                while (!GetIsUniqueLetter(OBJECT_SELF, sLetter, nLtrCount, nStageCount)) {
                    sLetter = RandomLetter();
                }
                sStage += sLetter;
                nLtrCount++;
                // SendMessageToPC(oPC, "[DEBUG] " + IntToString(nStageCount) + ", " + IntToString(nLtrCount) + ": " + sStage);
            }
            SetLocalString(OBJECT_SELF, "stage" + IntToString(nStageCount), sStage);
            nStageCount++;
        }
        // Place each letter of the solution in a random stage
        nStageCount--;
        int nRandomStage;
        nLtrCount = 1;
        while (nLtrCount <= nLength) {
            nRandomStage = Random(nStageCount) + 1;
            sLetter = GetSubString(sSolution, nLtrCount - 1, 1);
            sStage = GetLocalString(OBJECT_SELF, "stage" + IntToString(nRandomStage));
            sStage = GetStringLeft(sStage, nLtrCount - 1) + sLetter + GetStringRight(sStage, GetStringLength(sStage) - nLtrCount);
            SetLocalString(OBJECT_SELF, "stage" + IntToString(nRandomStage), sStage);
            // SendMessageToPC(oPC, "[DEBUG] New stage " + IntToString(nRandomStage) + " set to " + sStage);
            nLtrCount++;
        }
    }


    // ************************************************************
    // Set the custom tokens for each tumbler
    // ************************************************************
    int nCount = 1;
    int nStage;
    string sLetter;
    string sCurrent;
    // Clear them out first
    while (nCount <= 10) {
        SetCustomToken(1800 + nCount - 1, "");
        nCount++;
    }
    nCount = 1;
    while (nCount <= GetStringLength(sSolution)) {
        nStage = GetLocalInt(OBJECT_SELF, "Letter" + IntToString(nCount));
        if (nStage < 1) {
            nStage = 1;
        }
        sCurrent = GetLocalString(OBJECT_SELF, "stage" + IntToString(nStage));
        sLetter = GetSubString(sCurrent, nCount - 1, 1);
        if (nCount != GetStringLength(sSolution)) {
            sLetter += " - ";
        }
        SetCustomToken(1800 + nCount - 1, GetStringUpperCase(sLetter));
        nCount++;
    }


    // ************************************************************
    // Get the riddle
    // ************************************************************
    // When we store the riddle in the string variable, the newline ("\n")
    // no longer works as intended. So we use our own newline ("||")
    // and manually break it into multiple lines.
    string sRiddle = GetLocalString(OBJECT_SELF, "riddle");
    int nLineNum = 1;
    while (nCount != -1) {
        nCount = FindSubString(sRiddle, "||");
        if (nCount == -1) {
            SetLocalString(OBJECT_SELF, "RiddleLine" + IntToString(nLineNum), sRiddle);
        } else {
            SetLocalString(OBJECT_SELF, "RiddleLine" + IntToString(nLineNum), GetStringLeft(sRiddle, nCount));
            sRiddle = GetStringRight(sRiddle, GetStringLength(sRiddle) - nCount - 2);
        }
        nLineNum++;
    }
    switch (nLineNum - 1) {
        case 1:
            SetCustomToken(1798, GetLocalString(OBJECT_SELF, "RiddleLine1"));
            break;
        case 2:
            SetCustomToken(1798, GetLocalString(OBJECT_SELF, "RiddleLine1") + "\n" + GetLocalString(OBJECT_SELF, "RiddleLine2"));
            break;
        case 3:
            SetCustomToken(1798, GetLocalString(OBJECT_SELF, "RiddleLine1") + "\n" + GetLocalString(OBJECT_SELF, "RiddleLine2") + "\n" + GetLocalString(OBJECT_SELF, "RiddleLine3"));
            break;
        case 4:
            SetCustomToken(1798, GetLocalString(OBJECT_SELF, "RiddleLine1") + "\n" + GetLocalString(OBJECT_SELF, "RiddleLine2") + "\n" + GetLocalString(OBJECT_SELF, "RiddleLine3")
             + "\n" + GetLocalString(OBJECT_SELF, "RiddleLine4"));
            break;
        case 5:
            SetCustomToken(1798, GetLocalString(OBJECT_SELF, "RiddleLine1") + "\n" + GetLocalString(OBJECT_SELF, "RiddleLine2") + "\n" + GetLocalString(OBJECT_SELF, "RiddleLine3")
             + "\n" + GetLocalString(OBJECT_SELF, "RiddleLine4") + "\n" + GetLocalString(OBJECT_SELF, "RiddleLine5"));
            break;
        case 6:
            SetCustomToken(1798, GetLocalString(OBJECT_SELF, "RiddleLine1") + "\n" + GetLocalString(OBJECT_SELF, "RiddleLine2") + "\n" + GetLocalString(OBJECT_SELF, "RiddleLine3")
             + "\n" + GetLocalString(OBJECT_SELF, "RiddleLine4") + "\n" + GetLocalString(OBJECT_SELF, "RiddleLine5") + "\n" + GetLocalString(OBJECT_SELF, "RiddleLine6"));
            break;
        case 7:
            SetCustomToken(1798, GetLocalString(OBJECT_SELF, "RiddleLine1") + "\n" + GetLocalString(OBJECT_SELF, "RiddleLine2") + "\n" + GetLocalString(OBJECT_SELF, "RiddleLine3")
             + "\n" + GetLocalString(OBJECT_SELF, "RiddleLine4") + "\n" + GetLocalString(OBJECT_SELF, "RiddleLine5") + "\n" + GetLocalString(OBJECT_SELF, "RiddleLine6")
             + "\n" + GetLocalString(OBJECT_SELF, "RiddleLine7"));
            break;
        case 8:
            SetCustomToken(1798, GetLocalString(OBJECT_SELF, "RiddleLine1") + "\n" + GetLocalString(OBJECT_SELF, "RiddleLine2") + "\n" + GetLocalString(OBJECT_SELF, "RiddleLine3")
             + "\n" + GetLocalString(OBJECT_SELF, "RiddleLine4") + "\n" + GetLocalString(OBJECT_SELF, "RiddleLine5") + "\n" + GetLocalString(OBJECT_SELF, "RiddleLine6")
             + "\n" + GetLocalString(OBJECT_SELF, "RiddleLine7") + "\n" + GetLocalString(OBJECT_SELF, "RiddleLine8"));
            break;
        case 9:
            SetCustomToken(1798, GetLocalString(OBJECT_SELF, "RiddleLine1") + "\n" + GetLocalString(OBJECT_SELF, "RiddleLine2") + "\n" + GetLocalString(OBJECT_SELF, "RiddleLine3")
             + "\n" + GetLocalString(OBJECT_SELF, "RiddleLine4") + "\n" + GetLocalString(OBJECT_SELF, "RiddleLine5") + "\n" + GetLocalString(OBJECT_SELF, "RiddleLine6")
             + "\n" + GetLocalString(OBJECT_SELF, "RiddleLine7") + "\n" + GetLocalString(OBJECT_SELF, "RiddleLine8") + "\n" + GetLocalString(OBJECT_SELF, "RiddleLine9"));
            break;
        case 10:
            SetCustomToken(1798, GetLocalString(OBJECT_SELF, "RiddleLine1") + "\n" + GetLocalString(OBJECT_SELF, "RiddleLine2") + "\n" + GetLocalString(OBJECT_SELF, "RiddleLine3")
             + "\n" + GetLocalString(OBJECT_SELF, "RiddleLine4") + "\n" + GetLocalString(OBJECT_SELF, "RiddleLine5") + "\n" + GetLocalString(OBJECT_SELF, "RiddleLine6")
             + "\n" + GetLocalString(OBJECT_SELF, "RiddleLine7") + "\n" + GetLocalString(OBJECT_SELF, "RiddleLine8") + "\n" + GetLocalString(OBJECT_SELF, "RiddleLine9")
             + "\n" + GetLocalString(OBJECT_SELF, "RiddleLine10"));
            break;
    }

    // ************************************************************
    // Get the name of this object
    // ************************************************************
    SetCustomToken(1797, GetStringLowerCase(GetName(OBJECT_SELF)));


    // ************************************************************
    // Now start the conversation
    // ************************************************************
    ActionStartConversation(oPC, "", FALSE, FALSE);

}