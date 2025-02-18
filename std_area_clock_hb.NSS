// wired 09/18/2009 hook for werewolf character
#include "ginc_lycan"

void main()
{

    int nCurrentHour;
    object oPC;
    string sCurrentHour;
    string sTimes;
    
    nCurrentHour = GetTimeHour();
	int nCurrentMin = GetTimeMinute();

    if (nCurrentHour != GetLocalInt(OBJECT_SELF, "nLastHour"))
    {
	
        SetLocalInt(OBJECT_SELF, "nLastHour", nCurrentHour);
        
        switch (nCurrentHour)
        {
            case 0:
                sCurrentHour = "twelve";
            break;
            case 1:
                sCurrentHour = "one";
            break;
            case 2:
                sCurrentHour = "two";
            break;
            case 3:
                sCurrentHour = "three";
            break;
            case 4:
                sCurrentHour = "four";
            break;
            case 5:
                sCurrentHour = "five";
            break;
            case 6:
                sCurrentHour = "six";
            break;
            case 7:
                sCurrentHour = "seven";
            break;
            case 8:
                sCurrentHour = "eight";
            break;
            case 9:
                sCurrentHour = "nine";
            break;
            case 10:
                sCurrentHour = "ten";
            break;
            case 11:
                sCurrentHour = "eleven";
            break;
            case 12:
                sCurrentHour = "twelve";
            break;
            case 13:
                sCurrentHour = "one";
            break;
            case 14:
                sCurrentHour = "two";
            break;
            case 15:
                sCurrentHour = "three";
            break;
            case 16:
                sCurrentHour = "four";
            break;
            case 17:
                sCurrentHour = "five";
            break;
            case 18:
                sCurrentHour = "six";
            break;
            case 19:
                sCurrentHour = "seven";
            break;
            case 20:
                sCurrentHour = "eight";
            break;
            case 21:
                sCurrentHour = "nine";
            break;
            case 22:
                sCurrentHour = "ten";
            break;
            case 23:
                sCurrentHour = "eleven";
            break;
        }
        if (sCurrentHour == "one")
        {
            sTimes = "time.";
        }
        else 
        {
            sTimes = "times.";
        }

        oPC = GetFirstPC();
        while (GetIsObjectValid(oPC))
        {
			CheckLycanChange(oPC);	
			
            if (GetArea(oPC) == OBJECT_SELF)
            {
                SendMessageToPC(oPC, "In the distance, you hear a bell toll " + sCurrentHour + " " + sTimes);
            }                
            oPC = GetNextPC();
        }
    }
}