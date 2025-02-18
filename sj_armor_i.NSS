// -----------------------------------------------------------------------------
//  sj_armor_i
// -----------------------------------------------------------------------------
/*
    Sunjammer's Armor Functions Library
    ===================================

    A library of armor related constants and functions.


    NOTES
    =====

    Hide And Chain Shirt: the BioWare implementation for these armors differs
    from both the 3rd Edition rules and the toolset palettes in which they are
    found. The NWN Engine treats Hide as light and Chain Shirt as medium armor
    and, consequently, so does this library.

    IsMetallic And Studded Leather: because IsMetallic is based on the armor
    type it will return FALSE for Studded Leather armor. If this is an issue
    additional checks can be implemented such as checking the item's name or
    using a local variable to flag studded armor.

    The functions in this library were developed on an ad hoc basis in response
    to various requests posted in the NWN Scripting forum. For v2.00 they have
    been rewritten to expand the functionality; to provide greater consistency
    between functions and to take advantage of more vigorous naming conventions.
    However to ensure it is backwards compatible with earlier versions all
    existing functionality has been retained as deprecated functions.

    This library uses one or more functions from my sj_core_i library which have
    been included in the temporary sj_armor_x library. That file can be removed
    and any references in sj_armor_x replaced with a reference to sj_core_i
    if/when the SJ Framework is installed.


    TODO @ v2.00
    ============

    - add *GetArcaneFailure(object oItem, int bBaseValue)
    - add *GetMaximumDexBonus(object oItem, int bBaseValue)

*/
// -----------------------------------------------------------------------------
/*
    Version 2.00 - 20 Mar 06 - Sumjammer
    - rewritten

    Version 1.04 - 31 Aug 05 - Sumjammer
    - added GetArmorCheckPenalty function
    - added GetItemArmorCheckPenalty function
    - added Get2DAInt (from sj_core_i library)

    Version 1.03 - 10 Mar 04 - Sumjammer
    - added GetArmorIsMetallic function

    Version 1.02 - 21 Feb 04 - Sumjammer
    - revised GetItemACBase function to use 2DA

    Version 1.01 - 20 Feb 04 - Sumjammer
    - added GetArmorType function
    - added armor type constansts

    Version 1.00 - 12 Dec 03 - Sumjammer
    - created
*/
// -----------------------------------------------------------------------------
#include "sj_armor_x"


// -----------------------------------------------------------------------------
//  CONSTANTS
// -----------------------------------------------------------------------------

// armor types
const int SJ_ARMOR_TYPE_CLOTH      = 0;
const int SJ_ARMOR_TYPE_LIGHT      = 1;
const int SJ_ARMOR_TYPE_MEDIUM     = 2;
const int SJ_ARMOR_TYPE_HEAVY      = 3;
const int SJ_ARMOR_TYPE_SHIELD     = 4;


// -----------------------------------------------------------------------------
//  PROTOTYPES
// -----------------------------------------------------------------------------

// Returns the total armor check penalty for oCreature's armor and shield as a
// positive integer, i.e. armor check penalty of -8 will return 8.
//  - oCreature:        any PC or NPC
//  * Returns:          armor check penalty
//  * OnError:          returns -1 if oPC is invalid
int SJ_Armor_GetArmorCheckPenalty(object oCreature);

// Returns TRUE if the armor is metallic.
// NOTE: because IsMetallic is based on the armor type it will return FALSE for
// Studded Leather therefore using Hide whenever possible is recommended.
//  - oArmor:           any armor item
//  * Returns:          TRUE (if oArmor is metalic) or FALSE
//  * OnError:          returns FALSE if oArmor is invalid or not armor
int SJ_Armor_GetIsMetallic(object oArmor);

// Returns TRUE if the armor is using a robe model.
//  - oArmor:           any armor item
//  * Returns:          TRUE (if oArmor is using a robe model) or FALSE
//  * OnError:          returns FALSE if oArmor is invalid or not armor
int SJ_Armor_GetIsRobe(object oArmor);

// Returns the base AC of oItem.
//  - oItem:            any armor or shield item
//  * Returns:          base AC of armor (0 - 8)
//  * OnError:          returns -1 if oItem is invalid or not armor/a shield
int SJ_Armor_GetItemACBase(object oItem);

// Returns the armor type of oItem.
//  - oItem:            any armor or shield item
//  * Returns:          SJ_ARMOR_TYPE_* constant
//  * OnError:          returns -1 if oItem is invalid or not armor/a shield
int SJ_Armor_GetItemArmorType(object oItem);

// Returns the armor check penalty of armor oItem as a positive integer, i.e. an
// armor check penalty of -8 will return 8.
//  - oItem:            any armor or shield item
//  * Returns:          armor check penalty
//  * OnError:          returns -1 if oItem is invalid or not armor/a shield
int SJ_Armor_GetItemArmorCheckPenalty(object oItem);


// -----------------------------------------------------------------------------
//  DEPRECATED
// -----------------------------------------------------------------------------

