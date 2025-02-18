// Module OnEnter Bare Bones.nss

object GetMoneyPouch(object oPC)
{
	object oMoneyPouch = GetItemPossessedBy(oPC, "rw_moneypouch");

	if (oMoneyPouch == OBJECT_INVALID)
	{
		oMoneyPouch = CreateItemOnObject("rw_moneypouch",oPC);
	}
	SetItemCursedFlag(oMoneyPouch, TRUE);
	
	return oMoneyPouch;
}

void CalculateGoldWeight(object oPC)
{
	object oMoneyPouch = GetMoneyPouch(oPC);
	
	int iPCGold = GetGold(oPC);
	int iCount;
	int iCoinsPerLB = 5000; // change this to tweak wt setting for coins - currently set to 5000GP = 50 Emperors = 1lb
	int iGoldAtLastCheck = GetLocalInt(oMoneyPouch, "iGoldAtLastCheck"); //hey why do all this work if the gold is the same...
	
	itemproperty ipAddWeight; 
	
	string sPouchDescription;
	string sCurrentCash;
	
	if(iGoldAtLastCheck != iPCGold)
	{
		//AssignCommand(oPC, ActionSpeakString("Money checker, Haurrah!"));
		
		//Clear old weight setting
		itemproperty ipLoop=GetFirstItemProperty(oMoneyPouch);
	
		//Loop for as long as the ipLoop variable is valid
		while (GetIsItemPropertyValid(ipLoop))
	   	{
		   	//If ipLoop is a wt property, remove it
		   	if (GetItemPropertyType(ipLoop)==ITEM_PROPERTY_WEIGHT_INCREASE)
			//AssignCommand(oPC, ActionSpeakString("removing weight"));
	    	RemoveItemProperty(oMoneyPouch, ipLoop);
	   		//Next itemproperty on the list...
	   		ipLoop=GetNextItemProperty(oMoneyPouch);
		}
		
		//add new weight setting
		int i100 = (iPCGold/(100 * iCoinsPerLB));
		int i50 = (iPCGold - ((iCoinsPerLB*100)*i100) )/(50 * iCoinsPerLB);
		int i10 = (iPCGold - ( ((iCoinsPerLB*100)*i100) + ((iCoinsPerLB*50)*i50) ) )/(10 * iCoinsPerLB);
		int i5 = ( iPCGold - ( ((iCoinsPerLB*100)*i100) + ((iCoinsPerLB*50)*i50) + ((iCoinsPerLB*10)*i10)) )/(5 * iCoinsPerLB); 
		
		iCount=1;
		while(iCount <= i100)
		{
		ipAddWeight =ItemPropertyWeightIncrease(IP_CONST_WEIGHTINCREASE_100_LBS);
		AddItemProperty(DURATION_TYPE_PERMANENT,ipAddWeight,oMoneyPouch);
		iCount++;
		}
		
		iCount=1;
		while(iCount <= i50 )
		{
		ipAddWeight =ItemPropertyWeightIncrease(IP_CONST_WEIGHTINCREASE_50_LBS);
		AddItemProperty(DURATION_TYPE_PERMANENT,ipAddWeight,oMoneyPouch);
		iCount++;
		}
		
		iCount=1;
		while(iCount <= i10)
		{
		ipAddWeight =ItemPropertyWeightIncrease(IP_CONST_WEIGHTINCREASE_10_LBS);
		AddItemProperty(DURATION_TYPE_PERMANENT,ipAddWeight,oMoneyPouch);
		iCount++;
		}
		
		iCount=1;
		while(iCount <= i5 )
		{
		ipAddWeight =ItemPropertyWeightIncrease(IP_CONST_WEIGHTINCREASE_5_LBS);
		AddItemProperty(DURATION_TYPE_PERMANENT,ipAddWeight,oMoneyPouch);
		iCount++;
		}
		
		/* Non working setdescription code 
		if(iPCGold == 0)
		{
		sCurrentCash= "some lint...";
		}
		else if(iPCGold <= (iCoinsPerLB*5))
		{
		sCurrentCash = (IntToString(iPCGold) + " Crowns and some lint.");
		}
		else
		{
		sCurrentCash = (IntToString((iPCGold/iCoinsPerLB))+ " Emperors and some loose Crowns.");
		}
		sPouchDescription = "Your money pouch. Currently it contains "+ sCurrentCash;
		SetDescription(oMoneyPouch, sPouchDescription);	
		*/
		
		SetLocalInt(oMoneyPouch, "iGoldAtLastCheck", iPCGold );
	}
}