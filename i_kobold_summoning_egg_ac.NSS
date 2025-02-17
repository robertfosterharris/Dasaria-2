//i_kobold_summoning_egg_ac

void main()
{
	object oPC = GetItemActivator();
	object oKobold1;
	object oKobold2;
	object oKobold3;
	
	if (!GetIsObjectValid(	GetObjectByTag("kobold_comp1")	)	) 
	{
		oKobold1 = CreateObject(OBJECT_TYPE_CREATURE,"",GetLocation(oPC),TRUE,"kobold_comp1");
		DelayCommand(2.0,AssignCommand(oKobold1,AddHenchman(oPC)));
	}
	
	if (!GetIsObjectValid(GetObjectByTag("kobold_comp2")) )
	{
		oKobold2 = CreateObject(OBJECT_TYPE_CREATURE,"",GetLocation(oPC),TRUE,"kobold_comp2");
		DelayCommand(2.0,AssignCommand(oKobold2,AddHenchman(oPC)));
	}
	
	if (!GetIsObjectValid(GetObjectByTag("kobold_comp3")) )
	{
		oKobold3 = CreateObject(OBJECT_TYPE_CREATURE,"",GetLocation(oPC),TRUE,"kobold_comp3");
		DelayCommand(2.0,AssignCommand(oKobold3,AddHenchman(oPC)));
	}	
}