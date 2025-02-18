//
//	ROBERT HARRIS	10/31/2008	ROBERTHARRIS@ROBERTHARRIS.COM
//
// 

						//	Shade		Shade		Wired		Wired		Rob			RW			SABRE		EUMEN		PHOENIX		OSIRIS		LOKI		BACCHUS		KITTY		SEBEK		FENRIR		PROMETHEUS	SETH		ODIN		ODIN		NARSILIC	ERIS
const string STAFF_KEYS =  "KCQG9FNX	K6J4KKP6	KANUETWX	KCMTWE4K	KCMT6P6U	KCQQXKDG	K6M9L9AC	KCMGDHJM	KCMCLL9Q	YPQLAQRY	KCMNQ7QY	YPQKHGGK	KA7WFGKQ	KCUCN9LM	KCUKFAFR	KCMTCG9P	K6J4WTEW	KVCCMUVM	KNDXUUTL	KCQGRUGG	KVK63JWC";

// FALCON		ATHARIN
// KCMPMDLW		KA4X36P

//
//	GLOBAL CONDITIONAL - RETURNS TRUE IF THE SPEAKER IS A MEMBER OF DASARIA'S STAFF
//

int GetIsStaff(object oPC)
{
	int bIsStaff;
	string sKey;
	
	
	sKey = GetPCPublicCDKey(oPC);
	
	if (FindSubString(STAFF_KEYS, sKey) == -1)
	{
		bIsStaff = FALSE;
	}
	else
	{
		bIsStaff = TRUE;
	}
	
	return bIsStaff;
}
//
//	RETURNS TRUE IF THE CHARACTER IS SHAPECHANGED
//
int	GetIsShapechanged(object oPC)
{
	effect eEffect;
	int nType;
	int bIsShapechanged;
	
	bIsShapechanged = FALSE;
	eEffect = GetFirstEffect(oPC);
	while (GetIsEffectValid(eEffect))
	{
		nType = GetEffectType(eEffect);
		if (nType == EFFECT_TYPE_WILDSHAPE ) bIsShapechanged = TRUE;
		if (nType == EFFECT_TYPE_POLYMORPH ) bIsShapechanged = TRUE;
		eEffect = GetNextEffect(oPC);
	}
	return bIsShapechanged;
}
//
//	WRAPPER FOR EXPORT SINGLE CHARACER
//
void SaveSingleCharacter(object oPC) 
{
	if (!GetIsShapechanged(oPC))
	{
		ExportSingleCharacter(oPC);
		SendMessageToPC(oPC, "Your character has been saved.");
	}		
}
//
//	SET LOCAL INTEGER ON EVERY MEMBER OF oOBJECT'S PARTY
//
void SetPartyInt(object oObject, string sVarName, int nValue)
{
	object oPC;
	
	oPC = GetFirstFactionMember(oObject);
	
	while (GetIsObjectValid(oPC))
	{
		SetLocalInt(oPC, sVarName, nValue);
		oPC = GetNextFactionMember(oObject);
	}
}