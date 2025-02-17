// when used, shoots poisoned bolt
// use on poisons
// Ath
void Shoot(object oTarget,object oPC)
{
object oBolts = GetItemInSlot(INVENTORY_SLOT_BOLTS,oPC);
int nStack = GetItemStackSize(oBolts);
SetItemStackSize(oBolts,nStack-1,FALSE);

int nAttack = TouchAttackRanged(oTarget,TRUE);

    float fDist = GetDistanceBetween(OBJECT_SELF, oTarget);
    float fDelay = fDist/(3.0 * log(fDist) + 2.0);
	
	if (nAttack > 0)//Hit!
	{
	int nDamage = d6(2);
	if (nAttack == 2) { nDamage = nDamage * 2; }
    float fDelay2; fDelay2 += 0.1; fDelay += fDelay2;
	//DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectNWN2SpecialEffectFile("fx_arrowtrail",oTarget),oPC));
    // Play the sound of a dart hitting
	DelayCommand(fDelay2,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(nDamage,DAMAGE_TYPE_PIERCING,DAMAGE_POWER_PLUS_THREE),oTarget));
	DelayCommand(fDelay2,ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectPoison(44),oTarget));	
	return;
	}
	else//Miss!
	{
	/*
	vector vPos = GetPosition(oTarget);
	float fRand = IntToFloat(Random(2)+1);
	vector vMiss = vPos + Vector(fRand,fRand,fRand);
	DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectNWN2SpecialEffectFile("fx_arrowtrail",OBJECT_INVALID,vMiss),oPC));	
	*/
	return;
	}
return;
}


void main()
{
object oPC = GetItemActivator();
object oTarget = GetItemActivatedTarget();
object oItem = GetItemActivated();
int nCharge = GetItemCharges(oItem);


if (GetLocalInt(oPC,"CarcMantiShot")) 
{
AssignCommand(oTarget,PlaySound("al_en_arrows02"));
Shoot(oTarget,oPC); DeleteLocalInt(oPC,"CarcMantiShot"); 
return; 
}

if (GetObjectType(oTarget) == OBJECT_TYPE_ITEM)
{
string sTag = GetTag(oTarget);
//SendMessageToPC(oPC,sTag); //debug

//Check if it's poison
if ((GetStringLeft(sTag,10) == "nx1_poison")
|| (GetStringLeft(sTag,10) == "x2_it_pois")
|| (sTag == "bander_spider_poison039")
|| (sTag == "immortali_venom005"))
{
if (nCharge >= 7) { SendMessageToPC(oPC,"It is fully loaded already!"); return; }

SetItemCharges(oItem, nCharge+1);
SendMessageToPC(oPC,"You have "+IntToString(nCharge)+" shots left.");
DestroyObject(oTarget);
return;
}
else 
{ SendMessageToPC(oPC,"You need poison for this!"); return; }

}


//Shot creature
else if (GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
{
	//No ammo!
	if (nCharge <= 1) 
	{ 
	SendMessageToPC(oPC, "Reserve depleted. You must refill the contraption with poison."); 
	return; 
	}
	
	if (GetItemInSlot(INVENTORY_SLOT_BOLTS,oPC) == OBJECT_INVALID)
	{
	SendMessageToPC(oPC, "You must equip yourself with bolts."); 
	return;
	}

else
{
SetLocalInt(oPC,"CarcMantiShot",1);
//Shoot(oTarget,oPC);
SetItemCharges(oItem, nCharge-1);
SendMessageToPC(oPC,"You have "+IntToString(nCharge-2)+" shots left.");

ExecuteScript("i_carci_mantic_ac",oPC);
return;
}
}


//Not an item nor a creature!
	else 
	{ 
	SendMessageToPC(oPC,"Invalid target! Use a poison vial or target a living creature.");
	return;
	}
}