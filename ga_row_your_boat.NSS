#include "ginc_overland_constants"

void DeactivateUI(object oPC = OBJECT_SELF)
{
	//Close all of the Ingame UI elements we want hidden.
	CloseGUIScreen(oPC, GUI_SCREEN_DEFAULT_PARTY_BAR);
	CloseGUIScreen(oPC, GUI_SCREEN_DEFAULT_HOTBAR);
	CloseGUIScreen(oPC, GUI_SCREEN_DEFAULT_HOTBAR_2);
	CloseGUIScreen(oPC, GUI_SCREEN_DEFAULT_HOTBAR_V1);
	CloseGUIScreen(oPC, GUI_SCREEN_DEFAULT_HOTBAR_V2);
	CloseGUIScreen(oPC, GUI_SCREEN_DEFAULT_MODEBAR);
	CloseGUIScreen(oPC, GUI_SCREEN_DEFAULT_PLAYERMENU);
	CloseGUIScreen(oPC, GUI_SCREEN_DEFAULT_ACTIONQUEUE);
}

void ReactivateUI(object oPC = OBJECT_SELF)
{
	//Open the new Custom UI Elements for the OL Map.
	DisplayGuiScreen(oPC, GUI_SCREEN_DEFAULT_PARTY_BAR, FALSE);
	DisplayGuiScreen(oPC, GUI_SCREEN_DEFAULT_HOTBAR, FALSE);
	DisplayGuiScreen(oPC, GUI_SCREEN_DEFAULT_HOTBAR_2, FALSE);
	DisplayGuiScreen(oPC, GUI_SCREEN_DEFAULT_HOTBAR_V1, FALSE);
	DisplayGuiScreen(oPC, GUI_SCREEN_DEFAULT_HOTBAR_V2, FALSE);
	DisplayGuiScreen(oPC, GUI_SCREEN_DEFAULT_MODEBAR, FALSE);
	DisplayGuiScreen(oPC, GUI_SCREEN_DEFAULT_PLAYERMENU, FALSE);
	DisplayGuiScreen(oPC, GUI_SCREEN_DEFAULT_ACTIONQUEUE, FALSE);
}

/*
void JumpPeeps()
{
	object oPartyMem = GetFirstFactionMember(OBJECT_SELF, FALSE);
	object oWP = GetWaypointByTag("WP_LH_ENDPOINT");
	
    while (GetIsObjectValid(oPartyMem)) 
	{
		AssignCommand(oPartyMem, JumpToObject(oWP));
        oPartyMem = GetNextFactionMember(OBJECT_SELF, FALSE);
    }
}
*/

void RemoveCS()
{
	effect eff = GetFirstEffect(OBJECT_SELF);
    while (GetIsEffectValid(eff))
    {
    	if(GetEffectSpellId(eff) == 8777)
        {
        	RemoveEffect(OBJECT_SELF, eff);
 		}
         eff=GetNextEffect(OBJECT_SELF);
	}
}

void DoActions()
{
    // Note that OBJECT_SELF is now the assigned object (oPC)
	ActionDoCommand(DeactivateUI());
   	ActionJumpToObject(	GetObjectByTag("POST_lancon_rowboat"),FALSE	);
	ActionDoCommand(SetCameraMode(OBJECT_SELF,CAMERA_MODE_STIFF_CHASE_CAMERA));	
	ActionForceMoveToObject(	GetObjectByTag("WP_LH_FINISH"), FALSE);
	ActionDoCommand(FadeToBlack(OBJECT_SELF));
	ActionDoCommand(RemoveCS());
	//ActionDoCommand(JumpPeeps());
	ActionJumpToObject(	GetObjectByTag("WP_LH_ENDPOINT"),FALSE	);	
	ActionDoCommand(FadeFromBlack(OBJECT_SELF));
	ActionDoCommand(ReactivateUI());
   	ActionDoCommand(SetCommandable(TRUE));	
   	SetCommandable(FALSE);
}

void main()
{
    object oPC = GetPCSpeaker();
	object oPartyMem = GetFirstFactionMember(oPC, FALSE);
	effect e = EffectVisualEffect( VFX_DUR_CUTSCENE_INVISIBILITY);	

    while (GetIsObjectValid(oPartyMem)) 
	{
		ApplyEffectToObject( DURATION_TYPE_PERMANENT, SetEffectSpellId(e, 8777), oPC );	
		AssignCommand(oPartyMem,DoActions());
        oPartyMem = GetNextFactionMember(oPC, FALSE);
    }
}