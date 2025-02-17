/* nUse: 1 = Copy to Tailor | 2 = Destroy | 3 = Copy to PC
nUseSlots:
Helmet: 0  | Chest: 1  |  Boots: 2 |  Cloak: 6 
Gloves: 3  | RHand: 4  |  LHand: 5
////////////////////////////////////////////////////////////*/
/*
Conversation + Script tacked onto XPCraft to make it a touch more flexible,
like NWN1's tailoring models of old.
- Atharin.
*/
#include "nwnx_craft_system"
void StripProps(object oItem);
void ApplyProps(object oNew, object oOld);
void SetDR(object oOld, object oNew);
void CopyVars(object oOld, object oNew);
void CopyDesc(object OriginalDesc, object TargetDesc, object oPC);
void CalculateWeight(object oOld, object oNew );

void main(int nSlot, int nUse=0)
{
object oPC = GetPCSpeaker();
if (nSlot < 1) nSlot = INVENTORY_SLOT_HEAD;
object oCopying = GetItemInSlot(nSlot,oPC);

if (nUse == 1) //Default copy item appearance
{

object oPCItem = GetItemInSlot(nSlot,oPC);
// Is the item an adamantine armor with DR? STOP!
int nStop; int nMaterialType = GetItemBaseMaterialType(oPCItem);
if (nMaterialType == GMATERIAL_METAL_ADAMANTINE)
	{
	if (GetBaseItemType(oPCItem) == BASE_ITEM_SMALLSHIELD) nStop=1;
	if (GetBaseItemType(oPCItem) == BASE_ITEM_LARGESHIELD) nStop=1;
	if (GetBaseItemType(oPCItem) == BASE_ITEM_TOWERSHIELD) nStop=1;
	if (GetBaseItemType(oPCItem) == BASE_ITEM_ARMOR) nStop=1;
	if (GetTag(oPCItem) == "culnul_cirumvax_mask")nStop=1;
	}

if (nStop) 
	{ 
	SendMessageToPC(oPC,"Currently, adamantine armors/shields cannot be copied to the tailoring dummy. You may import appearances <i>to</i> your adamantine armors/shields freely, however.");
	return;
	}	
// End STOP!
// Conclusion: The only way we can neatly circumvent this fault in the dummy tailor, as far as I can tell, is to simply replace
// all items in the module that use the NWN2 Damage Reduction field with the "hidden" item property (it works fine).
// We can retroactively alter existing items with a script.
// Note: This will screw up enchantment for adamantine armors (as it will count towards the properties max), UNLESS we add in an
// exception for ip 90 (do not use the constant in the toolset).
		
object oCopied = CopyItem(oCopying,OBJECT_SELF,TRUE);
AssignCommand(OBJECT_SELF,ActionEquipItem(oCopied,nSlot));

StripProps(oCopied);
}


if (nUse == 2) //Reset command destroys item
{
	if (nSlot == 99)//Destroy everything was selected
	{    
		int nCount = 0;
		while (nCount < 7)
		{
//		AssignCommand(OBJECT_SELF,ActionUnequipItem(GetItemInSlot(nCount,OBJECT_SELF)));
		DestroyObject(GetItemInSlot(nCount,OBJECT_SELF));	
		nCount = nCount+1;
		}		
	}
	else 
	{
	//AssignCommand(OBJECT_SELF,ActionUnequipItem(GetItemInSlot(nSlot,OBJECT_SELF)));
	DestroyObject(GetItemInSlot(nSlot,OBJECT_SELF));
	}
}

if (nUse == 3) //Copy item to PC
{

object oAltered = GetItemInSlot(nSlot,OBJECT_SELF);
object oPCItem = GetItemInSlot(nSlot,oPC);

// make sure the item type matches the recepient
if (GetBaseItemType(oAltered) != GetBaseItemType(oPCItem)) 
{
SendMessageToPC(oPC,"ERROR: Item type mismatch!");
return;
}

//freezing the PC to avoid action queue canceling
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectCutsceneParalyze(),oPC,0.5);

// Match materials and armor rules
int nMaterialType = GetItemBaseMaterialType(oPCItem);
SetItemBaseMaterialType(oAltered,nMaterialType);
int nArmorRules = GetArmorRulesType(oPCItem);
SetArmorRulesType(oAltered,nArmorRules);

//Reset icon, name, tag and desc:
SetIdentified(oAltered,TRUE);
string sDesc = GetDescription(oPCItem);
string sName = GetName(oPCItem);
int iIcon = GetItemIcon(oPCItem);
SetItemIcon(oAltered,iIcon);
//SetDescription(oAltered,sDesc);
//SetDescription(oAltered, GetDescription(oPCItem));
CopyDesc(oPCItem,oAltered,oPC);
SetFirstName(oAltered,sName);//SetLastName(oAltered,"");
SetTag(oAltered,GetTag(oPCItem));

object oNewCopy = CopyItem(oAltered,oPC,TRUE);//copying new item to PC..
ApplyProps(oNewCopy,oPCItem);//Applying the old properties
CopyVars(oPCItem,oNewCopy); //copying variables
SetDR(oPCItem,oNewCopy); //copying DR

CalculateWeight(oPCItem,oNewCopy); //Matching weight

DestroyObject(oPCItem);//destroying the old item
DelayCommand(0.55,AssignCommand(oPC,ActionEquipItem(oNewCopy,nSlot)));//equip new


}


}

