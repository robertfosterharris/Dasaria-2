//	SPAWNS A CREATURE DURING A CONTAINERS ON OPEN EVENT
//
//	SET THESE VARIABLES ON THE CONTANER...
// COFFINCREATURE - (STRING) RESREF OF THE CREATURE TO SPAWN
//  RESPAWNRATE - (FLOAT) NUMBER OF SECONDS BETWEEN RESPAWNS				
//
void main()
{
	if (!GetLocalInt(OBJECT_SELF, "Triggered"))
	{
		SetLocalInt(OBJECT_SELF, "Triggered", TRUE);
		CreateObject(OBJECT_TYPE_CREATURE, GetLocalString(OBJECT_SELF, "CoffinCreature"), GetLocation(OBJECT_SELF));
		DelayCommand(GetLocalFloat(OBJECT_SELF, "RespawnRate"), SetLocalInt(OBJECT_SELF, "Triggered", FALSE));
	}
}	