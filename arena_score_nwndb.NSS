//////////////////////////////////////
///// Created by: bushido/////////////
//////////////////////////////////////
/////Edited For Database By Knowj/////
//////////////////////////////////////

float fGetKD (object oFirstPC)
{
    float fKD;
    float fKilled;
    float fDied;
    int iKilled = GetCampaignInt("SCORE", "iKilled", oFirstPC);
    int iDied = GetCampaignInt("SCORE", "iDied", oFirstPC);

    fKilled = IntToFloat(iKilled);
    fDied = IntToFloat(iDied);
    if (fDied == 0.0f)
    {
        return fKilled*1.667f;
    }
    fKD = fKilled/fDied;
    return fKD;
}

float fGetKD (object oFirstPC);

void main()
{
    object oPC = GetLastUsedBy();
    object oFirstPC = GetFirstPC();

    int nFirstPlace;
    int iKilled = GetCampaignInt("SCORE", "iKilled", oPC);
    int iDied = GetCampaignInt("SCORE", "iDied", oPC);
    int nScore = (iKilled - iDied);
    int k1;
    int k2;
    int k3;
    int k4;
    int k5;
    int k6;
    int k7;
    int k8;
    int k9;
    int k10;
    float f1;
    float f2;
    float f3;
    float f4;
    float f5;
    float f6;
    float f7;
    float f8;
    float f9;
    float f10;
    string s1 = "vacant";
    string s2 = "vacant";
    string s3 = "vacant";
    string s4 = "vacant";
    string s5 = "vacant";
    string s6 = "vacant";
    string s7 = "vacant";
    string s8 = "vacant";
    string s9 = "vacant";
    string s10 = "vacant";
    string sTopTen;

    while (GetIsPC(oFirstPC))
    {
        float fKD = fGetKD(oFirstPC);
        nFirstPlace = GetCampaignInt("SCORE", "iKilled", oFirstPC);
        // 1st place
        if (fKD > f1)
        {
            k2 = k1;
            k1 = nFirstPlace;
            f2 = f1;
            f1 = fKD;
            s2 = s1;
            s1 = GetName(oFirstPC);
        }
        if (fKD == f1 && nFirstPlace > k1)
        {
            k2 = k1;
            k1 = nFirstPlace;
            f2 = f1;
            f1 = fKD;
            s2 = s1;
            s1 = GetName(oFirstPC);
        }
        oFirstPC = GetNextPC();
    }

    oFirstPC = GetFirstPC();

    while (GetIsPC(oFirstPC))
    {
        float fKD = fGetKD(oFirstPC);
        nFirstPlace = GetCampaignInt("SCORE", "iKilled", oFirstPC);;
        // 2nd place
        if (fKD > f2 && fKD < f1)
        {
            k3 = k2;
            k2 = nFirstPlace;
            f3 = f2;
            f2 = fKD;
            s3 = s2;
            s2 = GetName(oFirstPC);
        }
        if (fKD == f2 && nFirstPlace > k2)
        {
            k3 = k2;
            k2 = nFirstPlace;
            f3 = f2;
            f2 = fKD;
            s3 = s2;
            s2 = GetName(oFirstPC);
        }
        oFirstPC = GetNextPC();
    }


    oFirstPC = GetFirstPC();

    while (GetIsPC(oFirstPC))
    {
        float fKD = fGetKD(oFirstPC);
        nFirstPlace = GetCampaignInt("SCORE", "iKilled", oFirstPC);
        // 3rd place
        if (fKD > f3 && fKD < f2)
        {
            k4 = k3;
            k3 = nFirstPlace;
            f4 = f3;
            f3 = fKD;
            s4 = s3;
            s3 = GetName(oFirstPC);
        }
        if (fKD == f3 && nFirstPlace > k3)
        {
            k4 = k3;
            k3 = nFirstPlace;
            f4 = f3;
            f3 = fKD;
            s4 = s3;
            s3 = GetName(oFirstPC);
        }
        oFirstPC = GetNextPC();
    }

    oFirstPC = GetFirstPC();

    while (GetIsPC(oFirstPC))
    {
        float fKD = fGetKD(oFirstPC);
        nFirstPlace = GetCampaignInt("SCORE", "iKilled", oFirstPC);
        // 4th place
        if (fKD > f4 && fKD < f3)
        {
            k5 = k4;
            k4 = nFirstPlace;
            f5 = f4;
            f4 = fKD;
            s5 = s4;
            s4 = GetName(oFirstPC);
        }
        if (fKD == f4 && nFirstPlace > k4)
        {
            k5 = k4;
            k4 = nFirstPlace;
            f5 = f4;
            f4 = fKD;
            s5 = s4;
            s4 = GetName(oFirstPC);
        }
        oFirstPC = GetNextPC();
    }


    oFirstPC = GetFirstPC();

    while (GetIsPC(oFirstPC))
    {
        float fKD = fGetKD(oFirstPC);
        nFirstPlace = GetCampaignInt("SCORE", "iKilled", oFirstPC);
        // 5th place
        if (fKD > f5 && fKD < f4)
        {
            k6 = k5;
            k5 = nFirstPlace;
            f6 = f5;
            f5 = fKD;
            s6 = s5;
            s5 = GetName(oFirstPC);
        }
        if (fKD == f5 && nFirstPlace > k5)
        {
            k6 = k5;
            k5 = nFirstPlace;
            f6 = f5;
            f5 = fKD;
            s6 = s5;
            s5 = GetName(oFirstPC);
        }
        oFirstPC = GetNextPC();
    }

    oFirstPC = GetFirstPC();

    while (GetIsPC(oFirstPC))
    {
        float fKD = fGetKD(oFirstPC);
        nFirstPlace = GetCampaignInt("SCORE", "iKilled", oFirstPC);
        // 6th place
        if (fKD > f6 && fKD < f5)
        {
            k7 = k6;
            k6 = nFirstPlace;
            f7 = f6;
            f6 = fKD;
            s7 = s6;
            s6 = GetName(oFirstPC);
        }
        if (fKD == f6 && nFirstPlace > k6)
        {
            k7 = k6;
            k6 = nFirstPlace;
            f7 = f6;
            f6 = fKD;
            s7 = s6;
            s6 = GetName(oFirstPC);
        }
        oFirstPC = GetNextPC();
    }


    oFirstPC = GetFirstPC();

    while (GetIsPC(oFirstPC))
    {
        float fKD = fGetKD(oFirstPC);
        nFirstPlace = GetCampaignInt("SCORE", "iKilled", oFirstPC);
        // 7th place
        if (fKD > f7 && fKD < f6)
        {
            k8 = k7;
            k7 = nFirstPlace;
            f8 = f7;
            f7 = fKD;
            s8 = s7;
            s7 = GetName(oFirstPC);
        }
        if (fKD == f7 && nFirstPlace > k7)
        {
            k7 = k6;
            k6 = nFirstPlace;
            f7 = f6;
            f6 = fKD;
            s7 = s6;
            s6 = GetName(oFirstPC);
        }
        oFirstPC = GetNextPC();
    }

    oFirstPC = GetFirstPC();

    while (GetIsPC(oFirstPC))
    {
        float fKD = fGetKD(oFirstPC);
        nFirstPlace = GetCampaignInt("SCORE", "iKilled", oFirstPC);
        // 8th place
        if (fKD > f8 && fKD < f7)
        {
            k9 = k8;
            k8 = nFirstPlace;
            f9 = f8;
            f8 = fKD;
            s9 = s8;
            s8 = GetName(oFirstPC);
        }
        if (fKD == f8 && nFirstPlace > k8)
        {
            k9 = k8;
            k8 = nFirstPlace;
            f9 = f8;
            f8 = fKD;
            s9 = s8;
            s8 = GetName(oFirstPC);
        }
        oFirstPC = GetNextPC();
    }

    oFirstPC = GetFirstPC();

    while (GetIsPC(oFirstPC))
    {
        float fKD = fGetKD(oFirstPC);
        nFirstPlace = GetCampaignInt("SCORE", "iKilled", oFirstPC);
        // 9th place
        if (fKD > f9 && fKD < f8)
        {
            k10 = k9;
            k9 = nFirstPlace;
            f10 = f9;
            f9 = fKD;
            s10 = s9;
            s9 = GetName(oFirstPC);
        }
        if (fKD == f9 && nFirstPlace > k9)
        {
            k10 = k9;
            k9 = nFirstPlace;
            f10 = f9;
            f9 = fKD;
            s10 = s9;
            s9 = GetName(oFirstPC);
        }
        oFirstPC = GetNextPC();
    }

    oFirstPC = GetFirstPC();

    while (GetIsPC(oFirstPC))
    {
        float fKD = fGetKD(oFirstPC);
        nFirstPlace = GetCampaignInt("SCORE", "iKilled", oFirstPC);
        // 10th place
        if (fKD > f10 && fKD < f9)
        {
            k10 = nFirstPlace;
            f10 = fKD;
            s10 = GetName(oFirstPC);
        }
        if (fKD == f10 && nFirstPlace > k10)
        {
            k10 = nFirstPlace;
            f10 = fKD;
            s10 = GetName(oFirstPC);
        }
        oFirstPC = GetNextPC();
    }



    sTopTen += "\n-------------------------------\n";
    sTopTen += "1st place: " + s1;
    sTopTen += "\n";
    sTopTen += "2nd place: " + s2;
    sTopTen += "\n";
    sTopTen += "3rd place: " + s3;
    sTopTen += "\n";
    sTopTen += "4th place: " + s4;
    sTopTen += "\n";
    sTopTen += "5th place: " + s5;
    sTopTen += "\n";
    sTopTen += "6th place: " + s6;
    sTopTen += "\n";
    sTopTen += "7th place: " + s7;
    sTopTen += "\n";
    sTopTen += "8th place: " + s8;
    sTopTen += "\n";
    sTopTen += "9th place: " + s9;
    sTopTen += "\n";
    sTopTen += "10th place: " + s10;
    sTopTen += "\n";
    sTopTen += "-------------------------------\n";
    sTopTen += "Your Kill/Death Ratio is: \n";
    sTopTen += IntToString(iKilled);
    sTopTen += "/";
    sTopTen += IntToString(iDied);
    sTopTen += "\n Your Score Is: \n";
    sTopTen += IntToString(nScore);

AssignCommand(oPC, SpeakString(sTopTen, TALKVOLUME_WHISPER));
}