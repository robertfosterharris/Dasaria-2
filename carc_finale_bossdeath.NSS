void main()
{
object oPC = GetLastKiller();
object oArea = GetArea(oPC);
if (GetTag(oArea) != "misc_carcerum_finale") return;

//kill all horned devils that remain

//object oHorn = GetFirstObjectInShape(SHAPE_SPHERE, 900.0, GetLocation(oPC),FALSE,OBJECT_TYPE_CREATURE);
/*while (GetIsObjectValid(oHorn))
{
	if (GetTag(oHorn) == "c_devilhorn")
	{ 	ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDeath(FALSE,TRUE,TRUE),oHorn);  }
GetNextObjectInShape(SHAPE_SPHERE, 900.0, GetLocation(oPC),FALSE,OBJECT_TYPE_CREATURE);
}*/
string sVar;

if (GetTag(OBJECT_SELF) == "carcerum_maeruloch")
{
object oHorn1 = GetObjectByTag("carcerum_maeraid01");
object oHorn2 = GetObjectByTag("carcerum_maeraid02");
object oHorn3 = GetObjectByTag("carcerum_maeraid03");
object oHorn4 = GetObjectByTag("carcerum_maeraid04");
	ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDeath(FALSE,TRUE,TRUE),oHorn1);  
	ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDeath(FALSE,TRUE,TRUE),oHorn2);  
	ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDeath(FALSE,TRUE,TRUE),oHorn3);  
	ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDeath(FALSE,TRUE,TRUE),oHorn4);  
	
sVar = "Maeru_Dead";
}

if (GetTag(OBJECT_SELF) == "carcerum_abelis")
{
object oHorn1 = GetObjectByTag("carcerum_abelisaid1");
object oHorn2 = GetObjectByTag("carcerum_abelisaid2");
object oHorn3 = GetObjectByTag("carcerum_abelisaid3");
	ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDeath(FALSE,TRUE,TRUE),oHorn1);  
	ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDeath(FALSE,TRUE,TRUE),oHorn2);  
	ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDeath(FALSE,TRUE,TRUE),oHorn3);   

sVar = "Abelis_Dead";
}

if (GetTag(OBJECT_SELF) == "carcerum_coliel")
{
object oHorn1 = GetObjectByTag("carcerum_coliaid1");
object oHorn2 = GetObjectByTag("carcerum_coliaid2");
object oHorn3 = GetObjectByTag("carcerum_coliaid3");
object oHorn4 = GetObjectByTag("carcerum_coliaid4");
	ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDeath(FALSE,TRUE,TRUE),oHorn1);  
	ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDeath(FALSE,TRUE,TRUE),oHorn2);  
	ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDeath(FALSE,TRUE,TRUE),oHorn3);  
	ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDeath(FALSE,TRUE,TRUE),oHorn4);  

// 
oHorn1 = GetObjectByTag("carcerum_coliimp1");
ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDeath(FALSE,TRUE,TRUE),oHorn1); 
oHorn1 = GetObjectByTag("carcerum_coliimp2");
ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDeath(FALSE,TRUE,TRUE),oHorn1); 
oHorn1 = GetObjectByTag("carcerum_coliimp3");
ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDeath(FALSE,TRUE,TRUE),oHorn1); 
oHorn1 = GetObjectByTag("carcerum_coliimp4");
ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDeath(FALSE,TRUE,TRUE),oHorn1); 

sVar = "Coliel_Dead";
}

//start convo
object oMember = GetFirstFactionMember(oPC,TRUE);
	while (GetIsObjectValid(oMember))
	{
	if (GetIsPC(oMember))
	{
	AssignCommand(oMember,ClearAllActions(TRUE));
	SetLocalInt(oMember,sVar,1);
	AssignCommand(oMember,ActionStartConversation(oMember,"carc_finale",FALSE,FALSE,TRUE,FALSE));
	DelayCommand(12.0,DeleteLocalInt(oMember,sVar));
	return;
	}
	else { oMember = GetNextFactionMember(oPC,TRUE); }
	}
}