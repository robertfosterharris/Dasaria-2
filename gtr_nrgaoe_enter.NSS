// wired feb 2014
// gtr_nrgaoe_enter

location GetCenterPointOfPersistentObject(object oPO);

void main()
{
	object oPC = GetEnteringObject();
	object oCtrl = GetFirstInPersistentObject(OBJECT_SELF,OBJECT_TYPE_PLACEABLE);
	int iCheck = FALSE;
	location lCenter;
	int iDmgType = GetLocalInt(OBJECT_SELF,"iDmgType");
	int iDmgPwr = GetLocalInt(OBJECT_SELF,"iDmgPwr"); 
	int iDice = GetLocalInt(OBJECT_SELF,"iDmgDice");
	
	if (!GetIsPC(oPC)) return;
	
	if (GetLocalInt(OBJECT_SELF,"iArmed") == TRUE) return;
	
	while (GetIsObjectValid(oCtrl))
	{
		if (GetResRef(oCtrl) == "plc_nrgaoe_ctrl")
		{
			iCheck = TRUE;
		}
	
		GetNextInPersistentObject(OBJECT_SELF,OBJECT_TYPE_PLACEABLE);
	}
	
	if (iCheck == FALSE)
	{
		oCtrl = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_nrgaoe_ctrl",GetCenterPointOfPersistentObject(OBJECT_SELF));
		SetLocalInt(OBJECT_SELF,"iArmed",1);
		SetLocalObject(OBJECT_SELF,"oCtrl",oCtrl);
		DelayCommand(1.0f,SetLocalObject(oCtrl,"oParent",OBJECT_SELF));
		DelayCommand(1.0f,SetLocalInt(oCtrl,"iDmgType",iDmgType));
		DelayCommand(1.0f,SetLocalInt(oCtrl,"iDmgPwr",iDmgPwr));
		DelayCommand(1.0f,SetLocalInt(oCtrl,"iDice",iDice));
	}
	
}

// getting their positions, so it is resource-intensive.
location GetCenterPointOfPersistentObject(object oPO)
{
    float fXMax = 0.0;
    float fXMin = 10000.0;
    float fYMax = 0.0;
    float fYMin = 10000.0;

    object oTmp = OBJECT_INVALID;
	object oArea = GetArea(oPO);
    vector vTmp;

    oTmp =  GetFirstInPersistentObject(oPO);
    while (GetIsObjectValid(oTmp)) {
        vTmp = GetPositionFromLocation(GetLocation(oTmp));
        if (vTmp.x > fXMax)
            fXMax = vTmp.x;
        if (vTmp.x < fXMin)
            fXMin = vTmp.x;
        if (vTmp.y > fYMax)
            fYMax = vTmp.y;
        if (vTmp.y < fYMin)
            fYMin = vTmp.y;
        oTmp = GetNextInPersistentObject(oPO);
    }

    // We now have the max and min positions of all objects in an area.
    vTmp = Vector( (fXMax + fXMin)/2.0, (fYMax + fYMin)/2.0, 0.0);

    //PrintString("Center vector: " + VectorToString(vTmp));

    return Location(oArea, vTmp, 0.0);
}