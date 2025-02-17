// gp_firedamage_hb
// Runs off a placeable with fire VFX, deals fire damage to PCs within AOE


void main() {

object oTarget;
location lCenter;
int iDie;

// Set location of fire's center and read number of die for damage
lCenter = GetLocation(OBJECT_SELF);
iDie = GetLocalInt(OBJECT_SELF, "iDie");

// Create the effect to apply
effect eDamage = EffectDamage(d6(iDie), DAMAGE_TYPE_FIRE);
effect eVis = EffectNWN2SpecialEffectFile("fx_defaultitem_fire");

oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 12.0, lCenter);

while(GetIsObjectValid(oTarget))
{
   ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget);
   ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget, 6.0);      
   oTarget = GetNextObjectInShape(SHAPE_SPHERE, 12.0, lCenter);
} 

}