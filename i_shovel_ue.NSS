 // unequip
 
void main()
{
	object oPC = GetPCItemLastUnequippedBy();	
	effect eFirst = GetFirstEffect(oPC);
	
   while (GetIsEffectValid(eFirst))
       {
	   if (GetEffectSpellId(eFirst) == -899)
	      {
		  RemoveEffect(oPC, eFirst);
		  break;
		  }
	   eFirst = GetNextEffect(oPC);	  
	   } 
}