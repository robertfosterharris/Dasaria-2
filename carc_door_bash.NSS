//#include "nw_o2_coninclude"
//the Lock DC (not unlock!) = Bash HP.
//-frac

void MyShoutDisturbed(object oAttacker) {
  if (GetLocalInt(OBJECT_SELF,"DamageTaken") > 0)
    {
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_CREATURE);
        //Cycle through the targets within the spell shape until an invalid object is captured.
        while (GetIsObjectValid(oTarget))
        {
           if (GetFactionEqual(oTarget, OBJECT_SELF) == TRUE)
           {
        // * Make anyone who is a member of my faction hostile if I am violated
             SetIsTemporaryEnemy(oAttacker,oTarget,TRUE,60.0);
             AssignCommand(oTarget, ActionAttack(oAttacker));
           }
           oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_CREATURE);
        }
    }
}

void main()
{
  int iDC = GetLockLockDC(OBJECT_SELF);
  int iDamage = GetLocalInt(OBJECT_SELF,"DamageTaken");
  object oPC = GetLastAttacker();

  if (GetLockKeyRequired(OBJECT_SELF))
  {
    DelayCommand(0.1, FloatingTextStringOnCreature("(This lock cannot be bashed.)", oPC, FALSE));
  } 
  else {
    if (GetLockLockable(OBJECT_SELF) && iDamage <= iDC) 
	{
      if (GetLocked(OBJECT_SELF)) 
	  {
        MyShoutDisturbed(oPC);

        if (iDamage < 0)  iDamage = 0;
        iDamage = iDamage + 1;
        DelayCommand(0.1, FloatingTextStringOnCreature("Damage done: " + IntToString(iDamage) + " of " + IntToString(iDC), oPC, FALSE));

        if (iDamage >=  iDC) 
		{
          iDamage = iDC;
          SetLocked(OBJECT_SELF, FALSE);
          DelayCommand(0.1, FloatingTextStringOnCreature("<i>click</i>. The lock breaks.", oPC, FALSE));
          AssignCommand(oPC,ClearAllActions());
		  DelayCommand(1.5, SetLocalInt(OBJECT_SELF,"DamageTaken",0));
        }
        SetLocalInt(OBJECT_SELF,"DamageTaken",iDamage);
      } 
	  else 
	  {
        SetLocalInt(OBJECT_SELF,"DamageTaken",iDC);
      }
    } 
	else 
	{
      SetLocalInt(OBJECT_SELF,"DamageTaken",iDC+1);
      DelayCommand(0.1, FloatingTextStringOnCreature("<i>The door is not locked.</i>", oPC, FALSE));
      AssignCommand(oPC,ClearAllActions());
    }
  }
}