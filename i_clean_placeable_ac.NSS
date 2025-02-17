// i_clean_placeable_ac
void main()
{
    object oPC = GetItemActivator();
    object oTarget = GetItemActivatedTarget();
	
	object oInShape = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_SMALL, GetLocation(oTarget), TRUE, OBJECT_TYPE_PLACED_EFFECT | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_LIGHT);
	//Cycle through the targets within the spell shape until an invalid object is captured.
	while (GetIsObjectValid(oInShape))
	{
		DestroyObject(oInShape);
		SendMessageToPC(oPC, "Destroyed Object " + GetTag(oInShape));
	    oInShape = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_SMALL, GetLocation(oTarget), TRUE, OBJECT_TYPE_PLACED_EFFECT | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_LIGHT);
	}
}