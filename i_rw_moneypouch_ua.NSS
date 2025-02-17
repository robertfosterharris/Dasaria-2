// i_rw_moneypouch_ua

/*
   Template for an UnAquire item script.
   This script will run each time the item is un-acquired (aka lost).
   
   How to use this script:
   Replace the word "temp" (in line 1) with the tag of the item.  Rename the script with this name.  
    
   Additional Info:
   In general, all the item "tag-based" scripts will be named as follows:
   - a prefix ("i_" by defualt)
   - the tag of the item
   - a postfix indicating the item event.
   
   This script will be called automatically (by defualt) whether it exists or not.  If if does not exist, nothing happens.
   
   Note: this event runs on the module object, an important consideration for assigning actions.
   -ChazM   
*/
// Name_Date
void main()
{
    // * This code runs when the item is unacquired
    object oPC      = GetModuleItemLostBy();
    object oItem    = GetModuleItemLost();
	DestroyObject(oItem,0.0);
	
}