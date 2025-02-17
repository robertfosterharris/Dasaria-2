void main(int nLetterNum)
{
    // We can reuse this script just by changing nLetterNum.
//    int nLetterNum = 1;

    PlaySound("fs_metal_soft3");

    // nLetter is the current stage of this letter.
    int nLetter = GetLocalInt(OBJECT_SELF, "Letter" + IntToString(nLetterNum));

    // If it is 0, then it has not been used yet, so we should be at stage 1.
    // Hence, increase to 2.
    if (nLetter == 0) {
        nLetter = 2;
    } else {
        nLetter++;
    }

    // Get the whole string of the current stage
    string sLetter = GetStringUpperCase(GetLocalString(OBJECT_SELF, "stage" + IntToString(nLetter)));

    // If we can't find the stage, then we cycle back to stage 1.
    if (sLetter == "") {
        nLetter = 1;
        sLetter = GetStringUpperCase(GetLocalString(OBJECT_SELF, "stage" + IntToString(nLetter)));
    }

//    SendMessageToPC(GetFirstPC(), "Letter " + IntToString(nLetterNum) + " is at stage " + IntToString(nLetter));

    // Change the string of the whole stage to the single letter.
    sLetter = GetSubString(sLetter, nLetterNum - 1, 1);
    // GetStringLeft(GetStringRight(sLetter, GetStringLength(sLetter) - nLetterNum + 1), 1);
    SetLocalInt(OBJECT_SELF, "Letter" + IntToString(nLetterNum), nLetter);
    int nStage;

    // Get the new wordlock combination and compare it to the solution.
    int nCount = 1;
    string sCurrent;
    string sStageVar;
    string sThisLetter;
    while (nCount <= GetStringLength(GetLocalString(OBJECT_SELF, "solution"))) {
        nStage = GetLocalInt(OBJECT_SELF, "Letter" + IntToString(nCount));
        if (nStage < 1) {
            nStage = 1;
        }
        sStageVar = "stage" + IntToString(nStage);
        // sCurrent = GetLocalString(OBJECT_SELF, "stage" + IntToString(nCount));
        sThisLetter = GetSubString(GetLocalString(OBJECT_SELF, sStageVar), nCount - 1, 1);
        // GetStringUpperCase(GetStringLeft(GetStringRight(GetLocalString(OBJECT_SELF, sStageVar), GetStringLength(GetLocalString(OBJECT_SELF, "solution")) - nCount + 1), 1));
        sCurrent += sThisLetter;
        nCount++;
    }

    if (GetStringUpperCase(sCurrent) == GetStringUpperCase(GetLocalString(OBJECT_SELF, "solution"))) {
        SetLocked(OBJECT_SELF, FALSE);
        PlaySound("gui_trapdisarm");
        SetLocalInt(OBJECT_SELF, "Solved", TRUE);
        if (GetObjectType(OBJECT_SELF) == OBJECT_TYPE_PLACEABLE) {
            PlayAnimation(ANIMATION_PLACEABLE_OPEN);
        } else {
            ActionOpenDoor(OBJECT_SELF);
        }
    }

    if (GetStringLength(GetLocalString(OBJECT_SELF, "solution")) != nLetterNum) {
        sLetter += " - ";
    }
    SetCustomToken(1800 + nLetterNum - 1, GetStringUpperCase(sLetter));


}