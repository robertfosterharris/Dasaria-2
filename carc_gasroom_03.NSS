//onconversation for carcerum gas chamber listener
//frac

void RemoveCloudkill(object oObject)
{
    effect eEffect = GetFirstEffect(oObject);
    while(GetIsEffectValid(eEffect))
    {   RemoveEffect(oObject, eEffect);
        eEffect = GetNextEffect(oObject);
    }
}

void main()
{
int nMatch = GetListenPatternNumber();
//object oPener = GetObjectByTag("carc_abelis_gaslistener");

object oDoor1 = GetObjectByTag("carc_abelis_gaschamb01");
object oDoor2 = GetObjectByTag("carc_abelis_gaschamb02");
object oCenter = GetObjectByTag("carc_abelis_gascenter");
if (!GetLocalInt(oCenter,"Gasing")) return;

//PHRASE IS MET.
if ((nMatch == 72001) || (nMatch == 72002) || (nMatch == 72003))
{

//first, let's rid the PCs from the gas effects.
object oGassed = GetFirstObjectInShape(SHAPE_CUBE,6.0,GetLocation(oCenter),FALSE,OBJECT_TYPE_CREATURE);
while (GetIsObjectValid(oGassed))
{ 
if (GetLocalInt(oGassed,"gassed")) { DeleteLocalInt(oGassed,"gassed"); }
oGassed = GetNextObjectInShape(SHAPE_CUBE,6.0,GetLocation(oCenter),FALSE,OBJECT_TYPE_CREATURE);
}

//Let's turn off the gas
DeleteLocalInt(oCenter,"Gasing");
RemoveCloudkill(oCenter);

//Open the doors. 
SetLocked(oDoor1,FALSE); SetLocked(oDoor2,FALSE);
AssignCommand(oDoor1, ActionSpeakString("<i>The poisonous gas quickly dissipates.</i>"));
AssignCommand(oDoor1, ActionOpenDoor(oDoor1)); 
AssignCommand(oDoor2, ActionOpenDoor(oDoor2));

}

else if ((nMatch == 72010) || (nMatch == 72011) || (nMatch == 72012) ||
(nMatch == 72013) || (nMatch == 72014) || (nMatch == 72015) ||
(nMatch == 72016) || (nMatch == 72017) || (nMatch == 72018))
{ 
object oPC = GetLastSpeaker();
object oStatue = GetObjectByTag("carc_abelis_gascenter");
int nDamage = d8(3)+d6(2);
nDamage = GetReflexAdjustedDamage(nDamage,oPC,18,SAVING_THROW_TYPE_TRAP);
effect eDamage = EffectDamage(nDamage, DAMAGE_TYPE_ACID);
if(nDamage > 0)
{
DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oPC));
DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_HIT_SPELL_ACID),oPC));
}
}

else return;
}