void StripProps(object oItem)
{
SetItemBaseMaterialType(oItem,0); // Set material to non-specific. 
itemproperty ip = GetFirstItemProperty(oItem);
while (GetIsItemPropertyValid(ip))
{
RemoveItemProperty(oItem,ip);
ip = GetNextItemProperty(oItem);
}
}

void ApplyProps(object oNew,object oOld)
{
itemproperty ip = GetFirstItemProperty(oOld);
while (GetIsItemPropertyValid(ip))
{
AddItemProperty(DURATION_TYPE_PERMANENT,ip,oNew);
ip = GetNextItemProperty(oOld);
}
}


void SetDR(object oOld,object oNew)
{
//Set DR, if applicable: 
int nMaterialType = GetItemBaseMaterialType(oOld);
if (nMaterialType == GMATERIAL_METAL_ADAMANTINE)
 {
if (!GetLocalInt(oOld,"DamageReduction"))//Don't add DR to items that already have it
 {
 int nDR;
	//shields
	if (GetBaseItemType(oOld) == BASE_ITEM_SMALLSHIELD) nDR = 1;
	if (GetBaseItemType(oOld) == BASE_ITEM_LARGESHIELD) nDR = 2;
	if (GetBaseItemType(oOld) == BASE_ITEM_TOWERSHIELD) nDR = 3;
	//armors:
	
	if ((GetBaseItemType(oOld) == BASE_ITEM_ARMOR) && (GetArmorRank(oOld) == ARMOR_RANK_HEAVY))
	{ nDR = 3; }
	if ((GetBaseItemType(oOld) == BASE_ITEM_ARMOR) && (GetArmorRank(oOld) == ARMOR_RANK_MEDIUM))
	{ nDR = 2; }
	

//Entries for specific items....:
if (GetTag(oOld) == "culnul_cirumvax_mask")nDR =2;


string sDRRef;	int nDRVar;
switch (nDR)
{
case 1: sDRRef = "ath_dr_1";nDRVar=1;break;
case 2: sDRRef = "ath_dr_2";nDRVar=2;break;
case 3: sDRRef = "ath_dr_3";nDRVar=3;break;
case 4: sDRRef = "ath_dr_4";nDRVar=4;break;
case 5: sDRRef = "ath_dr_5";nDRVar=5;break;
}//end switch
itemproperty iDR = GetFirstItemProperty(GetObjectByTag(sDRRef));

AddItemProperty(DURATION_TYPE_PERMANENT,iDR,oNew);
SetLocalInt(oNew,"DamageReduction",nDRVar);
} //end if GetLocalInt "DamageReduction"
} //end if adamantine
}


void CopyVars(object oOld,object oNew)
{
// Copy all vars from equipped item to new item (REMOVE the CopyVars=True setting CopyItem):
int nVarCount = GetVariableCount(oOld); int nPosition=1;
string sVarName; int nVarType;
while (nPosition<=nVarCount)
{
sVarName = GetVariableName(oOld,nPosition); 
nVarType = GetVariableType(oOld,nPosition);
if (nVarType = VARIABLE_TYPE_INT) { SetLocalInt(oNew,sVarName,GetVariableValueInt(oOld,nPosition)); }
if (nVarType = VARIABLE_TYPE_FLOAT) { SetLocalFloat(oNew,sVarName,GetVariableValueFloat(oOld,nPosition)); }
if (nVarType = VARIABLE_TYPE_STRING) { SetLocalString(oNew,sVarName,GetVariableValueString(oOld,nPosition)); }
if (nVarType = VARIABLE_TYPE_LOCATION) { SetLocalLocation(oNew,sVarName,GetVariableValueLocation(oOld,nPosition)); }

nPosition++;
}
}



void CopyDesc(object OriginalDesc, object TargetDesc, object oPC)
{
//placeholder
string sOrigin = GetDescription(OriginalDesc);
SendMessageToPC(oPC, "Original Description is: ");
SendMessageToPC(oPC, sOrigin);
SendMessageToPC(oPC, "---");
SendMessageToPC(oPC, GetLocalString(OriginalDesc,"DESCRIPTION"));

}


void CalculateWeight(object oOld, object oNew)
{
int nGoal = GetWeight(oOld);
int nCurrent = GetWeight(oNew);

//ADD WEIGHT:
if (nCurrent < nGoal) //new item is lighter than PC's equipped item
	{
	itemproperty ipAddWeight=ItemPropertyWeightIncrease(IP_CONST_WEIGHTINCREASE_5_LBS);
	while (nCurrent < nGoal)
		{
		AddItemProperty(DURATION_TYPE_PERMANENT,ipAddWeight,oNew);
		nCurrent = GetWeight(oNew);
		}
	}
//DECREASE WEIGHT:
else if (nCurrent > nGoal)
	{
	itemproperty ipRemWeight=ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_10_PERCENT);
	while (nCurrent > nGoal)
		{
		AddItemProperty(DURATION_TYPE_PERMANENT,ipRemWeight,oNew);
		nCurrent = GetWeight(oNew);
		}
	}
}