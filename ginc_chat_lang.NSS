#include "nw_i0_plot"
#include "std_i0_misc"
#include "x0_i0_position"
#include "nw_i0_spells"
#include "x0_i0_corpses"
#include "dmfi_inc_tool"
#include "std_persist_i0"
#include "ginc_das_jail"
#include "std_i0_markofdeath"
#include "x0_i0_partywide"
#include "ginc_cutscene"
#include "ginc_renown"
#include "ginc_henchman"
#include "ginc_param_const"
#include "ginc_custom_races"


/*
Row values from Das_Lang.2da
LNG_COMMON_D		1
LNG_ELF_RIAN		2
LNG_ELF_IRYROD		3
LNG_DWARF_MODERN	4
LNG_DWARF_DUNK		5
LNG_DWARF_ANCIENT	6
LNG_RELLIAN			7
LNG_DARISH			8
LNG_CUHANNAN		9
LNG_KAOLISK			10
LNG_EXODONIAN		11
LNG_DAWN_TONGUE		12
LNG_FIENDISH		13
LNG_GNOME_DUR		14
LNG_KOR				15
LNG_VOKK			16
LNG_SHAI			17
LNG_TAHNAI			18
LNG_GIANT_D			19
LNG_DRAGON_D		20
LNG_GNOLL_D			21
LNG_FAYE			22
LNG_GOBLIN_D		23
LNG_ANJIRAN			24
LNG_KOBOLD_D		25
LNG_JILYN			26
LNG_TRAILSIGN		27
LNG_DRUID_D			28
LNG_SCOUTSIGN		29
LNG_KALEM			30
LNG_NITRIAD			31
LNG_BARAAN			32
*/


string SetLanguageFontPrefix(object oSender, int iLanguageNowSpoken, int nChannel, string sLNG_PC_FontStart="null" )
{
	string sFontPrefix = "<color=White>";
	
		switch(iLanguageNowSpoken)
		{
			case LNG_COMMON_D:
				sFontPrefix = "<color=White>";
				
				if(sLNG_PC_FontStart!="null"){sFontPrefix = "<color="+ sLNG_PC_FontStart+">";}
				
			break;	
			case LNG_ELF_RIAN:
			{	
				sFontPrefix = "<color=ForestGreen><i>"; 
				if(GetSubRace(oSender) == RACIAL_SUBTYPE_ELF_T )
				{
					sFontPrefix = "<color=FireBrick><i>";
				}
			}
			break;
			case LNG_ELF_IRYROD:
				sFontPrefix = "<color=LightCyan><i>";	
			break;	
			case LNG_DWARF_MODERN:
			sFontPrefix = "<color=LightGrey><b>";
			break;
			case LNG_DWARF_DUNK:
			sFontPrefix = "<color=LightGrey><b>";
			break;
			case LNG_DWARF_ANCIENT:
			sFontPrefix = "<color=LightGrey><b>";
			break;
			case LNG_RELLIAN:
				sFontPrefix = "<color=White>";
			break;
			case LNG_DARISH:
				sFontPrefix = "<color=MintCream>";
			break;
			case LNG_CUHANNAN:
				sFontPrefix = "<color=White><i>";
			break;
			case LNG_KAOLISK:
				sFontPrefix = "<color=Thistle><b>";	
			break;
			case LNG_EXODONIAN:
				sFontPrefix = "<color=BlueViolet><i>";	
			break;
			case LNG_DAWN_TONGUE:
				sFontPrefix = "<color=Azure>";	
			break;
			case LNG_FIENDISH:
				sFontPrefix = "<color=DarkRed>";	
			break;
			case LNG_GNOME_DUR:
				sFontPrefix = "<color=White><i><b>";	
			break;
			case LNG_KOR:
				sFontPrefix = "<color=MintCream><b>";
			break;
			case LNG_VOKK:
				sFontPrefix = "<color=MintCream><b>";
			break;
			case LNG_SHAI:
				sFontPrefix = "<color=MintCream><b>";
			break;
			case LNG_TAHNAI:
				sFontPrefix = "<color=Linen><i>";	
			break;
			case LNG_GIANT_D:
				sFontPrefix = "<color=LightGrey><b>";		
			break;
			case LNG_DRAGON_D:
					sFontPrefix = "<color=BlueViolet><i><b>";
			break;
			case LNG_GNOLL_D:
				sFontPrefix = "<color=NavajoWhite><b>";	
			break;
			case LNG_FAYE:
				sFontPrefix = "<color=Plum><i>";	
			break;
			case LNG_GOBLIN_D:
				sFontPrefix = "<color=White><i>";	
			break;
			case LNG_ANJIRAN:
				sFontPrefix = "<color=White><i>";	
			break;
			case LNG_KOBOLD_D:
				sFontPrefix = "<color=NavajoWhite><i>";		
			break;
			case LNG_JILYN:
				sFontPrefix = "<color=Purple><i>";		
			break;
			case LNG_TRAILSIGN:
				sFontPrefix = "<color=Gray><i>";	
			break;
			case LNG_DRUID_D:
				sFontPrefix = "<color=Thistle><i>";	
			break;
			case LNG_SCOUTSIGN:
				sFontPrefix = "<color=Gray><i>";	
			break;
			case LNG_KALEM:
				sFontPrefix = "<color=Gray><i>";
			break;
			case LNG_NITRIAD:
				sFontPrefix = "<color=Gray><i>";	
			break;
			case LNG_BARAAN:
				sFontPrefix = "<color=Lavender>";
			default:
			break;	
		}
	
	if(nChannel == CHAT_MODE_SHOUT)
	{
		
		if(FindSubString( sFontPrefix,  "<i>") != -1)	
		{
			sFontPrefix = CLR_SHOUT+"<i>";	
		}
		else if(FindSubString( sFontPrefix,  "<b>") != -1)	
		{
			sFontPrefix = CLR_SHOUT+"<b>";	
		}
		else
		{
			sFontPrefix = CLR_SHOUT;
		}
	}
	if(nChannel == CHAT_MODE_WHISPER)	
	{
	
		if(FindSubString( sFontPrefix,  "<i>")	!= -1)
		{
			sFontPrefix = CLR_WHISPER+"<i>";
		}
		else if(FindSubString( sFontPrefix,  "<b>")	!= -1)
		{
			sFontPrefix = CLR_WHISPER+"<b>";
		}	
		else
		{
			sFontPrefix = CLR_WHISPER;
		}			
	}
		
	return sFontPrefix;
}

string SetLanguageFontSuffix(string sPCFontStart )
{

	string sFontSuffix ="</color>";

	if(FindSubString(sPCFontStart, "<b>") != -1) { sFontSuffix = sFontSuffix +"</b>";}
	if(FindSubString(sPCFontStart, "<i>") != -1) { sFontSuffix = sFontSuffix +"</i>";}

	return sFontSuffix;
}


string sTranslateCharacter(string sCurrentCharacter, string sMessage, int nChannel, int iPosition, string sDefaultCharacter ="null", string sDefaultCharacter_Y ="null", string sCheckForPrior1 ="null", string sSetBasedOnPrior1="null", string sSetBasedOnPrior1_Y="null", string sCheckForPrior2 ="null" , string sSetBasedOnPrior2="null", string sSetBasedOnPrior2_Y="null", string sSetBasedOn_I="null", string sSetBasedOn_I_Y="null"  )
{

object oPC = GetFirstPC();
	string sOutPutCharacter ="";
	int iPriorPosition = iPosition -1;
	if (iPriorPosition < 0){iPriorPosition == 0;}
	
	string sPriorCharacter = GetSubString(sMessage, iPriorPosition, 1);

	if(nChannel != CHAT_MODE_SHOUT)
	{
		sOutPutCharacter = sDefaultCharacter ;
		if (iPriorPosition >= 0)
		{	
			if(sCheckForPrior1 != "null")
			{
				if(FindSubString(sCheckForPrior1,sPriorCharacter)!= -1 )
				{	
				sOutPutCharacter = sSetBasedOnPrior1 ;
				}
			}
	 		if(sCheckForPrior2 != "null")
			{
				if(FindSubString(sCheckForPrior2,sPriorCharacter)!= -1 )
					{
					sOutPutCharacter = sSetBasedOnPrior2 ;
					}
			}
		}
	}
	else
	{
		sOutPutCharacter = sDefaultCharacter_Y ;
		if (iPriorPosition >= 0)
		{	
			if(sCheckForPrior1 != "null")
			{
				if(FindSubString(sCheckForPrior1,sPriorCharacter) != -1 )
				{	
				sOutPutCharacter = sSetBasedOnPrior1_Y ;
				}
			}
	 		if(sCheckForPrior2 != "null")
			{
				if(FindSubString(sCheckForPrior2,sPriorCharacter)!= -1 )
					{
					sOutPutCharacter = sSetBasedOnPrior2_Y ;
					}
			}
		}
	}	
	
	if(sSetBasedOn_I != "null" && sCurrentCharacter == "I")
	{
		if(iPosition >= 1)
		{ 

			if( GetSubString(sMessage, iPosition+1, 1) == " " || GetSubString(sMessage, iPosition+1, 1) == "" || GetSubString(sMessage, iPosition+1, 1) == "'"  || GetSubString(sMessage, iPosition+1, 1) == "." ) 
			{
				sOutPutCharacter = sSetBasedOn_I;
				if(nChannel == CHAT_MODE_SHOUT){sOutPutCharacter = sSetBasedOn_I_Y;}
			}
		}
		else{
	
			if( GetSubString(sMessage, iPosition+1, 1) == " " || GetSubString(sMessage, iPosition+1, 1) == "" || GetSubString(sMessage, iPosition+1, 1) == "'"  || GetSubString(sMessage, iPosition+1, 1) == "." ) 
			{
				sOutPutCharacter = StringTrim(sSetBasedOn_I);
				sOutPutCharacter = GetStringUpperCase(GetStringLeft(sOutPutCharacter, 1)) + GetStringRight(sOutPutCharacter, GetStringLength(sOutPutCharacter)-1);

				if(nChannel == CHAT_MODE_SHOUT){sOutPutCharacter = sSetBasedOn_I_Y;}
			}		
		}
	}
	return sOutPutCharacter;
}



string sOutPut_LNG_COMMON_D(string sSubString, int nChannel, object oSender)
{
	int iSubStringLength;
	int iClearTextStart, iClearTextEnd;
	string sLetter, sOutputString, sClearText;


	iSubStringLength = GetStringLength(sSubString);
	sOutputString = "";
	iClearTextStart = 0;
	iClearTextEnd = FindSubString(sSubString, "**", iClearTextStart );

	 while( iClearTextEnd != -1)
	 {
	 	sOutputString = sOutputString + GetSubString(sSubString,iClearTextStart ,iClearTextEnd- iClearTextStart);
		iClearTextStart = iClearTextEnd+2;
		iClearTextEnd = FindSubString(sSubString, "**", iClearTextStart );	 
	 }
	 
	sOutputString = sOutputString + GetSubString(sSubString, iClearTextStart, iSubStringLength - iClearTextStart); 

	if( nChannel == CHAT_MODE_SHOUT )
	{
		sOutputString = GetStringUpperCase(sOutputString);
	}
	return sOutputString;
}


