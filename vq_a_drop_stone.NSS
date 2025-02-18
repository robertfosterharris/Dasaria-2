//	ACTION SCRIPT - DROPS STONE BLOCK CRUSHING VAMPIRE COFFINS
//
//	01/28/07	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM
//
void ResetStone();

void main(float fRespawn)
{
	int nNth;

	location locStone;
	object oStone;
	vector vStone;
	
	object oCoffin;
	
	if (!GetLocalInt(OBJECT_SELF, "Triggered"))
	{
		SetLocalInt(OBJECT_SELF, "Triggered", TRUE);

		oStone = GetObjectByTag("vq_p_stone");
		vStone = GetPosition(oStone);
		vStone.z = 0.0f;
		locStone = Location(GetArea(oStone), vStone, GetFacing(oStone));
		DestroyObject(oStone);
		CreateObject(OBJECT_TYPE_PLACEABLE, "vq_p_stone", locStone);

		nNth = 0;
		oCoffin = GetObjectByTag("vq_p_vampire_coffin", nNth);
		while (GetIsObjectValid(oCoffin))
		{
			ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(TRUE), oCoffin);
			nNth++;
			oCoffin = GetObjectByTag("vq_p_vampire_coffin", nNth);
		}			
	}
	AssignCommand(OBJECT_SELF, DelayCommand(fRespawn, ResetStone()));
}	

void ResetStone()
{
	int nNth;

	location locStone;
	object oStone;
	vector vStone;
	
	object oCoffin;

	SetLocalInt(OBJECT_SELF, "Triggered", FALSE);
	
	oStone = GetObjectByTag("vq_p_stone");
	vStone = GetPosition(oStone);
	vStone.z = 1.0f;
	locStone = Location(GetArea(oStone), vStone, GetFacing(oStone));
	DestroyObject(oStone);
	CreateObject(OBJECT_TYPE_PLACEABLE, "vq_p_stone", locStone);

	nNth = 0;
	oCoffin = GetObjectByTag("vq_p_crushed_coffin", nNth);
	while (GetIsObjectValid(oCoffin))
	{
		ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(TRUE), oCoffin);
		nNth++;
		oCoffin = GetObjectByTag("vq_p_crushed_coffin", nNth);
	}			
}