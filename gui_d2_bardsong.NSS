// gui_d2_bardsong
// wired 2013/01/27

// NOT CURRENTLY USED BUT DON'T DELETE THANKS

// OnLeftClick1=UIObject_Misc_ExecuteServerScript("gui_d2_bardsong")

#include "std_inc_bardsong"

void main()
{
	// die if not bard
	if (!GetLevelByClass(CLASS_TYPE_BARD,OBJECT_SELF) > 0) return;
	
	int nCurrentAction = GetCurrentAction();
	int nLastSpellClass =  GetLastSpellCastClass();	
	
	// some other logic
	//SendMessageToPC(OBJECT_SELF,"Action is: "+IntToString(nCurrentAction));
	//SendMessageToPC(OBJECT_SELF,"Last Spellcast Class was: "+IntToString(nLastSpellClass));
	
	//
	if (nCurrentAction == ACTION_CASTSPELL)
	{
		// to avoid double-bardsong if a regular spell is cast from a hotbar
		SetLocalInt(OBJECT_SELF,"BardHotBarBypass",1);
		DelayCommand(3.0,DeleteLocalInt(OBJECT_SELF,"BardHotBarBypass"));
		
		d2_PlayBardSongSound();
	}
}