string sOutPut_LNG_ELF_RIAN(string sSubString, int nChannel, object oSender)
{

	int iSubStringLength, iTrans, iCounter;
	int iClearTextStart, iClearTextEnd;
	string sLetter, sOutputString, sClearText, sReturnString , sDuplicate;
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ";
    
	sOutputString = "";
	iSubStringLength = GetStringLength(sSubString);
	
	for(iCounter=0;iCounter <= iSubStringLength; iCounter++)
	{
		sLetter = GetSubString(sSubString,iCounter,1);
			
		if(sLetter == "*")
		{
			if(FindSubString(sSubString, "**", iCounter)== iCounter)
			{
				iClearTextStart = iCounter +2;
				iClearTextEnd = FindSubString(sSubString," ",iClearTextStart);

				if(iClearTextEnd == -1)
				{
					iClearTextEnd = iSubStringLength; 
				}
				
				sClearText = GetSubString(sSubString, iClearTextStart, iClearTextEnd - iClearTextStart );
				sOutputString = sOutputString + CLR_SPACE + sClearText + CLR_SPACE;
				iCounter = iClearTextEnd; 			
			}
		}
		else
		{
			iTrans = FindSubString(sTranslate, sLetter);
			
			switch (iTrans)
		   	{
				case 0: sReturnString = sTranslateCharacter("a", sSubString, nChannel, iCounter, "l","L", "elotm", " qu", " QU", "ahnrs", "'ça", "'ÇA"); break;
				case 1: sReturnString = sTranslateCharacter("b", sSubString, nChannel, iCounter, "ni","NI", "elotm", " al", " AL", "ahnrs", "wa", "WA"); break;
				case 2: sReturnString = sTranslateCharacter("c", sSubString, nChannel, iCounter, "il","IL", "elotm", " ho", " HO", "ahnrs", "ên", "ÊN"); break;
				case 3: sReturnString = sTranslateCharacter("d", sSubString, nChannel, iCounter, "ne","NE", "elotm", "ro", "RO", "ahnrs", "he", "HE"); break;
				case 4: sReturnString = sTranslateCharacter("e", sSubString, nChannel, iCounter, "","", "l", "go", "GO", "n", "rim", "RIM"); break;
				case 5: sReturnString = sTranslateCharacter("f", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 6: sReturnString = sTranslateCharacter("g", sSubString, nChannel, iCounter, "th","TH", "elotm", " lá", " LÁ", "ahnrs", "vâr", "VÂR"); break;
				case 7: sReturnString = sTranslateCharacter("h", sSubString, nChannel, iCounter, "ron","RON", "elotm", " qu", " QU", "ahnrs", "ûr", "ÛR"); break;
				case 8: sReturnString = sTranslateCharacter("i", sSubString, nChannel, iCounter, "","", "ahnrs", "m-â", "M-Â", "vV", "tel'", "TEL'"); break;
				case 9: sReturnString = sTranslateCharacter("j", sSubString, nChannel, iCounter, "esse","ESSE", "elotm", " cû", " CÛ", "ahnrs", "ll", "LL"); break;
				case 10: sReturnString = sTranslateCharacter("k", sSubString, nChannel, iCounter, "wá","WÁ", "elotm", " fa", " FA", "ahnrs", "ma", "MA"); break;
				case 11: sReturnString = sTranslateCharacter("l", sSubString, nChannel, iCounter, "","", "e", "e go", "E GO", "l", "vann", "VANN"); break;
				case 12: sReturnString = sTranslateCharacter("m", sSubString, nChannel, iCounter, "","", "ahnrs", "-rim", "-RIM", "", "", ""); break;
				case 13: sReturnString = sTranslateCharacter("n", sSubString, nChannel, iCounter, "th","TH", "eltm", " na", " NA", "ahnrs", "an", "AN"); break;
				case 14: sReturnString = sTranslateCharacter("o", sSubString, nChannel, iCounter, "","", "l", "en", "EN", "", "", ""); break;
				case 15: sReturnString = sTranslateCharacter("p", sSubString, nChannel, iCounter, "ya","YA", "elotm", " ni", " NI", "ahnrs", "oh", "OH"); break;
				case 16: sReturnString = sTranslateCharacter("q", sSubString, nChannel, iCounter, "dur","DUR", "elotm", " mâ", " MÂ", "ahnrs", "th", "TH"); break;
				case 17: sReturnString = sTranslateCharacter("r", sSubString, nChannel, iCounter, "ár","ÁR", "elotm", " vi", " VI", "ahnrs", "it", "IT"); break;
				case 18: sReturnString = sTranslateCharacter("s", sSubString, nChannel, iCounter, "","", "lotm", " li", " LI", "ahnrs", "h", "H"); break;
				case 19: sReturnString = sTranslateCharacter("t", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 20: sReturnString = sTranslateCharacter("u", sSubString, nChannel, iCounter, "qu","QU", "elotm", " he", " HE", "ahnrs", "pa", "PA"); break;
				case 21: sReturnString = sTranslateCharacter("v", sSubString, nChannel, iCounter, " I'"," I'", "elotm", " er", " ER", "ahnrs", "t", "T"); break;
				case 22: sReturnString = sTranslateCharacter("w", sSubString, nChannel, iCounter, "yo","YO", "elotm", " éi", " ÉI", "ahnrs", "ese", "ESE"); break;
				case 23: sReturnString = sTranslateCharacter("x", sSubString, nChannel, iCounter, "ce","CE", "elotm", " ca", " CA", "ahnrs", "si", "SI"); break;
				case 24: sReturnString = sTranslateCharacter("y", sSubString, nChannel, iCounter, "","", "hnrs", "-", "-", "", "", ""); break;
				case 25: sReturnString = sTranslateCharacter("z", sSubString, nChannel, iCounter, "st","ST", "elotm", " li", " LI", "ahnrs", "th", "TH"); break;
				case 26: sReturnString = sTranslateCharacter("A", sSubString, nChannel, iCounter, " Qu"," QU", "", "", "", "", "", ""); break;
				case 27: sReturnString = sTranslateCharacter("B", sSubString, nChannel, iCounter, " Ál"," ÁL", "", "", "", "", "", ""); break;
				case 28: sReturnString = sTranslateCharacter("C", sSubString, nChannel, iCounter, " Ho"," HO", "", "", "", "", "", ""); break;
				case 29: sReturnString = sTranslateCharacter("D", sSubString, nChannel, iCounter, " Ro"," RO", "", "", "", "", "", ""); break;
				case 30: sReturnString = sTranslateCharacter("E", sSubString, nChannel, iCounter, " Ç"," Ç", "", "", "", "", "", ""); break;
				case 31: sReturnString = sTranslateCharacter("F", sSubString, nChannel, iCounter, " Sî"," SÎ", "", "", "", "", "", ""); break;
				case 32: sReturnString = sTranslateCharacter("G", sSubString, nChannel, iCounter, " Lá"," LÁ", "", "", "", "", "", ""); break;
				case 33: sReturnString = sTranslateCharacter("H", sSubString, nChannel, iCounter, " Ma"," MA", "", "", "", "", "", ""); break;
				case 34: sReturnString = sTranslateCharacter("I", sSubString, nChannel, iCounter, " Mê"," MÊ", "", "", "", "", "", ""," amin", "AMIN"); break;
				case 35: sReturnString = sTranslateCharacter("J", sSubString, nChannel, iCounter, " Cu"," CU", "", "", "", "", "", ""); break;
				case 36: sReturnString = sTranslateCharacter("K", sSubString, nChannel, iCounter, " Fa"," FA", "", "", "", "", "", ""); break;
				case 37: sReturnString = sTranslateCharacter("L", sSubString, nChannel, iCounter, " Ná"," NÁ", "", "", "", "", "", ""); break;
				case 38: sReturnString = sTranslateCharacter("M", sSubString, nChannel, iCounter, " Fal"," FAL", "", "", "", "", "", ""); break;
				case 39: sReturnString = sTranslateCharacter("N", sSubString, nChannel, iCounter, " Na"," NA", "", "", "", "", "", ""); break;
				case 40: sReturnString = sTranslateCharacter("O", sSubString, nChannel, iCounter, " Me"," ME", "", "", "", "", "", ""); break;
				case 41: sReturnString = sTranslateCharacter("P", sSubString, nChannel, iCounter, " Ni"," NI", "", "", "", "", "", ""); break;
				case 42: sReturnString = sTranslateCharacter("Q", sSubString, nChannel, iCounter, " Ma"," MA", "", "", "", "", "", ""); break;
				case 43: sReturnString = sTranslateCharacter("R", sSubString, nChannel, iCounter, " Vi"," VI", "", "", "", "", "", ""); break;
				case 44: sReturnString = sTranslateCharacter("S", sSubString, nChannel, iCounter, " Li"," LI", "", "", "", "", "", ""); break;
				case 45: sReturnString = sTranslateCharacter("T", sSubString, nChannel, iCounter, " Al"," AL", "", "", "", "", "", ""); break;
				case 46: sReturnString = sTranslateCharacter("U", sSubString, nChannel, iCounter, " He"," HE", "", "", "", "", "", ""); break;
				case 47: sReturnString = sTranslateCharacter("V", sSubString, nChannel, iCounter, " I'"," I'", "", "", "", "", "", ""); break;
				case 48: sReturnString = sTranslateCharacter("W", sSubString, nChannel, iCounter, " Ei"," EI", "", "", "", "", "", ""); break;
				case 49: sReturnString = sTranslateCharacter("X", sSubString, nChannel, iCounter, " Ca"," CA", "", "", "", "", "", ""); break;
				case 50: sReturnString = sTranslateCharacter("Y", sSubString, nChannel, iCounter, " Qù"," QÙ", "", "", "", "", "", ""); break;
				case 51: sReturnString = sTranslateCharacter("Z", sSubString, nChannel, iCounter, " Li"," LI", "", "", "", "", "", ""); break;
				case 52: sReturnString = sTranslateCharacter(" ", sSubString, nChannel, iCounter, " ","", "", "", "", "", "", ""); break;
				default: if(sLetter=="!" || sLetter=="?" || sLetter=="."){sReturnString = sLetter;}else{sOutputString = sOutputString;} break;
			}
			if(sReturnString != "")
			{
				if(sReturnString !=  sDuplicate)
				{
					sOutputString = sOutputString + sReturnString;
					sDuplicate = sReturnString;
				}
				else
				{
					sOutputString = sOutputString;
				}
			}								
		}
	}
	return sOutputString;
}




string sOutPut_LNG_ELF_IRYROD(string sSubString, int nChannel, object oSender)
{
	int iSubStringLength, iTrans, iCounter;
	int iClearTextStart, iClearTextEnd;
	string sLetter, sOutputString, sClearText, sReturnString , sDuplicate;
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ";    
	sOutputString = "";
	iSubStringLength = GetStringLength(sSubString);
		
	for(iCounter=0;iCounter <= iSubStringLength; iCounter++)
	{
		sLetter = GetSubString(sSubString,iCounter,1);

		if(sLetter == "*")
		{
			if(FindSubString(sSubString, "**", iCounter)== iCounter)
			{
				iClearTextStart = iCounter +2;
				iClearTextEnd = FindSubString(sSubString," ",iClearTextStart);
			
				if(iClearTextEnd == -1)
				{
					iClearTextEnd = iSubStringLength; 
				}
				
				sClearText = GetSubString(sSubString, iClearTextStart, iClearTextEnd - iClearTextStart );
				sOutputString = sOutputString + CLR_SPACE + sClearText + CLR_SPACE;
				iCounter = iClearTextEnd; 
			}
		}
		else
		{
			iTrans = FindSubString(sTranslate, sLetter);
	
			switch (iTrans)
		   	{
			
				case 0: sReturnString = sTranslateCharacter("a", sSubString, nChannel, iCounter, "l","L", "elotm", " qu", " QU", "ahnrs", "q'a", "Q'A"); break;
				case 1: sReturnString = sTranslateCharacter("b", sSubString, nChannel, iCounter, "ni","NI", "elotm", " él", " ÉL", "ahnrs", "wa", "WA"); break;
				case 2: sReturnString = sTranslateCharacter("c", sSubString, nChannel, iCounter, "ill","ILL", "elotm", " ho", " HO", "ahnrs", "in", "IN"); break;
				case 3: sReturnString = sTranslateCharacter("d", sSubString, nChannel, iCounter, "ne","NE", "elotm", " rû", " RÛ", "ahnrs", "he", "HE"); break;
				case 4: sReturnString = sTranslateCharacter("e", sSubString, nChannel, iCounter, "","", "l", " gû", " GÛ", "n", "rim", "RIM"); break;
				case 5: sReturnString = sTranslateCharacter("f", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 6: sReturnString = sTranslateCharacter("g", sSubString, nChannel, iCounter, "th","TH", "elotm", " lá", " LÁ", "ahnrs", "vâr", "VÂR"); break;
				case 7: sReturnString = sTranslateCharacter("h", sSubString, nChannel, iCounter, "rén","RÉN", "elotm", " me", " ME", "ahnrs", "ûr", "ÛR"); break;
				case 8: sReturnString = sTranslateCharacter("i", sSubString, nChannel, iCounter, "","", "ahnrs", "m-â", "M-Â", "vV", "tél", "TÉL"); break;
				case 9: sReturnString = sTranslateCharacter("j", sSubString, nChannel, iCounter, "esse","ESSE", "elotm", " cû", " CÛ", "ahnrs", "ll", "LL"); break;
				case 10: sReturnString = sTranslateCharacter("k", sSubString, nChannel, iCounter, "wá","WÁ", "elotm", " fa", " FA", "ahnrs", "ma", "MA"); break;
				case 11: sReturnString = sTranslateCharacter("l", sSubString, nChannel, iCounter, "","", "e", "e-gor", "E-GOR", "l", "vann", "VANN"); break;
				case 12: sReturnString = sTranslateCharacter("m", sSubString, nChannel, iCounter, "","", "ahnrs", "-rim", "-RIM", "", "", ""); break;
				case 13: sReturnString = sTranslateCharacter("n", sSubString, nChannel, iCounter, "th","TH", "eltm", " na", " NA", "ahnrs", "ér", "ÉR"); break;
				case 14: sReturnString = sTranslateCharacter("o", sSubString, nChannel, iCounter, "","", "l", "ân", "ÂN", "", "", ""); break;
				case 15: sReturnString = sTranslateCharacter("p", sSubString, nChannel, iCounter, "ya","YA", "elotm", " ni", " NI", "ahnrs", "oh", "OH"); break;
				case 16: sReturnString = sTranslateCharacter("q", sSubString, nChannel, iCounter, "dur","DUR", "elotm", " mâ", " MÂ", "ahnrs", "th", "TH"); break;
				case 17: sReturnString = sTranslateCharacter("r", sSubString, nChannel, iCounter, "ár","ÁR", "elotm", " vi", " VI", "ahnrs", "it", "IT"); break;
				case 18: sReturnString = sTranslateCharacter("s", sSubString, nChannel, iCounter, "","", "lotm", " lir", " LIR", "ahnrs", "hû", "HÛ"); break;
				case 19: sReturnString = sTranslateCharacter("t", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 20: sReturnString = sTranslateCharacter("u", sSubString, nChannel, iCounter, "qu","QU", "elotm", " he", " HE", "ahnrs", "pa", "PA"); break;
				case 21: sReturnString = sTranslateCharacter("v", sSubString, nChannel, iCounter, "er","ER", "elotm", " er", " ER", "ahnrs", "t", "T"); break;
				case 22: sReturnString = sTranslateCharacter("w", sSubString, nChannel, iCounter, "qo","QO", "elotm", " éi", " ÉI", "ahnrs", "ezze", "EZZE"); break;
				case 23: sReturnString = sTranslateCharacter("x", sSubString, nChannel, iCounter, "ce","CE", "elotm", " ca", " CA", "ahnrs", "zi", "ZI"); break;
				case 24: sReturnString = sTranslateCharacter("y", sSubString, nChannel, iCounter, "","", "hnrs", "-", "-", "", "", ""); break;
				case 25: sReturnString = sTranslateCharacter("z", sSubString, nChannel, iCounter, "zt","ZT", "elotm", " li", " LI", "ahnrs", "th", "TH"); break;
				case 26: sReturnString = sTranslateCharacter("A", sSubString, nChannel, iCounter, " Qu"," QU", "", "", "", "", "", ""); break;
				case 27: sReturnString = sTranslateCharacter("B", sSubString, nChannel, iCounter, " Ál"," ÁL", "", "", "", "", "", ""); break;
				case 28: sReturnString = sTranslateCharacter("C", sSubString, nChannel, iCounter, " Ho"," HO", "", "", "", "", "", ""); break;
				case 29: sReturnString = sTranslateCharacter("D", sSubString, nChannel, iCounter, " Ro"," RO", "", "", "", "", "", ""); break;
				case 30: sReturnString = sTranslateCharacter("E", sSubString, nChannel, iCounter, " Ç"," Ç", "", "", "", "", "", ""); break;
				case 31: sReturnString = sTranslateCharacter("F", sSubString, nChannel, iCounter, " Sî"," SÎ", "", "", "", "", "", ""); break;
				case 32: sReturnString = sTranslateCharacter("G", sSubString, nChannel, iCounter, " Lá"," LÁ", "", "", "", "", "", ""); break;
				case 33: sReturnString = sTranslateCharacter("H", sSubString, nChannel, iCounter, " Me"," ME", "", "", "", "", "", ""); break;
				case 34: sReturnString = sTranslateCharacter("I", sSubString, nChannel, iCounter, " Mê"," MÊ", "", "", "", "", "", ""," amán ", " AMÁN "); break;
				case 35: sReturnString = sTranslateCharacter("J", sSubString, nChannel, iCounter, " Cu"," CU", "", "", "", "", "", ""); break;
				case 36: sReturnString = sTranslateCharacter("K", sSubString, nChannel, iCounter, " Fa"," FA", "", "", "", "", "", ""); break;
				case 37: sReturnString = sTranslateCharacter("L", sSubString, nChannel, iCounter, " Ná"," NÁ", "", "", "", "", "", ""); break;
				case 38: sReturnString = sTranslateCharacter("M", sSubString, nChannel, iCounter, " Fal"," FAL", "", "", "", "", "", ""); break;
				case 39: sReturnString = sTranslateCharacter("N", sSubString, nChannel, iCounter, " Na"," NA", "", "", "", "", "", ""); break;
				case 40: sReturnString = sTranslateCharacter("O", sSubString, nChannel, iCounter, " Me"," ME", "", "", "", "", "", ""); break;
				case 41: sReturnString = sTranslateCharacter("P", sSubString, nChannel, iCounter, " Ni"," NI", "", "", "", "", "", ""); break;
				case 42: sReturnString = sTranslateCharacter("Q", sSubString, nChannel, iCounter, " Ma"," MA", "", "", "", "", "", ""); break;
				case 43: sReturnString = sTranslateCharacter("R", sSubString, nChannel, iCounter, " Vi"," VI", "", "", "", "", "", ""); break;
				case 44: sReturnString = sTranslateCharacter("S", sSubString, nChannel, iCounter, " Li"," LI", "", "", "", "", "", ""); break;
				case 45: sReturnString = sTranslateCharacter("T", sSubString, nChannel, iCounter, " Al"," AL", "", "", "", "", "", ""); break;
				case 46: sReturnString = sTranslateCharacter("U", sSubString, nChannel, iCounter, " He"," HE", "", "", "", "", "", ""); break;
				case 47: sReturnString = sTranslateCharacter("V", sSubString, nChannel, iCounter, " I'"," I'", "", "", "", "", "", ""); break;
				case 48: sReturnString = sTranslateCharacter("W", sSubString, nChannel, iCounter, " Ei"," EI", "", "", "", "", "", ""); break;
				case 49: sReturnString = sTranslateCharacter("X", sSubString, nChannel, iCounter, " Ca"," CA", "", "", "", "", "", ""); break;
				case 50: sReturnString = sTranslateCharacter("Y", sSubString, nChannel, iCounter, " Qù"," QÙ", "", "", "", "", "", ""); break;
				case 51: sReturnString = sTranslateCharacter("Z", sSubString, nChannel, iCounter, " Li"," LI", "", "", "", "", "", ""); break;
				case 52: sReturnString = sTranslateCharacter(" ", sSubString, nChannel, iCounter, " ","", "", "", "", "", "", ""); break;
				default: if(sLetter=="!" || sLetter=="?" || sLetter=="."){sReturnString = sLetter;}else{sOutputString = sOutputString;} break;
			}				
			if(sReturnString != "")
			{
				if(sReturnString !=  sDuplicate)
				{
					sOutputString = sOutputString + sReturnString;
					sDuplicate = sReturnString;
				}
				else
				{
					sOutputString = sOutputString;
				}
			}						
		}
	}
	return sOutputString;
}
			
string sOutPut_LNG_DWARF_MODERN(string sSubString, int nChannel, object oSender)
{
	int iSubStringLength, iTrans, iCounter;
	int iClearTextStart, iClearTextEnd;
	string sLetter, sOutputString, sClearText, sReturnString , sDuplicate;
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ";    
	sOutputString = "";
	iSubStringLength = GetStringLength(sSubString);
		
	for(iCounter=0;iCounter <= iSubStringLength; iCounter++)
	{
		sLetter = GetSubString(sSubString,iCounter,1);

		if(sLetter == "*")
		{
			if(FindSubString(sSubString, "**", iCounter)== iCounter)
			{
				iClearTextStart = iCounter +2;
				iClearTextEnd = FindSubString(sSubString," ",iClearTextStart);
			
				if(iClearTextEnd == -1)
				{
					iClearTextEnd = iSubStringLength; 
				}
				
				sClearText = GetSubString(sSubString, iClearTextStart, iClearTextEnd - iClearTextStart );
				
				sOutputString = sOutputString + CLR_SPACE + sClearText + CLR_SPACE;
				iCounter = iClearTextEnd; 
			}
		}
		else
		{
			iTrans = FindSubString(sTranslate, sLetter);
	
			switch (iTrans)
		   	{
				case 0: sReturnString = sTranslateCharacter("a", sSubString, nChannel, iCounter, "","", "dehilrtz", " bl'er", " BL'ER", "anos", "køn", "KØN"); break;
				case 1: sReturnString = sTranslateCharacter("b", sSubString, nChannel, iCounter, "till","TILL", "dehilrtz", " tál", " TÁL", "anos", "bur", "BUR"); break;
				case 2: sReturnString = sTranslateCharacter("c", sSubString, nChannel, iCounter, "klá","KLÁ", "dehilrtz", " ne", " NE", "anos", "ká", "KÁ"); break;
				case 3: sReturnString = sTranslateCharacter("d", sSubString, nChannel, iCounter, "","", "dehilrtz", " bjø", " BJØ", "", "", ""); break;
				case 4: sReturnString = sTranslateCharacter("e", sSubString, nChannel, iCounter, "","", "deirtz", " vär", " VÄR", "nshgl", "ën", "ËN"); break;
				case 5: sReturnString = sTranslateCharacter("f", sSubString, nChannel, iCounter, "bygg","BYGG", "dehilrtz", " fä", " FÄ", "anos", "ët", "ËT"); break;
				case 6: sReturnString = sTranslateCharacter("g", sSubString, nChannel, iCounter, "svá","SVÁ", "dehltz", " vi", " VI", "ainos", "ën", "ËN"); break;
				case 7: sReturnString = sTranslateCharacter("h", sSubString, nChannel, iCounter, "","", "dehilrz", " ska", " SKA", "t", "ëh", "ËH"); break;
				case 8: sReturnString = sTranslateCharacter("i", sSubString, nChannel, iCounter, "","", "dehirtz", " ent", " ENT", "", "", ""); break;
				case 9: sReturnString = sTranslateCharacter("j", sSubString, nChannel, iCounter, "flá","FLÁ", "dehilrtz", " hau", " HAU", "anos", "fli", "FLI"); break;
				case 10: sReturnString = sTranslateCharacter("k", sSubString, nChannel, iCounter, "ng","NG", "dehilrtz", " ef't", " EF'T", "anos", "ren", "REN"); break;
				case 11: sReturnString = sTranslateCharacter("l", sSubString, nChannel, iCounter, "et ","ET ", "dhirtz", " sna", " SNA", "l", "et", "ET"); break;
				case 12: sReturnString = sTranslateCharacter("m", sSubString, nChannel, iCounter, "sva","SVA", "dehilrtz", " for", " FOR", "anos", "møg", "MØG"); break;
				case 13: sReturnString = sTranslateCharacter("n", sSubString, nChannel, iCounter, "mall","MALL", "dehilrtz", " mál", " MÁL", "anos", "ür", "ÜR"); break;
				case 14: sReturnString = sTranslateCharacter("o", sSubString, nChannel, iCounter, "","", "dehirtz", " gø", " GØ", "C", "r-l", "R-L"); break;
				case 15: sReturnString = sTranslateCharacter("p", sSubString, nChannel, iCounter, "hä","HÄ", "dehilrtz", " hä", " HÄ", "anos", "rk", "RK"); break;
				case 16: sReturnString = sTranslateCharacter("q", sSubString, nChannel, iCounter, "tak","TAK", "dehilrtz", " ár", " ÁR", "anos", "nad", "NAD"); break;
				case 17: sReturnString = sTranslateCharacter("r", sSubString, nChannel, iCounter, "","", "dehilrtz", " et", " ET", "u", "en", "EN"); break;
				case 18: sReturnString = sTranslateCharacter("s", sSubString, nChannel, iCounter, "blëk","BLËK", "dhiltz", " ter", " TER", "aenos", "ha", "HA"); break;
				case 19: sReturnString = sTranslateCharacter("t", sSubString, nChannel, iCounter, "","", "deilrz", " kët", " KËT", "", "", ""); break;
				case 20: sReturnString = sTranslateCharacter("u", sSubString, nChannel, iCounter, "","", "dehilrtz", " det", " DET", "S", "ne", "NE"); break;
				case 21: sReturnString = sTranslateCharacter("v", sSubString, nChannel, iCounter, "nad","NAD", "dehilrtz", " det", " DET", "anos", "nár", "NÁR"); break;
				case 22: sReturnString = sTranslateCharacter("w", sSubString, nChannel, iCounter, "ven","VEN", "hilrtz", " káv", " KÁV", "anos", "ar", "AR"); break;
				case 23: sReturnString = sTranslateCharacter("x", sSubString, nChannel, iCounter, "dag","DAG", "dehilrtz", " väl", " VÄL", "anos", "ll", "LL"); break;
				case 24: sReturnString = sTranslateCharacter("y", sSubString, nChannel, iCounter, "sán","SÁN", "dehilrtz", " jä", " JÄ", "anos", "ck", "CK"); break;
				case 25: sReturnString = sTranslateCharacter("z", sSubString, nChannel, iCounter, "","", "dehilrtz", " de", " DE", "", "", ""); break;
				case 26: sReturnString = sTranslateCharacter("A", sSubString, nChannel, iCounter, " Blër"," BLËR", "", "", "", "", "", ""); break;
				case 27: sReturnString = sTranslateCharacter("B", sSubString, nChannel, iCounter, " Ta"," TA", "", "", "", "", "", ""); break;
				case 28: sReturnString = sTranslateCharacter("C", sSubString, nChannel, iCounter, " Du"," DU", "", "", "", "", "", ""); break;
				case 29: sReturnString = sTranslateCharacter("D", sSubString, nChannel, iCounter, " Kø"," KØ", "", "", "", "", "", ""); break;
				case 30: sReturnString = sTranslateCharacter("E", sSubString, nChannel, iCounter, " Ko"," KO", "", "", "", "", "", ""); break;
				case 31: sReturnString = sTranslateCharacter("F", sSubString, nChannel, iCounter, " Bjør"," BJØR", "", "", "", "", "", ""); break;
				case 32: sReturnString = sTranslateCharacter("G", sSubString, nChannel, iCounter, " Vi"," VI", "", "", "", "", "", ""); break;
				case 33: sReturnString = sTranslateCharacter("H", sSubString, nChannel, iCounter, " Ská"," SKÁ", "", "", "", "", "", ""); break;
				case 34: sReturnString = sTranslateCharacter("I", sSubString, nChannel, iCounter, " Va"," VA", "", "", "", "", "", ""," Jeg ", " JEG "); break;
				case 35: sReturnString = sTranslateCharacter("J", sSubString, nChannel, iCounter, " Háu"," HÁU", "", "", "", "", "", ""); break;
				case 36: sReturnString = sTranslateCharacter("K", sSubString, nChannel, iCounter, " Ëft"," ËFT", "", "", "", "", "", ""); break;
				case 37: sReturnString = sTranslateCharacter("L", sSubString, nChannel, iCounter, " Et"," ET", "", "", "", "", "", ""); break;
				case 38: sReturnString = sTranslateCharacter("M", sSubString, nChannel, iCounter, " For"," FOR", "", "", "", "", "", ""); break;
				case 39: sReturnString = sTranslateCharacter("N", sSubString, nChannel, iCounter, " Ür"," ÜR", "", "", "", "", "", ""); break;
				case 40: sReturnString = sTranslateCharacter("O", sSubString, nChannel, iCounter, " Gø"," GØ", "", "", "", "", "", ""); break;
				case 41: sReturnString = sTranslateCharacter("P", sSubString, nChannel, iCounter, " Há"," HÁ", "", "", "", "", "", ""); break;
				case 42: sReturnString = sTranslateCharacter("Q", sSubString, nChannel, iCounter, " Va"," VA", "", "", "", "", "", ""); break;
				case 43: sReturnString = sTranslateCharacter("R", sSubString, nChannel, iCounter, " Är"," ÄR", "", "", "", "", "", ""); break;
				case 44: sReturnString = sTranslateCharacter("S", sSubString, nChannel, iCounter, " He"," HE", "", "", "", "", "", ""); break;
				case 45: sReturnString = sTranslateCharacter("T", sSubString, nChannel, iCounter, " For"," FOR", "", "", "", "", "", ""); break;
				case 46: sReturnString = sTranslateCharacter("U", sSubString, nChannel, iCounter, " Ørr"," ØRR", "", "", "", "", "", ""); break;
				case 47: sReturnString = sTranslateCharacter("V", sSubString, nChannel, iCounter, " Det"," DET", "", "", "", "", "", ""); break;
				case 48: sReturnString = sTranslateCharacter("W", sSubString, nChannel, iCounter, " Kár"," KÁR", "", "", "", "", "", ""); break;
				case 49: sReturnString = sTranslateCharacter("X", sSubString, nChannel, iCounter, " Val"," VAL", "", "", "", "", "", ""); break;
				case 50: sReturnString = sTranslateCharacter("Y", sSubString, nChannel, iCounter, " Já"," JÁ", "", "", "", "", "", ""); break;
				case 51: sReturnString = sTranslateCharacter("Z", sSubString, nChannel, iCounter, " No"," NO", "", "", "", "", "", ""); break;
				case 52: sReturnString = sTranslateCharacter(" ", sSubString, nChannel, iCounter, " ","", "", "", "", "", "", ""); break;
	
				default: if(sLetter=="!" || sLetter=="?" || sLetter=="."){sReturnString = sLetter;}else{sOutputString = sOutputString;} break;
			}
			if(sReturnString != "")
			{
				if(sReturnString !=  sDuplicate)
				{
					sOutputString = sOutputString + sReturnString;
					sDuplicate = sReturnString;
				}
				else
				{
					sOutputString = sOutputString;
				}
			}													
		}
	}
	return sOutputString;
}

string sOutPut_LNG_DWARF_DUNK(string sSubString, int nChannel, object oSender)
{
	int iSubStringLength, iTrans, iCounter;
	int iClearTextStart, iClearTextEnd;
	string sLetter, sOutputString, sClearText, sReturnString , sDuplicate;
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ";   
	sOutputString = "";
	iSubStringLength = GetStringLength(sSubString);
		
	for(iCounter=0;iCounter <= iSubStringLength; iCounter++)
	{
		sLetter = GetSubString(sSubString,iCounter,1);

		if(sLetter == "*")
		{
			if(FindSubString(sSubString, "**", iCounter)== iCounter)
			{
				iClearTextStart = iCounter +2;
				iClearTextEnd = FindSubString(sSubString," ",iClearTextStart);
			
				if(iClearTextEnd == -1)
				{
					iClearTextEnd = iSubStringLength; 
				}
				
				sClearText = GetSubString(sSubString, iClearTextStart, iClearTextEnd - iClearTextStart );
				sOutputString = sOutputString + CLR_SPACE + sClearText + CLR_SPACE;
				iCounter = iClearTextEnd; 
			}
		}
		else
		{
			iTrans = FindSubString(sTranslate, sLetter);
	
			switch (iTrans)
		   	{
				case 0: sReturnString = sTranslateCharacter("a", sSubString, nChannel, iCounter, "","", "dehilrtz", " bl'e", " BL'E", "anos", "kön", "KÖN"); break;
				case 1: sReturnString = sTranslateCharacter("b", sSubString, nChannel, iCounter, "til","TIL", "dehilrtz", " tál", " TÁL", "anos", "bur", "BUR"); break;
				case 2: sReturnString = sTranslateCharacter("c", sSubString, nChannel, iCounter, "klå","KLÅ", "dehilrtz", " ne", " NE", "anos", "kå", "KÅ"); break;
				case 3: sReturnString = sTranslateCharacter("d", sSubString, nChannel, iCounter, "","", "dehilrtz", " bö", " BÖ", "", "", ""); break;
				case 4: sReturnString = sTranslateCharacter("e", sSubString, nChannel, iCounter, "","", "deirtz", " väj", " VÄJ", "nshgl", "ën", "ËN"); break;
				case 5: sReturnString = sTranslateCharacter("f", sSubString, nChannel, iCounter, "bygg","BYGG", "dehilrtz", " fä", " FÄ", "anos", "et", "ET"); break;
				case 6: sReturnString = sTranslateCharacter("g", sSubString, nChannel, iCounter, "svá","SVÁ", "dehltz", " vi", " VI", "ainos", "ën", "ËN"); break;
				case 7: sReturnString = sTranslateCharacter("h", sSubString, nChannel, iCounter, "","", "dehilrz", " ska", " SKA", "t", "ëh", "ËH"); break;
				case 8: sReturnString = sTranslateCharacter("i", sSubString, nChannel, iCounter, "","", "dehirtz", " ent", " ENT", "", "", ""); break;
				case 9: sReturnString = sTranslateCharacter("j", sSubString, nChannel, iCounter, "flá","FLÁ", "dehilrtz", " hau", " HAU", "anos", "fli", "FLI"); break;
				case 10: sReturnString = sTranslateCharacter("k", sSubString, nChannel, iCounter, "ng","NG", "dehilrtz", " ef't", " EF'T", "anos", "ren", "REN"); break;
				case 11: sReturnString = sTranslateCharacter("l", sSubString, nChannel, iCounter, "et ","ET ", "dhirtz", " sna", " SNA", "l", "ët", "ËT"); break;
				case 12: sReturnString = sTranslateCharacter("m", sSubString, nChannel, iCounter, "sva","SVA", "dehilrtz", " för", " FÖR", "anos", "mog", "MOG"); break;
				case 13: sReturnString = sTranslateCharacter("n", sSubString, nChannel, iCounter, "mall","MALL", "dehilrtz", " mål", " MÅL", "anos", "ür", "ÜR"); break;
				case 14: sReturnString = sTranslateCharacter("o", sSubString, nChannel, iCounter, "","", "dehirtz", " go", " GO", "C", "r-l", "R-L"); break;
				case 15: sReturnString = sTranslateCharacter("p", sSubString, nChannel, iCounter, "hä","HÄ", "dehilrtz", " hä", " HÄ", "anos", "rk", "RK"); break;
				case 16: sReturnString = sTranslateCharacter("q", sSubString, nChannel, iCounter, "tak","TAK", "dehilrtz", " ár", " ÁR", "anos", "nåd", "NÅD"); break;
				case 17: sReturnString = sTranslateCharacter("r", sSubString, nChannel, iCounter, "","", "dehilrtz", " et", " ET", "u", "enn", "ENN"); break;
				case 18: sReturnString = sTranslateCharacter("s", sSubString, nChannel, iCounter, "blëk","BLËK", "dhiltz", " tar", " TAR", "aenos", "ha", "HA"); break;
				case 19: sReturnString = sTranslateCharacter("t", sSubString, nChannel, iCounter, "","", "deilrz", " kët", " KËT", "", "", ""); break;
				case 20: sReturnString = sTranslateCharacter("u", sSubString, nChannel, iCounter, "","", "dehilrtz", " det", " DET", "S", "ne", "NE"); break;
				case 21: sReturnString = sTranslateCharacter("v", sSubString, nChannel, iCounter, "nad","NAD", "dehilrtz", " dët", " DËT", "anos", "nár", "NÁR"); break;
				case 22: sReturnString = sTranslateCharacter("w", sSubString, nChannel, iCounter, "ven","VEN", "hilrtz", " kåv", " KÅV", "anos", "ar", "AR"); break;
				case 23: sReturnString = sTranslateCharacter("x", sSubString, nChannel, iCounter, "dåg","DÅG", "dehilrtz", " välj", " VÄLJ", "anos", "ll", "LL"); break;
				case 24: sReturnString = sTranslateCharacter("y", sSubString, nChannel, iCounter, "sán","SÁN", "dehilrtz", " jä", " JÄ", "anos", "ck", "CK"); break;
				case 25: sReturnString = sTranslateCharacter("z", sSubString, nChannel, iCounter, "","", "dehilrtz", " de", " DE", "", "", ""); break;
				case 26: sReturnString = sTranslateCharacter("A", sSubString, nChannel, iCounter, " Blër"," BLËR", "", "", "", "", "", ""); break;
				case 27: sReturnString = sTranslateCharacter("B", sSubString, nChannel, iCounter, " Tå"," TÅ", "", "", "", "", "", ""); break;
				case 28: sReturnString = sTranslateCharacter("C", sSubString, nChannel, iCounter, " Du"," DU", "", "", "", "", "", ""); break;
				case 29: sReturnString = sTranslateCharacter("D", sSubString, nChannel, iCounter, "Ku","KU", "", "", "", "", "", ""); break;
				case 30: sReturnString = sTranslateCharacter("E", sSubString, nChannel, iCounter, " Kö"," KÖ", "", "", "", "", "", ""); break;
				case 31: sReturnString = sTranslateCharacter("F", sSubString, nChannel, iCounter, " Bjö"," BJÖ", "", "", "", "", "", ""); break;
				case 32: sReturnString = sTranslateCharacter("G", sSubString, nChannel, iCounter, " Vi"," VI", "", "", "", "", "", ""); break;
				case 33: sReturnString = sTranslateCharacter("H", sSubString, nChannel, iCounter, " Skä"," SKÄ", "", "", "", "", "", ""); break;
				case 34: sReturnString = sTranslateCharacter("I", sSubString, nChannel, iCounter, " Va"," VA", "", "", "", "", "", ""," Jürg ", " JÜRG "); break;
				case 35: sReturnString = sTranslateCharacter("J", sSubString, nChannel, iCounter, " Háu"," HÁU", "", "", "", "", "", ""); break;
				case 36: sReturnString = sTranslateCharacter("K", sSubString, nChannel, iCounter, " Ëft"," ËFT", "", "", "", "", "", ""); break;
				case 37: sReturnString = sTranslateCharacter("L", sSubString, nChannel, iCounter, " Et"," ET", "", "", "", "", "", ""); break;
				case 38: sReturnString = sTranslateCharacter("M", sSubString, nChannel, iCounter, " For"," FOR", "", "", "", "", "", ""); break;
				case 39: sReturnString = sTranslateCharacter("N", sSubString, nChannel, iCounter, " Ür"," ÜR", "", "", "", "", "", ""); break;
				case 40: sReturnString = sTranslateCharacter("O", sSubString, nChannel, iCounter, " Go"," GO", "", "", "", "", "", ""); break;
				case 41: sReturnString = sTranslateCharacter("P", sSubString, nChannel, iCounter, " Hä"," HÄ", "", "", "", "", "", ""); break;
				case 42: sReturnString = sTranslateCharacter("Q", sSubString, nChannel, iCounter, " Vå"," VÅ", "", "", "", "", "", ""); break;
				case 43: sReturnString = sTranslateCharacter("R", sSubString, nChannel, iCounter, " Är"," ÄR", "", "", "", "", "", ""); break;
				case 44: sReturnString = sTranslateCharacter("S", sSubString, nChannel, iCounter, " Hë"," HË", "", "", "", "", "", ""); break;
				case 45: sReturnString = sTranslateCharacter("T", sSubString, nChannel, iCounter, "For","FOR", "", "", "", "", "", ""); break;
				case 46: sReturnString = sTranslateCharacter("U", sSubString, nChannel, iCounter, " Ör"," ÖR", "", "", "", "", "", ""); break;
				case 47: sReturnString = sTranslateCharacter("V", sSubString, nChannel, iCounter, " Det"," DET", "", "", "", "", "", ""); break;
				case 48: sReturnString = sTranslateCharacter("W", sSubString, nChannel, iCounter, " Kav"," KAV", "", "", "", "", "", ""); break;
				case 49: sReturnString = sTranslateCharacter("X", sSubString, nChannel, iCounter, " Val"," VAL", "", "", "", "", "", ""); break;
				case 50: sReturnString = sTranslateCharacter("Y", sSubString, nChannel, iCounter, " Jå"," JÅ", "", "", "", "", "", ""); break;
				case 51: sReturnString = sTranslateCharacter("Z", sSubString, nChannel, iCounter, " No"," NO", "", "", "", "", "", ""); break;
				case 52: sReturnString = sTranslateCharacter(" ", sSubString, nChannel, iCounter, " ","", "", "", "", "", "", ""); break;

				default: if(sLetter=="!" || sLetter=="?" || sLetter=="."){sReturnString = sLetter;}else{sOutputString = sOutputString;} break;
			}
			if(sReturnString != "")
			{
				if(sReturnString !=  sDuplicate)
				{
					sOutputString = sOutputString + sReturnString;
					sDuplicate = sReturnString;
				}
				else
				{
					sOutputString = sOutputString;
				}
			}													
		}
	}
	return sOutputString;
}

string sOutPut_LNG_DWARF_ANCIENT(string sSubString, int nChannel, object oSender)
{
	int iSubStringLength, iTrans, iCounter;
	int iClearTextStart, iClearTextEnd;
	string sLetter, sOutputString, sClearText, sReturnString , sDuplicate;
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ";    
	sOutputString = "";
	iSubStringLength = GetStringLength(sSubString);
		
	for(iCounter=0;iCounter <= iSubStringLength; iCounter++)
	{
		sLetter = GetSubString(sSubString,iCounter,1);

		if(sLetter == "*")
		{
			if(FindSubString(sSubString, "**", iCounter)== iCounter)
			{
				iClearTextStart = iCounter +2;
				iClearTextEnd = FindSubString(sSubString," ",iClearTextStart);
			
				if(iClearTextEnd == -1)
				{
					iClearTextEnd = iSubStringLength; 
				}
				
				sClearText = GetSubString(sSubString, iClearTextStart, iClearTextEnd - iClearTextStart );
				sOutputString = sOutputString + CLR_SPACE + sClearText + CLR_SPACE;
				iCounter = iClearTextEnd; 
			}
		}
		else
		{
			iTrans = FindSubString(sTranslate, sLetter);
	
			switch (iTrans)
		   	{
				case 0: sReturnString = sTranslateCharacter("a", sSubString, nChannel, iCounter, "","", "dehilrtz", " bl'er", " BL'ER", "anos", "kon", "KON"); break;
				case 1: sReturnString = sTranslateCharacter("b", sSubString, nChannel, iCounter, "till","TILL", "dehilrtz", " tál", " TÁL", "anos", "bur", "BUR"); break;
				case 2: sReturnString = sTranslateCharacter("c", sSubString, nChannel, iCounter, "klä","KLÄ", "dehilrtz", " ne", " NE", "anos", "kå", "KÅ"); break;
				case 3: sReturnString = sTranslateCharacter("d", sSubString, nChannel, iCounter, "","", "dehilrtz", " bjø", " BJØ", "", "", ""); break;
				case 4: sReturnString = sTranslateCharacter("e", sSubString, nChannel, iCounter, "","", "deirtz", " vä", " VÄ", "nshgl", "ën", "ËN"); break;
				case 5: sReturnString = sTranslateCharacter("f", sSubString, nChannel, iCounter, "bygg","BYGG", "dehilrtz", " fä", " FÄ", "anos", "ët", "ËT"); break;
				case 6: sReturnString = sTranslateCharacter("g", sSubString, nChannel, iCounter, "svá","SVÁ", "dehltz", " vi", " VI", "ainos", "ën", "ËN"); break;
				case 7: sReturnString = sTranslateCharacter("h", sSubString, nChannel, iCounter, "","", "dehilrz", " ska", " SKA", "t", "ëh", "ËH"); break;
				case 8: sReturnString = sTranslateCharacter("i", sSubString, nChannel, iCounter, "","", "dehirtz", " ent", " ENT", "", "", ""); break;
				case 9: sReturnString = sTranslateCharacter("j", sSubString, nChannel, iCounter, "flá","FLÁ", "dehilrtz", " hau", " HAU", "anos", "fli", "FLI"); break;
				case 10: sReturnString = sTranslateCharacter("k", sSubString, nChannel, iCounter, "ng","NG", "dehilrtz", " ef't", " EF'T", "anos", "ren", "REN"); break;
				case 11: sReturnString = sTranslateCharacter("l", sSubString, nChannel, iCounter, "et ","ET ", "dhirtz", " sna", " SNA", "l", "et", "ET"); break;
				case 12: sReturnString = sTranslateCharacter("m", sSubString, nChannel, iCounter, "sva","SVA", "dehilrtz", " før", " FØR", "anos", "mog", "MOG"); break;
				case 13: sReturnString = sTranslateCharacter("n", sSubString, nChannel, iCounter, "mall","MALL", "dehilrtz", " mál", " MÁL", "anos", "ür", "ÜR"); break;
				case 14: sReturnString = sTranslateCharacter("o", sSubString, nChannel, iCounter, "","", "dehirtz", " go", " GO", "C", "r-l", "R-L"); break;
				case 15: sReturnString = sTranslateCharacter("p", sSubString, nChannel, iCounter, "hä","HÄ", "dehilrtz", " hä", " HÄ", "anos", "rk", "RK"); break;
				case 16: sReturnString = sTranslateCharacter("q", sSubString, nChannel, iCounter, "tak","TAK", "dehilrtz", " ár", " ÁR", "anos", "nad", "NAD"); break;
				case 17: sReturnString = sTranslateCharacter("r", sSubString, nChannel, iCounter, "","", "dehilrtz", " et", " ET", "u", "en", "EN"); break;
				case 18: sReturnString = sTranslateCharacter("s", sSubString, nChannel, iCounter, "blëk","BLËK", "dhiltz", " ter", " TER", "aenos", "ha", "HA"); break;
				case 19: sReturnString = sTranslateCharacter("t", sSubString, nChannel, iCounter, "","", "deilrz", " kët", " KËT", "", "", ""); break;
				case 20: sReturnString = sTranslateCharacter("u", sSubString, nChannel, iCounter, "","", "dehilrtz", " det", " DET", "S", "ne", "NE"); break;
				case 21: sReturnString = sTranslateCharacter("v", sSubString, nChannel, iCounter, "nad","NAD", "dehilrtz", " det", " DET", "anos", "nár", "NÁR"); break;
				case 22: sReturnString = sTranslateCharacter("w", sSubString, nChannel, iCounter, "ven","VEN", "hilrtz", " kåv", " KÅV", "anos", "ar", "AR"); break;
				case 23: sReturnString = sTranslateCharacter("x", sSubString, nChannel, iCounter, "dag","DAG", "dehilrtz", " väl", " VÄL", "anos", "ll", "LL"); break;
				case 24: sReturnString = sTranslateCharacter("y", sSubString, nChannel, iCounter, "sán","SÁN", "dehilrtz", " jä", " JÄ", "anos", "ck", "CK"); break;
				case 25: sReturnString = sTranslateCharacter("z", sSubString, nChannel, iCounter, "","", "dehilrtz", " de", " DE", "", "", ""); break;
				case 26: sReturnString = sTranslateCharacter("A", sSubString, nChannel, iCounter, " Blër"," BLËR", "", "", "", "", "", ""); break;
				case 27: sReturnString = sTranslateCharacter("B", sSubString, nChannel, iCounter, " Ta"," TA", "", "", "", "", "", ""); break;
				case 28: sReturnString = sTranslateCharacter("C", sSubString, nChannel, iCounter, " Du"," DU", "", "", "", "", "", ""); break;
				case 29: sReturnString = sTranslateCharacter("D", sSubString, nChannel, iCounter, " Ko"," KO", "", "", "", "", "", ""); break;
				case 30: sReturnString = sTranslateCharacter("E", sSubString, nChannel, iCounter, " Kö"," KÖ", "", "", "", "", "", ""); break;
				case 31: sReturnString = sTranslateCharacter("F", sSubString, nChannel, iCounter, " Bjö"," BJÖ", "", "", "", "", "", ""); break;
				case 32: sReturnString = sTranslateCharacter("G", sSubString, nChannel, iCounter, " Vi"," VI", "", "", "", "", "", ""); break;
				case 33: sReturnString = sTranslateCharacter("H", sSubString, nChannel, iCounter, " Skä"," SKÄ", "", "", "", "", "", ""); break;
				case 34: sReturnString = sTranslateCharacter("I", sSubString, nChannel, iCounter, " Va"," VA", "", "", "", "", "", ""," Jág ", " JÁG "); break;
				case 35: sReturnString = sTranslateCharacter("J", sSubString, nChannel, iCounter, " Háu"," HÁU", "", "", "", "", "", ""); break;
				case 36: sReturnString = sTranslateCharacter("K", sSubString, nChannel, iCounter, " Ëft"," ËFT", "", "", "", "", "", ""); break;
				case 37: sReturnString = sTranslateCharacter("L", sSubString, nChannel, iCounter, " Et"," ET", "", "", "", "", "", ""); break;
				case 38: sReturnString = sTranslateCharacter("M", sSubString, nChannel, iCounter, " For"," FOR", "", "", "", "", "", ""); break;
				case 39: sReturnString = sTranslateCharacter("N", sSubString, nChannel, iCounter, " Ür"," ÜR", "", "", "", "", "", ""); break;
				case 40: sReturnString = sTranslateCharacter("O", sSubString, nChannel, iCounter, " Go"," GO", "", "", "", "", "", ""); break;
				case 41: sReturnString = sTranslateCharacter("P", sSubString, nChannel, iCounter, " Hä"," HÄ", "", "", "", "", "", ""); break;
				case 42: sReturnString = sTranslateCharacter("Q", sSubString, nChannel, iCounter, " Va"," VA", "", "", "", "", "", ""); break;
				case 43: sReturnString = sTranslateCharacter("R", sSubString, nChannel, iCounter, " Är"," ÄR", "", "", "", "", "", ""); break;
				case 44: sReturnString = sTranslateCharacter("S", sSubString, nChannel, iCounter, " He"," HE", "", "", "", "", "", ""); break;
				case 45: sReturnString = sTranslateCharacter("T", sSubString, nChannel, iCounter, " For"," FOR", "", "", "", "", "", ""); break;
				case 46: sReturnString = sTranslateCharacter("U", sSubString, nChannel, iCounter, " Ör"," ÖR", "", "", "", "", "", ""); break;
				case 47: sReturnString = sTranslateCharacter("V", sSubString, nChannel, iCounter, " Det"," DET", "", "", "", "", "", ""); break;
				case 48: sReturnString = sTranslateCharacter("W", sSubString, nChannel, iCounter, " Kav"," KAV", "", "", "", "", "", ""); break;
				case 49: sReturnString = sTranslateCharacter("X", sSubString, nChannel, iCounter, " Val"," VAL", "", "", "", "", "", ""); break;
				case 50: sReturnString = sTranslateCharacter("Y", sSubString, nChannel, iCounter, " Já"," JÁ", "", "", "", "", "", ""); break;
				case 51: sReturnString = sTranslateCharacter("Z", sSubString, nChannel, iCounter, " No"," NO", "", "", "", "", "", ""); break;
				case 52: sReturnString = sTranslateCharacter(" ", sSubString, nChannel, iCounter, " ","", "", "", "", "", "", ""); break;
				
				default: if(sLetter=="!" || sLetter=="?" || sLetter=="."){sReturnString = sLetter;}else{sOutputString = sOutputString;} break;
			}
			if(sReturnString != "")
			{
				if(sReturnString !=  sDuplicate)
				{
					sOutputString = sOutputString + sReturnString;
					sDuplicate = sReturnString;
				}
				else
				{
					sOutputString = sOutputString;
				}
			}													
		}
	}
	return sOutputString;
}

string sOutPut_LNG_RELLIAN(string sSubString, int nChannel, object oSender)
{
	int iSubStringLength, iTrans, iCounter;
	int iClearTextStart, iClearTextEnd;
	string sLetter, sOutputString, sClearText, sReturnString , sDuplicate;
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ";    
	sOutputString = "";
	iSubStringLength = GetStringLength(sSubString);
		
	for(iCounter=0;iCounter <= iSubStringLength; iCounter++)
	{
		sLetter = GetSubString(sSubString,iCounter,1);

		if(sLetter == "*")
		{
			if(FindSubString(sSubString, "**", iCounter)== iCounter)
			{
				iClearTextStart = iCounter +2;
				iClearTextEnd = FindSubString(sSubString," ",iClearTextStart);
			
				if(iClearTextEnd == -1)
				{
					iClearTextEnd = iSubStringLength; 
				}
				
				sClearText = GetSubString(sSubString, iClearTextStart, iClearTextEnd - iClearTextStart );
				sOutputString = sOutputString + CLR_SPACE + sClearText + CLR_SPACE;
				iCounter = iClearTextEnd; 
			}
		}
		else
		{
			iTrans = FindSubString(sTranslate, sLetter);
	
			switch (iTrans)
		   	{
				case 0: sReturnString = sTranslateCharacter("a", sSubString, nChannel, iCounter, "","", "hH", "ê", "Ê", "w", "u", "U"); break;
				case 1: sReturnString = sTranslateCharacter("b", sSubString, nChannel, iCounter, "b","B", "", "", "", "", "", ""); break;
				case 2: sReturnString = sTranslateCharacter("c", sSubString, nChannel, iCounter, "k","K", "aA", "s", "S", "", "", ""); break;
				case 3: sReturnString = sTranslateCharacter("d", sSubString, nChannel, iCounter, "d","D", "", "", "", "", "", ""); break;
				case 4: sReturnString = sTranslateCharacter("e", sSubString, nChannel, iCounter, "e","E", "mMwWrRpP", "î", "Î", "vfeu", "", ""); break;
				case 5: sReturnString = sTranslateCharacter("f", sSubString, nChannel, iCounter, "wh","WH", "", "", "", "", "", ""); break;
				case 6: sReturnString = sTranslateCharacter("g", sSubString, nChannel, iCounter, "j","J", "u", "", "", "", "", ""); break;
				case 7: sReturnString = sTranslateCharacter("h", sSubString, nChannel, iCounter, "h","H", "t", "x", "X", "T", "", ""); break;
				case 8: sReturnString = sTranslateCharacter("i", sSubString, nChannel, iCounter, "i","I", "fF", "aî", "AÎ", "", "", ""); break;
				case 9: sReturnString = sTranslateCharacter("j", sSubString, nChannel, iCounter, "j","J", "", "", "", "", "", ""); break;
				case 10: sReturnString = sTranslateCharacter("k", sSubString, nChannel, iCounter, "k","K", "", "", "", "", "", ""); break;
				case 11: sReturnString = sTranslateCharacter("l", sSubString, nChannel, iCounter, "l","L", "aA", "al", "AL", "l", "", ""); break;
				case 12: sReturnString = sTranslateCharacter("m", sSubString, nChannel, iCounter, "m","M", "", "", "", "", "", ""); break;
				case 13: sReturnString = sTranslateCharacter("n", sSubString, nChannel, iCounter, "n","N", "aA", "n", "N", "", "", ""); break;
				case 14: sReturnString = sTranslateCharacter("o", sSubString, nChannel, iCounter, "o","O", "tT", "tû", "TÛ", "o", "", ""); break;
				case 15: sReturnString = sTranslateCharacter("p", sSubString, nChannel, iCounter, "p","P", "", "", "", "", "", ""); break;
				case 16: sReturnString = sTranslateCharacter("q", sSubString, nChannel, iCounter, "q","Q", "", "", "", "", "", ""); break;
				case 17: sReturnString = sTranslateCharacter("r", sSubString, nChannel, iCounter, "r","R", "eE", "", "", "", "", ""); break;
				case 18: sReturnString = sTranslateCharacter("s", sSubString, nChannel, iCounter, "s","S", "ir", "z", "Z", "", "", ""); break;
				case 19: sReturnString = sTranslateCharacter("t", sSubString, nChannel, iCounter, "","", "fFsSnNaAuU", "t", "T", "", "", ""); break;
				case 20: sReturnString = sTranslateCharacter("u", sSubString, nChannel, iCounter, "u","U", "o", "", "", "", "", ""); break;
				case 21: sReturnString = sTranslateCharacter("v", sSubString, nChannel, iCounter, "v","V", "", "", "", "", "", ""); break;
				case 22: sReturnString = sTranslateCharacter("w", sSubString, nChannel, iCounter, "w","W", "", "", "", "", "", ""); break;
				case 23: sReturnString = sTranslateCharacter("x", sSubString, nChannel, iCounter, "ks","KS", "", "", "", "", "", ""); break;
				case 24: sReturnString = sTranslateCharacter("y", sSubString, nChannel, iCounter, "î","Î", " ", "u", "U", "", "", ""); break;
				case 25: sReturnString = sTranslateCharacter("z", sSubString, nChannel, iCounter, "s","S", "", "", "", "", "", ""); break;
				case 26: sReturnString = sTranslateCharacter("A", sSubString, nChannel, iCounter, "A","A", "", "", "", "", "", ""); break;
				case 27: sReturnString = sTranslateCharacter("B", sSubString, nChannel, iCounter, "B","B", "", "", "", "", "", ""); break;
				case 28: sReturnString = sTranslateCharacter("C", sSubString, nChannel, iCounter, "K","K", "", "", "", "", "", ""); break;
				case 29: sReturnString = sTranslateCharacter("D", sSubString, nChannel, iCounter, "D","D", "", "", "", "", "", ""); break;
				case 30: sReturnString = sTranslateCharacter("E", sSubString, nChannel, iCounter, "E","E", "", "", "", "", "", ""); break;
				case 31: sReturnString = sTranslateCharacter("F", sSubString, nChannel, iCounter, "Wh","WH", "", "", "", "", "", ""); break;
				case 32: sReturnString = sTranslateCharacter("G", sSubString, nChannel, iCounter, "J","J", "", "", "", "", "", ""); break;
				case 33: sReturnString = sTranslateCharacter("H", sSubString, nChannel, iCounter, "H","H", "tT", "X", "X", "", "", ""); break;
				case 34: sReturnString = sTranslateCharacter("I", sSubString, nChannel, iCounter, "I","I", "", "", "", "", "", "I","I"); break;
				case 35: sReturnString = sTranslateCharacter("J", sSubString, nChannel, iCounter, "J","J", "", "", "", "", "", ""); break;
				case 36: sReturnString = sTranslateCharacter("K", sSubString, nChannel, iCounter, " K"," K", "", "", "", "", "", ""); break;
				case 37: sReturnString = sTranslateCharacter("L", sSubString, nChannel, iCounter, " L"," L", "", "", "", "", "", ""); break;
				case 38: sReturnString = sTranslateCharacter("M", sSubString, nChannel, iCounter, " M"," M", "", "", "", "", "", ""); break;
				case 39: sReturnString = sTranslateCharacter("N", sSubString, nChannel, iCounter, " N"," N", "", "", "", "", "", ""); break;
				case 40: sReturnString = sTranslateCharacter("O", sSubString, nChannel, iCounter, " O"," O", "", "", "", "", "", ""); break;
				case 41: sReturnString = sTranslateCharacter("P", sSubString, nChannel, iCounter, " P"," P", "", "", "", "", "", ""); break;
				case 42: sReturnString = sTranslateCharacter("Q", sSubString, nChannel, iCounter, " Q"," Q", "", "", "", "", "", ""); break;
				case 43: sReturnString = sTranslateCharacter("R", sSubString, nChannel, iCounter, " R"," R", "", "", "", "", "", ""); break;
				case 44: sReturnString = sTranslateCharacter("S", sSubString, nChannel, iCounter, " S"," S", "", "", "", "", "", ""); break;
				case 45: sReturnString = sTranslateCharacter("T", sSubString, nChannel, iCounter, "X","X", "", "", "", "", "", ""); break;
				case 46: sReturnString = sTranslateCharacter("U", sSubString, nChannel, iCounter, " U"," U", "", "", "", "", "", ""); break;
				case 47: sReturnString = sTranslateCharacter("V", sSubString, nChannel, iCounter, " V"," V", "", "", "", "", "", ""); break;
				case 48: sReturnString = sTranslateCharacter("W", sSubString, nChannel, iCounter, " W"," W", "", "", "", "", "", ""); break;
				case 49: sReturnString = sTranslateCharacter("X", sSubString, nChannel, iCounter, " Ks"," KS", "", "", "", "", "", ""); break;
				case 50: sReturnString = sTranslateCharacter("Y", sSubString, nChannel, iCounter, " I"," I", "", "", "", "", "", ""); break;
				case 51: sReturnString = sTranslateCharacter("Z", sSubString, nChannel, iCounter, " S"," S", "", "", "", "", "", ""); break;
				case 52: sReturnString = sTranslateCharacter(" ", sSubString, nChannel, iCounter, " "," ", "", "", "", "", "", ""); break;
	
				default: if(sLetter=="!" || sLetter=="?" || sLetter=="."){sReturnString = sLetter;}else{sOutputString = sOutputString;} break;
			}
			if(sReturnString != "")
			{
				if(sReturnString !=  sDuplicate)
				{
					sOutputString = sOutputString + sReturnString;
					sDuplicate = sReturnString;
				}
				else
				{
					sOutputString = sOutputString;
				}
			}													
		}
	}
	return sOutputString;
}

string sOutPut_LNG_DARISH(string sSubString, int nChannel, object oSender)
{
	int iSubStringLength, iTrans, iCounter;
	int iClearTextStart, iClearTextEnd;
	string sLetter, sOutputString, sClearText, sReturnString , sDuplicate;
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ";    
	sOutputString = "";
	iSubStringLength = GetStringLength(sSubString);
		
	for(iCounter=0;iCounter <= iSubStringLength; iCounter++)
	{
		sLetter = GetSubString(sSubString,iCounter,1);

		if(sLetter == "*")
		{
			if(FindSubString(sSubString, "**", iCounter)== iCounter)
			{
				iClearTextStart = iCounter +2;
				iClearTextEnd = FindSubString(sSubString," ",iClearTextStart);
			
				if(iClearTextEnd == -1)
				{
					iClearTextEnd = iSubStringLength; 
				}
				
				sClearText = GetSubString(sSubString, iClearTextStart, iClearTextEnd - iClearTextStart );
				sOutputString = sOutputString + CLR_SPACE + sClearText + CLR_SPACE;
				iCounter = iClearTextEnd; 
			}
		}
		else
		{
			iTrans = FindSubString(sTranslate, sLetter);
	
			switch (iTrans)
		   	{
				case 0: sReturnString = sTranslateCharacter("a", sSubString, nChannel, iCounter, "","", "M", "r", "R", "m", "r", "R"); break;
				case 1: sReturnString = sTranslateCharacter("b", sSubString, nChannel, iCounter, "ri","RI", "aei", " sa", " SA", "ort", " bä", " BÄ"); break;
				case 2: sReturnString = sTranslateCharacter("c", sSubString, nChannel, iCounter, "","", "aei", " og", " OG", "ort", " od", " OD"); break;
				case 3: sReturnString = sTranslateCharacter("d", sSubString, nChannel, iCounter, "or","OR", "aei", " më", " MË", "ort", " no", " NO"); break;
				case 4: sReturnString = sTranslateCharacter("e", sSubString, nChannel, iCounter, "","", " abdfghkl", "na", "NA", "mnpqtvwyz", "ed", "ED"); break;
				case 5: sReturnString = sTranslateCharacter("f", sSubString, nChannel, iCounter, "ut","UT", "aei", " ikh", " IKH", "ort", " so", " SO"); break;
				case 6: sReturnString = sTranslateCharacter("g", sSubString, nChannel, iCounter, "mg","MG", "aei", " yu", " YU", "ort", " mä", " MÄ"); break;
				case 7: sReturnString = sTranslateCharacter("h", sSubString, nChannel, iCounter, "","", "aei", " sä", " SÄ", "ort", " yu", " YU"); break;
				case 8: sReturnString = sTranslateCharacter("i", sSubString, nChannel, iCounter, "","", " abdfghkl", "oi", "OI", "mnpqtvwyz", "an", "AN"); break;
				case 9: sReturnString = sTranslateCharacter("j", sSubString, nChannel, iCounter, "r","R", "aei", " bi", " BI", "ort", " on", " ON"); break;
				case 10: sReturnString = sTranslateCharacter("k", sSubString, nChannel, iCounter, "vt","VT", "aei", " aj", " AJ", "ort", " yu", " YU"); break;
				case 11: sReturnString = sTranslateCharacter("l", sSubString, nChannel, iCounter, "","", "aei", " zu", " ZU", "ort", " or", " OR"); break;
				case 12: sReturnString = sTranslateCharacter("m", sSubString, nChannel, iCounter, "ug","UG", " ", " dä", " DÄ", "ort", " të", " TË"); break;
				case 13: sReturnString = sTranslateCharacter("n", sSubString, nChannel, iCounter, "","", "ei", " aj", " AJ", "ort", " on", " ON"); break;
				case 14: sReturnString = sTranslateCharacter("o", sSubString, nChannel, iCounter, "","", " abdfghkl", "d", "D", "mnpqtvwyz", "ui", "UI"); break;
				case 15: sReturnString = sTranslateCharacter("p", sSubString, nChannel, iCounter, "st","ST", "aei", " ch", " CH", "ort", " uu", " UU"); break;
				case 16: sReturnString = sTranslateCharacter("q", sSubString, nChannel, iCounter, "nt","NT", "aei", " ve", " VE", "ort", " ge", " GE"); break;
				case 17: sReturnString = sTranslateCharacter("r", sSubString, nChannel, iCounter, "","", " abdfghkl", "eg", "EG", "mnpqtvwyz", "en", "EN"); break;
				case 18: sReturnString = sTranslateCharacter("s", sSubString, nChannel, iCounter, "","", "aei", " kh'", " KH'", "ort", " zu", " ZU"); break;
				case 19: sReturnString = sTranslateCharacter("t", sSubString, nChannel, iCounter, "","", " bdfghkl", "ër", "ËR", "mnpqtvwyz", "i'i", "I'I"); break;
				case 20: sReturnString = sTranslateCharacter("u", sSubString, nChannel, iCounter, "ra","RA", "aei", " hu", " HU", "ort", " uk", " UK"); break;
				case 21: sReturnString = sTranslateCharacter("v", sSubString, nChannel, iCounter, "är","ÄR", "aei", " kh", " KH", "ort", " ji", " JI"); break;
				case 22: sReturnString = sTranslateCharacter("w", sSubString, nChannel, iCounter, "","", "aei", " äv", " ÄV", "ort", " do", " DO"); break;
				case 23: sReturnString = sTranslateCharacter("x", sSubString, nChannel, iCounter, "ls","LS", "aei", " oo", " OO", "ort", " su", " SU"); break;
				case 24: sReturnString = sTranslateCharacter("y", sSubString, nChannel, iCounter, "","", "aei", " og", " OG", "ort", " uk", " UK"); break;
				case 25: sReturnString = sTranslateCharacter("z", sSubString, nChannel, iCounter, "","", "aei", " ji", " JI", "ort", " on", " ON"); break;
				case 26: sReturnString = sTranslateCharacter("A", sSubString, nChannel, iCounter, " Bä"," BÄ", "", "", "", "", "", ""); break;
				case 27: sReturnString = sTranslateCharacter("B", sSubString, nChannel, iCounter, " Og"," OG", "", "", "", "", "", ""); break;
				case 28: sReturnString = sTranslateCharacter("C", sSubString, nChannel, iCounter, " Od"," OD", "", "", "", "", "", ""); break;
				case 29: sReturnString = sTranslateCharacter("D", sSubString, nChannel, iCounter, "Ya","YA", "", "", "", "", "", ""); break;
				case 30: sReturnString = sTranslateCharacter("E", sSubString, nChannel, iCounter, " No"," NO", "", "", "", "", "", ""); break;
				case 31: sReturnString = sTranslateCharacter("F", sSubString, nChannel, iCounter, " Ta"," TA", "", "", "", "", "", ""); break;
				case 32: sReturnString = sTranslateCharacter("G", sSubString, nChannel, iCounter, " So"," SO", "", "", "", "", "", ""); break;
				case 33: sReturnString = sTranslateCharacter("H", sSubString, nChannel, iCounter, " Yu"," YU", "", "", "", "", "", ""); break;
				case 34: sReturnString = sTranslateCharacter("I", sSubString, nChannel, iCounter, " Ma"," MA", "", "", "", "", "", ""," Bi", " BI"); break;
				case 35: sReturnString = sTranslateCharacter("J", sSubString, nChannel, iCounter, " Bi"," BI", "", "", "", "", "", ""); break;
				case 36: sReturnString = sTranslateCharacter("K", sSubString, nChannel, iCounter, " On"," ON", "", "", "", "", "", ""); break;
				case 37: sReturnString = sTranslateCharacter("L", sSubString, nChannel, iCounter, " Aj"," AJ", "", "", "", "", "", ""); break;
				case 38: sReturnString = sTranslateCharacter("M", sSubString, nChannel, iCounter, " Dä"," DÄ", "", "", "", "", "", ""); break;
				case 39: sReturnString = sTranslateCharacter("N", sSubString, nChannel, iCounter, " Zu"," ZU", "", "", "", "", "", ""); break;
				case 40: sReturnString = sTranslateCharacter("O", sSubString, nChannel, iCounter, " Or"," OR", "", "", "", "", "", ""); break;
				case 41: sReturnString = sTranslateCharacter("P", sSubString, nChannel, iCounter, " Un"," UN", "", "", "", "", "", ""); break;
				case 42: sReturnString = sTranslateCharacter("Q", sSubString, nChannel, iCounter, " Te"," TE", "", "", "", "", "", ""); break;
				case 43: sReturnString = sTranslateCharacter("R", sSubString, nChannel, iCounter, " Ch"," CH", "", "", "", "", "", ""); break;
				case 44: sReturnString = sTranslateCharacter("S", sSubString, nChannel, iCounter, " Uu"," UU", "", "", "", "", "", ""); break;
				case 45: sReturnString = sTranslateCharacter("T", sSubString, nChannel, iCounter, " Ve"," VE", "", "", "", "", "", ""); break;
				case 46: sReturnString = sTranslateCharacter("U", sSubString, nChannel, iCounter, " Ge"," GE", "", "", "", "", "", ""); break;
				case 47: sReturnString = sTranslateCharacter("V", sSubString, nChannel, iCounter, " Hu"," HU", "", "", "", "", "", ""); break;
				case 48: sReturnString = sTranslateCharacter("W", sSubString, nChannel, iCounter, " Uk"," UK", "", "", "", "", "", ""); break;
				case 49: sReturnString = sTranslateCharacter("X", sSubString, nChannel, iCounter, " Kh"," KH", "", "", "", "", "", ""); break;
				case 50: sReturnString = sTranslateCharacter("Y", sSubString, nChannel, iCounter, " Ji"," JI", "", "", "", "", "", ""); break;
				case 51: sReturnString = sTranslateCharacter("Z", sSubString, nChannel, iCounter, " Do"," DO", "", "", "", "", "", ""); break;
				case 52: sReturnString = sTranslateCharacter(" ", sSubString, nChannel, iCounter, " ","", "", "", "", "", "", ""); break;
				
				default: if(sLetter=="!" || sLetter=="?" || sLetter=="."){sReturnString = sLetter;}else{sOutputString = sOutputString;} break;
			}
			if(sReturnString != "")
			{
				if(sReturnString !=  sDuplicate)
				{
					sOutputString = sOutputString + sReturnString;
					sDuplicate = sReturnString;
				}
				else
				{
					sOutputString = sOutputString;
				}
			}													
		}
	}
	return sOutputString;
}

string sOutPut_LNG_CUHANNAN(string sSubString, int nChannel, object oSender)
{
	int iSubStringLength, iTrans, iCounter;
	int iClearTextStart, iClearTextEnd;
	string sLetter, sOutputString, sClearText, sReturnString , sDuplicate;
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ";   
	sOutputString = "";
	iSubStringLength = GetStringLength(sSubString);
		
	for(iCounter=0;iCounter <= iSubStringLength; iCounter++)
	{
		sLetter = GetSubString(sSubString,iCounter,1);

		if(sLetter == "*")
		{
			if(FindSubString(sSubString, "**", iCounter)== iCounter)
			{
				iClearTextStart = iCounter +2;
				iClearTextEnd = FindSubString(sSubString," ",iClearTextStart);
			
				if(iClearTextEnd == -1)
				{
					iClearTextEnd = iSubStringLength; 
				}
				
				sClearText = GetSubString(sSubString, iClearTextStart, iClearTextEnd - iClearTextStart );
				sOutputString = sOutputString + CLR_SPACE + sClearText + CLR_SPACE;
				iCounter = iClearTextEnd; 
			}
		}
		else
		{
			iTrans = FindSubString(sTranslate, sLetter);
	
			switch (iTrans)
		   	{
				case 0: sReturnString = sTranslateCharacter("a", sSubString, nChannel, iCounter, "ho","HO", "dhilrtz", " sa", " SA", "anos", "lan", "LAN"); break;
				case 1: sReturnString = sTranslateCharacter("b", sSubString, nChannel, iCounter, "hy","HY", "dhilrtz", " ma", " MA", "anos", "qi", "QI"); break;
				case 2: sReturnString = sTranslateCharacter("c", sSubString, nChannel, iCounter, "'w","'W", "dhilrtz", " an", " AN", "anos", "'bee", "'BEE"); break;
				case 3: sReturnString = sTranslateCharacter("d", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 4: sReturnString = sTranslateCharacter("e", sSubString, nChannel, iCounter, "","", "dhilrtz", "", "", "", "", ""); break;
				case 5: sReturnString = sTranslateCharacter("f", sSubString, nChannel, iCounter, "lek","LEK", "dhilrtz", " kai", " KAI", "anos", "ho", "HO"); break;
				case 6: sReturnString = sTranslateCharacter("g", sSubString, nChannel, iCounter, "ed","ED", "dhilrtz", " ant", " ANT", "anos", "'qay", "'QAY"); break;
				case 7: sReturnString = sTranslateCharacter("h", sSubString, nChannel, iCounter, " bek"," BEK", "", "", "", "", "", ""); break;
				case 8: sReturnString = sTranslateCharacter("i", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 9: sReturnString = sTranslateCharacter("j", sSubString, nChannel, iCounter, "edd","EDD", "dhilrtz", " jay", " JAY", "anos", "ka", "KA"); break;
				case 10: sReturnString = sTranslateCharacter("k", sSubString, nChannel, iCounter, "af","AF", "dhilrtz", " aa", " AA", "anos", "'hatu", "'HATU"); break;
				case 11: sReturnString = sTranslateCharacter("l", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 12: sReturnString = sTranslateCharacter("m", sSubString, nChannel, iCounter, "aje","AJE", "dhilrtz", " esh", " ESH", "anos", "qu", "QU"); break;
				case 13: sReturnString = sTranslateCharacter("n", sSubString, nChannel, iCounter, "'ka","'KA", "dhilrtz", " tos", " TOS", "anos", "ke", "KE"); break;
				case 14: sReturnString = sTranslateCharacter("o", sSubString, nChannel, iCounter, "ja","JA", "dhilrtz", " hal", " HAL", "anos", "'du", "'DU"); break;
				case 15: sReturnString = sTranslateCharacter("p", sSubString, nChannel, iCounter, "tha","THA", "dhilrtz", " ma", " MA", "anos", "qay", "QAY"); break;
				case 16: sReturnString = sTranslateCharacter("q", sSubString, nChannel, iCounter, "shy","SHY", "dhilrtz", " lah", " LAH", "anos", "wa", "WA"); break;
				case 17: sReturnString = sTranslateCharacter("r", sSubString, nChannel, iCounter, " "," ", "", "", "", "", "", ""); break;
				case 18: sReturnString = sTranslateCharacter("s", sSubString, nChannel, iCounter, "de","DE", "dhilortz", " ay", " AY", "ans", "'la", "'LA"); break;
				case 19: sReturnString = sTranslateCharacter("t", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 20: sReturnString = sTranslateCharacter("u", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 21: sReturnString = sTranslateCharacter("v", sSubString, nChannel, iCounter, "","", "dhilrtz", " ab", " AB", "anos", "qi", "QI"); break;
				case 22: sReturnString = sTranslateCharacter("w", sSubString, nChannel, iCounter, "'e","'E", "dhilrtz", " ib", " IB", "anos", "di", "DI"); break;
				case 23: sReturnString = sTranslateCharacter("x", sSubString, nChannel, iCounter, "noa","NOA", "dhilrtz", " kam", " KAM", "anos", "wa", "WA"); break;
				case 24: sReturnString = sTranslateCharacter("y", sSubString, nChannel, iCounter, "wa","WA", "dhilrtz", " men", " MEN", "anos", "hai", "HAI"); break;
				case 25: sReturnString = sTranslateCharacter("z", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 26: sReturnString = sTranslateCharacter("A", sSubString, nChannel, iCounter, " Sa"," SA", "", "", "", "", "", ""); break;
				case 27: sReturnString = sTranslateCharacter("B", sSubString, nChannel, iCounter, " Ma"," MA", "", "", "", "", "", ""); break;
				case 28: sReturnString = sTranslateCharacter("C", sSubString, nChannel, iCounter, " An"," AN", "", "", "", "", "", ""); break;
				case 29: sReturnString = sTranslateCharacter("D", sSubString, nChannel, iCounter, " Ab"," AB", "", "", "", "", "", ""); break;
				case 30: sReturnString = sTranslateCharacter("E", sSubString, nChannel, iCounter, " Me"," ME", "", "", "", "", "", ""); break;
				case 31: sReturnString = sTranslateCharacter("F", sSubString, nChannel, iCounter, " Hai"," HAI", "", "", "", "", "", ""); break;
				case 32: sReturnString = sTranslateCharacter("G", sSubString, nChannel, iCounter, " Ta'"," TA'", "", "", "", "", "", ""); break;
				case 33: sReturnString = sTranslateCharacter("H", sSubString, nChannel, iCounter, " Aj"," AJ", "", "", "", "", "", ""); break;
				case 34: sReturnString = sTranslateCharacter("I", sSubString, nChannel, iCounter, " Ad"," AD", "", "", "", "", "", ""," Abha ", " ABHA "); break;
				case 35: sReturnString = sTranslateCharacter("J", sSubString, nChannel, iCounter, " Ja"," JA", "", "", "", "", "", ""); break;
				case 36: sReturnString = sTranslateCharacter("K", sSubString, nChannel, iCounter, " Aa"," AA", "", "", "", "", "", ""); break;
				case 37: sReturnString = sTranslateCharacter("L", sSubString, nChannel, iCounter, " Ar"," AR", "", "", "", "", "", ""); break;
				case 38: sReturnString = sTranslateCharacter("M", sSubString, nChannel, iCounter, " Esh"," ESH", "", "", "", "", "", ""); break;
				case 39: sReturnString = sTranslateCharacter("N", sSubString, nChannel, iCounter, " Tos"," TOS", "", "", "", "", "", ""); break;
				case 40: sReturnString = sTranslateCharacter("O", sSubString, nChannel, iCounter, " Hal"," HAL", "", "", "", "", "", ""); break;
				case 41: sReturnString = sTranslateCharacter("P", sSubString, nChannel, iCounter, " Ma'"," MA'", "", "", "", "", "", ""); break;
				case 42: sReturnString = sTranslateCharacter("Q", sSubString, nChannel, iCounter, " Lah"," LAH", "", "", "", "", "", ""); break;
				case 43: sReturnString = sTranslateCharacter("R", sSubString, nChannel, iCounter, " Fa"," FA", "", "", "", "", "", ""); break;
				case 44: sReturnString = sTranslateCharacter("S", sSubString, nChannel, iCounter, " Ay"," AY", "", "", "", "", "", ""); break;
				case 45: sReturnString = sTranslateCharacter("T", sSubString, nChannel, iCounter, " Ta"," TA", "", "", "", "", "", ""); break;
				case 46: sReturnString = sTranslateCharacter("U", sSubString, nChannel, iCounter, " Shi"," SHI", "", "", "", "", "", ""); break;
				case 47: sReturnString = sTranslateCharacter("V", sSubString, nChannel, iCounter, " Ab"," AB", "", "", "", "", "", ""); break;
				case 48: sReturnString = sTranslateCharacter("W", sSubString, nChannel, iCounter, " Ib"," IB", "", "", "", "", "", ""); break;
				case 49: sReturnString = sTranslateCharacter("X", sSubString, nChannel, iCounter, " Kam"," KAM", "", "", "", "", "", ""); break;
				case 50: sReturnString = sTranslateCharacter("Y", sSubString, nChannel, iCounter, " Men"," MEN", "", "", "", "", "", ""); break;
				case 51: sReturnString = sTranslateCharacter("Z", sSubString, nChannel, iCounter, " Mal"," MAL", "", "", "", "", "", ""); break;
				case 52: sReturnString = sTranslateCharacter(" ", sSubString, nChannel, iCounter, " ","", "", "", "", "", "", ""); break;
	
				default: if(sLetter=="!" || sLetter=="?" || sLetter=="."){sReturnString = sLetter;}else{sOutputString = sOutputString;} break;
			}
			if(sReturnString != "")
			{
				if(sReturnString !=  sDuplicate)
				{
					sOutputString = sOutputString + sReturnString;
					sDuplicate = sReturnString;
				}
				else
				{
					sOutputString = sOutputString;
				}
			}													
		}
	}
	return sOutputString;
}

string sOutPut_LNG_KAOLISK(string sSubString, int nChannel, object oSender)
{
	int iSubStringLength, iTrans, iCounter;
	int iClearTextStart, iClearTextEnd;
	string sLetter, sOutputString, sClearText, sReturnString , sDuplicate;
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ";    
	sOutputString = "";
	iSubStringLength = GetStringLength(sSubString);
		
	for(iCounter=0;iCounter <= iSubStringLength; iCounter++)
	{
		sLetter = GetSubString(sSubString,iCounter,1);

		if(sLetter == "*")
		{
			if(FindSubString(sSubString, "**", iCounter)== iCounter)
			{
				iClearTextStart = iCounter +2;
				iClearTextEnd = FindSubString(sSubString," ",iClearTextStart);
			
				if(iClearTextEnd == -1)
				{
					iClearTextEnd = iSubStringLength; 
				}
				
				sClearText = GetSubString(sSubString, iClearTextStart, iClearTextEnd - iClearTextStart );
				sOutputString = sOutputString + CLR_SPACE + sClearText + CLR_SPACE;
				iCounter = iClearTextEnd; 
			}
		}
		else
		{
			iTrans = FindSubString(sTranslate, sLetter);
	
			switch (iTrans)
		   	{
				case 0: sReturnString = sTranslateCharacter("a", sSubString, nChannel, iCounter, "","", "diotv", " fi", " FI", "enruz", " fú", " FÚ"); break;
				case 1: sReturnString = sTranslateCharacter("b", sSubString, nChannel, iCounter, "án","ÁN", "diotv", " kâ", " KÂ", "enruz", " sâ", " SÂ"); break;
				case 2: sReturnString = sTranslateCharacter("c", sSubString, nChannel, iCounter, "nâ","NÂ", "diotv", " ss", " SS", "enruz", " hî", " HÎ"); break;
				case 3: sReturnString = sTranslateCharacter("d", sSubString, nChannel, iCounter, "","", "diotvenruz", "ka", "KA", "", "", ""); break;
				case 4: sReturnString = sTranslateCharacter("e", sSubString, nChannel, iCounter, "","", "diotv", "s's", "S'S", "enruz", "æz", "ÆZ"); break;
				case 5: sReturnString = sTranslateCharacter("f", sSubString, nChannel, iCounter, "l","L", "diotv", " fu", " FU", "enruz", " ks", " KS"); break;
				case 6: sReturnString = sTranslateCharacter("g", sSubString, nChannel, iCounter, "","", "diotv", " sâ", " SÂ", "enruz", " má", " MÁ"); break;
				case 7: sReturnString = sTranslateCharacter("h", sSubString, nChannel, iCounter, "","", "diotvenruz", " ki", " KI", "", "", ""); break;
				case 8: sReturnString = sTranslateCharacter("i", sSubString, nChannel, iCounter, "","", "diotvenruz", "pa", "PA", "", "", ""); break;
				case 9: sReturnString = sTranslateCharacter("j", sSubString, nChannel, iCounter, "ez","EZ", "diotv", " fa", " FA", "enruz", " hu", " HU"); break;
				case 10: sReturnString = sTranslateCharacter("k", sSubString, nChannel, iCounter, "ne","NE", "diotv", " le", " LE", "enruz", " fs", " FS"); break;
				case 11: sReturnString = sTranslateCharacter("l", sSubString, nChannel, iCounter, "kæ","KÆ", "diotvenruz", " ká", " KÁ", "", "", ""); break;
				case 12: sReturnString = sTranslateCharacter("m", sSubString, nChannel, iCounter, "æs","ÆS", "diotv", " fæ", " FÆ", "enruz", " fú", " FÚ"); break;
				case 13: sReturnString = sTranslateCharacter("n", sSubString, nChannel, iCounter, "","", "diotvenruz", "is", "IS", "", "", ""); break;
				case 14: sReturnString = sTranslateCharacter("o", sSubString, nChannel, iCounter, "","", "diotvenruz", "æs ", "ÆS ", "", "", ""); break;
				case 15: sReturnString = sTranslateCharacter("p", sSubString, nChannel, iCounter, "âh","ÂH", "diotv", " ks", " KS", "enruz", " hu", " HU"); break;
				case 16: sReturnString = sTranslateCharacter("q", sSubString, nChannel, iCounter, "i","I", "diotv", " mâ", " MÂ", "enruz", " fs", " FS"); break;
				case 17: sReturnString = sTranslateCharacter("r", sSubString, nChannel, iCounter, "","", "diotvenruz", "nâ", "NÂ", "", "", ""); break;
				case 18: sReturnString = sTranslateCharacter("s", sSubString, nChannel, iCounter, "s's","S'S", "diotv", " ps", " PS", "enruz", " sâ", " SÂ"); break;
				case 19: sReturnString = sTranslateCharacter("t", sSubString, nChannel, iCounter, "","", "diotvenruz", "s", "S", "", "", ""); break;
				case 20: sReturnString = sTranslateCharacter("u", sSubString, nChannel, iCounter, "","", "diotvenruz", "hâ", "HÂ", "", "", ""); break;
				case 21: sReturnString = sTranslateCharacter("v", sSubString, nChannel, iCounter, "","", "diotv", " hu", " HU", "enruz", " s's", " S'S"); break;
				case 22: sReturnString = sTranslateCharacter("w", sSubString, nChannel, iCounter, "hâ","HÂ", "diotv", " fz", " FZ", "enruz", " ps", " PS"); break;
				case 23: sReturnString = sTranslateCharacter("x", sSubString, nChannel, iCounter, "ki","KI", "diotv", " hî", " HÎ", "enruz", " kâ", " KÂ"); break;
				case 24: sReturnString = sTranslateCharacter("y", sSubString, nChannel, iCounter, "l","L", "diotv", "hâ", "HÂ", "enruz", " ma", " MA"); break;
				case 25: sReturnString = sTranslateCharacter("z", sSubString, nChannel, iCounter, "","", "diotvenruz", "æ", "Æ", "", "", ""); break;
				case 26: sReturnString = sTranslateCharacter("A", sSubString, nChannel, iCounter, " Fi"," FI", "", "", "", "", "", ""); break;
				case 27: sReturnString = sTranslateCharacter("B", sSubString, nChannel, iCounter, " Ka"," KA", "", "", "", "", "", ""); break;
				case 28: sReturnString = sTranslateCharacter("C", sSubString, nChannel, iCounter, " Ss"," SS", "", "", "", "", "", ""); break;
				case 29: sReturnString = sTranslateCharacter("D", sSubString, nChannel, iCounter, " P'z"," P'Z", "", "", "", "", "", ""); break;
				case 30: sReturnString = sTranslateCharacter("E", sSubString, nChannel, iCounter, " Kâ"," KÂ", "", "", "", "", "", ""); break;
				case 31: sReturnString = sTranslateCharacter("F", sSubString, nChannel, iCounter, " Fu"," FU", "", "", "", "", "", ""); break;
				case 32: sReturnString = sTranslateCharacter("G", sSubString, nChannel, iCounter, " Zâ"," ZÂ", "", "", "", "", "", ""); break;
				case 33: sReturnString = sTranslateCharacter("H", sSubString, nChannel, iCounter, " Ki"," KI", "", "", "", "", "", ""); break;
				case 34: sReturnString = sTranslateCharacter("I", sSubString, nChannel, iCounter, " Pa"," PA", "", "", "", "", "", "null","null"); break;
				case 35: sReturnString = sTranslateCharacter("J", sSubString, nChannel, iCounter, " Faa"," FAA", "", "", "", "", "", ""); break;
				case 36: sReturnString = sTranslateCharacter("K", sSubString, nChannel, iCounter, " Le"," LE", "", "", "", "", "", ""); break;
				case 37: sReturnString = sTranslateCharacter("L", sSubString, nChannel, iCounter, " Kà"," KÀ", "", "", "", "", "", ""); break;
				case 38: sReturnString = sTranslateCharacter("M", sSubString, nChannel, iCounter, " Fæ"," FÆ", "", "", "", "", "", ""); break;
				case 39: sReturnString = sTranslateCharacter("N", sSubString, nChannel, iCounter, " Is"," IS", "", "", "", "", "", ""); break;
				case 40: sReturnString = sTranslateCharacter("O", sSubString, nChannel, iCounter, " Æs"," ÆS", "", "", "", "", "", ""); break;
				case 41: sReturnString = sTranslateCharacter("P", sSubString, nChannel, iCounter, " K's"," K'S", "", "", "", "", "", ""); break;
				case 42: sReturnString = sTranslateCharacter("Q", sSubString, nChannel, iCounter, " Ma"," MA", "", "", "", "", "", ""); break;
				case 43: sReturnString = sTranslateCharacter("R", sSubString, nChannel, iCounter, " S's"," S'S", "", "", "", "", "", ""); break;
				case 44: sReturnString = sTranslateCharacter("S", sSubString, nChannel, iCounter, " P's"," P'S", "", "", "", "", "", ""); break;
				case 45: sReturnString = sTranslateCharacter("T", sSubString, nChannel, iCounter, " Kâ"," KÂ", "", "", "", "", "", ""); break;
				case 46: sReturnString = sTranslateCharacter("U", sSubString, nChannel, iCounter, " Ma"," MA", "", "", "", "", "", ""); break;
				case 47: sReturnString = sTranslateCharacter("V", sSubString, nChannel, iCounter, " Hu"," HU", "", "", "", "", "", ""); break;
				case 48: sReturnString = sTranslateCharacter("W", sSubString, nChannel, iCounter, " Fs"," FS", "", "", "", "", "", ""); break;
				case 49: sReturnString = sTranslateCharacter("X", sSubString, nChannel, iCounter, " Hî"," HÎ", "", "", "", "", "", ""); break;
				case 50: sReturnString = sTranslateCharacter("Y", sSubString, nChannel, iCounter, " Hu"," HU", "", "", "", "", "", ""); break;
				case 51: sReturnString = sTranslateCharacter("Z", sSubString, nChannel, iCounter, " Ps"," PS", "", "", "", "", "", ""); break;
				case 52: sReturnString = sTranslateCharacter(" ", sSubString, nChannel, iCounter, " ","", "", "", "", "", "", ""); break;
	
				default: if(sLetter=="!" || sLetter=="?" || sLetter=="."){sReturnString = sLetter;}else{sOutputString = sOutputString;} break;
			}
			if(sReturnString != "")
			{
				if(sReturnString !=  sDuplicate)
				{
					sOutputString = sOutputString + sReturnString;
					sDuplicate = sReturnString;
				}
				else
				{
					sOutputString = sOutputString;
				}
			}													
		}
	}
	return sOutputString;
}

string sOutPut_LNG_EXODONIAN(string sSubString, int nChannel, object oSender)
{
	int iSubStringLength, iTrans, iCounter;
	int iClearTextStart, iClearTextEnd;
	string sLetter, sOutputString, sClearText, sReturnString , sDuplicate;
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ";    
	sOutputString = "";
	iSubStringLength = GetStringLength(sSubString);
		
	for(iCounter=0;iCounter <= iSubStringLength; iCounter++)
	{
		sLetter = GetSubString(sSubString,iCounter,1);

		if(sLetter == "*")
		{
			if(FindSubString(sSubString, "**", iCounter)== iCounter)
			{
				iClearTextStart = iCounter +2;
				iClearTextEnd = FindSubString(sSubString," ",iClearTextStart);
			
				if(iClearTextEnd == -1)
				{
					iClearTextEnd = iSubStringLength; 
				}
				
				sClearText = GetSubString(sSubString, iClearTextStart, iClearTextEnd - iClearTextStart );
				sOutputString = sOutputString + CLR_SPACE + sClearText + CLR_SPACE;
				iCounter = iClearTextEnd;
			}
		}
		else
		{
			iTrans = FindSubString(sTranslate, sLetter);
	
			switch (iTrans)
		   	{
				case 0: sReturnString = sTranslateCharacter("a", sSubString, nChannel, iCounter, "","", "m", "h'", "H'", "", "", ""); break;
				case 1: sReturnString = sTranslateCharacter("b", sSubString, nChannel, iCounter, "n","N", "adhlotyz", " as", " AS", "eims", "", ""); break;
				case 2: sReturnString = sTranslateCharacter("c", sSubString, nChannel, iCounter, "a","A", "adhlotyz", " at", " AT", "eims", " lu", " LU"); break;
				case 3: sReturnString = sTranslateCharacter("d", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 4: sReturnString = sTranslateCharacter("e", sSubString, nChannel, iCounter, "da","DA", "adhlotyz", " an", " AN", "eims", "-wa", "-WA"); break;
				case 5: sReturnString = sTranslateCharacter("f", sSubString, nChannel, iCounter, "h","H", "adhlotyz", " na", " NA", "eims", "hi", "HI"); break;
				case 6: sReturnString = sTranslateCharacter("g", sSubString, nChannel, iCounter, "ha'","HA'", "adhlotyz", " ma'", " MA'", "eims", "wa", "WA"); break;
				case 7: sReturnString = sTranslateCharacter("h", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 8: sReturnString = sTranslateCharacter("i", sSubString, nChannel, iCounter, "es","ES", "adhlotyz", " bi", " BI", "eims", "", ""); break;
				case 9: sReturnString = sTranslateCharacter("j", sSubString, nChannel, iCounter, "sh","SH", "adhlotyz", " le", " LE", "eims", "es", "ES"); break;
				case 10: sReturnString = sTranslateCharacter("k", sSubString, nChannel, iCounter, "y","Y", "adhlotyz", " az", " AZ", "eims", "", ""); break;
				case 11: sReturnString = sTranslateCharacter("l", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 12: sReturnString = sTranslateCharacter("m", sSubString, nChannel, iCounter, "Ta","TA", "adhlotyz", " ko'", " KO'", "eims", "ih", "IH"); break;
				case 13: sReturnString = sTranslateCharacter("n", sSubString, nChannel, iCounter, "nai","NAI", "dhlotyz", " lo", " LO", "eims", "-da", "-DA"); break;
				case 14: sReturnString = sTranslateCharacter("o", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 15: sReturnString = sTranslateCharacter("p", sSubString, nChannel, iCounter, "a'e","A'E", "adhlotyz", " al", " AL", "eims", "", ""); break;
				case 16: sReturnString = sTranslateCharacter("q", sSubString, nChannel, iCounter, "iz","IZ", "adhlotyz", " tl'", " TL'", "eims", "d'd", "D'D"); break;
				case 17: sReturnString = sTranslateCharacter("r", sSubString, nChannel, iCounter, "aa'","AA'", "adhlotyz", " ya", " YA", "eims", "", ""); break;
				case 18: sReturnString = sTranslateCharacter("s", sSubString, nChannel, iCounter, "o'","O'", "adhlotyz", " li", " LI", "eims", "", ""); break;
				case 19: sReturnString = sTranslateCharacter("t", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 20: sReturnString = sTranslateCharacter("u", sSubString, nChannel, iCounter, "ed","ED", "adhlotyz", "am", "AM", "eims", "", ""); break;
				case 21: sReturnString = sTranslateCharacter("v", sSubString, nChannel, iCounter, "he'","HE'", "adhlotyz", " jo", " JO", "eims", "", ""); break;
				case 22: sReturnString = sTranslateCharacter("w", sSubString, nChannel, iCounter, "kii","KII", "adhlotyz", " to", " TO", "eims", "", ""); break;
				case 23: sReturnString = sTranslateCharacter("x", sSubString, nChannel, iCounter, "za","ZA", "adhlotyz", " ao", " AO", "eims", "", ""); break;
				case 24: sReturnString = sTranslateCharacter("y", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 25: sReturnString = sTranslateCharacter("z", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 26: sReturnString = sTranslateCharacter("A", sSubString, nChannel, iCounter, " As"," AS", "", "", "", "", "", ""); break;
				case 27: sReturnString = sTranslateCharacter("B", sSubString, nChannel, iCounter, " At"," AT", "", "", "", "", "", ""); break;
				case 28: sReturnString = sTranslateCharacter("C", sSubString, nChannel, iCounter, " Am"," AM", "", "", "", "", "", ""); break;
				case 29: sReturnString = sTranslateCharacter("D", sSubString, nChannel, iCounter, " An"," AN", "", "", "", "", "", ""); break;
				case 30: sReturnString = sTranslateCharacter("E", sSubString, nChannel, iCounter, " Na"," NA", "", "", "", "", "", ""); break;
				case 31: sReturnString = sTranslateCharacter("F", sSubString, nChannel, iCounter, " Ma'"," MA'", "", "", "", "", "", ""); break;
				case 32: sReturnString = sTranslateCharacter("G", sSubString, nChannel, iCounter, " Di"," DI", "", "", "", "", "", ""); break;
				case 33: sReturnString = sTranslateCharacter("H", sSubString, nChannel, iCounter, " Bi"," BI", "", "", "", "", "", ""); break;
				case 34: sReturnString = sTranslateCharacter("I", sSubString, nChannel, iCounter, " Le"," LE", "", "", "", "", "", "","naq ", "NAQ "); break;
				case 35: sReturnString = sTranslateCharacter("J", sSubString, nChannel, iCounter, " Az"," AZ", "", "", "", "", "", ""); break;
				case 36: sReturnString = sTranslateCharacter("K", sSubString, nChannel, iCounter, " Do"," DO", "", "", "", "", "", ""); break;
				case 37: sReturnString = sTranslateCharacter("L", sSubString, nChannel, iCounter, " Ko'"," KO'", "", "", "", "", "", ""); break;
				case 38: sReturnString = sTranslateCharacter("M", sSubString, nChannel, iCounter, " Ha"," HA", "", "", "", "", "", ""); break;
				case 39: sReturnString = sTranslateCharacter("N", sSubString, nChannel, iCounter, " Si"," SI", "", "", "", "", "", ""); break;
				case 40: sReturnString = sTranslateCharacter("O", sSubString, nChannel, iCounter, " Al"," AL", "", "", "", "", "", ""); break;
				case 41: sReturnString = sTranslateCharacter("P", sSubString, nChannel, iCounter, " Tl'"," TL'", "", "", "", "", "", ""); break;
				case 42: sReturnString = sTranslateCharacter("Q", sSubString, nChannel, iCounter, " Ya"," YA", "", "", "", "", "", ""); break;
				case 43: sReturnString = sTranslateCharacter("R", sSubString, nChannel, iCounter, " Li"," LI", "", "", "", "", "", ""); break;
				case 44: sReturnString = sTranslateCharacter("S", sSubString, nChannel, iCounter, " At'"," AT'", "", "", "", "", "", ""); break;
				case 45: sReturnString = sTranslateCharacter("T", sSubString, nChannel, iCounter, " Ah"," AH", "", "", "", "", "", ""); break;
				case 46: sReturnString = sTranslateCharacter("U", sSubString, nChannel, iCounter, " Jo"," JO", "", "", "", "", "", ""); break;
				case 47: sReturnString = sTranslateCharacter("V", sSubString, nChannel, iCounter, " To"," TO", "", "", "", "", "", ""); break;
				case 48: sReturnString = sTranslateCharacter("W", sSubString, nChannel, iCounter, " Ao"," AO", "", "", "", "", "", ""); break;
				case 49: sReturnString = sTranslateCharacter("X", sSubString, nChannel, iCounter, " Ho"," HO", "", "", "", "", "", ""); break;
				case 50: sReturnString = sTranslateCharacter("Y", sSubString, nChannel, iCounter, " Ch"," CH", "", "", "", "", "", ""); break;
				case 51: sReturnString = sTranslateCharacter("Z", sSubString, nChannel, iCounter, " Lu"," LU", "", "", "", "", "", ""); break;
				case 52: sReturnString = sTranslateCharacter(" ", sSubString, nChannel, iCounter, " ","", "", "", "", "", "", ""); break;
			
				default: if(sLetter=="!" || sLetter=="?" || sLetter=="."){sReturnString = sLetter;}else{sOutputString = sOutputString;} break;
			}
			if(sReturnString != "")
			{
				if(sReturnString !=  sDuplicate)
				{
					sOutputString = sOutputString + sReturnString;
					sDuplicate = sReturnString;
				}
				else
				{
					sOutputString = sOutputString;
				}
			}													
		}
	}
	return sOutputString;
}

string sOutPut_LNG_DAWN_TONGUE(string sSubString, int nChannel, object oSender)
{
	int iSubStringLength, iTrans, iCounter;
	int iClearTextStart, iClearTextEnd;
	string sLetter, sOutputString, sClearText, sReturnString , sDuplicate;
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ";	
	sOutputString = "";
	iSubStringLength = GetStringLength(sSubString);
		
	for(iCounter=0;iCounter <= iSubStringLength; iCounter++)
	{
		sLetter = GetSubString(sSubString,iCounter,1);

		if(sLetter == "*")
		{
			if(FindSubString(sSubString, "**", iCounter)== iCounter)
			{
				iClearTextStart = iCounter +2;
				iClearTextEnd = FindSubString(sSubString," ",iClearTextStart);
			
				if(iClearTextEnd == -1)
				{
					iClearTextEnd = iSubStringLength; 
				}
				
				sClearText = GetSubString(sSubString, iClearTextStart, iClearTextEnd - iClearTextStart );
				sOutputString = sOutputString + CLR_SPACE + sClearText + CLR_SPACE;
				iCounter = iClearTextEnd; 
			}
		}
		else
		{
			iTrans = FindSubString(sTranslate, sLetter);
	
			switch (iTrans)
		   	{
				case 0: sReturnString = sTranslateCharacter("a", sSubString, nChannel, iCounter, "","", "hiotwe", "pa ", "PA ", "", "", ""); break;
				case 1: sReturnString = sTranslateCharacter("b", sSubString, nChannel, iCounter, "im","IM", "ahlnstz", "deo", "DEO", "ceimorwy", "um", "UM"); break;
				case 2: sReturnString = sTranslateCharacter("c", sSubString, nChannel, iCounter, "","", "hiotwe", "em ", "EM ", "", "", ""); break;
				case 3: sReturnString = sTranslateCharacter("d", sSubString, nChannel, iCounter, "ti","TI", "ahlnstz", "re", "RE", "ceimorwy", "ab", "AB"); break;
				case 4: sReturnString = sTranslateCharacter("e", sSubString, nChannel, iCounter, "","", "hiotw", "ium ", "IUM ", "m", "mu", "MU"); break;
				case 5: sReturnString = sTranslateCharacter("f", sSubString, nChannel, iCounter, "os","OS", "ahlnstz", "ti", "TI", "ceimorwy", "or", "OR"); break;
				case 6: sReturnString = sTranslateCharacter("g", sSubString, nChannel, iCounter, "ed","ED", "ahlnstz", "reo", "REO", "ceimorwy", "neo", "NEO"); break;
				case 7: sReturnString = sTranslateCharacter("h", sSubString, nChannel, iCounter, "","", "hiotwe", "om ", "OM ", "", "", ""); break;
				case 8: sReturnString = sTranslateCharacter("i", sSubString, nChannel, iCounter, "","", "hiotwe", "en ", "EN ", "", "", ""); break;
				case 9: sReturnString = sTranslateCharacter("j", sSubString, nChannel, iCounter, "ss","SS", "ahlnstz", "ma", "MA", "ceimorwy", "es", "ES"); break;
				case 10: sReturnString = sTranslateCharacter("k", sSubString, nChannel, iCounter, "ci","CI", "ahlnstz", "in", "IN", "ceimorwy", "ha", "HA"); break;
				case 11: sReturnString = sTranslateCharacter("l", sSubString, nChannel, iCounter, "","", "hiotwe", "lum ", "LUM ", "", "", ""); break;
				case 12: sReturnString = sTranslateCharacter("m", sSubString, nChannel, iCounter, "","", "ahlnstz", "nn", "NN", "ceimorwy", "or", "OR"); break;
				case 13: sReturnString = sTranslateCharacter("n", sSubString, nChannel, iCounter, "","", "hiotwe", "est ", "EST ", "", "", ""); break;
				case 14: sReturnString = sTranslateCharacter("o", sSubString, nChannel, iCounter, "","", "hiote", "equ", "EQU", "w", "ius ", "IUS "); break;
				case 15: sReturnString = sTranslateCharacter("p", sSubString, nChannel, iCounter, "rt","RT", "ahlnstz", "reo", "REO", "ceimorwy", "on", "ON"); break;
				case 16: sReturnString = sTranslateCharacter("q", sSubString, nChannel, iCounter, "re","RE", "ahlnstz", "vo ", "VO ", "ceimorwy", "sub", "SUB"); break;
				case 17: sReturnString = sTranslateCharacter("r", sSubString, nChannel, iCounter, "","", "hiotw", "a", "A", "", "", ""); break;
				case 18: sReturnString = sTranslateCharacter("s", sSubString, nChannel, iCounter, "","", "hiotwe", "eo ", "EO ", " ", " gl", " GL"); break;
				case 19: sReturnString = sTranslateCharacter("t", sSubString, nChannel, iCounter, "","", "hiotwe", "ri ", "RI ", "", "", ""); break;
				case 20: sReturnString = sTranslateCharacter("u", sSubString, nChannel, iCounter, "po","PO", "ahlnstz", "um", "UM", "ceimorwy", "it", "IT"); break;
				case 21: sReturnString = sTranslateCharacter("v", sSubString, nChannel, iCounter, "cu","CU", "ahlnstz", "ex", "EX", "ceimorwy", "pa", "PA"); break;
				case 22: sReturnString = sTranslateCharacter("w", sSubString, nChannel, iCounter, "","", "hiotwe", "lo ", "LO ", "sS", "ad", "AD"); break;
				case 23: sReturnString = sTranslateCharacter("x", sSubString, nChannel, iCounter, "me","ME", "ahlnstz", "ti", "TI", "ceimorwy", "mu", "MU"); break;
				case 24: sReturnString = sTranslateCharacter("y", sSubString, nChannel, iCounter, "","", "hiotwe", "tu ", "TU ", "", "", ""); break;
				case 25: sReturnString = sTranslateCharacter("z", sSubString, nChannel, iCounter, "","", "hiotwe", "est ", "EST ", "", "", ""); break;
				case 26: sReturnString = sTranslateCharacter("A", sSubString, nChannel, iCounter, " Gr"," GR", "", "", "", "", "", ""); break;
				case 27: sReturnString = sTranslateCharacter("B", sSubString, nChannel, iCounter, " Re"," RE", "", "", "", "", "", ""); break;
				case 28: sReturnString = sTranslateCharacter("C", sSubString, nChannel, iCounter, " Ti"," TI", "", "", "", "", "", ""); break;
				case 29: sReturnString = sTranslateCharacter("D", sSubString, nChannel, iCounter, " Reo"," REO", "", "", "", "", "", ""); break;
				case 30: sReturnString = sTranslateCharacter("E", sSubString, nChannel, iCounter, " Inv"," INV", "", "", "", "", "", ""); break;
				case 31: sReturnString = sTranslateCharacter("F", sSubString, nChannel, iCounter, " Im"," IM", "", "", "", "", "", ""); break;
				case 32: sReturnString = sTranslateCharacter("G", sSubString, nChannel, iCounter, " Et"," ET", "", "", "", "", "", ""); break;
				case 33: sReturnString = sTranslateCharacter("H", sSubString, nChannel, iCounter, " Fo"," FO", "", "", "", "", "", ""); break;
				case 34: sReturnString = sTranslateCharacter("I", sSubString, nChannel, iCounter, "Li","LI", "", "", "", "", "", ""," Deo ", " DEO "); break;
				case 35: sReturnString = sTranslateCharacter("J", sSubString, nChannel, iCounter, " Fr"," FR", "", "", "", "", "", ""); break;
				case 36: sReturnString = sTranslateCharacter("K", sSubString, nChannel, iCounter, " No"," NO", "", "", "", "", "", ""); break;
				case 37: sReturnString = sTranslateCharacter("L", sSubString, nChannel, iCounter, " Ex"," EX", "", "", "", "", "", ""); break;
				case 38: sReturnString = sTranslateCharacter("M", sSubString, nChannel, iCounter, " Ti"," TI", "", "", "", "", "", ""); break;
				case 39: sReturnString = sTranslateCharacter("N", sSubString, nChannel, iCounter, " Um"," UM", "", "", "", "", "", ""); break;
				case 40: sReturnString = sTranslateCharacter("O", sSubString, nChannel, iCounter, " Di"," DI", "", "", "", "", "", ""); break;
				case 41: sReturnString = sTranslateCharacter("P", sSubString, nChannel, iCounter, " Ab"," AB", "", "", "", "", "", ""); break;
				case 42: sReturnString = sTranslateCharacter("Q", sSubString, nChannel, iCounter, "Or","OR", "", "", "", "", "", ""); break;
				case 43: sReturnString = sTranslateCharacter("R", sSubString, nChannel, iCounter, " Es"," ES", "", "", "", "", "", ""); break;
				case 44: sReturnString = sTranslateCharacter("S", sSubString, nChannel, iCounter, " Gl"," GL", "", "", "", "", "", ""); break;
				case 45: sReturnString = sTranslateCharacter("T", sSubString, nChannel, iCounter, " Or"," OR", "", "", "", "", "", ""); break;
				case 46: sReturnString = sTranslateCharacter("U", sSubString, nChannel, iCounter, " On"," ON", "", "", "", "", "", ""); break;
				case 47: sReturnString = sTranslateCharacter("V", sSubString, nChannel, iCounter, " Sub"," SUB", "", "", "", "", "", ""); break;
				case 48: sReturnString = sTranslateCharacter("W", sSubString, nChannel, iCounter, " It"," IT", "", "", "", "", "", ""); break;
				case 49: sReturnString = sTranslateCharacter("X", sSubString, nChannel, iCounter, " Gr"," GR", "", "", "", "", "", ""); break;
				case 50: sReturnString = sTranslateCharacter("Y", sSubString, nChannel, iCounter, " Co"," CO", "", "", "", "", "", ""); break;
				case 51: sReturnString = sTranslateCharacter("Z", sSubString, nChannel, iCounter, " Gl"," GL", "", "", "", "", "", ""); break;
				case 52: sReturnString = sTranslateCharacter(" ", sSubString, nChannel, iCounter, " ","", "", "", "", "", "", ""); break;
	
				default: if(sLetter=="!" || sLetter=="?" || sLetter=="."){sReturnString = sLetter;}else{sOutputString = sOutputString;} break;
			}
			if(sReturnString != "")
			{
				if(sReturnString !=  sDuplicate)
				{
					sOutputString = sOutputString + sReturnString;
					sDuplicate = sReturnString;
				}
				else
				{
					sOutputString = sOutputString;
				}
			}	
		}
	}
	return sOutputString;
}

string sOutPut_LNG_FIENDISH(string sSubString, int nChannel, object oSender)
{
	int iSubStringLength, iTrans, iCounter;
	int iClearTextStart, iClearTextEnd;
	string sLetter, sOutputString, sClearText, sReturnString , sDuplicate;
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ";    
	sOutputString = "";
	iSubStringLength = GetStringLength(sSubString);
		
	for(iCounter=0;iCounter <= iSubStringLength; iCounter++)
	{
		sLetter = GetSubString(sSubString,iCounter,1);

		if(sLetter == "*")
		{
			if(FindSubString(sSubString, "**", iCounter)== iCounter)
			{
				iClearTextStart = iCounter +2;
				iClearTextEnd = FindSubString(sSubString," ",iClearTextStart);
			
				if(iClearTextEnd == -1)
				{
					iClearTextEnd = iSubStringLength; 
				}
				
				sClearText = GetSubString(sSubString, iClearTextStart, iClearTextEnd - iClearTextStart );
				sOutputString = sOutputString + CLR_SPACE + sClearText + CLR_SPACE;
				iCounter = iClearTextEnd; 
			}
		}
		else
		{
			iTrans = FindSubString(sTranslate, sLetter);
	
			switch (iTrans)
		   	{
				case 0: sReturnString = sTranslateCharacter("a", sSubString, nChannel, iCounter, "l","L", "elotm", " k'a", " K'A", "ahnrs", "q'a", "Q'A"); break;
				case 1: sReturnString = sTranslateCharacter("b", sSubString, nChannel, iCounter, "ni","NI", "elotm", " él", " ÉL", "ahnrs", "wa", "WA"); break;
				case 2: sReturnString = sTranslateCharacter("c", sSubString, nChannel, iCounter, "ill","ILL", "elotm", " ko", " KO", "ahnrs", "in", "IN"); break;
				case 3: sReturnString = sTranslateCharacter("d", sSubString, nChannel, iCounter, "ne","NE", "elotm", " rû", " RÛ", "ahnrs", "he", "HE"); break;
				case 4: sReturnString = sTranslateCharacter("e", sSubString, nChannel, iCounter, "","", "l", " gû", " GÛ", "n", "rim", "RIM"); break;
				case 5: sReturnString = sTranslateCharacter("f", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 6: sReturnString = sTranslateCharacter("g", sSubString, nChannel, iCounter, "th","TH", "elotm", " lá", " LÁ", "ahnrs", "vâr", "VÂR"); break;
				case 7: sReturnString = sTranslateCharacter("h", sSubString, nChannel, iCounter, "rén","RÉN", "elotm", " me", " ME", "ahnrs", "ûr", "ÛR"); break;
				case 8: sReturnString = sTranslateCharacter("i", sSubString, nChannel, iCounter, "","", "ahnrs", "m-â", "M-Â", "vV", "tél", "TÉL"); break;
				case 9: sReturnString = sTranslateCharacter("j", sSubString, nChannel, iCounter, "esse","ESSE", "elotm", " cû", " CÛ", "ahnrs", "ll", "LL"); break;
				case 10: sReturnString = sTranslateCharacter("k", sSubString, nChannel, iCounter, "wá","WÁ", "elotm", " fa", " FA", "ahnrs", "ma", "MA"); break;
				case 11: sReturnString = sTranslateCharacter("l", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 12: sReturnString = sTranslateCharacter("m", sSubString, nChannel, iCounter, "","", "ahnrs", "-rim", "-RIM", "", "", ""); break;
				case 13: sReturnString = sTranslateCharacter("n", sSubString, nChannel, iCounter, "th","TH", "elotm", " na", " NA", "ahnrs", "ér", "ÉR"); break;
				case 14: sReturnString = sTranslateCharacter("o", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 15: sReturnString = sTranslateCharacter("p", sSubString, nChannel, iCounter, "ya","YA", "elotm", " bi", " BI", "ahnrs", "oh", "OH"); break;
				case 16: sReturnString = sTranslateCharacter("q", sSubString, nChannel, iCounter, "dur","DUR", "elotm", " mâ", " MÂ", "ahnrs", "th", "TH"); break;
				case 17: sReturnString = sTranslateCharacter("r", sSubString, nChannel, iCounter, "ár","ÁR", "elotm", " ho", " HO", "ahnrs", "it", "IT"); break;
				case 18: sReturnString = sTranslateCharacter("s", sSubString, nChannel, iCounter, "on","ON", "elotm", " lir", " LIR", "ahnrs", "hû", "HÛ"); break;
				case 19: sReturnString = sTranslateCharacter("t", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 20: sReturnString = sTranslateCharacter("u", sSubString, nChannel, iCounter, "qu","QU", "elotm", " he", " HE", "ahnrs", "pa", "PA"); break;
				case 21: sReturnString = sTranslateCharacter("v", sSubString, nChannel, iCounter, "er","ER", "elotm", " er", " ER", "ahnrs", "t", "T"); break;
				case 22: sReturnString = sTranslateCharacter("w", sSubString, nChannel, iCounter, "qo","QO", "elotm", "t'i", "T'I", "ahnrs", "ezze", "EZZE"); break;
				case 23: sReturnString = sTranslateCharacter("x", sSubString, nChannel, iCounter, "ce","CE", "elotm", " ça", " ÇA", "ahnrs", "zi", "ZI"); break;
				case 24: sReturnString = sTranslateCharacter("y", sSubString, nChannel, iCounter, "","", "hnrs", "-", "-", "", "", ""); break;
				case 25: sReturnString = sTranslateCharacter("z", sSubString, nChannel, iCounter, "zt","ZT", "elotm", " oh", " OH", "ahnrs", "th", "TH"); break;
				case 26: sReturnString = sTranslateCharacter("A", sSubString, nChannel, iCounter, " Qu"," QU", "", "", "", "", "", ""); break;
				case 27: sReturnString = sTranslateCharacter("B", sSubString, nChannel, iCounter, " Ál"," ÁL", "", "", "", "", "", ""); break;
				case 28: sReturnString = sTranslateCharacter("C", sSubString, nChannel, iCounter, " Ho"," HO", "", "", "", "", "", ""); break;
				case 29: sReturnString = sTranslateCharacter("D", sSubString, nChannel, iCounter, " Ro"," RO", "", "", "", "", "", ""); break;
				case 30: sReturnString = sTranslateCharacter("E", sSubString, nChannel, iCounter, " Ç"," Ç", "", "", "", "", "", ""); break;
				case 31: sReturnString = sTranslateCharacter("F", sSubString, nChannel, iCounter, " Sî"," SÎ", "", "", "", "", "", ""); break;
				case 32: sReturnString = sTranslateCharacter("G", sSubString, nChannel, iCounter, " Lá"," LÁ", "", "", "", "", "", ""); break;
				case 33: sReturnString = sTranslateCharacter("H", sSubString, nChannel, iCounter, " Ho"," HO", "", "", "", "", "", ""); break;
				case 34: sReturnString = sTranslateCharacter("I", sSubString, nChannel, iCounter, " Mê"," MÊ", "", "", "", "", "", "","tén ", "TÊN "); break;
				case 35: sReturnString = sTranslateCharacter("J", sSubString, nChannel, iCounter, " Cu"," CU", "", "", "", "", "", ""); break;
				case 36: sReturnString = sTranslateCharacter("K", sSubString, nChannel, iCounter, " Fa"," FA", "", "", "", "", "", ""); break;
				case 37: sReturnString = sTranslateCharacter("L", sSubString, nChannel, iCounter, " Ná"," NÁ", "", "", "", "", "", ""); break;
				case 38: sReturnString = sTranslateCharacter("M", sSubString, nChannel, iCounter, " Fal"," FAL", "", "", "", "", "", ""); break;
				case 39: sReturnString = sTranslateCharacter("N", sSubString, nChannel, iCounter, " No"," NO", "", "", "", "", "", ""); break;
				case 40: sReturnString = sTranslateCharacter("O", sSubString, nChannel, iCounter, " Me"," ME", "", "", "", "", "", ""); break;
				case 41: sReturnString = sTranslateCharacter("P", sSubString, nChannel, iCounter, " Ni"," NI", "", "", "", "", "", ""); break;
				case 42: sReturnString = sTranslateCharacter("Q", sSubString, nChannel, iCounter, " Ma"," MA", "", "", "", "", "", ""); break;
				case 43: sReturnString = sTranslateCharacter("R", sSubString, nChannel, iCounter, " Vi"," VI", "", "", "", "", "", ""); break;
				case 44: sReturnString = sTranslateCharacter("S", sSubString, nChannel, iCounter, " Li"," LI", "", "", "", "", "", ""); break;
				case 45: sReturnString = sTranslateCharacter("T", sSubString, nChannel, iCounter, " Ok"," OK", "", "", "", "", "", ""); break;
				case 46: sReturnString = sTranslateCharacter("U", sSubString, nChannel, iCounter, " He"," HE", "", "", "", "", "", ""); break;
				case 47: sReturnString = sTranslateCharacter("V", sSubString, nChannel, iCounter, " I'"," I'", "", "", "", "", "", ""); break;
				case 48: sReturnString = sTranslateCharacter("W", sSubString, nChannel, iCounter, " Ei"," EI", "", "", "", "", "", ""); break;
				case 49: sReturnString = sTranslateCharacter("X", sSubString, nChannel, iCounter, " Ca"," CA", "", "", "", "", "", ""); break;
				case 50: sReturnString = sTranslateCharacter("Y", sSubString, nChannel, iCounter, " Qù"," QÙ", "", "", "", "", "", ""); break;
				case 51: sReturnString = sTranslateCharacter("Z", sSubString, nChannel, iCounter, " Dz"," DZ", "", "", "", "", "", ""); break;
				case 52: sReturnString = sTranslateCharacter(" ", sSubString, nChannel, iCounter, " ","", "", "", "", "", "", ""); break;
	
				default: if(sLetter=="!" || sLetter=="?" || sLetter=="."){sReturnString = sLetter;}else{sOutputString = sOutputString;} break;
			}
			if(sReturnString != "")
			{
				if(sReturnString !=  sDuplicate)
				{
					sOutputString = sOutputString + sReturnString;
					sDuplicate = sReturnString;
				}
				else
				{
					sOutputString = sOutputString;
				}
			}													
		}
	}
	return sOutputString;
}

string sOutPut_LNG_GNOME_DUR(string sSubString, int nChannel, object oSender)
{
	int iSubStringLength, iTrans, iCounter;
	int iClearTextStart, iClearTextEnd;
	string sLetter, sOutputString, sClearText, sReturnString , sDuplicate;
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";    
	sOutputString = "";
	iSubStringLength = GetStringLength(sSubString);
		
	for(iCounter=0;iCounter <= iSubStringLength; iCounter++)
	{
		sLetter = GetSubString(sSubString,iCounter,1);

		if(sLetter == "*")
		{
			if(FindSubString(sSubString, "**", iCounter)== iCounter)
			{
				iClearTextStart = iCounter +2;
				iClearTextEnd = FindSubString(sSubString," ",iClearTextStart);
			
				if(iClearTextEnd == -1)
				{
					iClearTextEnd = iSubStringLength; 
				}
				
				sClearText = GetSubString(sSubString, iClearTextStart, iClearTextEnd - iClearTextStart );
				sOutputString = sOutputString + CLR_SPACE + sClearText + CLR_SPACE;
				iCounter = iClearTextEnd; 
			}
		}
		else
		{
			iTrans = FindSubString(sTranslate, sLetter);
	
			switch (iTrans)
		   	{
				case 0: sReturnString = sTranslateCharacter("a", sSubString, nChannel, iCounter, "","", "bcegjklpqruvx", "gos't", "GOS'T", "hinostw", "~I'l", "~I'L"); break;
				case 1: sReturnString = sTranslateCharacter("b", sSubString, nChannel, iCounter, "e'le","E'LE", "ahinostw", "~ri", "~RI", "", "", ""); break;
				case 2: sReturnString = sTranslateCharacter("c", sSubString, nChannel, iCounter, "gul","GUL", "ahinostw", "~ru", "~RU", "", "", ""); break;
				case 3: sReturnString = sTranslateCharacter("d", sSubString, nChannel, iCounter, "d'th","D'TH", "ahinostw", "~fe", "~FE", "", "", ""); break;
				case 4: sReturnString = sTranslateCharacter("e", sSubString, nChannel, iCounter, "","", "ahinostw", "~nikke", "~NIKKE", "", "", ""); break;
				case 5: sReturnString = sTranslateCharacter("f", sSubString, nChannel, iCounter, "z'uk","Z'UK", "ahinostw", "~fi", "~FI", "", "", ""); break;
				case 6: sReturnString = sTranslateCharacter("g", sSubString, nChannel, iCounter, "ek","EK", "ahinostw", "~fah", "~FAH", "", "", ""); break;
				case 7: sReturnString = sTranslateCharacter("h", sSubString, nChannel, iCounter, "","", "bcegjklpqruvx", "renti", "RENTI", "ainostw", "~oulgo", "~OULGO"); break;
				case 8: sReturnString = sTranslateCharacter("i", sSubString, nChannel, iCounter, "zi","ZI", "bcegjklpqruvx", "doth", "DOTH", "ahnostw", "~kun", "~KUN"); break;
				case 9: sReturnString = sTranslateCharacter("j", sSubString, nChannel, iCounter, "jil","JIL", "ahinostw", "~gu", "~GU", "", "", ""); break;
				case 10: sReturnString = sTranslateCharacter("k", sSubString, nChannel, iCounter, "rum","RUM", "ahinostw", "~ol", "~OL", "", "", ""); break;
				case 11: sReturnString = sTranslateCharacter("l", sSubString, nChannel, iCounter, "","", "ahinostw", "~rix'k", "~RIX'K", "", "", ""); break;
				case 12: sReturnString = sTranslateCharacter("m", sSubString, nChannel, iCounter, "m-nu","M-NU", "ahinostw", "~re", "~RE", "", "", ""); break;
				case 13: sReturnString = sTranslateCharacter("n", sSubString, nChannel, iCounter, "","", "bcegjklpqruvx", "e'a", "E'A", "ahiostw", "~aldbe", "~ALDBE"); break;
				case 14: sReturnString = sTranslateCharacter("o", sSubString, nChannel, iCounter, "","", "bcegjklpqruvx", "", "", "ahinstw", "~fe-tha", "~FE-THA"); break;
				case 15: sReturnString = sTranslateCharacter("p", sSubString, nChannel, iCounter, "ent'l","ENT'L", "ahinostw", "~du", "~DU", "", "", ""); break;
				case 16: sReturnString = sTranslateCharacter("q", sSubString, nChannel, iCounter, "","", "ahinostw", "~ylemlem", "~YLEMLEM", "", "", ""); break;
				case 17: sReturnString = sTranslateCharacter("r", sSubString, nChannel, iCounter, "ss","SS", "ahinostw", "~da", "~DA", "", "", ""); break;
				case 18: sReturnString = sTranslateCharacter("s", sSubString, nChannel, iCounter, "","", "bcegjklpqruvx", "hutl", "HUTL", "ahinotw", "~jul", "~JUL"); break;
				case 19: sReturnString = sTranslateCharacter("t", sSubString, nChannel, iCounter, "","", "bcegjklpqruvx", "su'l", "SU'L", "ahinosw", "~ze'h", "~ZE'H"); break;
				case 20: sReturnString = sTranslateCharacter("u", sSubString, nChannel, iCounter, "fol","FOL", "ahinostw", "~ho", "~HO", "", "", ""); break;
				case 21: sReturnString = sTranslateCharacter("v", sSubString, nChannel, iCounter, "gu'le","GU'LE", "ahinostw", "~ki", "~KI", "", "", ""); break;
				case 22: sReturnString = sTranslateCharacter("w", sSubString, nChannel, iCounter, "","", "bcegjklpqruvx", "ll", "LL", "ahinost", "~o'unt", "~O'UNT"); break;
				case 23: sReturnString = sTranslateCharacter("x", sSubString, nChannel, iCounter, "rel","REL", "ahinostw", "~ku", "~KU", "", "", ""); break;
				case 24: sReturnString = sTranslateCharacter("y", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 25: sReturnString = sTranslateCharacter("z", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 26: sReturnString = sTranslateCharacter("A", sSubString, nChannel, iCounter, "~Ri","~RI", "", "", "", "", "", ""); break;
				case 27: sReturnString = sTranslateCharacter("B", sSubString, nChannel, iCounter, "~Ru","~RU", "", "", "", "", "", ""); break;
				case 28: sReturnString = sTranslateCharacter("C", sSubString, nChannel, iCounter, "~Fe","~FE", "", "", "", "", "", ""); break;
				case 29: sReturnString = sTranslateCharacter("D", sSubString, nChannel, iCounter, "~Et","~ET", "", "", "", "", "", ""); break;
				case 30: sReturnString = sTranslateCharacter("E", sSubString, nChannel, iCounter, "~Fi","~FI", "", "", "", "", "", ""); break;
				case 31: sReturnString = sTranslateCharacter("F", sSubString, nChannel, iCounter, "~Fah","~FAH", "", "", "", "", "", ""); break;
				case 32: sReturnString = sTranslateCharacter("G", sSubString, nChannel, iCounter, "Renti","RENTI", "", "", "", "", "", ""); break;
				case 33: sReturnString = sTranslateCharacter("H", sSubString, nChannel, iCounter, "~Oth","~OTH", "", "", "", "", "", ""); break;
				case 34: sReturnString = sTranslateCharacter("I", sSubString, nChannel, iCounter, "~Gu","~GU", "", "", "", "", "", "","~Thel'~", "~THEL'~"); break;
				case 35: sReturnString = sTranslateCharacter("J", sSubString, nChannel, iCounter, "~Ol","~OL", "", "", "", "", "", ""); break;
				case 36: sReturnString = sTranslateCharacter("K", sSubString, nChannel, iCounter, "~Ke'","~KE'", "", "", "", "", "", ""); break;
				case 37: sReturnString = sTranslateCharacter("L", sSubString, nChannel, iCounter, "~Re","~RE", "", "", "", "", "", ""); break;
				case 38: sReturnString = sTranslateCharacter("M", sSubString, nChannel, iCounter, "~E'a","~E'A", "", "", "", "", "", ""); break;
				case 39: sReturnString = sTranslateCharacter("N", sSubString, nChannel, iCounter, "~Ju","~JU", "", "", "", "", "", ""); break;
				case 40: sReturnString = sTranslateCharacter("O", sSubString, nChannel, iCounter, "~Du","~DU", "", "", "", "", "", ""); break;
				case 41: sReturnString = sTranslateCharacter("P", sSubString, nChannel, iCounter, "~Al","~AL", "", "", "", "", "", ""); break;
				case 42: sReturnString = sTranslateCharacter("Q", sSubString, nChannel, iCounter, "~Da","~DA", "", "", "", "", "", ""); break;
				case 43: sReturnString = sTranslateCharacter("R", sSubString, nChannel, iCounter, "~Hu","~HU", "", "", "", "", "", ""); break;
				case 44: sReturnString = sTranslateCharacter("S", sSubString, nChannel, iCounter, "su'l","SU'L", "", "", "", "", "", ""); break;
				case 45: sReturnString = sTranslateCharacter("T", sSubString, nChannel, iCounter, "~O","~O", "", "", "", "", "", ""); break;
				case 46: sReturnString = sTranslateCharacter("U", sSubString, nChannel, iCounter, "~Ki","~KI", "", "", "", "", "", ""); break;
				case 47: sReturnString = sTranslateCharacter("V", sSubString, nChannel, iCounter, "~Ll","~LL", "", "", "", "", "", ""); break;
				case 48: sReturnString = sTranslateCharacter("W", sSubString, nChannel, iCounter, "~Ku","~KU", "", "", "", "", "", ""); break;
				case 49: sReturnString = sTranslateCharacter("X", sSubString, nChannel, iCounter, "~Ni","~NI", "", "", "", "", "", ""); break;
				case 50: sReturnString = sTranslateCharacter("Y", sSubString, nChannel, iCounter, "~Nu","~NU", "", "", "", "", "", ""); break;
				case 51: sReturnString = sTranslateCharacter("Z", sSubString, nChannel, iCounter, "~Su't","~SU'T", "", "", "", "", "", ""); break;
				
				default: sOutputString = sOutputString; break;
			}
			if(sReturnString != "")
			{
				if(sReturnString !=  sDuplicate)
				{
					sOutputString = sOutputString + sReturnString;
					sDuplicate = sReturnString;
				}
				else
				{
					sOutputString = sOutputString;
				}
			}													
		}
	}
	sOutputString = sOutputString + " ";
	return sOutputString;
}

string sOutPut_LNG_KOR(string sSubString, int nChannel, object oSender)
{
	int iSubStringLength, iTrans, iCounter;
	int iClearTextStart, iClearTextEnd;
	string sLetter, sOutputString, sClearText, sReturnString , sDuplicate;
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ";   
	sOutputString = "";
	iSubStringLength = GetStringLength(sSubString);
		
	for(iCounter=0;iCounter <= iSubStringLength; iCounter++)
	{
		sLetter = GetSubString(sSubString,iCounter,1);

		if(sLetter == "*")
		{
			if(FindSubString(sSubString, "**", iCounter)== iCounter)
			{
				iClearTextStart = iCounter +2;
				iClearTextEnd = FindSubString(sSubString," ",iClearTextStart);
			
				if(iClearTextEnd == -1)
				{
					iClearTextEnd = iSubStringLength; 
				}
				
				sClearText = GetSubString(sSubString, iClearTextStart, iClearTextEnd - iClearTextStart );
				sOutputString = sOutputString + CLR_SPACE + sClearText + CLR_SPACE;
				iCounter = iClearTextEnd; 
			}
		}
		else
		{
			iTrans = FindSubString(sTranslate, sLetter);
	
			switch (iTrans)
		   	{
				case 0: sReturnString = sTranslateCharacter("a", sSubString, nChannel, iCounter, "","", "bcegjklpqruvx", "rb", "RB", "hinostw", " näzg", " NÄZG"); break;
				case 1: sReturnString = sTranslateCharacter("b", sSubString, nChannel, iCounter, "sh","SH", "ahinostw", " ga", " GA", "", "", ""); break;
				case 2: sReturnString = sTranslateCharacter("c", sSubString, nChannel, iCounter, "mb","MB", "ahinostw", " as", " AS", "", "", ""); break;
				case 3: sReturnString = sTranslateCharacter("d", sSubString, nChannel, iCounter, "at","AT", "ahinostw", " ûg", " ÛG", "", "", ""); break;
				case 4: sReturnString = sTranslateCharacter("e", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 5: sReturnString = sTranslateCharacter("f", sSubString, nChannel, iCounter, "rûm","RÛM", "ahinostw", " du", " DU", "", "", ""); break;
				case 6: sReturnString = sTranslateCharacter("g", sSubString, nChannel, iCounter, "ek","EK", "ahinostw", " bâ", " BÂ", "", " ng'h", " NG'H"); break;
				case 7: sReturnString = sTranslateCharacter("h", sSubString, nChannel, iCounter, "","", "bcegjklpqruvx", "h ", "H ", "ainostw", " göl", " GÖL"); break;
				case 8: sReturnString = sTranslateCharacter("i", sSubString, nChannel, iCounter, "","", "bcegjklpqruvx", "uk", "UK", "ahnostw", "akh", "AKH"); break;
				case 9: sReturnString = sTranslateCharacter("j", sSubString, nChannel, iCounter, "ma","MA", "ahinostw", " ûl", " ÛL", "", "", ""); break;
				case 10: sReturnString = sTranslateCharacter("k", sSubString, nChannel, iCounter, "ra","RA", "ahinostw", " gôl", " GÔL", "", "", ""); break;
				case 11: sReturnString = sTranslateCharacter("l", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 12: sReturnString = sTranslateCharacter("m", sSubString, nChannel, iCounter, "ka","KA", "ahinostw", " gi", " GI", "", "", ""); break;
				case 13: sReturnString = sTranslateCharacter("n", sSubString, nChannel, iCounter, "","", "bcegjklpqruvx", "sh", "SH", "ahiostw", " äsh", " ÄSH"); break;
				case 14: sReturnString = sTranslateCharacter("o", sSubString, nChannel, iCounter, "","", "bcegjklpqruvx", "ob", "OB", "ahinstw", " u", " U"); break;
				case 15: sReturnString = sTranslateCharacter("p", sSubString, nChannel, iCounter, "rzu","RZU", "ahinostw", " th", " TH", "", "", ""); break;
				case 16: sReturnString = sTranslateCharacter("q", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 17: sReturnString = sTranslateCharacter("r", sSubString, nChannel, iCounter, "im","IM", "ahinostw", " pû", " PÛ", "", "", ""); break;
				case 18: sReturnString = sTranslateCharacter("s", sSubString, nChannel, iCounter, "","", "bcegjklpqruvx", "sh", "SH", "ahinotw", " ai", " AI"); break;
				case 19: sReturnString = sTranslateCharacter("t", sSubString, nChannel, iCounter, "","", "bcegjklpqruvx", "um", "UM", "ahinosw", " olag", " OLAG"); break;
				case 20: sReturnString = sTranslateCharacter("u", sSubString, nChannel, iCounter, "pa","PA", "ahinostw", " sa", " SA", "", "", ""); break;
				case 21: sReturnString = sTranslateCharacter("v", sSubString, nChannel, iCounter, "sh","SH", "ahinostw", " bu", " BU", "", "", ""); break;
				case 22: sReturnString = sTranslateCharacter("w", sSubString, nChannel, iCounter, "","", "bcegjklpqruvx", "hi", "HI", "ahinost", " öb", " ÖB"); break;
				case 23: sReturnString = sTranslateCharacter("x", sSubString, nChannel, iCounter, "as","AS", "ahinostw", " 'ag", " 'AG", "", "", ""); break;
				case 24: sReturnString = sTranslateCharacter("y", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 25: sReturnString = sTranslateCharacter("z", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 26: sReturnString = sTranslateCharacter("A", sSubString, nChannel, iCounter, " Go"," GO", "", "", "", "", "", ""); break;
				case 27: sReturnString = sTranslateCharacter("B", sSubString, nChannel, iCounter, " Ga"," GA", "", "", "", "", "", ""); break;
				case 28: sReturnString = sTranslateCharacter("C", sSubString, nChannel, iCounter, " As"," AS", "", "", "", "", "", ""); break;
				case 29: sReturnString = sTranslateCharacter("D", sSubString, nChannel, iCounter, " Ug"," UG", "", "", "", "", "", ""); break;
				case 30: sReturnString = sTranslateCharacter("E", sSubString, nChannel, iCounter, " A"," A", "", "", "", "", "", ""); break;
				case 31: sReturnString = sTranslateCharacter("F", sSubString, nChannel, iCounter, " Kû"," KÛ", "", "", "", "", "", ""); break;
				case 32: sReturnString = sTranslateCharacter("G", sSubString, nChannel, iCounter, " Bâ"," BÂ", "", "", "", "", "", ""); break;
				case 33: sReturnString = sTranslateCharacter("H", sSubString, nChannel, iCounter, " Ba"," BA", "", "", "", "", "", ""); break;
				case 34: sReturnString = sTranslateCharacter("I", sSubString, nChannel, iCounter, " Uk"," UK", "", "", "", "", "", "","un ", "UN "); break;
				case 35: sReturnString = sTranslateCharacter("J", sSubString, nChannel, iCounter, " Ul"," UL", "", "", "", "", "", ""); break;
				case 36: sReturnString = sTranslateCharacter("K", sSubString, nChannel, iCounter, " Gôl"," GÔL", "", "", "", "", "", ""); break;
				case 37: sReturnString = sTranslateCharacter("L", sSubString, nChannel, iCounter, " Za"," ZA", "", "", "", "", "", ""); break;
				case 38: sReturnString = sTranslateCharacter("M", sSubString, nChannel, iCounter, " Gi"," GI", "", "", "", "", "", ""); break;
				case 39: sReturnString = sTranslateCharacter("N", sSubString, nChannel, iCounter, " Ol"," OL", "", "", "", "", "", ""); break;
				case 40: sReturnString = sTranslateCharacter("O", sSubString, nChannel, iCounter, " Ng"," NG", "", "", "", "", "", ""); break;
				case 41: sReturnString = sTranslateCharacter("P", sSubString, nChannel, iCounter, " Th"," TH", "", "", "", "", "", ""); break;
				case 42: sReturnString = sTranslateCharacter("Q", sSubString, nChannel, iCounter, " Û"," Û", "", "", "", "", "", ""); break;
				case 43: sReturnString = sTranslateCharacter("R", sSubString, nChannel, iCounter, " Pu"," PU", "", "", "", "", "", ""); break;
				case 44: sReturnString = sTranslateCharacter("S", sSubString, nChannel, iCounter, " Ul"," UL", "", "", "", "", "", ""); break;
				case 45: sReturnString = sTranslateCharacter("T", sSubString, nChannel, iCounter, " Bâ"," BÂ", "", "", "", "", "", ""); break;
				case 46: sReturnString = sTranslateCharacter("U", sSubString, nChannel, iCounter, " Sa"," SA", "", "", "", "", "", ""); break;
				case 47: sReturnString = sTranslateCharacter("V", sSubString, nChannel, iCounter, " Bu"," BU", "", "", "", "", "", ""); break;
				case 48: sReturnString = sTranslateCharacter("W", sSubString, nChannel, iCounter, " Ga"," GA", "", "", "", "", "", ""); break;
				case 49: sReturnString = sTranslateCharacter("X", sSubString, nChannel, iCounter, " Ag"," AG", "", "", "", "", "", ""); break;
				case 50: sReturnString = sTranslateCharacter("Y", sSubString, nChannel, iCounter, " As"," AS", "", "", "", "", "", ""); break;
				case 51: sReturnString = sTranslateCharacter("Z", sSubString, nChannel, iCounter, " Ug"," UG", "", "", "", "", "", ""); break;
				case 52: sReturnString = sTranslateCharacter(" ", sSubString, nChannel, iCounter, " ","", "", "", "", "", "", ""); break;
				
				default: if(sLetter=="!" || sLetter=="?" || sLetter=="."){sReturnString = sLetter;}else{sOutputString = sOutputString;} break;
			}
			if(sReturnString != "")
			{
				if(sReturnString !=  sDuplicate)
				{
					sOutputString = sOutputString + sReturnString;
					sDuplicate = sReturnString;
				}
				else
				{
					sOutputString = sOutputString;
				}
			}													
		}
	}
	return sOutputString;
}

string sOutPut_LNG_VOKK(string sSubString, int nChannel, object oSender)
{
	int iSubStringLength, iTrans, iCounter;
	int iClearTextStart, iClearTextEnd;
	string sLetter, sOutputString, sClearText, sReturnString , sDuplicate;
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ";    
	sOutputString = "";
	iSubStringLength = GetStringLength(sSubString);
		
	for(iCounter=0;iCounter <= iSubStringLength; iCounter++)
	{
		sLetter = GetSubString(sSubString,iCounter,1);

		if(sLetter == "*")
		{
			if(FindSubString(sSubString, "**", iCounter)== iCounter)
			{
				iClearTextStart = iCounter +2;
				iClearTextEnd = FindSubString(sSubString," ",iClearTextStart);
			
				if(iClearTextEnd == -1)
				{
					iClearTextEnd = iSubStringLength; 
				}
				
				sClearText = GetSubString(sSubString, iClearTextStart, iClearTextEnd - iClearTextStart );
				sOutputString = sOutputString + CLR_SPACE + sClearText + CLR_SPACE;
				iCounter = iClearTextEnd; 
			}
		}
		else
		{
			iTrans = FindSubString(sTranslate, sLetter);
	
			switch (iTrans)
		   	{
				case 0: sReturnString = sTranslateCharacter("a", sSubString, nChannel, iCounter, "","", "bcegjklpqruvx", "rb", "RB", "hinostw", " näzg", " NÄZG"); break;
				case 1: sReturnString = sTranslateCharacter("b", sSubString, nChannel, iCounter, "sh","SH", "ahinostw", " gò", " GÒ", "", "", ""); break;
				case 2: sReturnString = sTranslateCharacter("c", sSubString, nChannel, iCounter, "mb","MB", "ahinostw", " òs", " ÒS", "", "", ""); break;
				case 3: sReturnString = sTranslateCharacter("d", sSubString, nChannel, iCounter, "at","AT", "ahinostw", " âg", " ÂG", "", "", ""); break;
				case 4: sReturnString = sTranslateCharacter("e", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 5: sReturnString = sTranslateCharacter("f", sSubString, nChannel, iCounter, "râm","RÂM", "ahinostw", " dâ", " DÂ", "", "", ""); break;
				case 6: sReturnString = sTranslateCharacter("g", sSubString, nChannel, iCounter, "ek","EK", "ahinostw", " bâ", " BÂ", "", " ng'h", " NG'H"); break;
				case 7: sReturnString = sTranslateCharacter("h", sSubString, nChannel, iCounter, "","", "bcegjklpqruvx", "h ", "H ", "ainostw", " gòl", " GÒL"); break;
				case 8: sReturnString = sTranslateCharacter("i", sSubString, nChannel, iCounter, "","", "bcegjklpqruvx", "uk", "UK", "ahnostw", "akh", "AKH"); break;
				case 9: sReturnString = sTranslateCharacter("j", sSubString, nChannel, iCounter, "mò","MÒ", "ahinostw", " âl", " ÂL", "", "", ""); break;
				case 10: sReturnString = sTranslateCharacter("k", sSubString, nChannel, iCounter, "ra","RA", "ahinostw", " gôl", " GÔL", "", "", ""); break;
				case 11: sReturnString = sTranslateCharacter("l", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 12: sReturnString = sTranslateCharacter("m", sSubString, nChannel, iCounter, "kò","KÒ", "ahinostw", " gi", " GI", "", "", ""); break;
				case 13: sReturnString = sTranslateCharacter("n", sSubString, nChannel, iCounter, "","", "bcegjklpqruvx", "sh", "SH", "ahiostw", " äsh", " ÄSH"); break;
				case 14: sReturnString = sTranslateCharacter("o", sSubString, nChannel, iCounter, "","", "bcegjklpqruvx", "ob", "OB", "ahinstw", " u", " U"); break;
				case 15: sReturnString = sTranslateCharacter("p", sSubString, nChannel, iCounter, "rzâ","RZÂ", "ahinostw", " th", " TH", "", "", ""); break;
				case 16: sReturnString = sTranslateCharacter("q", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 17: sReturnString = sTranslateCharacter("r", sSubString, nChannel, iCounter, "im","IM", "ahinostw", " pâ", " PÂ", "", "", ""); break;
				case 18: sReturnString = sTranslateCharacter("s", sSubString, nChannel, iCounter, "","", "bcegjklpqruvx", "sh", "SH", "ahinotw", " ai", " AI"); break;
				case 19: sReturnString = sTranslateCharacter("t", sSubString, nChannel, iCounter, "","", "bcegjklpqruvx", "um", "UM", "ahinosw", " ològ", " OLÒG"); break;
				case 20: sReturnString = sTranslateCharacter("u", sSubString, nChannel, iCounter, "pò","PÒ", "ahinostw", " sò", " SÒ", "", "", ""); break;
				case 21: sReturnString = sTranslateCharacter("v", sSubString, nChannel, iCounter, "sh","SH", "ahinostw", " bâ", " BÂ", "", "", ""); break;
				case 22: sReturnString = sTranslateCharacter("w", sSubString, nChannel, iCounter, "","", "bcegjklpqruvx", "hi", "HI", "ahinost", " öb", " ÖB"); break;
				case 23: sReturnString = sTranslateCharacter("x", sSubString, nChannel, iCounter, "as","AS", "ahinostw", " 'ag", " 'AG", "", "", ""); break;
				case 24: sReturnString = sTranslateCharacter("y", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 25: sReturnString = sTranslateCharacter("z", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 26: sReturnString = sTranslateCharacter("A", sSubString, nChannel, iCounter, " Go"," GO", "", "", "", "", "", ""); break;
				case 27: sReturnString = sTranslateCharacter("B", sSubString, nChannel, iCounter, " Gò"," GÒ", "", "", "", "", "", ""); break;
				case 28: sReturnString = sTranslateCharacter("C", sSubString, nChannel, iCounter, " As"," AS", "", "", "", "", "", ""); break;
				case 29: sReturnString = sTranslateCharacter("D", sSubString, nChannel, iCounter, " Ug"," UG", "", "", "", "", "", ""); break;
				case 30: sReturnString = sTranslateCharacter("E", sSubString, nChannel, iCounter, " A"," A", "", "", "", "", "", ""); break;
				case 31: sReturnString = sTranslateCharacter("F", sSubString, nChannel, iCounter, " Câ"," CÂ", "", "", "", "", "", ""); break;
				case 32: sReturnString = sTranslateCharacter("G", sSubString, nChannel, iCounter, " Bâ"," BÂ", "", "", "", "", "", ""); break;
				case 33: sReturnString = sTranslateCharacter("H", sSubString, nChannel, iCounter, " Bò"," BÒ", "", "", "", "", "", ""); break;
				case 34: sReturnString = sTranslateCharacter("I", sSubString, nChannel, iCounter, " Uc"," UC", "", "", "", "", "", "","än ", "ÄN "); break;
				case 35: sReturnString = sTranslateCharacter("J", sSubString, nChannel, iCounter, " Ul"," UL", "", "", "", "", "", ""); break;
				case 36: sReturnString = sTranslateCharacter("K", sSubString, nChannel, iCounter, " Gôl"," GÔL", "", "", "", "", "", ""); break;
				case 37: sReturnString = sTranslateCharacter("L", sSubString, nChannel, iCounter, " Za"," ZA", "", "", "", "", "", ""); break;
				case 38: sReturnString = sTranslateCharacter("M", sSubString, nChannel, iCounter, " Gi"," GI", "", "", "", "", "", ""); break;
				case 39: sReturnString = sTranslateCharacter("N", sSubString, nChannel, iCounter, " Ol"," OL", "", "", "", "", "", ""); break;
				case 40: sReturnString = sTranslateCharacter("O", sSubString, nChannel, iCounter, " Ng"," NG", "", "", "", "", "", ""); break;
				case 41: sReturnString = sTranslateCharacter("P", sSubString, nChannel, iCounter, " Th"," TH", "", "", "", "", "", ""); break;
				case 42: sReturnString = sTranslateCharacter("Q", sSubString, nChannel, iCounter, " Â"," Â", "", "", "", "", "", ""); break;
				case 43: sReturnString = sTranslateCharacter("R", sSubString, nChannel, iCounter, " Pu"," PU", "", "", "", "", "", ""); break;
				case 44: sReturnString = sTranslateCharacter("S", sSubString, nChannel, iCounter, " Âl"," ÂL", "", "", "", "", "", ""); break;
				case 45: sReturnString = sTranslateCharacter("T", sSubString, nChannel, iCounter, " Bâ"," BÂ", "", "", "", "", "", ""); break;
				case 46: sReturnString = sTranslateCharacter("U", sSubString, nChannel, iCounter, " Sa"," SA", "", "", "", "", "", ""); break;
				case 47: sReturnString = sTranslateCharacter("V", sSubString, nChannel, iCounter, " Bu"," BU", "", "", "", "", "", ""); break;
				case 48: sReturnString = sTranslateCharacter("W", sSubString, nChannel, iCounter, " Ga"," GA", "", "", "", "", "", ""); break;
				case 49: sReturnString = sTranslateCharacter("X", sSubString, nChannel, iCounter, " Ag"," AG", "", "", "", "", "", ""); break;
				case 50: sReturnString = sTranslateCharacter("Y", sSubString, nChannel, iCounter, " As"," AS", "", "", "", "", "", ""); break;
				case 51: sReturnString = sTranslateCharacter("Z", sSubString, nChannel, iCounter, " Ug"," UG", "", "", "", "", "", ""); break;
				case 52: sReturnString = sTranslateCharacter(" ", sSubString, nChannel, iCounter, " ","", "", "", "", "", "", ""); break;
				
				default: if(sLetter=="!" || sLetter=="?" || sLetter=="."){sReturnString = sLetter;}else{sOutputString = sOutputString;} break;
			}
			if(sReturnString != "")
			{
				if(sReturnString !=  sDuplicate)
				{
					sOutputString = sOutputString + sReturnString;
					sDuplicate = sReturnString;
				}
				else
				{
					sOutputString = sOutputString;
				}
			}													
		}
	}
	return sOutputString;
}

string sOutPut_LNG_SHAI(string sSubString, int nChannel, object oSender)
{
	int iSubStringLength, iTrans, iCounter;
	int iClearTextStart, iClearTextEnd;
	string sLetter, sOutputString, sClearText, sReturnString , sDuplicate;
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ";    
	sOutputString = "";
	iSubStringLength = GetStringLength(sSubString);
		
	for(iCounter=0;iCounter <= iSubStringLength; iCounter++)
	{
		sLetter = GetSubString(sSubString,iCounter,1);

		if(sLetter == "*")
		{
			if(FindSubString(sSubString, "**", iCounter)== iCounter)
			{
				iClearTextStart = iCounter +2;
				iClearTextEnd = FindSubString(sSubString," ",iClearTextStart);
			
				if(iClearTextEnd == -1)
				{
					iClearTextEnd = iSubStringLength; 
				}
				
				sClearText = GetSubString(sSubString, iClearTextStart, iClearTextEnd - iClearTextStart );
				sOutputString = sOutputString + CLR_SPACE + sClearText + CLR_SPACE;
				iCounter = iClearTextEnd; 
			}
		}
		else
		{
			iTrans = FindSubString(sTranslate, sLetter);
	
			switch (iTrans)
		   	{
				case 0: sReturnString = sTranslateCharacter("a", sSubString, nChannel, iCounter, "","", "bcegjklpqruvx", "rb", "RB", "hinostw", " näzg", " NÄZG"); break;
				case 1: sReturnString = sTranslateCharacter("b", sSubString, nChannel, iCounter, "sh","SH", "ahinostw", " gò", " GÒ", "", "", ""); break;
				case 2: sReturnString = sTranslateCharacter("c", sSubString, nChannel, iCounter, "mb","MB", "ahinostw", " òs", " ÒS", "", "", ""); break;
				case 3: sReturnString = sTranslateCharacter("d", sSubString, nChannel, iCounter, "at","AT", "ahinostw", " âg", " ÂG", "", "", ""); break;
				case 4: sReturnString = sTranslateCharacter("e", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 5: sReturnString = sTranslateCharacter("f", sSubString, nChannel, iCounter, "râm","RÂM", "ahinostw", " dâ", " DÂ", "", "", ""); break;
				case 6: sReturnString = sTranslateCharacter("g", sSubString, nChannel, iCounter, "ek","EK", "ahinostw", " bâ", " BÂ", "", " ng'h", " NG'H"); break;
				case 7: sReturnString = sTranslateCharacter("h", sSubString, nChannel, iCounter, "","", "bcegjklpqruvx", "h ", "H ", "ainostw", " gòl", " GÒL"); break;
				case 8: sReturnString = sTranslateCharacter("i", sSubString, nChannel, iCounter, "","", "bcegjklpqruvx", "uk", "UK", "ahnostw", "akh", "AKH"); break;
				case 9: sReturnString = sTranslateCharacter("j", sSubString, nChannel, iCounter, "mò","MÒ", "ahinostw", " âl", " ÂL", "", "", ""); break;
				case 10: sReturnString = sTranslateCharacter("k", sSubString, nChannel, iCounter, "ra","RA", "ahinostw", " gôl", " GÔL", "", "", ""); break;
				case 11: sReturnString = sTranslateCharacter("l", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 12: sReturnString = sTranslateCharacter("m", sSubString, nChannel, iCounter, "kò","KÒ", "ahinostw", " gi", " GI", "", "", ""); break;
				case 13: sReturnString = sTranslateCharacter("n", sSubString, nChannel, iCounter, "","", "bcegjklpqruvx", "sh", "SH", "ahiostw", " äsh", " ÄSH"); break;
				case 14: sReturnString = sTranslateCharacter("o", sSubString, nChannel, iCounter, "","", "bcegjklpqruvx", "ob", "OB", "ahinstw", " u", " U"); break;
				case 15: sReturnString = sTranslateCharacter("p", sSubString, nChannel, iCounter, "rzâ","RZÂ", "ahinostw", " th", " TH", "", "", ""); break;
				case 16: sReturnString = sTranslateCharacter("q", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 17: sReturnString = sTranslateCharacter("r", sSubString, nChannel, iCounter, "im","IM", "ahinostw", " pâ", " PÂ", "", "", ""); break;
				case 18: sReturnString = sTranslateCharacter("s", sSubString, nChannel, iCounter, "","", "bcegjklpqruvx", "sh", "SH", "ahinotw", " ai", " AI"); break;
				case 19: sReturnString = sTranslateCharacter("t", sSubString, nChannel, iCounter, "","", "bcegjklpqruvx", "um", "UM", "ahinosw", " ològ", " OLÒG"); break;
				case 20: sReturnString = sTranslateCharacter("u", sSubString, nChannel, iCounter, "pò","PÒ", "ahinostw", " sò", " SÒ", "", "", ""); break;
				case 21: sReturnString = sTranslateCharacter("v", sSubString, nChannel, iCounter, "sh","SH", "ahinostw", " bâ", " BÂ", "", "", ""); break;
				case 22: sReturnString = sTranslateCharacter("w", sSubString, nChannel, iCounter, "","", "bcegjklpqruvx", "hi", "HI", "ahinost", " öb", " ÖB"); break;
				case 23: sReturnString = sTranslateCharacter("x", sSubString, nChannel, iCounter, "as","AS", "ahinostw", " 'ag", " 'AG", "", "", ""); break;
				case 24: sReturnString = sTranslateCharacter("y", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 25: sReturnString = sTranslateCharacter("z", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 26: sReturnString = sTranslateCharacter("A", sSubString, nChannel, iCounter, " Go"," GO", "", "", "", "", "", ""); break;
				case 27: sReturnString = sTranslateCharacter("B", sSubString, nChannel, iCounter, " Gò"," GÒ", "", "", "", "", "", ""); break;
				case 28: sReturnString = sTranslateCharacter("C", sSubString, nChannel, iCounter, " As"," AS", "", "", "", "", "", ""); break;
				case 29: sReturnString = sTranslateCharacter("D", sSubString, nChannel, iCounter, " Ug"," UG", "", "", "", "", "", ""); break;
				case 30: sReturnString = sTranslateCharacter("E", sSubString, nChannel, iCounter, " A"," A", "", "", "", "", "", ""); break;
				case 31: sReturnString = sTranslateCharacter("F", sSubString, nChannel, iCounter, " Câ"," CÂ", "", "", "", "", "", ""); break;
				case 32: sReturnString = sTranslateCharacter("G", sSubString, nChannel, iCounter, " Bâ"," BÂ", "", "", "", "", "", ""); break;
				case 33: sReturnString = sTranslateCharacter("H", sSubString, nChannel, iCounter, " Bò"," BÒ", "", "", "", "", "", ""); break;
				case 34: sReturnString = sTranslateCharacter("I", sSubString, nChannel, iCounter, " Uc"," UC", "", "", "", "", "", "","Âun ", "ÂUN "); break;
				case 35: sReturnString = sTranslateCharacter("J", sSubString, nChannel, iCounter, " Ul"," UL", "", "", "", "", "", ""); break;
				case 36: sReturnString = sTranslateCharacter("K", sSubString, nChannel, iCounter, " Gôl"," GÔL", "", "", "", "", "", ""); break;
				case 37: sReturnString = sTranslateCharacter("L", sSubString, nChannel, iCounter, " Za"," ZA", "", "", "", "", "", ""); break;
				case 38: sReturnString = sTranslateCharacter("M", sSubString, nChannel, iCounter, " Gi"," GI", "", "", "", "", "", ""); break;
				case 39: sReturnString = sTranslateCharacter("N", sSubString, nChannel, iCounter, " Ol"," OL", "", "", "", "", "", ""); break;
				case 40: sReturnString = sTranslateCharacter("O", sSubString, nChannel, iCounter, " Ng"," NG", "", "", "", "", "", ""); break;
				case 41: sReturnString = sTranslateCharacter("P", sSubString, nChannel, iCounter, " Th"," TH", "", "", "", "", "", ""); break;
				case 42: sReturnString = sTranslateCharacter("Q", sSubString, nChannel, iCounter, " Â"," Â", "", "", "", "", "", ""); break;
				case 43: sReturnString = sTranslateCharacter("R", sSubString, nChannel, iCounter, " Pu"," PU", "", "", "", "", "", ""); break;
				case 44: sReturnString = sTranslateCharacter("S", sSubString, nChannel, iCounter, " Âl"," ÂL", "", "", "", "", "", ""); break;
				case 45: sReturnString = sTranslateCharacter("T", sSubString, nChannel, iCounter, " Bâ"," BÂ", "", "", "", "", "", ""); break;
				case 46: sReturnString = sTranslateCharacter("U", sSubString, nChannel, iCounter, " Sa"," SA", "", "", "", "", "", ""); break;
				case 47: sReturnString = sTranslateCharacter("V", sSubString, nChannel, iCounter, " Bu"," BU", "", "", "", "", "", ""); break;
				case 48: sReturnString = sTranslateCharacter("W", sSubString, nChannel, iCounter, " Ga"," GA", "", "", "", "", "", ""); break;
				case 49: sReturnString = sTranslateCharacter("X", sSubString, nChannel, iCounter, " Ag"," AG", "", "", "", "", "", ""); break;
				case 50: sReturnString = sTranslateCharacter("Y", sSubString, nChannel, iCounter, " As"," AS", "", "", "", "", "", ""); break;
				case 51: sReturnString = sTranslateCharacter("Z", sSubString, nChannel, iCounter, " Ug"," UG", "", "", "", "", "", ""); break;
				case 52: sReturnString = sTranslateCharacter(" ", sSubString, nChannel, iCounter, " ","", "", "", "", "", "", ""); break;
				
				default: if(sLetter=="!" || sLetter=="?" || sLetter=="."){sReturnString = sLetter;}else{sOutputString = sOutputString;} break;
			}
			if(sReturnString != "")
			{
				if(sReturnString !=  sDuplicate)
				{
					sOutputString = sOutputString + sReturnString;
					sDuplicate = sReturnString;
				}
				else
				{
					sOutputString = sOutputString;
				}
			}													
		}
	}
	return sOutputString;
}

string sOutPut_LNG_TAHNAI(string sSubString, int nChannel, object oSender)
{
	int iSubStringLength, iTrans, iCounter;
	int iClearTextStart, iClearTextEnd;
	string sLetter, sOutputString, sClearText, sReturnString , sDuplicate;
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ";    
	sOutputString = "";
	iSubStringLength = GetStringLength(sSubString);
		
	for(iCounter=0;iCounter <= iSubStringLength; iCounter++)
	{
		sLetter = GetSubString(sSubString,iCounter,1);

		if(sLetter == "*")
		{
			if(FindSubString(sSubString, "**", iCounter)== iCounter)
			{
				iClearTextStart = iCounter +2;
				iClearTextEnd = FindSubString(sSubString," ",iClearTextStart);
			
				if(iClearTextEnd == -1)
				{
					iClearTextEnd = iSubStringLength; 
				}
				
				sClearText = GetSubString(sSubString, iClearTextStart, iClearTextEnd - iClearTextStart );
				sOutputString = sOutputString + CLR_SPACE + sClearText + CLR_SPACE;
				iCounter = iClearTextEnd; 
			}
		}
		else
		{
			iTrans = FindSubString(sTranslate, sLetter);
	
			switch (iTrans)
		   	{
				case 0: sReturnString = sTranslateCharacter("a", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 1: sReturnString = sTranslateCharacter("b", sSubString, nChannel, iCounter, "n","N", "adhlotyz", " as", " AS", "eims", "", ""); break;
				case 2: sReturnString = sTranslateCharacter("c", sSubString, nChannel, iCounter, "â","Â", "adhlotyz", "at", "AT", "eims", "lu", "LU"); break;
				case 3: sReturnString = sTranslateCharacter("d", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 4: sReturnString = sTranslateCharacter("e", sSubString, nChannel, iCounter, "da","DA", "adhlotyz", "an", "AN", "eims", "-tu", "-TU"); break;
				case 5: sReturnString = sTranslateCharacter("f", sSubString, nChannel, iCounter, "nn","NN", "adhlotyz", "na", "NA", "eims", "hi", "HI"); break;
				case 6: sReturnString = sTranslateCharacter("g", sSubString, nChannel, iCounter, "ha'","HA'", "adhlotyz", "ma'", "MA'", "eims", "kâ", "KÂ"); break;
				case 7: sReturnString = sTranslateCharacter("h", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 8: sReturnString = sTranslateCharacter("i", sSubString, nChannel, iCounter, "ís","ÍS", "adhlotyz", "in", "IN", "eims", "", ""); break;
				case 9: sReturnString = sTranslateCharacter("j", sSubString, nChannel, iCounter, "sh","SH", "adhlotyz", " lí", " LÍ", "eims", "ís", "ÍS"); break;
				case 10: sReturnString = sTranslateCharacter("k", sSubString, nChannel, iCounter, "y","Y", "adhlotyz", " az", " AZ", "eims", "", ""); break;
				case 11: sReturnString = sTranslateCharacter("l", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 12: sReturnString = sTranslateCharacter("m", sSubString, nChannel, iCounter, "li","LI", "adhlotyz", "ko'", "KO'", "eims", "ih", "IH"); break;
				case 13: sReturnString = sTranslateCharacter("n", sSubString, nChannel, iCounter, "d","D", "adhlotyz", "lo", "LO", "eims", "-da", "-DA"); break;
				case 14: sReturnString = sTranslateCharacter("o", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 15: sReturnString = sTranslateCharacter("p", sSubString, nChannel, iCounter, "a'í","A'Í", "adhlotyz", " al", " AL", "eims", "", ""); break;
				case 16: sReturnString = sTranslateCharacter("q", sSubString, nChannel, iCounter, "iz","IZ", "adhlotyz", " tl'", " TL'", "eims", "k'k", "K'K"); break;
				case 17: sReturnString = sTranslateCharacter("r", sSubString, nChannel, iCounter, "aa'","AA'", "adhlotyz", "y", "Y", "eims", "", ""); break;
				case 18: sReturnString = sTranslateCharacter("s", sSubString, nChannel, iCounter, "a'o","A'O", "adhlotyz", "li", "LI", "eims", "", ""); break;
				case 19: sReturnString = sTranslateCharacter("t", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 20: sReturnString = sTranslateCharacter("u", sSubString, nChannel, iCounter, "íd","ÍD", "adhlotyz", "am", "AM", "eims", "", ""); break;
				case 21: sReturnString = sTranslateCharacter("v", sSubString, nChannel, iCounter, "hí'","HÍ'", "adhlotyz", " jo", " JO", "eims", "", ""); break;
				case 22: sReturnString = sTranslateCharacter("w", sSubString, nChannel, iCounter, "ki","KI", "adhlotyz", "to", "TO", "eims", "", ""); break;
				case 23: sReturnString = sTranslateCharacter("x", sSubString, nChannel, iCounter, "zâ","ZÂ", "adhlotyz", " âo", " ÂO", "eims", "", ""); break;
				case 24: sReturnString = sTranslateCharacter("y", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 25: sReturnString = sTranslateCharacter("z", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 26: sReturnString = sTranslateCharacter("A", sSubString, nChannel, iCounter, " Kâ"," KÂ", "", "", "", "", "", ""); break;
				case 27: sReturnString = sTranslateCharacter("B", sSubString, nChannel, iCounter, " Âj"," ÂJ", "", "", "", "", "", ""); break;
				case 28: sReturnString = sTranslateCharacter("C", sSubString, nChannel, iCounter, " Am"," AM", "", "", "", "", "", ""); break;
				case 29: sReturnString = sTranslateCharacter("D", sSubString, nChannel, iCounter, " An"," AN", "", "", "", "", "", ""); break;
				case 30: sReturnString = sTranslateCharacter("E", sSubString, nChannel, iCounter, " Na"," NA", "", "", "", "", "", ""); break;
				case 31: sReturnString = sTranslateCharacter("F", sSubString, nChannel, iCounter, " Qa'"," QA'", "", "", "", "", "", ""); break;
				case 32: sReturnString = sTranslateCharacter("G", sSubString, nChannel, iCounter, " Di"," DI", "", "", "", "", "", ""); break;
				case 33: sReturnString = sTranslateCharacter("H", sSubString, nChannel, iCounter, " In"," IN", "", "", "", "", "", ""); break;
				case 34: sReturnString = sTranslateCharacter("I", sSubString, nChannel, iCounter, " Lí"," LÍ", "", "", "", "", "", "","e'h", "E'H"); break;
				case 35: sReturnString = sTranslateCharacter("J", sSubString, nChannel, iCounter, " Az"," AZ", "", "", "", "", "", ""); break;
				case 36: sReturnString = sTranslateCharacter("K", sSubString, nChannel, iCounter, " Pi"," PI", "", "", "", "", "", ""); break;
				case 37: sReturnString = sTranslateCharacter("L", sSubString, nChannel, iCounter, " Ko'"," KO'", "", "", "", "", "", ""); break;
				case 38: sReturnString = sTranslateCharacter("M", sSubString, nChannel, iCounter, " Hâ"," HÂ", "", "", "", "", "", ""); break;
				case 39: sReturnString = sTranslateCharacter("N", sSubString, nChannel, iCounter, " Si"," SI", "", "", "", "", "", ""); break;
				case 40: sReturnString = sTranslateCharacter("O", sSubString, nChannel, iCounter, " Âl"," ÂL", "", "", "", "", "", ""); break;
				case 41: sReturnString = sTranslateCharacter("P", sSubString, nChannel, iCounter, " Tl'"," TL'", "", "", "", "", "", ""); break;
				case 42: sReturnString = sTranslateCharacter("Q", sSubString, nChannel, iCounter, " Yi"," YI", "", "", "", "", "", ""); break;
				case 43: sReturnString = sTranslateCharacter("R", sSubString, nChannel, iCounter, " Li"," LI", "", "", "", "", "", ""); break;
				case 44: sReturnString = sTranslateCharacter("S", sSubString, nChannel, iCounter, " At'"," AT'", "", "", "", "", "", ""); break;
				case 45: sReturnString = sTranslateCharacter("T", sSubString, nChannel, iCounter, " Ah"," AH", "", "", "", "", "", ""); break;
				case 46: sReturnString = sTranslateCharacter("U", sSubString, nChannel, iCounter, " Tu"," TU", "", "", "", "", "", ""); break;
				case 47: sReturnString = sTranslateCharacter("V", sSubString, nChannel, iCounter, " To"," TO", "", "", "", "", "", ""); break;
				case 48: sReturnString = sTranslateCharacter("W", sSubString, nChannel, iCounter, " Âo"," ÂO", "", "", "", "", "", ""); break;
				case 49: sReturnString = sTranslateCharacter("X", sSubString, nChannel, iCounter, " Ho"," HO", "", "", "", "", "", ""); break;
				case 50: sReturnString = sTranslateCharacter("Y", sSubString, nChannel, iCounter, " Qi"," QI", "", "", "", "", "", ""); break;
				case 51: sReturnString = sTranslateCharacter("Z", sSubString, nChannel, iCounter, " Lu"," LU", "", "", "", "", "", ""); break;
				case 52: sReturnString = sTranslateCharacter(" ", sSubString, nChannel, iCounter, " ","", "", "", "", "", "", ""); break;
			
				default: if(sLetter=="!" || sLetter=="?" || sLetter=="."){sReturnString = sLetter;}else{sOutputString = sOutputString;} break;
			}
			if(sReturnString != "")
			{
				if(sReturnString !=  sDuplicate)
				{
					sOutputString = sOutputString + sReturnString;
					sDuplicate = sReturnString;
				}
				else
				{
					sOutputString = sOutputString;
				}
			}													
		}
	}
	return sOutputString;
}

string sOutPut_LNG_GIANT_D(string sSubString, int nChannel, object oSender)
{
	int iSubStringLength, iTrans, iCounter;
	int iClearTextStart, iClearTextEnd;
	string sLetter, sOutputString, sClearText, sReturnString , sDuplicate;
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ";    
	sOutputString = "";
	iSubStringLength = GetStringLength(sSubString);
		
	for(iCounter=0;iCounter <= iSubStringLength; iCounter++)
	{
		sLetter = GetSubString(sSubString,iCounter,1);

		if(sLetter == "*")
		{
			if(FindSubString(sSubString, "**", iCounter)== iCounter)
			{
				iClearTextStart = iCounter +2;
				iClearTextEnd = FindSubString(sSubString," ",iClearTextStart);
			
				if(iClearTextEnd == -1)
				{
					iClearTextEnd = iSubStringLength; 
				}
				
				sClearText = GetSubString(sSubString, iClearTextStart, iClearTextEnd - iClearTextStart );
				sOutputString = sOutputString + CLR_SPACE + sClearText + CLR_SPACE;
				iCounter = iClearTextEnd; 
			}
		}
		else
		{
			iTrans = FindSubString(sTranslate, sLetter);
	
			switch (iTrans)
		   	{
				case 0: sReturnString = sTranslateCharacter("a", sSubString, nChannel, iCounter, "","", "dehilrtz", "B'ER", "B'ER", "anos", "KÖN", "KÖN"); break;
				case 1: sReturnString = sTranslateCharacter("b", sSubString, nChannel, iCounter, "TJIL","TJIL", "dehilrtz", "TÅ", "TÅ", "anos", "BUR", "BUR"); break;
				case 2: sReturnString = sTranslateCharacter("c", sSubString, nChannel, iCounter, "KLÅ","KLÅ", "dehilrtz", "NEE", "NEE", "anos", "KA", "KA"); break;
				case 3: sReturnString = sTranslateCharacter("d", sSubString, nChannel, iCounter, "","", "dehilrtz", "BJØ", "BJØ", "", "", ""); break;
				case 4: sReturnString = sTranslateCharacter("e", sSubString, nChannel, iCounter, "","", "deirtz", "VÅ", "VÅ", "nshgl", "ËN", "ËN"); break;
				case 5: sReturnString = sTranslateCharacter("f", sSubString, nChannel, iCounter, "BIGG","BIGG", "dehilrtz", "FAJ", "FAJ", "anos", "ET", "ET"); break;
				case 6: sReturnString = sTranslateCharacter("g", sSubString, nChannel, iCounter, "SZ'VÅ","SZ'VÅ", "dehltz", "VE", "VE", "ainos", "EN", "EN"); break;
				case 7: sReturnString = sTranslateCharacter("h", sSubString, nChannel, iCounter, "","", "dehilrz", "SKAR", "SKAR", "t", "EH", "EH"); break;
				case 8: sReturnString = sTranslateCharacter("i", sSubString, nChannel, iCounter, "","", "dehirtz", "ENT", "ENT", "", "", ""); break;
				case 9: sReturnString = sTranslateCharacter("j", sSubString, nChannel, iCounter, "FLØE","FLØE", "dehilrtz", "HU", "HU", "anos", "FLI", "FLI"); break;
				case 10: sReturnString = sTranslateCharacter("k", sSubString, nChannel, iCounter, "NRG","NRG", "dehilrtz", "EFT", "EFT", "anos", "RAN", "RAN"); break;
				case 11: sReturnString = sTranslateCharacter("l", sSubString, nChannel, iCounter, "IT","IT", "dhirtz", "SNAR", "SNAR", "l", "ËTT", "ËTT"); break;
				case 12: sReturnString = sTranslateCharacter("m", sSubString, nChannel, iCounter, "SVAR","SVAR", "dehilrtz", "FÖR", "FÖR", "anos", "MØG", "MØG"); break;
				case 13: sReturnString = sTranslateCharacter("n", sSubString, nChannel, iCounter, "MAL","MAL", "dehilrtz", "MAL", "MAL", "anos", "UR", "UR"); break;
				case 14: sReturnString = sTranslateCharacter("o", sSubString, nChannel, iCounter, "","", "dehirtz", "GØ", "GØ", "C", "LL", "LL"); break;
				case 15: sReturnString = sTranslateCharacter("p", sSubString, nChannel, iCounter, "HAR","HAR", "dehilrtz", "HAR", "HAR", "anos", "RK", "RK"); break;
				case 16: sReturnString = sTranslateCharacter("q", sSubString, nChannel, iCounter, "TAC","TAC", "dehilrtz", "ARR", "ARR", "anos", "NAD", "NAD"); break;
				case 17: sReturnString = sTranslateCharacter("r", sSubString, nChannel, iCounter, "","", "dehilrtz", "ETT", "ETT", "u", "ENN", "ENN"); break;
				case 18: sReturnString = sTranslateCharacter("s", sSubString, nChannel, iCounter, "BLEK","BLEK", "dhiltz", "TER", "TER", "aenos", "HA", "HA"); break;
				case 19: sReturnString = sTranslateCharacter("t", sSubString, nChannel, iCounter, "","", "deilrz", "KËT", "KËT", "", "", ""); break;
				case 20: sReturnString = sTranslateCharacter("u", sSubString, nChannel, iCounter, "","", "dehilrtz", "DET", "DET", "S", "NE", "NE"); break;
				case 21: sReturnString = sTranslateCharacter("v", sSubString, nChannel, iCounter, "NAD","NAD", "dehilrtz", "DAT", "DAT", "anos", "NAR", "NAR"); break;
				case 22: sReturnString = sTranslateCharacter("w", sSubString, nChannel, iCounter, "VIN","VIN", "hilrtz", "KVA", "KVA", "anos", "ÅR", "ÅR"); break;
				case 23: sReturnString = sTranslateCharacter("x", sSubString, nChannel, iCounter, "DARG","DARG", "dehilrtz", "VÖL", "VÖL", "anos", "LL", "LL"); break;
				case 24: sReturnString = sTranslateCharacter("y", sSubString, nChannel, iCounter, "SAN","SAN", "dehilrtz", "JÅ", "JÅ", "anos", "K", "K"); break;
				case 25: sReturnString = sTranslateCharacter("z", sSubString, nChannel, iCounter, "","", "dehilrtz", "DE", "DE", "", "", ""); break;
				case 26: sReturnString = sTranslateCharacter("A", sSubString, nChannel, iCounter, " BLËR"," BLËR", "", "", "", "", "", ""); break;
				case 27: sReturnString = sTranslateCharacter("B", sSubString, nChannel, iCounter, " TA"," TA", "", "", "", "", "", ""); break;
				case 28: sReturnString = sTranslateCharacter("C", sSubString, nChannel, iCounter, " DU"," DU", "", "", "", "", "", ""); break;
				case 29: sReturnString = sTranslateCharacter("D", sSubString, nChannel, iCounter, " KÖ"," KÖ", "", "", "", "", "", ""); break;
				case 30: sReturnString = sTranslateCharacter("E", sSubString, nChannel, iCounter, " KO"," KO", "", "", "", "", "", ""); break;
				case 31: sReturnString = sTranslateCharacter("F", sSubString, nChannel, iCounter, " BJOR"," BJOR", "", "", "", "", "", ""); break;
				case 32: sReturnString = sTranslateCharacter("G", sSubString, nChannel, iCounter, " VI"," VI", "", "", "", "", "", ""); break;
				case 33: sReturnString = sTranslateCharacter("H", sSubString, nChannel, iCounter, " SKÅ"," SKÅ", "", "", "", "", "", ""); break;
				case 34: sReturnString = sTranslateCharacter("I", sSubString, nChannel, iCounter, " VÅ"," VÅ", "", "", "", "", "", ""," YØG ", " YØG "); break;
				case 35: sReturnString = sTranslateCharacter("J", sSubString, nChannel, iCounter, " HA"," HA", "", "", "", "", "", ""); break;
				case 36: sReturnString = sTranslateCharacter("K", sSubString, nChannel, iCounter, " EFT"," EFT", "", "", "", "", "", ""); break;
				case 37: sReturnString = sTranslateCharacter("L", sSubString, nChannel, iCounter, " ËT"," ËT", "", "", "", "", "", ""); break;
				case 38: sReturnString = sTranslateCharacter("M", sSubString, nChannel, iCounter, " FOR"," FOR", "", "", "", "", "", ""); break;
				case 39: sReturnString = sTranslateCharacter("N", sSubString, nChannel, iCounter, " UR"," UR", "", "", "", "", "", ""); break;
				case 40: sReturnString = sTranslateCharacter("O", sSubString, nChannel, iCounter, " GÖ"," GÖ", "", "", "", "", "", ""); break;
				case 41: sReturnString = sTranslateCharacter("P", sSubString, nChannel, iCounter, " HA"," HA", "", "", "", "", "", ""); break;
				case 42: sReturnString = sTranslateCharacter("Q", sSubString, nChannel, iCounter, " VA"," VA", "", "", "", "", "", ""); break;
				case 43: sReturnString = sTranslateCharacter("R", sSubString, nChannel, iCounter, " AR"," AR", "", "", "", "", "", ""); break;
				case 44: sReturnString = sTranslateCharacter("S", sSubString, nChannel, iCounter, " HE"," HE", "", "", "", "", "", ""); break;
				case 45: sReturnString = sTranslateCharacter("T", sSubString, nChannel, iCounter, " FØR"," FØR", "", "", "", "", "", ""); break;
				case 46: sReturnString = sTranslateCharacter("U", sSubString, nChannel, iCounter, " ÖRR"," ÖRR", "", "", "", "", "", ""); break;
				case 47: sReturnString = sTranslateCharacter("V", sSubString, nChannel, iCounter, " DET"," DET", "", "", "", "", "", ""); break;
				case 48: sReturnString = sTranslateCharacter("W", sSubString, nChannel, iCounter, " KAR"," KAR", "", "", "", "", "", ""); break;
				case 49: sReturnString = sTranslateCharacter("X", sSubString, nChannel, iCounter, " VÅL"," VÅL", "", "", "", "", "", ""); break;
				case 50: sReturnString = sTranslateCharacter("Y", sSubString, nChannel, iCounter, " JA"," JA", "", "", "", "", "", ""); break;
				case 51: sReturnString = sTranslateCharacter("Z", sSubString, nChannel, iCounter, " NÖ"," NÖ", "", "", "", "", "", ""); break;
				case 52: sReturnString = sTranslateCharacter(" ", sSubString, nChannel, iCounter, " ","", "", "", "", "", "", ""); break;
			
				default: if(sLetter=="!" || sLetter=="?" || sLetter=="."){sReturnString = sLetter;}else{sOutputString = sOutputString;} break;
			}
			if(sReturnString != "")
			{
				if(sReturnString !=  sDuplicate)
				{
					sOutputString = sOutputString + sReturnString;
					sDuplicate = sReturnString;
				}
				else
				{
					sOutputString = sOutputString;
				}
			}													
		}
	}
	return sOutputString;
}

string sOutPut_LNG_DRAGON_D(string sSubString, int nChannel, object oSender)
{
	int iSubStringLength, iTrans, iCounter;
	int iClearTextStart, iClearTextEnd;
	string sLetter, sOutputString, sClearText, sReturnString , sDuplicate;
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ";   
	sOutputString = "";
	iSubStringLength = GetStringLength(sSubString);
		
	for(iCounter=0;iCounter <= iSubStringLength; iCounter++)
	{
		sLetter = GetSubString(sSubString,iCounter,1);

		if(sLetter == "*")
		{
			if(FindSubString(sSubString, "**", iCounter)== iCounter)
			{
				iClearTextStart = iCounter +2;
				iClearTextEnd = FindSubString(sSubString," ",iClearTextStart);
			
				if(iClearTextEnd == -1)
				{
					iClearTextEnd = iSubStringLength; 
				}
				
				sClearText = GetSubString(sSubString, iClearTextStart, iClearTextEnd - iClearTextStart );
				sOutputString = sOutputString + CLR_SPACE + sClearText + CLR_SPACE;
				iCounter = iClearTextEnd; 
			}
		}
		else
		{
			iTrans = FindSubString(sTranslate, sLetter);
	
			switch (iTrans)
		   	{
				case 0: sReturnString = sTranslateCharacter("a", sSubString, nChannel, iCounter, "","", "diotv", " Fi", " FI", "enruz", " Fú", " FÚ"); break;
				case 1: sReturnString = sTranslateCharacter("b", sSubString, nChannel, iCounter, "ra","RA", "diotv", " Ka", " KA", "enruz", " Zâ", " ZÂ"); break;
				case 2: sReturnString = sTranslateCharacter("c", sSubString, nChannel, iCounter, "na","NA", "diotv", " Ss", " SS", "enruz", " Hî", " HÎ"); break;
				case 3: sReturnString = sTranslateCharacter("d", sSubString, nChannel, iCounter, "","", "diotvenruz", "ha", "HA", "", "", ""); break;
				case 4: sReturnString = sTranslateCharacter("e", sSubString, nChannel, iCounter, "","", "diotvenruz", "z", "Z", "", "", ""); break;
				case 5: sReturnString = sTranslateCharacter("f", sSubString, nChannel, iCounter, "il-","IL-", "diotv", " Fu", " FU", "enruz", " Ks", " KS"); break;
				case 6: sReturnString = sTranslateCharacter("g", sSubString, nChannel, iCounter, "","", "diotv", " Zâ", " ZÂ", "enruz", " Ru", " RU"); break;
				case 7: sReturnString = sTranslateCharacter("h", sSubString, nChannel, iCounter, "ar","AR", "diotvenruz", " Ki", " KI", "", "", ""); break;
				case 8: sReturnString = sTranslateCharacter("i", sSubString, nChannel, iCounter, "","", "diotvenruz", "ha", "HA", "", "", ""); break;
				case 9: sReturnString = sTranslateCharacter("j", sSubString, nChannel, iCounter, "ez","EZ", "diotv", " Fa", " FA", "enruz", " Hu", " HU"); break;
				case 10: sReturnString = sTranslateCharacter("k", sSubString, nChannel, iCounter, "na","NA", "diotv", " Le", " LE", "enruz", " Fs", " FS"); break;
				case 11: sReturnString = sTranslateCharacter("l", sSubString, nChannel, iCounter, "ke","KE", "diotvenruz", " Kà", " KÀ", "", "", ""); break;
				case 12: sReturnString = sTranslateCharacter("m", sSubString, nChannel, iCounter, "z","Z", "diotv", " Fæ", " FÆ", "enruz", " Fú", " FÚ"); break;
				case 13: sReturnString = sTranslateCharacter("n", sSubString, nChannel, iCounter, "","", "diotvenruz", "iz", "IZ", "", "", ""); break;
				case 14: sReturnString = sTranslateCharacter("o", sSubString, nChannel, iCounter, "","", "diotvenruz", "f's", "F'S", "", "", ""); break;
				case 15: sReturnString = sTranslateCharacter("p", sSubString, nChannel, iCounter, "ah-","AH-", "diotv", " K'z", " K'Z", "enruz", " Hu", " HU"); break;
				case 16: sReturnString = sTranslateCharacter("q", sSubString, nChannel, iCounter, "i","I", "diotv", " Na", " NA", "enruz", " F'z", " F'Z"); break;
				case 17: sReturnString = sTranslateCharacter("r", sSubString, nChannel, iCounter, "","", "diotvenruz", "na", "NA", "", "", ""); break;
				case 18: sReturnString = sTranslateCharacter("s", sSubString, nChannel, iCounter, "s's","S'S", "diotv", " Ps", " PS", "enruz", " Sâ", " SÂ"); break;
				case 19: sReturnString = sTranslateCharacter("t", sSubString, nChannel, iCounter, "","", "diotvenruz", "s", "S", "", "", ""); break;
				case 20: sReturnString = sTranslateCharacter("u", sSubString, nChannel, iCounter, "","", "diotvenruz", "ha", "HA", "", "", ""); break;
				case 21: sReturnString = sTranslateCharacter("v", sSubString, nChannel, iCounter, "","", "diotv", " Hu", " HU", "enruz", " Z's", " Z'S"); break;
				case 22: sReturnString = sTranslateCharacter("w", sSubString, nChannel, iCounter, "ha","HA", "diotv", " fs", " FS", "enruz", " Pz", " PZ"); break;
				case 23: sReturnString = sTranslateCharacter("x", sSubString, nChannel, iCounter, "ki","KI", "diotv", " Hî", " HÎ", "enruz", " Ka", " KA"); break;
				case 24: sReturnString = sTranslateCharacter("y", sSubString, nChannel, iCounter, "il","IL", "diotv", " Hu", " HU", "enruz", " Ra", " RA"); break;
				case 25: sReturnString = sTranslateCharacter("z", sSubString, nChannel, iCounter, "","", "diotvenruz", "s", "S", "", "", ""); break;
				case 26: sReturnString = sTranslateCharacter("A", sSubString, nChannel, iCounter, " Fi"," FI", "", "", "", "", "", ""); break;
				case 27: sReturnString = sTranslateCharacter("B", sSubString, nChannel, iCounter, " Ka"," KA", "", "", "", "", "", ""); break;
				case 28: sReturnString = sTranslateCharacter("C", sSubString, nChannel, iCounter, " Zs"," ZS", "", "", "", "", "", ""); break;
				case 29: sReturnString = sTranslateCharacter("D", sSubString, nChannel, iCounter, " Ps"," PS", "", "", "", "", "", ""); break;
				case 30: sReturnString = sTranslateCharacter("E", sSubString, nChannel, iCounter, " Kà"," KÀ", "", "", "", "", "", ""); break;
				case 31: sReturnString = sTranslateCharacter("F", sSubString, nChannel, iCounter, " Fu"," FU", "", "", "", "", "", ""); break;
				case 32: sReturnString = sTranslateCharacter("G", sSubString, nChannel, iCounter, " Zâ"," ZÂ", "", "", "", "", "", ""); break;
				case 33: sReturnString = sTranslateCharacter("H", sSubString, nChannel, iCounter, " Ki"," KI", "", "", "", "", "", ""); break;
				case 34: sReturnString = sTranslateCharacter("I", sSubString, nChannel, iCounter, " Pa"," PA", "", "", "", "", "", "null","null"); break;
				case 35: sReturnString = sTranslateCharacter("J", sSubString, nChannel, iCounter, " Faa"," FAA", "", "", "", "", "", ""); break;
				case 36: sReturnString = sTranslateCharacter("K", sSubString, nChannel, iCounter, " Le"," LE", "", "", "", "", "", ""); break;
				case 37: sReturnString = sTranslateCharacter("L", sSubString, nChannel, iCounter, " Kà"," KÀ", "", "", "", "", "", ""); break;
				case 38: sReturnString = sTranslateCharacter("M", sSubString, nChannel, iCounter, " Fæ"," FÆ", "", "", "", "", "", ""); break;
				case 39: sReturnString = sTranslateCharacter("N", sSubString, nChannel, iCounter, " Is"," IS", "", "", "", "", "", ""); break;
				case 40: sReturnString = sTranslateCharacter("O", sSubString, nChannel, iCounter, " Æs"," ÆS", "", "", "", "", "", ""); break;
				case 41: sReturnString = sTranslateCharacter("P", sSubString, nChannel, iCounter, " K's"," K'S", "", "", "", "", "", ""); break;
				case 42: sReturnString = sTranslateCharacter("Q", sSubString, nChannel, iCounter, " Ra"," RA", "", "", "", "", "", ""); break;
				case 43: sReturnString = sTranslateCharacter("R", sSubString, nChannel, iCounter, " Z's"," Z'S", "", "", "", "", "", ""); break;
				case 44: sReturnString = sTranslateCharacter("S", sSubString, nChannel, iCounter, " Ps"," PS", "", "", "", "", "", ""); break;
				case 45: sReturnString = sTranslateCharacter("T", sSubString, nChannel, iCounter, " Ka"," KA", "", "", "", "", "", ""); break;
				case 46: sReturnString = sTranslateCharacter("U", sSubString, nChannel, iCounter, " Ra"," RA", "", "", "", "", "", ""); break;
				case 47: sReturnString = sTranslateCharacter("V", sSubString, nChannel, iCounter, " Hu"," HU", "", "", "", "", "", ""); break;
				case 48: sReturnString = sTranslateCharacter("W", sSubString, nChannel, iCounter, " Fs"," FS", "", "", "", "", "", ""); break;
				case 49: sReturnString = sTranslateCharacter("X", sSubString, nChannel, iCounter, " Hî"," HÎ", "", "", "", "", "", ""); break;
				case 50: sReturnString = sTranslateCharacter("Y", sSubString, nChannel, iCounter, " Ru"," RU", "", "", "", "", "", ""); break;
				case 51: sReturnString = sTranslateCharacter("Z", sSubString, nChannel, iCounter, " P'z"," P'Z", "", "", "", "", "", ""); break;
				case 52: sReturnString = sTranslateCharacter(" ", sSubString, nChannel, iCounter, " ","", "", "", "", "", "", ""); break;
			
				default: if(sLetter=="!" || sLetter=="?" || sLetter=="."){sReturnString = sLetter;}else{sOutputString = sOutputString;} break;
			}
			if(sReturnString != "")
			{
				if(sReturnString !=  sDuplicate)
				{
					sOutputString = sOutputString + sReturnString;
					sDuplicate = sReturnString;
				}
				else
				{
					sOutputString = sOutputString;
				}
			}													
		}
	}
	return sOutputString;
}

string sOutPut_LNG_GNOLL_D(string sSubString, int nChannel, object oSender)
{
	int iSubStringLength, iTrans, iCounter;
	int iClearTextStart, iClearTextEnd;
	string sLetter, sOutputString, sClearText, sReturnString , sDuplicate;
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ";    
	sOutputString = "";
	iSubStringLength = GetStringLength(sSubString);
		
	for(iCounter=0;iCounter <= iSubStringLength; iCounter++)
	{
		sLetter = GetSubString(sSubString,iCounter,1);

		if(sLetter == "*")
		{
			if(FindSubString(sSubString, "**", iCounter)== iCounter)
			{
				iClearTextStart = iCounter +2;
				iClearTextEnd = FindSubString(sSubString," ",iClearTextStart);
			
				if(iClearTextEnd == -1)
				{
					iClearTextEnd = iSubStringLength; 
				}
				
				sClearText = GetSubString(sSubString, iClearTextStart, iClearTextEnd - iClearTextStart );
				sOutputString = sOutputString + CLR_SPACE + sClearText + CLR_SPACE;
				iCounter = iClearTextEnd; 
			}
		}
		else
		{
			iTrans = FindSubString(sTranslate, sLetter);
	
			switch (iTrans)
		   	{
				case 0: sReturnString = sTranslateCharacter("a", sSubString, nChannel, iCounter, "ha","HA", "bcgklqvwxyz", "-hâ'a", "-HÂ'A", "aeiou", "hâ", "HÂ"); break;
				case 1: sReturnString = sTranslateCharacter("b", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 2: sReturnString = sTranslateCharacter("c", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 3: sReturnString = sTranslateCharacter("d", sSubString, nChannel, iCounter, "ga'a","GA'A", "bcgklqvwxyz", "-he", "-HE", "aeiou", "a-é", "A-É"); break;
				case 4: sReturnString = sTranslateCharacter("e", sSubString, nChannel, iCounter, "ka","KA", " bcgklqvwxyz", "-ga", "-GA", "aeiou", "hâ'a", "HÂ'A"); break;
				case 5: sReturnString = sTranslateCharacter("f", sSubString, nChannel, iCounter, "d'a","D'A", "bcgklqvwxyz", "-k'ah", "-K'AH", "aeiou", "a'ah", "A'AH"); break;
				case 6: sReturnString = sTranslateCharacter("g", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 7: sReturnString = sTranslateCharacter("h", sSubString, nChannel, iCounter, "ou","OU", "bcgklqvwxyzt", "-gâ", "-GÂ", "aeiou", "k'a", "K'A"); break;
				case 8: sReturnString = sTranslateCharacter("i", sSubString, nChannel, iCounter, "ga'a","GA'A", "bcgklqvwxyz", "-he", "-HE", "aeiou", "a-é", "A-É"); break;
				case 9: sReturnString = sTranslateCharacter("j", sSubString, nChannel, iCounter, "aa","AA", "bcgklqvwxyz", "ge", "GE", "aeiou", "ro", "RO"); break;
				case 10: sReturnString = sTranslateCharacter("k", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 11: sReturnString = sTranslateCharacter("l", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 12: sReturnString = sTranslateCharacter("m", sSubString, nChannel, iCounter, "k'a","K'A", "bcgklqvwxyz", "-d'e", "-D'E", "aeiou", "rê ", "RÊ "); break;
				case 13: sReturnString = sTranslateCharacter("n", sSubString, nChannel, iCounter, "ii","II", "bcgklqvwxyz", "-d'ah", "-D'AH", "aeiou", "ra", "RA"); break;
				case 14: sReturnString = sTranslateCharacter("o", sSubString, nChannel, iCounter, "gha","GHA", "bcgklqvwxyz", "-r'a", "-R'A", "aeiou", "na'h", "NA'H"); break;
				case 15: sReturnString = sTranslateCharacter("p", sSubString, nChannel, iCounter, "hi","HI", "bcgklqvwxyz", "-n'a", "-N'A", "aeiou", "ge", "GE"); break;
				case 16: sReturnString = sTranslateCharacter("q", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 17: sReturnString = sTranslateCharacter("r", sSubString, nChannel, iCounter, "ka","KA", "bcgklqvwxyz", "", "", "", "", ""); break;
				case 18: sReturnString = sTranslateCharacter("s", sSubString, nChannel, iCounter, "h'a","H'A", "bcgklqvwxyz", "", "", "", "", ""); break;
				case 19: sReturnString = sTranslateCharacter("t", sSubString, nChannel, iCounter, "h'e","H'E", "bcgklqvwxyz", "-hâ", "-HÂ", "aeiou", "-da", "-DA"); break;
				case 20: sReturnString = sTranslateCharacter("u", sSubString, nChannel, iCounter, "ke","KE", "bcgklqvwxyz", "-na", "-NA", "aeiou", "h'a", "H'A"); break;
				case 21: sReturnString = sTranslateCharacter("v", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 22: sReturnString = sTranslateCharacter("w", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 23: sReturnString = sTranslateCharacter("x", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 24: sReturnString = sTranslateCharacter("y", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 25: sReturnString = sTranslateCharacter("z", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 26: sReturnString = sTranslateCharacter("A", sSubString, nChannel, iCounter, " Hâ'a"," HÂ'A", "", "", "", "", "", ""); break;
				case 27: sReturnString = sTranslateCharacter("B", sSubString, nChannel, iCounter, " Ha"," HA", "", "", "", "", "", ""); break;
				case 28: sReturnString = sTranslateCharacter("C", sSubString, nChannel, iCounter, " K'ah"," K'AH", "", "", "", "", "", ""); break;
				case 29: sReturnString = sTranslateCharacter("D", sSubString, nChannel, iCounter, " He"," HE", "", "", "", "", "", ""); break;
				case 30: sReturnString = sTranslateCharacter("E", sSubString, nChannel, iCounter, " Ha"," HA", "", "", "", "", "", ""); break;
				case 31: sReturnString = sTranslateCharacter("F", sSubString, nChannel, iCounter, " K'ah"," K'AH", "", "", "", "", "", ""); break;
				case 32: sReturnString = sTranslateCharacter("G", sSubString, nChannel, iCounter, " D'e"," D'E", "", "", "", "", "", ""); break;
				case 33: sReturnString = sTranslateCharacter("H", sSubString, nChannel, iCounter, " Gâ"," GÂ", "", "", "", "", "", ""); break;
				case 34: sReturnString = sTranslateCharacter("I", sSubString, nChannel, iCounter, " Ga"," GA", "", "", "", "", "", "","k'ah", "K'AH"); break;
				case 35: sReturnString = sTranslateCharacter("J", sSubString, nChannel, iCounter, " Ge"," GE", "", "", "", "", "", ""); break;
				case 36: sReturnString = sTranslateCharacter("K", sSubString, nChannel, iCounter, " Hâ"," HÂ", "", "", "", "", "", ""); break;
				case 37: sReturnString = sTranslateCharacter("L", sSubString, nChannel, iCounter, " He"," HE", "", "", "", "", "", ""); break;
				case 38: sReturnString = sTranslateCharacter("M", sSubString, nChannel, iCounter, " D'e"," D'E", "", "", "", "", "", ""); break;
				case 39: sReturnString = sTranslateCharacter("N", sSubString, nChannel, iCounter, " D'ah"," D'AH", "", "", "", "", "null", "null"); break;
				case 40: sReturnString = sTranslateCharacter("O", sSubString, nChannel, iCounter, " R'a"," R'A", "", "", "", "", "", ""); break;
				case 41: sReturnString = sTranslateCharacter("P", sSubString, nChannel, iCounter, " N'a"," N'A", "", "", "", "", "", ""); break;
				case 42: sReturnString = sTranslateCharacter("Q", sSubString, nChannel, iCounter, " Ga"," GA", "", "", "", "", "", ""); break;
				case 43: sReturnString = sTranslateCharacter("R", sSubString, nChannel, iCounter, " Hâ"," HÂ", "", "", "", "", "", ""); break;
				case 44: sReturnString = sTranslateCharacter("S", sSubString, nChannel, iCounter, " D'ah"," D'AH", "", "", "", "", "", ""); break;
				case 45: sReturnString = sTranslateCharacter("T", sSubString, nChannel, iCounter, " Hâ"," HÂ", "", "", "", "", "", ""); break;
				case 46: sReturnString = sTranslateCharacter("U", sSubString, nChannel, iCounter, " Na"," NA", "", "", "", "", "", ""); break;
				case 47: sReturnString = sTranslateCharacter("V", sSubString, nChannel, iCounter, " R'a"," R'A", "", "", "", "", "", ""); break;
				case 48: sReturnString = sTranslateCharacter("W", sSubString, nChannel, iCounter, " Re"," RE", "", "", "", "", "", ""); break;
				case 49: sReturnString = sTranslateCharacter("X", sSubString, nChannel, iCounter, " K'ah"," K'AH", "", "", "", "", "", ""); break;
				case 50: sReturnString = sTranslateCharacter("Y", sSubString, nChannel, iCounter, " He"," HE", "", "", "", "", "", ""); break;
				case 51: sReturnString = sTranslateCharacter("Z", sSubString, nChannel, iCounter, " Hâ"," HÂ", "", "", "", "", "", ""); break;
				case 52: sReturnString = sTranslateCharacter(" ", sSubString, nChannel, iCounter, " ","", "", "", "", "", "", ""); break;
	
				default: if(sLetter=="!" || sLetter=="?" || sLetter=="."){sReturnString = sLetter;}else{sOutputString = sOutputString;} break;
			}
			if(sReturnString != "")
			{
				if(sReturnString !=  sDuplicate)
				{
					sOutputString = sOutputString + sReturnString;
					sDuplicate = sReturnString;
				}
				else
				{
					sOutputString = sOutputString;
				}
			}													
		}
	}
	return sOutputString;
}

string sOutPut_LNG_FAYE(string sSubString, int nChannel, object oSender)
{
	int iSubStringLength, iTrans, iCounter;
	int iClearTextStart, iClearTextEnd;
	string sLetter, sOutputString, sClearText, sReturnString , sDuplicate;
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ";    
	sOutputString = "";
	iSubStringLength = GetStringLength(sSubString);
		
	for(iCounter=0;iCounter <= iSubStringLength; iCounter++)
	{
		sLetter = GetSubString(sSubString,iCounter,1);

		if(sLetter == "*")
		{
			if(FindSubString(sSubString, "**", iCounter)== iCounter)
			{
				iClearTextStart = iCounter +2;
				iClearTextEnd = FindSubString(sSubString," ",iClearTextStart);
			
				if(iClearTextEnd == -1)
				{
					iClearTextEnd = iSubStringLength; 
				}
				
				sClearText = GetSubString(sSubString, iClearTextStart, iClearTextEnd - iClearTextStart );
				sOutputString = sOutputString + CLR_SPACE + sClearText + CLR_SPACE;
				iCounter = iClearTextEnd; 
			}
		}
		else
		{
			iTrans = FindSubString(sTranslate, sLetter);
	
			switch (iTrans)
		   	{
				case 0: sReturnString = sTranslateCharacter("a", sSubString, nChannel, iCounter, "l","L", "elotm", " çu", " ÇU", "ahnrs", "ç'a", "Ç'A"); break;
				case 1: sReturnString = sTranslateCharacter("b", sSubString, nChannel, iCounter, "ni","NI", "elotm", " él", " ÉL", "ahnrs", "fa", "FA"); break;
				case 2: sReturnString = sTranslateCharacter("c", sSubString, nChannel, iCounter, "ill","ILL", "elotm", " ho", " HO", "ahnrs", "in", "IN"); break;
				case 3: sReturnString = sTranslateCharacter("d", sSubString, nChannel, iCounter, "ne","NE", "elotm", " rû", " RÛ", "ahnrs", "he", "HE"); break;
				case 4: sReturnString = sTranslateCharacter("e", sSubString, nChannel, iCounter, "","", "l", " gû", " GÛ", "n", "rim", "RIM"); break;
				case 5: sReturnString = sTranslateCharacter("f", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 6: sReturnString = sTranslateCharacter("g", sSubString, nChannel, iCounter, "th","TH", "elotm", " lá", " LÁ", "ahnrs", "fâr", "FÂR"); break;
				case 7: sReturnString = sTranslateCharacter("h", sSubString, nChannel, iCounter, "rén","RÉN", "elotm", " me", " ME", "ahnrs", "ûr", "ÛR"); break;
				case 8: sReturnString = sTranslateCharacter("i", sSubString, nChannel, iCounter, "","", "ahnrs", "m-â", "M-Â", "vV", "tél", "TÉL"); break;
				case 9: sReturnString = sTranslateCharacter("j", sSubString, nChannel, iCounter, "esse","ESSE", "elotm", " qû", " QÛ", "ahnrs", "ll", "LL"); break;
				case 10: sReturnString = sTranslateCharacter("k", sSubString, nChannel, iCounter, "fá","FÁ", "elotm", " fa", " FA", "ahnrs", "ma", "MA"); break;
				case 11: sReturnString = sTranslateCharacter("l", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 12: sReturnString = sTranslateCharacter("m", sSubString, nChannel, iCounter, "","", "ahnrs", "-rim", "-RIM", "", "", ""); break;
				case 13: sReturnString = sTranslateCharacter("n", sSubString, nChannel, iCounter, "th","TH", "elotm", " na", " NA", "ahnrs", "ér", "ÉR"); break;
				case 14: sReturnString = sTranslateCharacter("o", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 15: sReturnString = sTranslateCharacter("p", sSubString, nChannel, iCounter, "ya","YA", "elotm", " ni", " NI", "ahnrs", "oh", "OH"); break;
				case 16: sReturnString = sTranslateCharacter("q", sSubString, nChannel, iCounter, "dur","DUR", "elotm", " mâ", " MÂ", "ahnrs", "th", "TH"); break;
				case 17: sReturnString = sTranslateCharacter("r", sSubString, nChannel, iCounter, "ár","ÁR", "elotm", " fy", " FY", "ahnrs", "it", "IT"); break;
				case 18: sReturnString = sTranslateCharacter("s", sSubString, nChannel, iCounter, "on","ON", "elotm", " lir", " LIR", "ahnrs", "hû", "HÛ"); break;
				case 19: sReturnString = sTranslateCharacter("t", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 20: sReturnString = sTranslateCharacter("u", sSubString, nChannel, iCounter, "qu","QU", "elotm", " he", " HE", "ahnrs", "pa", "PA"); break;
				case 21: sReturnString = sTranslateCharacter("v", sSubString, nChannel, iCounter, "er","ER", "elotm", " er", " ER", "ahnrs", "t", "T"); break;
				case 22: sReturnString = sTranslateCharacter("w", sSubString, nChannel, iCounter, "ço","ÇO", "elotm", " éi", " ÉI", "ahnrs", "ezze", "EZZE"); break;
				case 23: sReturnString = sTranslateCharacter("x", sSubString, nChannel, iCounter, "çe","ÇE", "elotm", " qa", " QA", "ahnrs", "zi", "ZI"); break;
				case 24: sReturnString = sTranslateCharacter("y", sSubString, nChannel, iCounter, "","", "hnrs", "-", "-", "", "", ""); break;
				case 25: sReturnString = sTranslateCharacter("z", sSubString, nChannel, iCounter, "zt","ZT", "elotm", " li", " LI", "ahnrs", "th", "TH"); break;
				case 26: sReturnString = sTranslateCharacter("A", sSubString, nChannel, iCounter, " Çu"," ÇU", "", "", "", "", "", ""); break;
				case 27: sReturnString = sTranslateCharacter("B", sSubString, nChannel, iCounter, " Ál"," ÁL", "", "", "", "", "", ""); break;
				case 28: sReturnString = sTranslateCharacter("C", sSubString, nChannel, iCounter, " Ho"," HO", "", "", "", "", "", ""); break;
				case 29: sReturnString = sTranslateCharacter("D", sSubString, nChannel, iCounter, " Ro"," RO", "", "", "", "", "", ""); break;
				case 30: sReturnString = sTranslateCharacter("E", sSubString, nChannel, iCounter, " Ç"," Ç", "", "", "", "", "", ""); break;
				case 31: sReturnString = sTranslateCharacter("F", sSubString, nChannel, iCounter, " Sî"," SÎ", "", "", "", "", "", ""); break;
				case 32: sReturnString = sTranslateCharacter("G", sSubString, nChannel, iCounter, " Lá"," LÁ", "", "", "", "", "", ""); break;
				case 33: sReturnString = sTranslateCharacter("H", sSubString, nChannel, iCounter, " Me"," ME", "", "", "", "", "", ""); break;
				case 34: sReturnString = sTranslateCharacter("I", sSubString, nChannel, iCounter, " Mê"," MÊ", "", "", "", "", "", "null","null"); break;
				case 35: sReturnString = sTranslateCharacter("J", sSubString, nChannel, iCounter, " Qu"," QU", "", "", "", "", "", ""); break;
				case 36: sReturnString = sTranslateCharacter("K", sSubString, nChannel, iCounter, " Fa"," FA", "", "", "", "", "", ""); break;
				case 37: sReturnString = sTranslateCharacter("L", sSubString, nChannel, iCounter, " Ná"," NÁ", "", "", "", "", "", ""); break;
				case 38: sReturnString = sTranslateCharacter("M", sSubString, nChannel, iCounter, " Fal"," FAL", "", "", "", "", "", ""); break;
				case 39: sReturnString = sTranslateCharacter("N", sSubString, nChannel, iCounter, " Na"," NA", "", "", "", "", "", ""); break;
				case 40: sReturnString = sTranslateCharacter("O", sSubString, nChannel, iCounter, " Me"," ME", "", "", "", "", "", ""); break;
				case 41: sReturnString = sTranslateCharacter("P", sSubString, nChannel, iCounter, " Ni"," NI", "", "", "", "", "", ""); break;
				case 42: sReturnString = sTranslateCharacter("Q", sSubString, nChannel, iCounter, " Ma"," MA", "", "", "", "", "", ""); break;
				case 43: sReturnString = sTranslateCharacter("R", sSubString, nChannel, iCounter, " Fy"," FY", "", "", "", "", "", ""); break;
				case 44: sReturnString = sTranslateCharacter("S", sSubString, nChannel, iCounter, " Li"," LI", "", "", "", "", "", ""); break;
				case 45: sReturnString = sTranslateCharacter("T", sSubString, nChannel, iCounter, " Al"," AL", "", "", "", "", "", ""); break;
				case 46: sReturnString = sTranslateCharacter("U", sSubString, nChannel, iCounter, " He"," HE", "", "", "", "", "", ""); break;
				case 47: sReturnString = sTranslateCharacter("V", sSubString, nChannel, iCounter, " I'"," I'", "", "", "", "", "", ""); break;
				case 48: sReturnString = sTranslateCharacter("W", sSubString, nChannel, iCounter, " Ei"," EI", "", "", "", "", "", ""); break;
				case 49: sReturnString = sTranslateCharacter("X", sSubString, nChannel, iCounter, " Qa"," QA", "", "", "", "", "", ""); break;
				case 50: sReturnString = sTranslateCharacter("Y", sSubString, nChannel, iCounter, " Çù"," ÇÙ", "", "", "", "", "", ""); break;
				case 51: sReturnString = sTranslateCharacter("Z", sSubString, nChannel, iCounter, " Li"," LI", "", "", "", "", "", ""); break;
				case 52: sReturnString = sTranslateCharacter(" ", sSubString, nChannel, iCounter, " ","", "", "", "", "", "", ""); break;
	
				default: if(sLetter=="!" || sLetter=="?" || sLetter=="."){sReturnString = sLetter;}else{sOutputString = sOutputString;} break;
			}
			if(sReturnString != "")
			{
				if(sReturnString !=  sDuplicate)
				{
					sOutputString = sOutputString + sReturnString;
					sDuplicate = sReturnString;
				}
				else
				{
					sOutputString = sOutputString;
				}
			}													
		}
	}
	return sOutputString;
}

string sOutPut_LNG_GOBLIN_D(string sSubString, int nChannel, object oSender)
{
	int iSubStringLength, iTrans, iCounter;
	int iClearTextStart, iClearTextEnd;
	string sLetter, sOutputString, sClearText, sReturnString , sDuplicate;
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ";   
	sOutputString = "";
	iSubStringLength = GetStringLength(sSubString);
		
	for(iCounter=0;iCounter <= iSubStringLength; iCounter++)
	{
		sLetter = GetSubString(sSubString,iCounter,1);

		if(sLetter == "*")
		{
			if(FindSubString(sSubString, "**", iCounter)== iCounter)
			{
				iClearTextStart = iCounter +2;
				iClearTextEnd = FindSubString(sSubString," ",iClearTextStart);
			
				if(iClearTextEnd == -1)
				{
					iClearTextEnd = iSubStringLength; 
				}
				
				sClearText = GetSubString(sSubString, iClearTextStart, iClearTextEnd - iClearTextStart );
				sOutputString = sOutputString + CLR_SPACE + sClearText + CLR_SPACE;
				iCounter = iClearTextEnd; 
			}
		}
		else
		{
			iTrans = FindSubString(sTranslate, sLetter);
	
			switch (iTrans)
		   	{
				case 0: sReturnString = sTranslateCharacter("a", sSubString, nChannel, iCounter, "","", "bcegjklpqruvx", "rb", "RB", "hinostw", " näzg", " NÄZG"); break;
				case 1: sReturnString = sTranslateCharacter("b", sSubString, nChannel, iCounter, "sh","SH", "ahinostw", " ya", " YA", "", "", ""); break;
				case 2: sReturnString = sTranslateCharacter("c", sSubString, nChannel, iCounter, "e'e","E'E", "ahinostw", " ag", " AG", "", "", ""); break;
				case 3: sReturnString = sTranslateCharacter("d", sSubString, nChannel, iCounter, "at","AT", "ahinostw", " ul", " UL", "", "", ""); break;
				case 4: sReturnString = sTranslateCharacter("e", sSubString, nChannel, iCounter, "","", "ahinostw", " kil'k", " KIL'K", "", "", ""); break;
				case 5: sReturnString = sTranslateCharacter("f", sSubString, nChannel, iCounter, "rum","RUM", "ahinostw", " du", " DU", "", "", ""); break;
				case 6: sReturnString = sTranslateCharacter("g", sSubString, nChannel, iCounter, "ek","EK", "ahinostw", " ye", " YE", "", " ng'k", " NG'K"); break;
				case 7: sReturnString = sTranslateCharacter("h", sSubString, nChannel, iCounter, "","", "bcegjklpqruvx", "h ", "H ", "ainostw", " glem", " GLEM"); break;
				case 8: sReturnString = sTranslateCharacter("i", sSubString, nChannel, iCounter, "","", "bcegjklpqruvx", "uk", "UK", "ahnostw", "akh", "AKH"); break;
				case 9: sReturnString = sTranslateCharacter("j", sSubString, nChannel, iCounter, "ma","MA", "ahinostw", " yi", " YI", "", "", ""); break;
				case 10: sReturnString = sTranslateCharacter("k", sSubString, nChannel, iCounter, "ra","RA", "ahinostw", " ge", " GE", "", "", ""); break;
				case 11: sReturnString = sTranslateCharacter("l", sSubString, nChannel, iCounter, "","", "ahinostw", " et'l", " ET'L", "", "", ""); break;
				case 12: sReturnString = sTranslateCharacter("m", sSubString, nChannel, iCounter, "sha","SHA", "ahinostw", " gi", " GI", "", "", ""); break;
				case 13: sReturnString = sTranslateCharacter("n", sSubString, nChannel, iCounter, "","", "bcegjklpqruvx", "sh", "SH", "ahiostw", " hi'i", " HI'I"); break;
				case 14: sReturnString = sTranslateCharacter("o", sSubString, nChannel, iCounter, "","", "bcegjklpqruvx", "ob", "OB", "ahinstw", " u", " U"); break;
				case 15: sReturnString = sTranslateCharacter("p", sSubString, nChannel, iCounter, "rzu","RZU", "ahinostw", " tre", " TRE", "", "", ""); break;
				case 16: sReturnString = sTranslateCharacter("q", sSubString, nChannel, iCounter, "","", "ahinostw", " zhee", " ZHEE", "", "", ""); break;
				case 17: sReturnString = sTranslateCharacter("r", sSubString, nChannel, iCounter, "im","IM", "ahinostw", " pi", " PI", "", "", ""); break;
				case 18: sReturnString = sTranslateCharacter("s", sSubString, nChannel, iCounter, "","", "bcegjklpqruvx", "sh", "SH", "ahinotw", " ai", " AI"); break;
				case 19: sReturnString = sTranslateCharacter("t", sSubString, nChannel, iCounter, "","", "bcegjklpqruvx", "um", "UM", "ahinosw", " yilk", " YILK"); break;
				case 20: sReturnString = sTranslateCharacter("u", sSubString, nChannel, iCounter, "pa","PA", "ahinostw", " sze", " SZE", "", "", ""); break;
				case 21: sReturnString = sTranslateCharacter("v", sSubString, nChannel, iCounter, "sh","SH", "ahinostw", " bu", " BU", "", "", ""); break;
				case 22: sReturnString = sTranslateCharacter("w", sSubString, nChannel, iCounter, "","", "bcegjklpqruvx", "hi", "HI", "ahinost", " öeb", " ÖEB"); break;
				case 23: sReturnString = sTranslateCharacter("x", sSubString, nChannel, iCounter, "as","AS", "ahinostw", " 'ag", " 'AG", "", "", ""); break;
				case 24: sReturnString = sTranslateCharacter("y", sSubString, nChannel, iCounter, "","", "ahinostw", " khar", " KHAR", "", "", ""); break;
				case 25: sReturnString = sTranslateCharacter("z", sSubString, nChannel, iCounter, "","", "ahinostw", " yeom", " YEOM", "", "", ""); break;
				case 26: sReturnString = sTranslateCharacter("A", sSubString, nChannel, iCounter, " Go"," GO", "", "", "", "", "", ""); break;
				case 27: sReturnString = sTranslateCharacter("B", sSubString, nChannel, iCounter, " Ga"," GA", "", "", "", "", "", ""); break;
				case 28: sReturnString = sTranslateCharacter("C", sSubString, nChannel, iCounter, " As"," AS", "", "", "", "", "", ""); break;
				case 29: sReturnString = sTranslateCharacter("D", sSubString, nChannel, iCounter, " Ug"," UG", "", "", "", "", "", ""); break;
				case 30: sReturnString = sTranslateCharacter("E", sSubString, nChannel, iCounter, " A"," A", "", "", "", "", "", ""); break;
				case 31: sReturnString = sTranslateCharacter("F", sSubString, nChannel, iCounter, " Ku"," KU", "", "", "", "", "", ""); break;
				case 32: sReturnString = sTranslateCharacter("G", sSubString, nChannel, iCounter, " Bâ"," BÂ", "", "", "", "", "", ""); break;
				case 33: sReturnString = sTranslateCharacter("H", sSubString, nChannel, iCounter, " Ba"," BA", "", "", "", "", "", ""); break;
				case 34: sReturnString = sTranslateCharacter("I", sSubString, nChannel, iCounter, " Uk"," UK", "", "", "", "", "", ""," shän ", " SHÄN "); break;
				case 35: sReturnString = sTranslateCharacter("J", sSubString, nChannel, iCounter, " Ul"," UL", "", "", "", "", "", ""); break;
				case 36: sReturnString = sTranslateCharacter("K", sSubString, nChannel, iCounter, " Gôl"," GÔL", "", "", "", "", "", ""); break;
				case 37: sReturnString = sTranslateCharacter("L", sSubString, nChannel, iCounter, " Za"," ZA", "", "", "", "", "", ""); break;
				case 38: sReturnString = sTranslateCharacter("M", sSubString, nChannel, iCounter, " Gi"," GI", "", "", "", "", "", ""); break;
				case 39: sReturnString = sTranslateCharacter("N", sSubString, nChannel, iCounter, " Ol"," OL", "", "", "", "", "", ""); break;
				case 40: sReturnString = sTranslateCharacter("O", sSubString, nChannel, iCounter, " Ng"," NG", "", "", "", "", "", ""); break;
				case 41: sReturnString = sTranslateCharacter("P", sSubString, nChannel, iCounter, " Th"," TH", "", "", "", "", "", ""); break;
				case 42: sReturnString = sTranslateCharacter("Q", sSubString, nChannel, iCounter, " U"," U", "", "", "", "", "", ""); break;
				case 43: sReturnString = sTranslateCharacter("R", sSubString, nChannel, iCounter, " Pu"," PU", "", "", "", "", "", ""); break;
				case 44: sReturnString = sTranslateCharacter("S", sSubString, nChannel, iCounter, " Ul"," UL", "", "", "", "", "", ""); break;
				case 45: sReturnString = sTranslateCharacter("T", sSubString, nChannel, iCounter, " Bâ"," BÂ", "", "", "", "", "", ""); break;
				case 46: sReturnString = sTranslateCharacter("U", sSubString, nChannel, iCounter, " Sa"," SA", "", "", "", "", "", ""); break;
				case 47: sReturnString = sTranslateCharacter("V", sSubString, nChannel, iCounter, " Bu"," BU", "", "", "", "", "", ""); break;
				case 48: sReturnString = sTranslateCharacter("W", sSubString, nChannel, iCounter, " Ga"," GA", "", "", "", "", "", ""); break;
				case 49: sReturnString = sTranslateCharacter("X", sSubString, nChannel, iCounter, " Ag"," AG", "", "", "", "", "", ""); break;
				case 50: sReturnString = sTranslateCharacter("Y", sSubString, nChannel, iCounter, " As"," AS", "", "", "", "", "", ""); break;
				case 51: sReturnString = sTranslateCharacter("Z", sSubString, nChannel, iCounter, " Ug"," UG", "", "", "", "", "", ""); break;
				case 52: sReturnString = sTranslateCharacter(" ", sSubString, nChannel, iCounter, " ","", "", "", "", "", "", ""); break;
				
				default: if(sLetter=="!" || sLetter=="?" || sLetter=="."){sReturnString = sLetter;}else{sOutputString = sOutputString;} break;
			}
			if(sReturnString != "")
			{
				if(sReturnString !=  sDuplicate)
				{
					sOutputString = sOutputString + sReturnString;
					sDuplicate = sReturnString;
				}
				else
				{
					sOutputString = sOutputString;
				}
			}													
		}
	}
	return sOutputString;
}

string sOutPut_LNG_ANJIRAN(string sSubString, int nChannel, object oSender)
{
	int iSubStringLength, iTrans, iCounter;
	int iClearTextStart, iClearTextEnd;
	string sLetter, sOutputString, sClearText, sReturnString , sDuplicate;
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ";   
	sOutputString = "";
	iSubStringLength = GetStringLength(sSubString);
		
	for(iCounter=0;iCounter <= iSubStringLength; iCounter++)
	{
		sLetter = GetSubString(sSubString,iCounter,1);

		if(sLetter == "*")
		{
			if(FindSubString(sSubString, "**", iCounter)== iCounter)
			{
				iClearTextStart = iCounter +2;
				iClearTextEnd = FindSubString(sSubString," ",iClearTextStart);
			
				if(iClearTextEnd == -1)
				{
					iClearTextEnd = iSubStringLength; 
				}
				
				sClearText = GetSubString(sSubString, iClearTextStart, iClearTextEnd - iClearTextStart );
				sOutputString = sOutputString + CLR_SPACE + sClearText + CLR_SPACE;
				iCounter = iClearTextEnd; 
			}
		}
		else
		{
			iTrans = FindSubString(sTranslate, sLetter);
	
			switch (iTrans)
		   	{
				case 0: sReturnString = sTranslateCharacter("a", sSubString, nChannel, iCounter, "","", "bB", "za", "ZA", "", "", ""); break;
				case 1: sReturnString = sTranslateCharacter("b", sSubString, nChannel, iCounter, " wa"," WA", "adhlotyz", " ho", " HO", "eims", "", ""); break;
				case 2: sReturnString = sTranslateCharacter("c", sSubString, nChannel, iCounter, "a","A", "adhlotyz", " ko", " KO", "eims", " lu", " LU"); break;
				case 3: sReturnString = sTranslateCharacter("d", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 4: sReturnString = sTranslateCharacter("e", sSubString, nChannel, iCounter, "ba","BA", "yY", "i", "I", "D", "", ""); break;
				case 5: sReturnString = sTranslateCharacter("f", sSubString, nChannel, iCounter, "h","H", "adhlotyz", " yo", " YO", "eims", " hi", " HI"); break;
				case 6: sReturnString = sTranslateCharacter("g", sSubString, nChannel, iCounter, " yo"," YO", "adhlotyz", " an", " AN", "eims", " wa", " WA"); break;
				case 7: sReturnString = sTranslateCharacter("h", sSubString, nChannel, iCounter, "ya","YA", "", "", "", "", "", ""); break;
				case 8: sReturnString = sTranslateCharacter("i", sSubString, nChannel, iCounter, "","", "adlotyz", " bi", " BI", "eimsHh", "a", "A"); break;
				case 9: sReturnString = sTranslateCharacter("j", sSubString, nChannel, iCounter, "sh","SH", "adhlotyz", " le", " LE", "eims", "es", "ES"); break;
				case 10: sReturnString = sTranslateCharacter("k", sSubString, nChannel, iCounter, "y","Y", "adhlotyz", " az", " AZ", "eims", "", ""); break;
				case 11: sReturnString = sTranslateCharacter("l", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 12: sReturnString = sTranslateCharacter("m", sSubString, nChannel, iCounter, "ta","TA", "adhlotyz", " sa", " SA", "eims", " ku", " KU"); break;
				case 13: sReturnString = sTranslateCharacter("n", sSubString, nChannel, iCounter, " ii"," II", "dhlotyz", " it", " IT", "eims", " ta", " TA"); break;
				case 14: sReturnString = sTranslateCharacter("o", sSubString, nChannel, iCounter, "","", "o", "i", "I", "nN", "e", "E"); break;
				case 15: sReturnString = sTranslateCharacter("p", sSubString, nChannel, iCounter, "tt","TT", "adhlotyz", " ai", " AI", "eimsp", "", ""); break;
				case 16: sReturnString = sTranslateCharacter("q", sSubString, nChannel, iCounter, "iz","IZ", "adhlotyz", " ma", " MA", "eims", " su", " SU"); break;
				case 17: sReturnString = sTranslateCharacter("r", sSubString, nChannel, iCounter, "aa","AA", "adhlotyz", " ya", " YA", "eims", "", ""); break;
				case 18: sReturnString = sTranslateCharacter("s", sSubString, nChannel, iCounter, "o'","O'", "adhlotyz", " li", " LI", "eims", "", ""); break;
				case 19: sReturnString = sTranslateCharacter("t", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 20: sReturnString = sTranslateCharacter("u", sSubString, nChannel, iCounter, "to","TO", "adhlotyz", "am", "AM", "eims", "", ""); break;
				case 21: sReturnString = sTranslateCharacter("v", sSubString, nChannel, iCounter, "su","SU", "adhlotyz", " sa", " SA", "eims", "", ""); break;
				case 22: sReturnString = sTranslateCharacter("w", sSubString, nChannel, iCounter, "ka","KA", "adhlotyz", " sh", " SH", "eims", "", ""); break;
				case 23: sReturnString = sTranslateCharacter("x", sSubString, nChannel, iCounter, "shou","SHOU", "adhlotyz", " de", " DE", "eims", "", ""); break;
				case 24: sReturnString = sTranslateCharacter("y", sSubString, nChannel, iCounter, " ha"," HA", "", "", "", "", "", ""); break;
				case 25: sReturnString = sTranslateCharacter("z", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 26: sReturnString = sTranslateCharacter("A", sSubString, nChannel, iCounter, " As"," AS", "", "", "", "", "", ""); break;
				case 27: sReturnString = sTranslateCharacter("B", sSubString, nChannel, iCounter, " Wa"," WA", "", "", "", "", "", ""); break;
				case 28: sReturnString = sTranslateCharacter("C", sSubString, nChannel, iCounter, " Am"," AM", "", "", "", "", "", ""); break;
				case 29: sReturnString = sTranslateCharacter("D", sSubString, nChannel, iCounter, " Ba"," BA", "", "", "", "", "", ""); break;
				case 30: sReturnString = sTranslateCharacter("E", sSubString, nChannel, iCounter, " Na"," NA", "", "", "", "", "", ""); break;
				case 31: sReturnString = sTranslateCharacter("F", sSubString, nChannel, iCounter, " Ma'"," MA'", "", "", "", "", "", ""); break;
				case 32: sReturnString = sTranslateCharacter("G", sSubString, nChannel, iCounter, " Yo"," YO", "", "", "", "", "", ""); break;
				case 33: sReturnString = sTranslateCharacter("H", sSubString, nChannel, iCounter, " Ya"," YA", "", "", "", "", "", ""); break;
				case 34: sReturnString = sTranslateCharacter("I", sSubString, nChannel, iCounter, " Le"," LE", "", "", "", "", "", "null","null"); break;
				case 35: sReturnString = sTranslateCharacter("J", sSubString, nChannel, iCounter, " Az"," AZ", "", "", "", "", "", ""); break;
				case 36: sReturnString = sTranslateCharacter("K", sSubString, nChannel, iCounter, " Do"," DO", "", "", "", "", "", ""); break;
				case 37: sReturnString = sTranslateCharacter("L", sSubString, nChannel, iCounter, " Ko'"," KO'", "", "", "", "", "", ""); break;
				case 38: sReturnString = sTranslateCharacter("M", sSubString, nChannel, iCounter, " Ha"," HA", "", "", "", "", "", ""); break;
				case 39: sReturnString = sTranslateCharacter("N", sSubString, nChannel, iCounter, " Ii"," II", "", "", "", "", "", ""); break;
				case 40: sReturnString = sTranslateCharacter("O", sSubString, nChannel, iCounter, " Al"," AL", "", "", "", "", "", ""); break;
				case 41: sReturnString = sTranslateCharacter("P", sSubString, nChannel, iCounter, " Tl'"," TL'", "", "", "", "", "", ""); break;
				case 42: sReturnString = sTranslateCharacter("Q", sSubString, nChannel, iCounter, " Ya"," YA", "", "", "", "", "", ""); break;
				case 43: sReturnString = sTranslateCharacter("R", sSubString, nChannel, iCounter, " Li"," LI", "", "", "", "", "", ""); break;
				case 44: sReturnString = sTranslateCharacter("S", sSubString, nChannel, iCounter, " At'"," AT'", "", "", "", "", "", ""); break;
				case 45: sReturnString = sTranslateCharacter("T", sSubString, nChannel, iCounter, " Ah"," AH", "", "", "", "", "", ""); break;
				case 46: sReturnString = sTranslateCharacter("U", sSubString, nChannel, iCounter, " Yo"," YO", "", "", "", "", "", ""); break;
				case 47: sReturnString = sTranslateCharacter("V", sSubString, nChannel, iCounter, " To"," TO", "", "", "", "", "", ""); break;
				case 48: sReturnString = sTranslateCharacter("W", sSubString, nChannel, iCounter, " Ao"," AO", "", "", "", "", "", ""); break;
				case 49: sReturnString = sTranslateCharacter("X", sSubString, nChannel, iCounter, " Ho"," HO", "", "", "", "", "", ""); break;
				case 50: sReturnString = sTranslateCharacter("Y", sSubString, nChannel, iCounter, " Ha"," HA", "", "", "", "", "", ""); break;
				case 51: sReturnString = sTranslateCharacter("Z", sSubString, nChannel, iCounter, " Lu"," LU", "", "", "", "", "", ""); break;
				case 52: sReturnString = sTranslateCharacter(" ", sSubString, nChannel, iCounter, " ","", "", "", "", "", "", ""); break;
	
				default: if(sLetter=="!" || sLetter=="?" || sLetter=="."){sReturnString = sLetter;}else{sOutputString = sOutputString;} break;
			}
			if(sReturnString != "")
			{
				if(sReturnString !=  sDuplicate)
				{
					sOutputString = sOutputString + sReturnString;
					sDuplicate = sReturnString;
				}
				else
				{
					sOutputString = sOutputString;
				}
			}													
		}
	}
	return sOutputString;
}

string sOutPut_LNG_KOBOLD_D(string sSubString, int nChannel, object oSender)
{
	int iSubStringLength, iTrans, iCounter;
	int iClearTextStart, iClearTextEnd;
	string sLetter, sOutputString, sClearText, sReturnString , sDuplicate;
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ";    
	sOutputString = "";
	iSubStringLength = GetStringLength(sSubString);
		
	for(iCounter=0;iCounter <= iSubStringLength; iCounter++)
	{
		sLetter = GetSubString(sSubString,iCounter,1);

		if(sLetter == "*")
		{
			if(FindSubString(sSubString, "**", iCounter)== iCounter)
			{
				iClearTextStart = iCounter +2;
				iClearTextEnd = FindSubString(sSubString," ",iClearTextStart);
			
				if(iClearTextEnd == -1)
				{
					iClearTextEnd = iSubStringLength;
				}
				
				sClearText = GetSubString(sSubString, iClearTextStart, iClearTextEnd - iClearTextStart );
				sOutputString = sOutputString + CLR_SPACE + sClearText + CLR_SPACE;
				iCounter = iClearTextEnd; 
			}
		}
		else
		{
			iTrans = FindSubString(sTranslate, sLetter);
	
			switch (iTrans)
		   	{
				case 0: sReturnString = sTranslateCharacter("a", sSubString, nChannel, iCounter, "zi","ZI", "aeiouy", "ni", "NI", "dlnrst", "~zi", "~ZI"); break;
				case 1: sReturnString = sTranslateCharacter("b", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 2: sReturnString = sTranslateCharacter("c", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 3: sReturnString = sTranslateCharacter("d", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 4: sReturnString = sTranslateCharacter("e", sSubString, nChannel, iCounter, "kre","KRE", "aeiouy", "ee", "EE", "dlnrst", "~chee", "~CHEE"); break;
				case 5: sReturnString = sTranslateCharacter("f", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 6: sReturnString = sTranslateCharacter("g", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 7: sReturnString = sTranslateCharacter("h", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 8: sReturnString = sTranslateCharacter("i", sSubString, nChannel, iCounter, "k'i","K'I", "aeiouy", "ae~ki", "AE~KI", "dlnrst", "~ne", "~NE"); break;
				case 9: sReturnString = sTranslateCharacter("j", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 10: sReturnString = sTranslateCharacter("k", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 11: sReturnString = sTranslateCharacter("l", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 12: sReturnString = sTranslateCharacter("m", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 13: sReturnString = sTranslateCharacter("n", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 14: sReturnString = sTranslateCharacter("o", sSubString, nChannel, iCounter, "re","RE", "aeiouy", "ck", "CK", "dlnrst", "~r'e", "~R'E"); break;
				case 15: sReturnString = sTranslateCharacter("p", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 16: sReturnString = sTranslateCharacter("q", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 17: sReturnString = sTranslateCharacter("r", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 18: sReturnString = sTranslateCharacter("s", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 19: sReturnString = sTranslateCharacter("t", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 20: sReturnString = sTranslateCharacter("u", sSubString, nChannel, iCounter, "ze","ZE", "aeiouy", "ch", "CH", "dlnrst", "~ch'e", "~CH'E"); break;
				case 21: sReturnString = sTranslateCharacter("v", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 22: sReturnString = sTranslateCharacter("w", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 23: sReturnString = sTranslateCharacter("x", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 24: sReturnString = sTranslateCharacter("y", sSubString, nChannel, iCounter, "ke","KE", "aeiouy", "t'l", "T'L", "dlnrst", "~vij", "~VIJ"); break;
				case 25: sReturnString = sTranslateCharacter("z", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 26: sReturnString = sTranslateCharacter("A", sSubString, nChannel, iCounter, "~Zi","~ZI", "", "", "", "", "", ""); break;
				case 27: sReturnString = sTranslateCharacter("B", sSubString, nChannel, iCounter, "~Re","~RE", "", "", "", "", "", ""); break;
				case 28: sReturnString = sTranslateCharacter("C", sSubString, nChannel, iCounter, "~Ze","~ZE", "", "", "", "", "", ""); break;
				case 29: sReturnString = sTranslateCharacter("D", sSubString, nChannel, iCounter, "~R'e","~R'E", "", "", "", "", "", ""); break;
				case 30: sReturnString = sTranslateCharacter("E", sSubString, nChannel, iCounter, "~Vi","~VI", "", "", "", "", "", ""); break;
				case 31: sReturnString = sTranslateCharacter("F", sSubString, nChannel, iCounter, "~Ki","~KI", "", "", "", "", "", ""); break;
				case 32: sReturnString = sTranslateCharacter("G", sSubString, nChannel, iCounter, "~Ch","~CH", "", "", "", "", "", ""); break;
				case 33: sReturnString = sTranslateCharacter("H", sSubString, nChannel, iCounter, "~Ck","~CK", "", "", "", "", "", ""); break;
				case 34: sReturnString = sTranslateCharacter("I", sSubString, nChannel, iCounter, "~Ch'e","~CH'E", "", "", "", "", "", "null","null"); break;
				case 35: sReturnString = sTranslateCharacter("J", sSubString, nChannel, iCounter, "~R'e","~R'E", "", "", "", "", "", ""); break;
				case 36: sReturnString = sTranslateCharacter("K", sSubString, nChannel, iCounter, "~Ri","~RI", "", "", "", "", "", ""); break;
				case 37: sReturnString = sTranslateCharacter("L", sSubString, nChannel, iCounter, "~K'i","~K'I", "", "", "", "", "", ""); break;
				case 38: sReturnString = sTranslateCharacter("M", sSubString, nChannel, iCounter, "~Chee","~CHEE", "", "", "", "", "", ""); break;
				case 39: sReturnString = sTranslateCharacter("N", sSubString, nChannel, iCounter, "~Ve","~VE", "", "", "", "", "", ""); break;
				case 40: sReturnString = sTranslateCharacter("O", sSubString, nChannel, iCounter, "~Zi","~ZI", "", "", "", "", "", ""); break;
				case 41: sReturnString = sTranslateCharacter("P", sSubString, nChannel, iCounter, "~Re","~RE", "", "", "", "", "", ""); break;
				case 42: sReturnString = sTranslateCharacter("Q", sSubString, nChannel, iCounter, "~Ze","~ZE", "", "", "", "", "", ""); break;
				case 43: sReturnString = sTranslateCharacter("R", sSubString, nChannel, iCounter, "~R'e","~R'E", "", "", "", "", "", ""); break;
				case 44: sReturnString = sTranslateCharacter("S", sSubString, nChannel, iCounter, "~Vi","~VI", "", "", "", "", "", ""); break;
				case 45: sReturnString = sTranslateCharacter("T", sSubString, nChannel, iCounter, "~Ki","~KI", "", "", "", "", "", ""); break;
				case 46: sReturnString = sTranslateCharacter("U", sSubString, nChannel, iCounter, "~Ch","~CH", "", "", "", "", "", ""); break;
				case 47: sReturnString = sTranslateCharacter("V", sSubString, nChannel, iCounter, "~Ck","~CK", "", "", "", "", "", ""); break;
				case 48: sReturnString = sTranslateCharacter("W", sSubString, nChannel, iCounter, "~Ch'e","~CH'E", "", "", "", "", "", ""); break;
				case 49: sReturnString = sTranslateCharacter("X", sSubString, nChannel, iCounter, "~R'e","~R'E", "", "", "", "", "", ""); break;
				case 50: sReturnString = sTranslateCharacter("Y", sSubString, nChannel, iCounter, "~Ri","~RI", "", "", "", "", "", ""); break;
				case 51: sReturnString = sTranslateCharacter("Z", sSubString, nChannel, iCounter, "~K'i","~K'I", "", "", "", "", "", ""); break;
				case 52: sReturnString = sTranslateCharacter(" ", sSubString, nChannel, iCounter, " ","", "", "", "", "", "", ""); break;
	
				default: if(sLetter=="!" || sLetter=="?" || sLetter=="."){sReturnString = sLetter;}else{sOutputString = sOutputString;} break;
			}
			if(sReturnString != "")
			{
				if(sReturnString !=  sDuplicate)
				{
					sOutputString = sOutputString + sReturnString;
					sDuplicate = sReturnString;
				}
				else
				{
					sOutputString = sOutputString;
				}
			}													
		}
	}
	return sOutputString;
}

string sOutPut_LNG_JILYN(string sSubString, int nChannel, object oSender)
{
	int iSubStringLength, iTrans, iCounter;
	int iClearTextStart, iClearTextEnd;
	string sLetter, sOutputString, sClearText, sReturnString , sDuplicate;
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ";    
	sOutputString = "";
	iSubStringLength = GetStringLength(sSubString);
		
	for(iCounter=0;iCounter <= iSubStringLength; iCounter++)
	{
		sLetter = GetSubString(sSubString,iCounter,1);

		if(sLetter == "*")
		{
			if(FindSubString(sSubString, "**", iCounter)== iCounter)
			{
				iClearTextStart = iCounter +2;
				iClearTextEnd = FindSubString(sSubString," ",iClearTextStart);
			
				if(iClearTextEnd == -1)
				{
					iClearTextEnd = iSubStringLength; 
				}
				
				sClearText = GetSubString(sSubString, iClearTextStart, iClearTextEnd - iClearTextStart );
				sOutputString = sOutputString + CLR_SPACE + sClearText + CLR_SPACE;
				iCounter = iClearTextEnd; 
			}
		}
		else
		{
			iTrans = FindSubString(sTranslate, sLetter);
	
			switch (iTrans)
		   	{
				case 0: sReturnString = sTranslateCharacter("a", sSubString, nChannel, iCounter, "","", "m", "h'", "H'", "", "", ""); break;
				case 1: sReturnString = sTranslateCharacter("b", sSubString, nChannel, iCounter, "ñ","Ñ", "adhlotyz", " as", " AS", "eims", "", ""); break;
				case 2: sReturnString = sTranslateCharacter("c", sSubString, nChannel, iCounter, "a","A", "adhlotyz", " at", " AT", "eims", " lu", " LU"); break;
				case 3: sReturnString = sTranslateCharacter("d", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 4: sReturnString = sTranslateCharacter("e", sSubString, nChannel, iCounter, "dæ","DÆ", "adhlotyz", " añ", " AÑ", "eims", "-za", "-ZA"); break;
				case 5: sReturnString = sTranslateCharacter("f", sSubString, nChannel, iCounter, "h","H", "adhlotyz", " ña", " ÑA", "eims", "hi", "HI"); break;
				case 6: sReturnString = sTranslateCharacter("g", sSubString, nChannel, iCounter, "hæ'","HÆ'", "adhlotyz", " ma'", " MA'", "eims", "zæ", "ZÆ"); break;
				case 7: sReturnString = sTranslateCharacter("h", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 8: sReturnString = sTranslateCharacter("i", sSubString, nChannel, iCounter, "ês","ÊS", "adhlotyz", " bi", " BI", "eims", "", ""); break;
				case 9: sReturnString = sTranslateCharacter("j", sSubString, nChannel, iCounter, "sh","SH", "adhlotyz", " le", " LE", "eims", "ês", "ÊS"); break;
				case 10: sReturnString = sTranslateCharacter("k", sSubString, nChannel, iCounter, "y","Y", "adhlotyz", " az", " AZ", "eims", "", ""); break;
				case 11: sReturnString = sTranslateCharacter("l", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 12: sReturnString = sTranslateCharacter("m", sSubString, nChannel, iCounter, "ta","TA", "adhlotyz", " ko'", " KO'", "eims", "ih", "IH"); break;
				case 13: sReturnString = sTranslateCharacter("n", sSubString, nChannel, iCounter, "ñai","ÑAI", "dhlotyz", " lo", " LO", "eims", "-da", "-DA"); break;
				case 14: sReturnString = sTranslateCharacter("o", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 15: sReturnString = sTranslateCharacter("p", sSubString, nChannel, iCounter, "æ","Æ", "adhlotyz", " al", " AL", "eims", "", ""); break;
				case 16: sReturnString = sTranslateCharacter("q", sSubString, nChannel, iCounter, "iz","IZ", "adhlotyz", " tl'", " TL'", "eims", "d'd", "D'D"); break;
				case 17: sReturnString = sTranslateCharacter("r", sSubString, nChannel, iCounter, "aa'","AA'", "adhlotyz", " ya", " YA", "eims", "", ""); break;
				case 18: sReturnString = sTranslateCharacter("s", sSubString, nChannel, iCounter, "o'","O'", "adhlotyz", " li", " LI", "eims", "", ""); break;
				case 19: sReturnString = sTranslateCharacter("t", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 20: sReturnString = sTranslateCharacter("u", sSubString, nChannel, iCounter, "êd","ÊD", "adhlotyz", "am", "AM", "eims", "", ""); break;
				case 21: sReturnString = sTranslateCharacter("v", sSubString, nChannel, iCounter, "hê'","HÊ'", "adhlotyz", " jo", " JO", "eims", "", ""); break;
				case 22: sReturnString = sTranslateCharacter("w", sSubString, nChannel, iCounter, "kii","KII", "adhlotyz", " to", " TO", "eims", "", ""); break;
				case 23: sReturnString = sTranslateCharacter("x", sSubString, nChannel, iCounter, "za","ZA", "adhlotyz", " ao", " AO", "eims", "", ""); break;
				case 24: sReturnString = sTranslateCharacter("y", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 25: sReturnString = sTranslateCharacter("z", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 26: sReturnString = sTranslateCharacter("A", sSubString, nChannel, iCounter, " Æs"," ÆS", "", "", "", "", "", ""); break;
				case 27: sReturnString = sTranslateCharacter("B", sSubString, nChannel, iCounter, " At"," AT", "", "", "", "", "", ""); break;
				case 28: sReturnString = sTranslateCharacter("C", sSubString, nChannel, iCounter, " Æm"," ÆM", "", "", "", "", "", ""); break;
				case 29: sReturnString = sTranslateCharacter("D", sSubString, nChannel, iCounter, " Añ"," AÑ", "", "", "", "", "", ""); break;
				case 30: sReturnString = sTranslateCharacter("E", sSubString, nChannel, iCounter, " Ña"," ÑA", "", "", "", "", "", ""); break;
				case 31: sReturnString = sTranslateCharacter("F", sSubString, nChannel, iCounter, " Ma'"," MA'", "", "", "", "", "", ""); break;
				case 32: sReturnString = sTranslateCharacter("G", sSubString, nChannel, iCounter, " Di"," DI", "", "", "", "", "", ""); break;
				case 33: sReturnString = sTranslateCharacter("H", sSubString, nChannel, iCounter, " Bi"," BI", "", "", "", "", "", ""); break;
				case 34: sReturnString = sTranslateCharacter("I", sSubString, nChannel, iCounter, " Le"," LE", "", "", "", "", "null", "null"); break;
				case 35: sReturnString = sTranslateCharacter("J", sSubString, nChannel, iCounter, " Az"," AZ", "", "", "", "", "", ""); break;
				case 36: sReturnString = sTranslateCharacter("K", sSubString, nChannel, iCounter, " Do"," DO", "", "", "", "", "", ""); break;
				case 37: sReturnString = sTranslateCharacter("L", sSubString, nChannel, iCounter, " Ko'"," KO'", "", "", "", "", "", ""); break;
				case 38: sReturnString = sTranslateCharacter("M", sSubString, nChannel, iCounter, " Ha"," HA", "", "", "", "", "", ""); break;
				case 39: sReturnString = sTranslateCharacter("N", sSubString, nChannel, iCounter, " Si"," SI", "", "", "", "", "", ""); break;
				case 40: sReturnString = sTranslateCharacter("O", sSubString, nChannel, iCounter, " Al"," AL", "", "", "", "", "", ""); break;
				case 41: sReturnString = sTranslateCharacter("P", sSubString, nChannel, iCounter, " Tl'"," TL'", "", "", "", "", "", ""); break;
				case 42: sReturnString = sTranslateCharacter("Q", sSubString, nChannel, iCounter, " Yæ"," YÆ", "", "", "", "", "", ""); break;
				case 43: sReturnString = sTranslateCharacter("R", sSubString, nChannel, iCounter, " Li"," LI", "", "", "", "", "", ""); break;
				case 44: sReturnString = sTranslateCharacter("S", sSubString, nChannel, iCounter, " Æt'"," ÆT'", "", "", "", "", "", ""); break;
				case 45: sReturnString = sTranslateCharacter("T", sSubString, nChannel, iCounter, " Ah"," AH", "", "", "", "", "", ""); break;
				case 46: sReturnString = sTranslateCharacter("U", sSubString, nChannel, iCounter, " Jo"," JO", "", "", "", "", "", ""); break;
				case 47: sReturnString = sTranslateCharacter("V", sSubString, nChannel, iCounter, " To"," TO", "", "", "", "", "", ""); break;
				case 48: sReturnString = sTranslateCharacter("W", sSubString, nChannel, iCounter, " Ao"," AO", "", "", "", "", "", ""); break;
				case 49: sReturnString = sTranslateCharacter("X", sSubString, nChannel, iCounter, " Ho"," HO", "", "", "", "", "", ""); break;
				case 50: sReturnString = sTranslateCharacter("Y", sSubString, nChannel, iCounter, " Ch"," CH", "", "", "", "", "", ""); break;
				case 51: sReturnString = sTranslateCharacter("Z", sSubString, nChannel, iCounter, " Lu"," LU", "", "", "", "", "", ""); break;
				case 52: sReturnString = sTranslateCharacter(" ", sSubString, nChannel, iCounter, " ","", "", "", "", "", "", ""); break;
	
				default: if(sLetter=="!" || sLetter=="?" || sLetter=="."){sReturnString = sLetter;}else{sOutputString = sOutputString;} break;
			}
			if(sReturnString != "")
			{
				if(sReturnString !=  sDuplicate)
				{
					sOutputString = sOutputString + sReturnString;
					sDuplicate = sReturnString;
				}
				else
				{
					sOutputString = sOutputString;
				}
			}													
		}
	}
	return sOutputString;
}



string sOutPut_LNG_DRUID_D(string sSubString, int nChannel, object oSender)
{
	int iSubStringLength, iTrans, iCounter;
	int iClearTextStart, iClearTextEnd;
	string sLetter, sOutputString, sClearText, sReturnString , sDuplicate;
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ";    
	sOutputString = "";
	iSubStringLength = GetStringLength(sSubString);
		
	for(iCounter=0;iCounter <= iSubStringLength; iCounter++)
	{
		sLetter = GetSubString(sSubString,iCounter,1);

		if(sLetter == "*")
		{
			if(FindSubString(sSubString, "**", iCounter)== iCounter)
			{
				iClearTextStart = iCounter +2;
				iClearTextEnd = FindSubString(sSubString," ",iClearTextStart);
			
				if(iClearTextEnd == -1)
				{
					iClearTextEnd = iSubStringLength; 
				}
				
				sClearText = GetSubString(sSubString, iClearTextStart, iClearTextEnd - iClearTextStart );
				sOutputString = sOutputString + CLR_SPACE + sClearText + CLR_SPACE;
				iCounter = iClearTextEnd; 
			}
		}
		else
		{
			iTrans = FindSubString(sTranslate, sLetter);
	
			switch (iTrans)
		   	{
				case 0: sReturnString = sTranslateCharacter("a", sSubString, nChannel, iCounter, "l","L", "elotm", " qu", " QU", "ahnrs", "q'a", "Q'A"); break;
				case 1: sReturnString = sTranslateCharacter("b", sSubString, nChannel, iCounter, "ni","NI", "elotm", " él", " ÉL", "ahnrs", "wa", "WA"); break;
				case 2: sReturnString = sTranslateCharacter("c", sSubString, nChannel, iCounter, "ill","ILL", "elotm", " ho", " HO", "ahnrs", "in", "IN"); break;
				case 3: sReturnString = sTranslateCharacter("d", sSubString, nChannel, iCounter, "ne","NE", "elotm", " rû", " RÛ", "ahnrs", "he", "HE"); break;
				case 4: sReturnString = sTranslateCharacter("e", sSubString, nChannel, iCounter, "","", "l", " gû", " GÛ", "n", "rim", "RIM"); break;
				case 5: sReturnString = sTranslateCharacter("f", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 6: sReturnString = sTranslateCharacter("g", sSubString, nChannel, iCounter, "th","TH", "elotm", " lá", " LÁ", "ahnrs", "vâr", "VÂR"); break;
				case 7: sReturnString = sTranslateCharacter("h", sSubString, nChannel, iCounter, "rén","RÉN", "elotm", " me", " ME", "ahnrs", "ûr", "ÛR"); break;
				case 8: sReturnString = sTranslateCharacter("i", sSubString, nChannel, iCounter, "","", "ahnrs", "m-â", "M-Â", "vV", "tél", "TÉL"); break;
				case 9: sReturnString = sTranslateCharacter("j", sSubString, nChannel, iCounter, "esse","ESSE", "elotm", " cû", " CÛ", "ahnrs", "ll", "LL"); break;
				case 10: sReturnString = sTranslateCharacter("k", sSubString, nChannel, iCounter, "wá","WÁ", "elotm", " fa", " FA", "ahnrs", "ma", "MA"); break;
				case 11: sReturnString = sTranslateCharacter("l", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 12: sReturnString = sTranslateCharacter("m", sSubString, nChannel, iCounter, "","", "ahnrs", "-rim", "-RIM", "", "", ""); break;
				case 13: sReturnString = sTranslateCharacter("n", sSubString, nChannel, iCounter, "th","TH", "elotm", " na", " NA", "ahnrs", "ér", "ÉR"); break;
				case 14: sReturnString = sTranslateCharacter("o", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 15: sReturnString = sTranslateCharacter("p", sSubString, nChannel, iCounter, "ya","YA", "elotm", " ni", " NI", "ahnrs", "oh", "OH"); break;
				case 16: sReturnString = sTranslateCharacter("q", sSubString, nChannel, iCounter, "dur","DUR", "elotm", " mâ", " MÂ", "ahnrs", "th", "TH"); break;
				case 17: sReturnString = sTranslateCharacter("r", sSubString, nChannel, iCounter, "ár","ÁR", "elotm", " vi", " VI", "ahnrs", "it", "IT"); break;
				case 18: sReturnString = sTranslateCharacter("s", sSubString, nChannel, iCounter, "on","ON", "elotm", " lir", " LIR", "ahnrs", "hû", "HÛ"); break;
				case 19: sReturnString = sTranslateCharacter("t", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 20: sReturnString = sTranslateCharacter("u", sSubString, nChannel, iCounter, "qu","QU", "elotm", " he", " HE", "ahnrs", "pa", "PA"); break;
				case 21: sReturnString = sTranslateCharacter("v", sSubString, nChannel, iCounter, "er","ER", "elotm", " er", " ER", "ahnrs", "t", "T"); break;
				case 22: sReturnString = sTranslateCharacter("w", sSubString, nChannel, iCounter, "qo","QO", "elotm", " éi", " ÉI", "ahnrs", "ezze", "EZZE"); break;
				case 23: sReturnString = sTranslateCharacter("x", sSubString, nChannel, iCounter, "ce","CE", "elotm", " ca", " CA", "ahnrs", "zi", "ZI"); break;
				case 24: sReturnString = sTranslateCharacter("y", sSubString, nChannel, iCounter, "","", "hnrs", "-", "-", "", "", ""); break;
				case 25: sReturnString = sTranslateCharacter("z", sSubString, nChannel, iCounter, "zt","ZT", "elotm", " li", " LI", "ahnrs", "th", "TH"); break;
				case 26: sReturnString = sTranslateCharacter("A", sSubString, nChannel, iCounter, " Qu"," QU", "", "", "", "", "", ""); break;
				case 27: sReturnString = sTranslateCharacter("B", sSubString, nChannel, iCounter, " Ál"," ÁL", "", "", "", "", "", ""); break;
				case 28: sReturnString = sTranslateCharacter("C", sSubString, nChannel, iCounter, " Ho"," HO", "", "", "", "", "", ""); break;
				case 29: sReturnString = sTranslateCharacter("D", sSubString, nChannel, iCounter, " Ro"," RO", "", "", "", "", "", ""); break;
				case 30: sReturnString = sTranslateCharacter("E", sSubString, nChannel, iCounter, " Ç"," Ç", "", "", "", "", "", ""); break;
				case 31: sReturnString = sTranslateCharacter("F", sSubString, nChannel, iCounter, " Sî"," SÎ", "", "", "", "", "", ""); break;
				case 32: sReturnString = sTranslateCharacter("G", sSubString, nChannel, iCounter, " Lá"," LÁ", "", "", "", "", "", ""); break;
				case 33: sReturnString = sTranslateCharacter("H", sSubString, nChannel, iCounter, " Me"," ME", "", "", "", "", "", ""); break;
				case 34: sReturnString = sTranslateCharacter("I", sSubString, nChannel, iCounter, " Mê"," MÊ", "", "", "", "", "", "null","null"); break;
				case 35: sReturnString = sTranslateCharacter("J", sSubString, nChannel, iCounter, " Cu"," CU", "", "", "", "", "", ""); break;
				case 36: sReturnString = sTranslateCharacter("K", sSubString, nChannel, iCounter, " Fa"," FA", "", "", "", "", "", ""); break;
				case 37: sReturnString = sTranslateCharacter("L", sSubString, nChannel, iCounter, " Ná"," NÁ", "", "", "", "", "", ""); break;
				case 38: sReturnString = sTranslateCharacter("M", sSubString, nChannel, iCounter, " Fal"," FAL", "", "", "", "", "", ""); break;
				case 39: sReturnString = sTranslateCharacter("N", sSubString, nChannel, iCounter, " Na"," NA", "", "", "", "", "", ""); break;
				case 40: sReturnString = sTranslateCharacter("O", sSubString, nChannel, iCounter, " Me"," ME", "", "", "", "", "", ""); break;
				case 41: sReturnString = sTranslateCharacter("P", sSubString, nChannel, iCounter, " Ni"," NI", "", "", "", "", "", ""); break;
				case 42: sReturnString = sTranslateCharacter("Q", sSubString, nChannel, iCounter, " Ma"," MA", "", "", "", "", "", ""); break;
				case 43: sReturnString = sTranslateCharacter("R", sSubString, nChannel, iCounter, " Vi"," VI", "", "", "", "", "", ""); break;
				case 44: sReturnString = sTranslateCharacter("S", sSubString, nChannel, iCounter, " Li"," LI", "", "", "", "", "", ""); break;
				case 45: sReturnString = sTranslateCharacter("T", sSubString, nChannel, iCounter, " Al"," AL", "", "", "", "", "", ""); break;
				case 46: sReturnString = sTranslateCharacter("U", sSubString, nChannel, iCounter, " He"," HE", "", "", "", "", "", ""); break;
				case 47: sReturnString = sTranslateCharacter("V", sSubString, nChannel, iCounter, " I'"," I'", "", "", "", "", "", ""); break;
				case 48: sReturnString = sTranslateCharacter("W", sSubString, nChannel, iCounter, " Ei"," EI", "", "", "", "", "", ""); break;
				case 49: sReturnString = sTranslateCharacter("X", sSubString, nChannel, iCounter, " Ca"," CA", "", "", "", "", "", ""); break;
				case 50: sReturnString = sTranslateCharacter("Y", sSubString, nChannel, iCounter, " Qù"," QÙ", "", "", "", "", "", ""); break;
				case 51: sReturnString = sTranslateCharacter("Z", sSubString, nChannel, iCounter, " Li"," LI", "", "", "", "", "", ""); break;
				case 52: sReturnString = sTranslateCharacter(" ", sSubString, nChannel, iCounter, " ","", "", "", "", "", "", ""); break;
	
				default: if(sLetter=="!" || sLetter=="?" || sLetter=="."){sReturnString = sLetter;}else{sOutputString = sOutputString;} break;
			}
			if(sReturnString != "")
			{
				if(sReturnString !=  sDuplicate)
				{
					sOutputString = sOutputString + sReturnString;
					sDuplicate = sReturnString;
				}
				else
				{
					sOutputString = sOutputString;
				}
			}													
		}
	}
	return sOutputString;
}


string sOutPut_LNG_BARAAN(string sSubString, int nChannel, object oSender)
{
	int iSubStringLength, iTrans, iCounter;
	int iClearTextStart, iClearTextEnd;
	string sLetter, sOutputString, sClearText, sReturnString , sDuplicate;
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ";   
	sOutputString = "";
	iSubStringLength = GetStringLength(sSubString);
		
	for(iCounter=0;iCounter <= iSubStringLength; iCounter++)
	{
		sLetter = GetSubString(sSubString,iCounter,1);

		if(sLetter == "*")
		{
			if(FindSubString(sSubString, "**", iCounter)== iCounter)
			{
				iClearTextStart = iCounter +2;
				iClearTextEnd = FindSubString(sSubString," ",iClearTextStart);
			
				if(iClearTextEnd == -1)
				{
					iClearTextEnd = iSubStringLength; 
				}
				
				sClearText = GetSubString(sSubString, iClearTextStart, iClearTextEnd - iClearTextStart );
				sOutputString = sOutputString + CLR_SPACE + sClearText + CLR_SPACE;
				iCounter = iClearTextEnd; 
			}
		}
		else
		{
			iTrans = FindSubString(sTranslate, sLetter);
	
			switch (iTrans)
		   	{
				case 0: sReturnString = sTranslateCharacter("a", sSubString, nChannel, iCounter, "","", " aehinorst", "aw", "AW", " bfgjmqrwx", "", ""); break;
				case 1: sReturnString = sTranslateCharacter("b", sSubString, nChannel, iCounter, "ad","AD", "elot", " ble", " BLE", " bfgjmqrwx", "", ""); break;
				case 2: sReturnString = sTranslateCharacter("c", sSubString, nChannel, iCounter, "","", "aeiou", "bor", "BOR", " bfgjmqrwx", "awn", "AWN"); break;
				case 3: sReturnString = sTranslateCharacter("d", sSubString, nChannel, iCounter, "dy","DY", "elot", " cy", " CY", " bfgjmqrwx", "", ""); break;
				case 4: sReturnString = sTranslateCharacter("e", sSubString, nChannel, iCounter, "","", "aehinorst", "da", "DA", " bfgjmqrwx", "lch", "LCH"); break;
				case 5: sReturnString = sTranslateCharacter("f", sSubString, nChannel, iCounter, "byn","BYN", "f", "dio", "DIO", " bfgjmqrwx", "", ""); break;
				case 6: sReturnString = sTranslateCharacter("g", sSubString, nChannel, iCounter, "","", "elot", " es", " ES", " bfgjmqrwx", "lw", "LW"); break;
				case 7: sReturnString = sTranslateCharacter("h", sSubString, nChannel, iCounter, "ch","CH", "t", "fa", "FA", " bfgjmqrwx", "", ""); break;
				case 8: sReturnString = sTranslateCharacter("i", sSubString, nChannel, iCounter, "yn","YN", "twk", "fy", "FY", " bfgjmqrwx", "", ""); break;
				case 9: sReturnString = sTranslateCharacter("j", sSubString, nChannel, iCounter, "enw","ENW", "elot", " cu", " CU", " bcfgjmqrwx", "gro", "GRO"); break;
				case 10: sReturnString = sTranslateCharacter("k", sSubString, nChannel, iCounter, "gus","GUS", "elot", " gwe", " GWE", " bfgjmqrwx", "", ""); break;
				case 11: sReturnString = sTranslateCharacter("l", sSubString, nChannel, iCounter, "","", "l", "gy", "GY", " bfgjmqrwx", "iol ", "IOL "); break;
				case 12: sReturnString = sTranslateCharacter("m", sSubString, nChannel, iCounter, "nod","NOD", "elot", " ha", " HA", " bfgjmqrwx", "", ""); break;
				case 13: sReturnString = sTranslateCharacter("n", sSubString, nChannel, iCounter, "nos","NOS", "elot", " he", " HE", " bfgjmqrwx", "", ""); break;
				case 14: sReturnString = sTranslateCharacter("o", sSubString, nChannel, iCounter, "","", "aehinorst", "'ia", "'IA", " bfgjmqrwx", "th", "TH"); break;
				case 15: sReturnString = sTranslateCharacter("p", sSubString, nChannel, iCounter, "","", "elot", " l", " L", " bfgjmqrwx", "ty", "TY"); break;
				case 16: sReturnString = sTranslateCharacter("q", sSubString, nChannel, iCounter, "wl","WL", "elot", " ne", " NE", " bfgjmqrwx", "", ""); break;
				case 17: sReturnString = sTranslateCharacter("r", sSubString, nChannel, iCounter, "","", "elot", " pry", " PRY", " bfgjmqrwx", "ws", "WS"); break;
				case 18: sReturnString = sTranslateCharacter("s", sSubString, nChannel, iCounter, "yf","YF", "aehinorst", "rhi", "RHI", " bfgjmqrwx", "", ""); break;
				case 19: sReturnString = sTranslateCharacter("t", sSubString, nChannel, iCounter, "","", "aehinorst", "eg", "EG", " bfgjmqrwx", "dd", "DD"); break;
				case 20: sReturnString = sTranslateCharacter("u", sSubString, nChannel, iCounter, "ys","YS", "elot", " sef", " SEF", " bfgjmqrwx", "", ""); break;
				case 21: sReturnString = sTranslateCharacter("v", sSubString, nChannel, iCounter, "","", "elot", " yd", " YD", " bfgjmqrwx", "ws", "WS"); break;
				case 22: sReturnString = sTranslateCharacter("w", sSubString, nChannel, iCounter, "ff","FF", "elot", " enw", " ENW", " bfgjmqrwx", "", ""); break;
				case 23: sReturnString = sTranslateCharacter("x", sSubString, nChannel, iCounter, "gus","GUS", "elot", " wl", " WL", " bfgjmqrwx", "", ""); break;
				case 24: sReturnString = sTranslateCharacter("y", sSubString, nChannel, iCounter, "byn","BYN", "elot", " dda", " DDA", " bfgjmqrwx", "", ""); break;
				case 25: sReturnString = sTranslateCharacter("z", sSubString, nChannel, iCounter, "lw","LW", "elot", " yf", " YF", " bfgjmqrwx", "", ""); break;
				case 26: sReturnString = sTranslateCharacter("A", sSubString, nChannel, iCounter, " Be"," BE", "", "", "", "", "", ""); break;
				case 27: sReturnString = sTranslateCharacter("B", sSubString, nChannel, iCounter, " Di"," DI", "", "", "", "", "", ""); break;
				case 28: sReturnString = sTranslateCharacter("C", sSubString, nChannel, iCounter, "","", "", "", "", "", "", ""); break;
				case 29: sReturnString = sTranslateCharacter("D", sSubString, nChannel, iCounter, " Ble"," BLE", "", "", "", "", "", ""); break;
				case 30: sReturnString = sTranslateCharacter("E", sSubString, nChannel, iCounter, " Mae"," MAE", "", "", "", "", "", ""); break;
				case 31: sReturnString = sTranslateCharacter("F", sSubString, nChannel, iCounter, " Su"," SU", "", "", "", "", "", ""); break;
				case 32: sReturnString = sTranslateCharacter("G", sSubString, nChannel, iCounter, " Da"," DA", "", "", "", "", "", ""); break;
				case 33: sReturnString = sTranslateCharacter("H", sSubString, nChannel, iCounter, " Bo"," BO", "", "", "", "", "", ""); break;
				case 34: sReturnString = sTranslateCharacter("I", sSubString, nChannel, iCounter, " Ne"," NE", "", "", "", "", "", "null","null"); break;
				case 35: sReturnString = sTranslateCharacter("J", sSubString, nChannel, iCounter, " Gwe"," GWE", "", "", "", "", "", ""); break;
				case 36: sReturnString = sTranslateCharacter("K", sSubString, nChannel, iCounter, " Cw"," CW", "", "", "", "", "", ""); break;
				case 37: sReturnString = sTranslateCharacter("L", sSubString, nChannel, iCounter, " En"," EN", "", "", "", "", "", ""); break;
				case 38: sReturnString = sTranslateCharacter("M", sSubString, nChannel, iCounter, " Ne"," NE", "", "", "", "", "", ""); break;
				case 39: sReturnString = sTranslateCharacter("N", sSubString, nChannel, iCounter, " He"," HE", "", "", "", "", "", ""); break;
				case 40: sReturnString = sTranslateCharacter("O", sSubString, nChannel, iCounter, " Ti"," TI", "", "", "", "", "", ""); break;
				case 41: sReturnString = sTranslateCharacter("P", sSubString, nChannel, iCounter, " Hy"," HY", "", "", "", "", "", ""); break;
				case 42: sReturnString = sTranslateCharacter("Q", sSubString, nChannel, iCounter, " Po"," PO", "", "", "", "", "", ""); break;
				case 43: sReturnString = sTranslateCharacter("R", sSubString, nChannel, iCounter, " Dw"," DW", "", "", "", "", "", ""); break;
				case 44: sReturnString = sTranslateCharacter("S", sSubString, nChannel, iCounter, " Ia"," IA", "", "", "", "", "", ""); break;
				case 45: sReturnString = sTranslateCharacter("T", sSubString, nChannel, iCounter, " Da"," DA", "", "", "", "", "", ""); break;
				case 46: sReturnString = sTranslateCharacter("U", sSubString, nChannel, iCounter, " Wn"," WN", "", "", "", "", "", ""); break;
				case 47: sReturnString = sTranslateCharacter("V", sSubString, nChannel, iCounter, " P'n"," P'N", "", "", "", "", "", ""); break;
				case 48: sReturnString = sTranslateCharacter("W", sSubString, nChannel, iCounter, " Ei"," EI", "", "", "", "", "", ""); break;
				case 49: sReturnString = sTranslateCharacter("X", sSubString, nChannel, iCounter, " Pry"," PRY", "", "", "", "", "", ""); break;
				case 50: sReturnString = sTranslateCharacter("Y", sSubString, nChannel, iCounter, " Ma"," MA", "", "", "", "", "", ""); break;
				case 51: sReturnString = sTranslateCharacter("Z", sSubString, nChannel, iCounter, " No"," NO", "", "", "", "", "", ""); break;
				case 52: sReturnString = sTranslateCharacter(" ", sSubString, nChannel, iCounter, " ","", "", "", "", "", "", ""); break;
	
				default: if(sLetter=="!" || sLetter=="?" || sLetter=="."){sReturnString = sLetter;}else{sOutputString = sOutputString;} break;
			}
			if(sReturnString != "")
			{
				if(sReturnString !=  sDuplicate)
				{
					sOutputString = sOutputString + sReturnString;
					sDuplicate = sReturnString;
				}
				else
				{
					sOutputString = sOutputString;
				}
			}													
		}
	}
	return sOutputString;
}


string sOutPut_LNG_TRAILSIGN(string sSubString, int nChannel, object oSender, string sLNG_PC_EmoteSymbolStart , string sLNG_PC_EmoteSymbolEnd )
{

	int iSubStringLength, iTrans, iRandom, iSilenceEffect,iType;
	string sLetter, sOutputString;
    string sTranslate = "abcdefghijklmnopqrstuvwxyz";
    string sHisHer;
   	effect eEffect;
		
	sOutputString = "";
	
	sHisHer =	GetGender(oSender) == 0 ? "his" : "her" ;

	iSubStringLength = GetStringLength(sSubString);
	iRandom = Random(iSubStringLength);	
	sLetter = GetStringLowerCase(GetSubString(sSubString,iRandom,1));
	iTrans = FindSubString(sTranslate, sLetter);


   	eEffect = GetFirstEffect(oSender);

   	while(GetIsEffectValid(eEffect))
   	{
		iType = GetEffectType(eEffect);
	  	if(iType == EFFECT_TYPE_SILENCE){iSilenceEffect = TRUE;}
      	eEffect = GetNextEffect(oSender);
   	}		
		
	switch (iTrans)
   	{
		case 0:
				if(iSilenceEffect)
				{sOutputString = sLNG_PC_EmoteSymbolStart+"Whistles silently"+sLNG_PC_EmoteSymbolEnd;}
				else{sOutputString = sLNG_PC_EmoteSymbolStart+"Whistles long and low"+sLNG_PC_EmoteSymbolEnd;}		
		 
		  break;
		case 1: sOutputString = sLNG_PC_EmoteSymbolStart+"Makes a fist, then extends fingers rapidly"+sLNG_PC_EmoteSymbolEnd; break;
		case 2: sOutputString = sLNG_PC_EmoteSymbolStart+"Taps "+sHisHer+" thumbs together"+sLNG_PC_EmoteSymbolEnd; break;
		case 3: sOutputString = sLNG_PC_EmoteSymbolStart+"Stretches "+sHisHer+" fingers wide"+sLNG_PC_EmoteSymbolEnd; break;
		case 4: 
				if(iSilenceEffect)
				{sOutputString = sLNG_PC_EmoteSymbolStart+"Whistles silently"+sLNG_PC_EmoteSymbolEnd;}
				else{sOutputString = sLNG_PC_EmoteSymbolStart+"Gives a trilling whistle"+sLNG_PC_EmoteSymbolEnd;}		
		
		 break;
		case 5: sOutputString = sLNG_PC_EmoteSymbolStart+"Rubs palm and forefinger together"+sLNG_PC_EmoteSymbolEnd; break;
		case 6: sOutputString = sLNG_PC_EmoteSymbolStart+"Rubs "+sHisHer+" palm with thumb"+sLNG_PC_EmoteSymbolEnd; break;
		case 7: sOutputString = sLNG_PC_EmoteSymbolStart+"Gestures"+sLNG_PC_EmoteSymbolEnd; break;
		case 8: sOutputString = sLNG_PC_EmoteSymbolStart+"Flips "+sHisHer+" palm around"+sLNG_PC_EmoteSymbolEnd; break;
		case 9: sOutputString = sLNG_PC_EmoteSymbolStart+"Makes a cutting motion with two fingers"+sLNG_PC_EmoteSymbolEnd; break;
		case 10: sOutputString = sLNG_PC_EmoteSymbolStart+"Waves three fingers forward"+sLNG_PC_EmoteSymbolEnd; break;
		case 11: sOutputString = sLNG_PC_EmoteSymbolStart+"Makes an 'X' with "+sHisHer+" fingers"+sLNG_PC_EmoteSymbolEnd; break;
		case 12: 
				if(iSilenceEffect)
				{sOutputString = sLNG_PC_EmoteSymbolStart+"Whistles silently"+sLNG_PC_EmoteSymbolEnd;}
				else{sOutputString = sLNG_PC_EmoteSymbolStart+"Gives a low whistle"+sLNG_PC_EmoteSymbolEnd;}
		 
		break;
		case 13: sOutputString = sLNG_PC_EmoteSymbolStart+"Flexes "+sHisHer+" fingers"+sLNG_PC_EmoteSymbolEnd; break;
		case 14: sOutputString = sLNG_PC_EmoteSymbolStart+"Taps index finger in "+sHisHer+" palm"+sLNG_PC_EmoteSymbolEnd; break;
		case 15: sOutputString = sLNG_PC_EmoteSymbolStart+"Makes a slasging motion with "+sHisHer+" hand"+sLNG_PC_EmoteSymbolEnd; break;
		case 16: sOutputString = sLNG_PC_EmoteSymbolStart+"Turns "+sHisHer+" palm a bit"+sLNG_PC_EmoteSymbolEnd; break;
		case 17:
				if(iSilenceEffect)
				{sOutputString = sLNG_PC_EmoteSymbolStart+"Whistles silently"+sLNG_PC_EmoteSymbolEnd;}
				else{sOutputString = sLNG_PC_EmoteSymbolStart+"Gives a warbling whistle"+sLNG_PC_EmoteSymbolEnd;}
						 
		  break;
		case 18: sOutputString = sLNG_PC_EmoteSymbolStart+"Gestures with one finger in a circle"+sLNG_PC_EmoteSymbolEnd; break;
		case 19: sOutputString = sLNG_PC_EmoteSymbolStart+"Waves two fingers forward"+sLNG_PC_EmoteSymbolEnd; break;
		case 20: sOutputString = sLNG_PC_EmoteSymbolStart+"Holds "+sHisHer+" palm vertical"+sLNG_PC_EmoteSymbolEnd; break;
		case 21: sOutputString = sLNG_PC_EmoteSymbolStart+"Holds "+sHisHer+" palm horizontal"+sLNG_PC_EmoteSymbolEnd; break;
		case 22: sOutputString = sLNG_PC_EmoteSymbolStart+"Slashes two fingers in the air"+sLNG_PC_EmoteSymbolEnd; break;	
		case 23: sOutputString = sLNG_PC_EmoteSymbolStart+"Makes a fist"+sLNG_PC_EmoteSymbolEnd; break;	
		case 24: sOutputString = sLNG_PC_EmoteSymbolStart+"Curls "+sHisHer+" fingers towards palm"+sLNG_PC_EmoteSymbolEnd; break;																																																																													
		case 25: sOutputString = sLNG_PC_EmoteSymbolStart+"Slashes two fingers in the air"+sLNG_PC_EmoteSymbolEnd; break;

		
		default: sOutputString = sLNG_PC_EmoteSymbolStart+"Nods"+sLNG_PC_EmoteSymbolEnd; break;

	}
	return sOutputString;
}


string sOutPut_LNG_SCOUTSIGN(string sSubString, int nChannel, object oSender, string sLNG_PC_EmoteSymbolStart , string sLNG_PC_EmoteSymbolEnd )
{

	int iSubStringLength, iTrans, iRandom;
	string sLetter, sOutputString;
    string sTranslate = "abcdefghijklmnopqrstuvwxyz";
    string sHisHer;
	
	sOutputString = "";
	sHisHer =	GetGender(oSender) == 0 ? "his" : "her" ;

	iSubStringLength = GetStringLength(sSubString);
	iRandom = Random(iSubStringLength);	
	sLetter = GetStringLowerCase(GetSubString(sSubString,iRandom,1));
	iTrans = FindSubString(sTranslate, sLetter);
		
	switch (iTrans)
   	{
		case 0: sOutputString = sLNG_PC_EmoteSymbolStart+"Shields "+sHisHer+" left thumb with "+sHisHer+" right hand"+sLNG_PC_EmoteSymbolEnd; break;
		case 1: sOutputString = sLNG_PC_EmoteSymbolStart+"Makes a fist, then extends fingers rapidly"+sLNG_PC_EmoteSymbolEnd; break;
		case 2: sOutputString = sLNG_PC_EmoteSymbolStart+"Taps "+sHisHer+" thumbs together"+sLNG_PC_EmoteSymbolEnd; break;
		case 3: sOutputString = sLNG_PC_EmoteSymbolStart+"Stretches "+sHisHer+" fingers wide"+sLNG_PC_EmoteSymbolEnd; break;
		case 4: sOutputString = sLNG_PC_EmoteSymbolStart+"Taps palm four times"+sLNG_PC_EmoteSymbolEnd; break;
		case 5: sOutputString = sLNG_PC_EmoteSymbolStart+"Rubs palm and forefinger together"+sLNG_PC_EmoteSymbolEnd; break;
		case 6: sOutputString = sLNG_PC_EmoteSymbolStart+"Rubs "+sHisHer+" palm with thumb"+sLNG_PC_EmoteSymbolEnd; break;
		case 7: sOutputString = sLNG_PC_EmoteSymbolStart+"Holds "+sHisHer+" hand up, pinky curled down"+sLNG_PC_EmoteSymbolEnd; break;
		case 8: sOutputString = sLNG_PC_EmoteSymbolStart+"Flips "+sHisHer+" palm around"+sLNG_PC_EmoteSymbolEnd; break;
		case 9: sOutputString = sLNG_PC_EmoteSymbolStart+"Makes a cutting motion with two fingers"+sLNG_PC_EmoteSymbolEnd; break;
		case 10: sOutputString = sLNG_PC_EmoteSymbolStart+"Waves three fingers forward"+sLNG_PC_EmoteSymbolEnd; break;
		case 11: sOutputString = sLNG_PC_EmoteSymbolStart+"Makes an 'X' with "+sHisHer+" fingers"+sLNG_PC_EmoteSymbolEnd; break;
		case 12: sOutputString = sLNG_PC_EmoteSymbolStart+"Holds "+sHisHer+" fingers still"+sLNG_PC_EmoteSymbolEnd; break;
		case 13: sOutputString = sLNG_PC_EmoteSymbolStart+"Flexes "+sHisHer+" fingers"+sLNG_PC_EmoteSymbolEnd; break;
		case 14: sOutputString = sLNG_PC_EmoteSymbolStart+"Taps index finger in "+sHisHer+" palm"+sLNG_PC_EmoteSymbolEnd; break;
		case 15: sOutputString = sLNG_PC_EmoteSymbolStart+"Makes a small slash with four fingers"+sLNG_PC_EmoteSymbolEnd; break;
		case 16: sOutputString = sLNG_PC_EmoteSymbolStart+"Turns "+sHisHer+" palm a bit"+sLNG_PC_EmoteSymbolEnd; break;
		case 17: sOutputString = sLNG_PC_EmoteSymbolStart+"Holds palm flat, index finger down"+sLNG_PC_EmoteSymbolEnd; break;
		case 18: sOutputString = sLNG_PC_EmoteSymbolStart+"Gestures with one finger in a circle"+sLNG_PC_EmoteSymbolEnd; break;
		case 19: sOutputString = sLNG_PC_EmoteSymbolStart+"Waves two fingers forward"+sLNG_PC_EmoteSymbolEnd; break;
		case 20: sOutputString = sLNG_PC_EmoteSymbolStart+"Holds "+sHisHer+" palm vertical"+sLNG_PC_EmoteSymbolEnd; break;
		case 21: sOutputString = sLNG_PC_EmoteSymbolStart+"Holds "+sHisHer+" palm horizontal"+sLNG_PC_EmoteSymbolEnd; break;
		case 22: sOutputString = sLNG_PC_EmoteSymbolStart+"Slashes two fingers in the air"+sLNG_PC_EmoteSymbolEnd; break;	
		case 23: sOutputString = sLNG_PC_EmoteSymbolStart+"Makes a fist"+sLNG_PC_EmoteSymbolEnd; break;	
		case 24: sOutputString = sLNG_PC_EmoteSymbolStart+"Curls "+sHisHer+" fingers towards palm"+sLNG_PC_EmoteSymbolEnd; break;																																																																													
		case 25: sOutputString = sLNG_PC_EmoteSymbolStart+"Slashes two fingers in the air"+sLNG_PC_EmoteSymbolEnd; break;
		
		default: sOutputString = sLNG_PC_EmoteSymbolStart+"Nods"+sLNG_PC_EmoteSymbolEnd; break;

	}
	return sOutputString;
}


string sOutPut_LNG_KALEM(string sSubString, int nChannel, object oSender, string sLNG_PC_EmoteSymbolStart , string sLNG_PC_EmoteSymbolEnd,  )
{
	int iSubStringLength, iTrans, iRandom;
	string sLetter, sOutputString;
    string sTranslate = "abcdefghijklmnopqrstuvwxyz";
    string sHisHer;
	
	sOutputString = "";
	sHisHer =	GetGender(oSender) == 0 ? "his" : "her" ;

	iSubStringLength = GetStringLength(sSubString);
	iRandom = Random(iSubStringLength);	
	sLetter = GetStringLowerCase(GetSubString(sSubString,iRandom,1));
	iTrans = FindSubString(sTranslate, sLetter);
		
	switch (iTrans)
   	{
		case 0: sOutputString = sLNG_PC_EmoteSymbolStart+"Shields "+sHisHer+" left thumb with "+sHisHer+" right hand"+sLNG_PC_EmoteSymbolEnd; break;
		case 1: sOutputString = sLNG_PC_EmoteSymbolStart+"Looks bored"+sLNG_PC_EmoteSymbolEnd; break;
		case 2: sOutputString = sLNG_PC_EmoteSymbolStart+"Taps "+sHisHer+" thumbs together"+sLNG_PC_EmoteSymbolEnd; break;
		case 3: sOutputString = sLNG_PC_EmoteSymbolStart+"Stretches "+sHisHer+" fingers wide"+sLNG_PC_EmoteSymbolEnd; break;
		case 4: sOutputString = sLNG_PC_EmoteSymbolStart+"Winks"+sLNG_PC_EmoteSymbolEnd; break;
		case 5: sOutputString = sLNG_PC_EmoteSymbolStart+"Rubs palm and forefinger together"+sLNG_PC_EmoteSymbolEnd; break;
		case 6: sOutputString = sLNG_PC_EmoteSymbolStart+"Rubs "+sHisHer+" palm with thumb"+sLNG_PC_EmoteSymbolEnd; break;
		case 7: sOutputString = sLNG_PC_EmoteSymbolStart+"Holds "+sHisHer+" hand up, pinky curled down"+sLNG_PC_EmoteSymbolEnd; break;
		case 8: sOutputString = sLNG_PC_EmoteSymbolStart+"Scowls"+sLNG_PC_EmoteSymbolEnd; break;
		case 9: sOutputString = sLNG_PC_EmoteSymbolStart+"Makes a cutting motion with two fingers"+sLNG_PC_EmoteSymbolEnd; break;
		case 10: sOutputString = sLNG_PC_EmoteSymbolStart+"Looks down"+sLNG_PC_EmoteSymbolEnd; break;
		case 11: sOutputString = sLNG_PC_EmoteSymbolStart+"Makes an 'X' with "+sHisHer+" fingers"+sLNG_PC_EmoteSymbolEnd; break;
		case 12: sOutputString = sLNG_PC_EmoteSymbolStart+"Holds "+sHisHer+" left fist out"+sLNG_PC_EmoteSymbolEnd; break;
		case 13: sOutputString = sLNG_PC_EmoteSymbolStart+"Flexes "+sHisHer+" fingers"+sLNG_PC_EmoteSymbolEnd; break;
		case 14: sOutputString = sLNG_PC_EmoteSymbolStart+"Taps index finger in "+sHisHer+" palm"+sLNG_PC_EmoteSymbolEnd; break;
		case 15: sOutputString = sLNG_PC_EmoteSymbolStart+"Looks to the right"+sLNG_PC_EmoteSymbolEnd; break;
		case 16: sOutputString = sLNG_PC_EmoteSymbolStart+"Rolls eyes"+sLNG_PC_EmoteSymbolEnd; break;
		case 17: sOutputString = sLNG_PC_EmoteSymbolStart+"Holds palm flat, index finger down"+sLNG_PC_EmoteSymbolEnd; break;
		case 18: sOutputString = sLNG_PC_EmoteSymbolStart+"Gestures with one finger in a circle"+sLNG_PC_EmoteSymbolEnd; break;
		case 19: sOutputString = sLNG_PC_EmoteSymbolStart+"Waves two fingers forward"+sLNG_PC_EmoteSymbolEnd; break;
		case 20: sOutputString = sLNG_PC_EmoteSymbolStart+"Rubs the back of "+sHisHer+" neck"+sLNG_PC_EmoteSymbolEnd; break;
		case 21: sOutputString = sLNG_PC_EmoteSymbolStart+"Holds "+sHisHer+" palm horizontal"+sLNG_PC_EmoteSymbolEnd; break;
		case 22: sOutputString = sLNG_PC_EmoteSymbolStart+"Slashes two fingers in the air"+sLNG_PC_EmoteSymbolEnd; break;	
		case 23: sOutputString = sLNG_PC_EmoteSymbolStart+"Makes a fist"+sLNG_PC_EmoteSymbolEnd; break;	
		case 24: sOutputString = sLNG_PC_EmoteSymbolStart+"Curls "+sHisHer+" fingers towards palm"+sLNG_PC_EmoteSymbolEnd; break;																																																																													
		case 25: sOutputString = sLNG_PC_EmoteSymbolStart+"Scratches "+sHisHer+" left knuckle with right hand"+sLNG_PC_EmoteSymbolEnd; break;
			default: sOutputString = sLNG_PC_EmoteSymbolStart+"Nods"+sLNG_PC_EmoteSymbolEnd; break;
	}
	return sOutputString;
}



string sOutPut_LNG_NITRIAD(string sSubString, int nChannel, object oSender, string sLNG_PC_EmoteSymbolStart , string sLNG_PC_EmoteSymbolEnd,  )
{
	int iSubStringLength, iTrans, iRandom;
	string sLetter, sOutputString;
    string sTranslate = "abcdefghijklmnopqrstuvwxyz";
    string sHisHer;
	
	sOutputString = "";
	sHisHer =	GetGender(oSender) == 0 ? "his" : "her" ;

	iSubStringLength = GetStringLength(sSubString);
	iRandom = Random(iSubStringLength);	
	sLetter = GetStringLowerCase(GetSubString(sSubString,iRandom,1));
	iTrans = FindSubString(sTranslate, sLetter);
		
	switch (iTrans)
   	{
		case 0: sOutputString = sLNG_PC_EmoteSymbolStart+"Stretches"+sLNG_PC_EmoteSymbolEnd; break;
		case 1: sOutputString = sLNG_PC_EmoteSymbolStart+"Looks bored"+sLNG_PC_EmoteSymbolEnd; break;
		case 2: sOutputString = sLNG_PC_EmoteSymbolStart+"Taps "+sHisHer+" thumbs together"+sLNG_PC_EmoteSymbolEnd; break;
		case 3: sOutputString = sLNG_PC_EmoteSymbolStart+"Stretches "+sHisHer+" fingers wide"+sLNG_PC_EmoteSymbolEnd; break;
		case 4: sOutputString = sLNG_PC_EmoteSymbolStart+"Winks"+sLNG_PC_EmoteSymbolEnd; break;
		case 5: sOutputString = sLNG_PC_EmoteSymbolStart+"Rubs palm and forefinger together"+sLNG_PC_EmoteSymbolEnd; break;
		case 6: sOutputString = sLNG_PC_EmoteSymbolStart+"Glances idly"+sLNG_PC_EmoteSymbolEnd; break;
		case 7: sOutputString = sLNG_PC_EmoteSymbolStart+"Holds "+sHisHer+" hand up, pinky curled down"+sLNG_PC_EmoteSymbolEnd; break;
		case 8: sOutputString = sLNG_PC_EmoteSymbolStart+"Gives a half-smile"+sLNG_PC_EmoteSymbolEnd; break;
		case 9: sOutputString = sLNG_PC_EmoteSymbolStart+"Looks thoughtful"+sLNG_PC_EmoteSymbolEnd; break;
		case 10: sOutputString = sLNG_PC_EmoteSymbolStart+"Looks down"+sLNG_PC_EmoteSymbolEnd; break;
		case 11: sOutputString = sLNG_PC_EmoteSymbolStart+"Makes an 'X' with "+sHisHer+" fingers"+sLNG_PC_EmoteSymbolEnd; break;
		case 12: sOutputString = sLNG_PC_EmoteSymbolStart+"Holds "+sHisHer+" left fist out"+sLNG_PC_EmoteSymbolEnd; break;
		case 13: sOutputString = sLNG_PC_EmoteSymbolStart+"Flexes "+sHisHer+" fingers"+sLNG_PC_EmoteSymbolEnd; break;
		case 14: sOutputString = sLNG_PC_EmoteSymbolStart+"Taps index finger in "+sHisHer+" palm"+sLNG_PC_EmoteSymbolEnd; break;
		case 15: sOutputString = sLNG_PC_EmoteSymbolStart+"Looks to the right"+sLNG_PC_EmoteSymbolEnd; break;
		case 16: sOutputString = sLNG_PC_EmoteSymbolStart+"Rolls eyes"+sLNG_PC_EmoteSymbolEnd; break;
		case 17: sOutputString = sLNG_PC_EmoteSymbolStart+"Holds palm flat, index finger down"+sLNG_PC_EmoteSymbolEnd; break;
		case 18: sOutputString = sLNG_PC_EmoteSymbolStart+"Gestures with one finger in a circle"+sLNG_PC_EmoteSymbolEnd; break;
		case 19: sOutputString = sLNG_PC_EmoteSymbolStart+"Scratches "+sHisHer+" ear"+sLNG_PC_EmoteSymbolEnd; break;
		case 20: sOutputString = sLNG_PC_EmoteSymbolStart+"Rubs the back of "+sHisHer+" neck"+sLNG_PC_EmoteSymbolEnd; break;
		case 21: sOutputString = sLNG_PC_EmoteSymbolStart+"Furrows brow"+sLNG_PC_EmoteSymbolEnd; break;
		case 22: sOutputString = sLNG_PC_EmoteSymbolStart+"Slashes two fingers in the air"+sLNG_PC_EmoteSymbolEnd; break;	
		case 23: sOutputString = sLNG_PC_EmoteSymbolStart+"Makes a fist"+sLNG_PC_EmoteSymbolEnd; break;	
		case 24: sOutputString = sLNG_PC_EmoteSymbolStart+"Curls "+sHisHer+" fingers towards palm"+sLNG_PC_EmoteSymbolEnd; break;																																																																													
		case 25: sOutputString = sLNG_PC_EmoteSymbolStart+"Scratches "+sHisHer+" left knuckle with right hand"+sLNG_PC_EmoteSymbolEnd; break;
		
		default: sOutputString = sLNG_PC_EmoteSymbolStart+"Nods"+sLNG_PC_EmoteSymbolEnd; break;
	}
	return sOutputString;
}