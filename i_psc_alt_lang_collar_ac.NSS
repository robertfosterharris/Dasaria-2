// wired 7/2/2010
// i_psc_alt_lang_collar_ac
//

#include "dmfi_inc_langexe"

void DMFI_GrantAdditionalLanguage(object oPC)
{
	object oTool;

	// build a current list
	DMFI_BuildChoosenList(oPC);
		
	SetLocalInt(oPC, DMFI_CHOOSE, 1);
	DMFI_ClearUIData(oPC);
	SetLocalString(oPC, DMFI_LAST_UI_COM, PRM_GRANT + PRM_);
	SetLocalString(oPC, DMFI_UI_PAGE, PG_LIST_DMLANGUAGE);
	SetLocalString(oPC, DMFI_UI_LIST_TITLE, CV_PROMPT_CHOOSE + "1");
	DMFI_ShowDMListUI(oPC, SCREEN_DMFI_CHOOSE);
}

void main()
{
	object oPC = GetItemActivator();
	DMFI_GrantAdditionalLanguage(oPC);
}

