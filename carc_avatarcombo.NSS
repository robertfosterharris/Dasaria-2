//If OBJECT_SELF matches the input sTag
//then set it's individual nCorrect to 0/1

void main(string sInput)
{
object oPC=GetPCSpeaker();
string sTag = GetTag(OBJECT_SELF);
object oMaster = GetObjectByTag("carc_coliel_avatardoor");
	//if we put in nuarari in the right table then set to 1
	if (sTag == "carc_coliel_avtable01")
	{
		if (sInput == "nuarari")
		{ SetLocalInt(OBJECT_SELF,"Combo", 1); }
		else //else, set to 0
		{ DeleteLocalInt(OBJECT_SELF,"Combo"); }
	}
	
	//if we put in tharon in the right table then set to 1
	if (sTag == "carc_coliel_avtable02")
	{
		if (sInput == "tharon")
		{ SetLocalInt(OBJECT_SELF,"Combo", 1); }
		else //else, set to 0
		{ DeleteLocalInt(OBJECT_SELF,"Combo"); }
	}	
	//if we put in coloth in the right table then set to 1
	if (sTag == "carc_coliel_avtable03")
	{
		if (sInput == "coloth")
		{ SetLocalInt(OBJECT_SELF,"Combo", 1); }
		else //else, set to 0
		{ DeleteLocalInt(OBJECT_SELF,"Combo"); }
	}	
	//if we put in lochwar in the right table then set to 1
	if (sTag == "carc_coliel_avtable04")
	{
		if (sInput == "lochwar")
		{ SetLocalInt(OBJECT_SELF,"Combo", 1); }
		else //else, set to 0
		{ DeleteLocalInt(OBJECT_SELF,"Combo"); }
	}	
	
int n1 = GetLocalInt(GetObjectByTag("carc_coliel_avtable01"),"Combo");
int n2 = GetLocalInt(GetObjectByTag("carc_coliel_avtable02"),"Combo");
int n3 = GetLocalInt(GetObjectByTag("carc_coliel_avtable03"),"Combo");
int n4 = GetLocalInt(GetObjectByTag("carc_coliel_avtable04"),"Combo");

int nTotal = n1+n2+n3+n4;
SetLocalInt(oMaster,"Combo",nTotal);

//SendMessageToPC(oPC, "sum is "+IntToString(GetLocalInt(oMaster,"Combo")));

//if (GetLocalInt(oMaster,"Combo") == 4)	
//SendMessageToPC(oPC, "Success!");
}