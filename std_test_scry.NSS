// wired 2010/04/03 Protype

void main()
{
	   object oCaller = GetPCSpeaker();
       object oPC = GetFirstPC();
       string sAreaTag;
       int nHD;
      
       // track count of players in each hub
       int cLendose = 0;
       int cCear = 0;
       int c2bridges = 0;
       int cAucklorn = 0;
	   int cDaris = 0;
       int cFOD = 0;
       int cMorell = 0;
       int cRvnwtch = 0;
       int cTristan = 0;
       int cThayad = 0;
       int cThralls = 0;
       int cElsewhere = 0;

       // track HD of players, divide by count later
       int lLendose = 0;
       int lCear = 0;
       int l2bridges = 0;
       int lAucklorn = 0;
	   int lDaris = 0;
       int lFOD = 0;
       int lMorell = 0;
       int lRvnwtch = 0;
       int lTristan = 0;
       int lThayad = 0;
       int lThralls = 0;
       int lElsewhere = 0;   
       
       while (OBJECT_INVALID != oPC )
       {
          	if(!GetIsDM(oPC))
			{
	   			sAreaTag =   GetTag(GetArea(oPC));
	        	nHD = GetHitDice(oPC);
	          
	         	if 			(FindSubString(sAreaTag,"cear")         >-1	 || FindSubString(sAreaTag,"dreamworld")   >-1)	{ cCear++;    lCear = lCear+nHD; }
	          	else if 	(FindSubString(sAreaTag,"thralls")      >-1	 || FindSubString(sAreaTag,"spiritworld")  >-1) { cThralls++; lThralls = lThralls+nHD; }
			  	else if 	(FindSubString(sAreaTag,"darisseaside") >-1  || FindSubString(sAreaTag,"darisvillage") >-1) { cDaris++;   lDaris = lDaris+nHD; }
				else if 	(FindSubString(sAreaTag,"aucklorn") >-1)	{ cAucklorn++; lAucklorn = lAucklorn+nHD; }
	          	else if 	(FindSubString(sAreaTag,"morell")>-1)		{ cMorell++; lMorell = lMorell+nHD; }
			 	else if 	(FindSubString(sAreaTag,"lendose") >-1)		{ cLendose++; lLendose = lLendose+nHD; }
			  	else if 	(FindSubString(sAreaTag,"tristan") >-1)		{ cTristan++; lTristan = lTristan+nHD; }
			  	else if 	(FindSubString(sAreaTag,"rvn") >-1)			{ cRvnwtch++; lRvnwtch = lRvnwtch+nHD; }
			  	else if 	(FindSubString(sAreaTag,"2bridges")>-1)		{ c2bridges++; l2bridges = l2bridges+nHD; }
			  	else if 	(FindSubString(sAreaTag,"thayad") >-1)		{ cThayad++; lThayad = lThayad+nHD; }
			  	else if 	(FindSubString(sAreaTag,"darisforest") >-1)	{ cFOD++; lFOD = lFOD+nHD; }
			  	else { cElsewhere++; lElsewhere=lElsewhere+nHD; }
			}
			
		   	oPC = GetNextPC();
       }   
	   
          // Should be something like
          // Ravenswatch, 7 Players, Avg Level 17
          // Morell, 2 Players, Avg Level 11
          // Elsewhere, 4 Players, Avg Level 2
		  
		   	if (cCear > 0) SendMessageToPC(oCaller,"Cear: "+IntToString(cCear)+" players, Avg Level: "+FloatToString(IntToFloat(lCear)/IntToFloat(cCear),18,2) );
			if (cThralls > 0) SendMessageToPC(oCaller,"Thralls Gate: "+IntToString(cThralls)+" players, Avg Level: "+FloatToString(IntToFloat(lThralls)/IntToFloat(cThralls),18,2) );
	       	if (cAucklorn > 0) SendMessageToPC(oCaller,"Aucklorn: "+IntToString(cAucklorn)+" players, Avg Level: "+FloatToString(IntToFloat(lAucklorn)/IntToFloat(cAucklorn),18,2) );	       
	       	if (c2bridges > 0) SendMessageToPC(oCaller,"Two Bridges "+IntToString(c2bridges)+" players, Avg Level: "+FloatToString(IntToFloat(l2bridges)/IntToFloat(c2bridges),18,2) );	       
	       	if (cMorell > 0) SendMessageToPC(oCaller,"Morell: "+IntToString(cMorell)+" players, Avg Level: "+FloatToString(IntToFloat(lMorell)/IntToFloat(cMorell),18,2) );	       
			if (cThayad > 0) SendMessageToPC(oCaller,"Thayad: "+IntToString(cThayad)+" players, Avg Level: "+FloatToString(IntToFloat(lThayad)/IntToFloat(cThayad),18,2) );	       
			if (cTristan > 0) SendMessageToPC(oCaller,"Tristan: "+IntToString(cTristan)+" players, Avg Level: "+FloatToString(IntToFloat(lTristan)/IntToFloat(cTristan),18,2) );	            
			if (cRvnwtch > 0) SendMessageToPC(oCaller,"Ravenswatch: "+IntToString(cRvnwtch)+" players, Avg Level: "+FloatToString(IntToFloat(lRvnwtch)/IntToFloat(cRvnwtch),18,2) );
			if (cFOD > 0) SendMessageToPC(oCaller,"Forest of Daris: "+IntToString(cFOD)+" players, Avg Level: "+FloatToString(IntToFloat(lFOD)/IntToFloat(cFOD),18,2 ));			
			if (cDaris > 0) SendMessageToPC(oCaller,"Daris: "+IntToString(cDaris)+" players, Avg Level: "+FloatToString(IntToFloat(lDaris)/IntToFloat(cDaris),18,2 ));			
			if (cLendose > 0) SendMessageToPC(oCaller,"Lendose: "+IntToString(cLendose)+" players, Avg Level: "+FloatToString(IntToFloat(lLendose)/IntToFloat(cLendose),18,2) );		
			if (cElsewhere > 0)  SendMessageToPC(oCaller,"Elsewhere: "+IntToString(cElsewhere)+" players, Avg Level: "+FloatToString(IntToFloat(lElsewhere)/IntToFloat(cElsewhere),18,2) );	
    }