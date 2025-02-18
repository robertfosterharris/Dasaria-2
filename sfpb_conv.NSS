//::///////////////////////////////////////////////
//:: Scarface's Persistent Banking
//:: sfpb_conv
//:://////////////////////////////////////////////
/*
    Written By Scarface
*/
//////////////////////////////////////////////////
void main()
{
	int iCounter, iStringLength, iIntStart, iIntEnd;
	string sIntString = "0123456789";
	string sThischar;
    BeginConversation();
    if (GetListenPatternNumber() == 1 &&
        GetLastSpeaker() == GetPCSpeaker())

	
				
	iIntStart = 200000;	//arbitary value
	iIntEnd = 	200000;	
    {
        string sGold = GetMatchedSubstring(0);
		
		iStringLength = GetStringLength(sGold);
	
		for(iCounter=0;iCounter<=iStringLength;iCounter++)
		{
			sThischar =	GetSubString(sGold, iCounter, 1);
			if(iIntStart == 200000)
			{
				if(FindSubString(sIntString,sThischar)!= -1)
				{
					iIntStart = iCounter;
				
				}
			}
			else
			{
				if(FindSubString(sIntString,sThischar)== -1 && iIntEnd == 200000 )
				{
					iIntEnd = iCounter;
				}			
			
			}
		
		}
		
				
		sGold = GetSubString(sGold,iIntStart,iIntEnd - iIntStart);
        SetLocalString(OBJECT_SELF, "GOLD", sGold  );
        SetCustomToken(1000, sGold);
    }
}