int GetArmorCheckPenalty(object oCreature)
{
    return SJ_Armor_GetArmorCheckPenalty(oCreature);
}


int GetArmorIsMetalic(object oArmor)
{
    return SJ_Armor_GetIsMetallic(oArmor);
}


int GetItemACBase(object oItem)
{
    return SJ_Armor_GetItemACBase(oItem);
}


int GetItemArmorType(object oItem)
{
    return SJ_Armor_GetItemArmorType(oItem);
}


int GetItemArmorCheckPenalty(object oItem)
{
    return SJ_Armor_GetItemArmorCheckPenalty(oItem);
}


// -----------------------------------------------------------------------------
//  FUNCTIONS
// -----------------------------------------------------------------------------

int SJ_Armor_GetArmorCheckPenalty(object oCreature)
{
    int nACP;

    // sanity check: creature is valid
    if(GetIsObjectValid(oCreature) == FALSE)
        return -1;

    // get armor and "shield"
    object oArmor = GetItemInSlot(INVENTORY_SLOT_CHEST, oCreature);
    object oShield = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oCreature);

    // NOTE: function checks object are correct types
    int nArmor = SJ_Armor_GetItemArmorCheckPenalty(oArmor);
    int nShield = SJ_Armor_GetItemArmorCheckPenalty(oShield);

    // if valid penalty returned then add to ACP
    if(nArmor > -1) nACP += nArmor;
    if(nShield > -1) nACP += nShield;

    // return total ACP
    return nACP;
}


int SJ_Armor_GetIsMetallic(object oArmor)
{
    if(GetBaseItemType(oArmor) == BASE_ITEM_ARMOR)
    {
        // medium and heavy are metallic
        int nType = SJ_Armor_GetItemArmorType(oArmor);
        return (nType > SJ_ARMOR_TYPE_LIGHT);
    }
    return FALSE;
}


int SJ_Armor_GetIsRobe(object oArmor)
{
    if(GetBaseItemType(oArmor) == BASE_ITEM_ARMOR)
    {
        // as the robe appearance overrides the normal model we can simply check
        // if the armor's robe model number is non-zero
        int nRobe = GetItemAppearance(oArmor, ITEM_APPR_TYPE_ARMOR_MODEL, ITEM_APPR_ARMOR_MODEL_ROBE);
        return (nRobe > 0);
    }
    return FALSE;
}


int SJ_Armor_GetItemACBase(object oItem)
{
    int nType = GetBaseItemType(oItem);

    if(nType == BASE_ITEM_ARMOR)
    {
        // get the torso model number
        int nTorso = GetItemAppearance(oItem, ITEM_APPR_TYPE_ARMOR_MODEL, ITEM_APPR_ARMOR_MODEL_TORSO);

        // read BaseAC from the appropriate 2DA
        // NOTE: can also use "parts_chest" which returns it as a "float"
        return Get2DAInt("des_crft_appear", "BaseAC", nTorso);
    }

    if(nType == BASE_ITEM_LARGESHIELD
    || nType == BASE_ITEM_SMALLSHIELD
    || nType == BASE_ITEM_TOWERSHIELD)
    {
        // read BaseAC from the appropriate 2DA
        return Get2DAInt("baseitems", "BaseAC", nType);
    }

    //  not armor or a shield: return an error
    return -1;
}


int SJ_Armor_GetItemArmorCheckPenalty(object oItem)
{
    int nType = GetBaseItemType(oItem);

    if(nType == BASE_ITEM_ARMOR)
    {
        // read and convert ACP from the appropriate 2DA
        return abs(Get2DAInt("armor", "ACCHECK", GetItemACBase(oItem)));
    }

    if(nType == BASE_ITEM_LARGESHIELD
    || nType == BASE_ITEM_SMALLSHIELD
    || nType == BASE_ITEM_TOWERSHIELD)
    {
        // read and convert ACP from the appropriate 2DA
        return abs(Get2DAInt("baseitems", "ArmorCheckPen", nType));
    }

    //  not armor or a shield: return an error
    return -1;
}


int SJ_Armor_GetItemArmorType(object oItem)
{
    int nType = GetBaseItemType(oItem);

    if(nType == BASE_ITEM_ARMOR)
    {
         // use the Base AC to determine the armor type
        int nBaseAC = SJ_Armor_GetItemACBase(oItem);
        if(nBaseAC == 0) return SJ_ARMOR_TYPE_CLOTH;
        if(nBaseAC <= 3) return SJ_ARMOR_TYPE_LIGHT;
        if(nBaseAC <= 5) return SJ_ARMOR_TYPE_MEDIUM;
        if(nBaseAC <= 8) return SJ_ARMOR_TYPE_HEAVY;
    }

    if(nType == BASE_ITEM_LARGESHIELD
    || nType == BASE_ITEM_SMALLSHIELD
    || nType == BASE_ITEM_TOWERSHIELD)
    {
        return SJ_ARMOR_TYPE_SHIELD;
    }

    //  not armor or a shield: return an error
    return -1;
}