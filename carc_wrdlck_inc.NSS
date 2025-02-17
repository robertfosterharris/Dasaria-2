// ********************************************************************************
// rbm_wordlock_inc
/*
    Wordlock / Riddle Creator functions
    Based on Merle's old system
	Disfigured, transformed, butchered and raped for NWN2
	by fractal/Coliphorbs @ February 2008
*/

// Clears all variables from the object that are used by the wordlock script
// so that new variables can be assigned.
void ClearRiddle(object oObject = OBJECT_SELF);

// Clears all variables from the object that are used by the wordlock script
// so that new variables can be assigned.
void AssignRiddle(object oObject = OBJECT_SELF, string sSolution = "", string sRiddle = "");

// Clears all variables from the object and resets the riddle.
void ResetRiddle(object oObject = OBJECT_SELF);

// Give a random letter from a - z. There is some skewing towards more frequent
// English letters.
string RandomLetter();

// Returns TRUE if sLetter at nPosition is unique up to nStage for the riddle
// of oObject. Also checks in the solution. This is used when generating random
// letters.
int GetIsUniqueLetter(object oObject = OBJECT_SELF, string sLetter = "", int nPosition = 1, int nStage = 2);

// Returns TRUE if the riddle for oObject has been solved.
int RiddleSolved(object oObject = OBJECT_SELF);


void ClearRiddle(object oObject) {
    AssignRiddle(oObject);
    SetLocked(oObject, FALSE);
}


void AssignRiddle(object oObject, string sSolution, string sRiddle) {
    SetLocalInt(oObject, "Solved", 0);
    SetLocalString(oObject, "riddle", sRiddle);
    SetLocalString(oObject, "solution", sSolution);
    //DelayCommand(59.0,SetLocked(oObject, TRUE));
    int nCount = 1;
    while (nCount <= 10) {
        SetLocalString(oObject, "Letter" + IntToString(nCount), "");
        SetLocalString(oObject, "stage" + IntToString(nCount), "");
        nCount++;
    }
}

void ResetRiddle(object oObject) {
	SetLocalInt(oObject, "Solved", 0);
    string sRiddle = GetLocalString(OBJECT_SELF, "riddle");
    string sSolution = GetLocalString(OBJECT_SELF, "solution");
    AssignRiddle(oObject, sSolution, sRiddle);
}


string RandomLetter() {
    int nRand = Random(36);
    switch (nRand) {
        case 0:  return "a"; break;
        case 1:  return "b"; break;
        case 2:  return "c"; break;
        case 3:  return "d"; break;
        case 4:  return "e"; break;
        case 5:  return "f"; break;
        case 6:  return "g"; break;
        case 7:  return "h"; break;
        case 8:  return "i"; break;
        case 9:  return "j"; break;
        case 10: return "k"; break;
        case 11: return "l"; break;
        case 12: return "m"; break;
        case 13: return "n"; break;
        case 14: return "o"; break;
        case 15: return "p"; break;
        case 16: return "q"; break;
        case 17: return "r"; break;
        case 18: return "s"; break;
        case 19: return "t"; break;
        case 20: return "u"; break;
        case 21: return "v"; break;
        case 22: return "w"; break;
        case 23: return "x"; break;
        case 24: return "y"; break;
        case 25: return "z"; break;
        case 26: return "e"; break;
        case 27: return "s"; break;
        case 28: return "d"; break;
        case 29: return "t"; break;
        case 30: return "n"; break;
        case 31: return "y"; break;
        case 32: return "r"; break;
        case 33: return "o"; break;
        case 34: return "l"; break;
        case 35: return "f"; break;
    }
    return "";
}


int GetIsUniqueLetter(object oObject, string sLetter, int nPosition, int nStage) {
    int nCount = 1;
    sLetter = GetStringLowerCase(sLetter);
    while (nCount < nStage) {
        if (sLetter == GetStringLowerCase(GetSubString(GetLocalString(oObject, "stage" + IntToString(nCount)), nPosition - 1, 1)) ||
            sLetter == GetStringLowerCase(GetSubString(GetLocalString(oObject, "solution"), nPosition - 1, 1))) {
            return FALSE;
        }
        nCount++;
    }
    return TRUE;
}

int RiddleSolved(object oObject) {
    return GetLocalInt(oObject, "Solved");
}