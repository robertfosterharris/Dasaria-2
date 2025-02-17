//////////////////////////////////////////////////
// CUSTOM TOKEN DIALOG SYSTEM
// EXAMPLE SCRIPT: By Demetrious
// NOTE:  All "code" for this example is above line 63
//////////////////////////////////////////////////

#include "dmfi_inc_conv"

void ConfigureConversation()
{
	// Turn on the End prompt for every page - everything else - standard
	ConfigureConv("list_items", OBJECT_SELF, 0, TRUE, "Thanks for shopping.", "Thanks for shopping.");
}	


void BuildStaticPages()
{
	object oSpeaker = GetPcDlgSpeaker();
	
	// ADD PAGES HERE that NEVER NEED TO BE REFRESHED - STATIC FOREVER.
	
	StaticPage("checkout","Would you like to see more items?", COLOR_MAGENTA);
	AddReply("Yes, thank you.  *keep shopping*", "list_items");
	AddReply("No thanks. *check out*");
}

void BuildInitPages()
{
	string sMess;
	object oItem;
	object oSpeaker = GetPcDlgSpeaker();
	// put the model on a respawning trigger
	object oModel = GetNearestObjectByTag("evlya_model");
	
	DynamicPage("list_items", "What would you like to start with?  Go ahead, pick anything.", COLOR_MAGENTA);
	object oObject = GetFirstItemInInventory(oModel);
	while (oObject!=OBJECT_INVALID)
	{
		AddReplyLinkObject(GetName(oObject), "buy_items", -1, oObject);
		oObject = GetNextItemInInventory(oModel);
	}
	AddReply("Nothing.");
}

void BuildRefreshPages()
{
	object oSpeaker = GetPcDlgSpeaker();
	object oModel = GetNearestObjectByTag("evlya_model");
	object oWearing = GetItemInSlot(INVENTORY_SLOT_CHEST,oModel);
	string sMess = GetLocalString(OBJECT_SELF,"sMess");
			
	DynamicPage("buy_items", sMess, COLOR_MAGENTA);	
	AddReplyLinkObject("I'll take it", "checkout");
	AddReplyLinkObject("I'd like to see something else please", "list_items");
}

void HandleSpecialBehavior(string sPage, int nSelection, object oHolder)
{
	object oSpeaker = GetPcDlgSpeaker();
	object oModel = GetNearestObjectByTag("evlya_model");
	object oModel2 = GetNearestObjectByTag("evlya_model_dude");
	
	if (sPage == "list_items")
	{			
		PlayCustomAnimation(OBJECT_SELF,"curtsey",0);
		SpeakString("Tah Dah!");
		
		object oItem = GetObjectElement(nSelection, sPage);		
		AssignCommand(oModel,ActionEquipItem(oItem,INVENTORY_SLOT_CHEST));
		
		object oItem2 = GetItemPossessedBy(oModel2,GetTag(oItem));
		AssignCommand(oModel2,ActionEquipItem(oItem2,INVENTORY_SLOT_CHEST));		
		
		vector vTarget = GetPosition(oSpeaker);
		AssignCommand(oModel, ActionDoCommand(SetFacingPoint(vTarget, 1)));
		AssignCommand(oModel2, ActionDoCommand(SetFacingPoint(vTarget, 1)));
		AssignCommand(oModel,ActionPlayAnimation(ANIMATION_FIREFORGET_GREETING));
		AssignCommand(oModel2,ActionPlayAnimation(ANIMATION_FIREFORGET_GREETING));
		
		string sMess = "Would you like to purchase this ";				
		sMess = sMess + GetName(oItem);
		int nValue = GetGoldPieceValue(oItem)*25;
		sMess = sMess + " for " + IntToString(nValue); 
		sMess = sMess + " gp?";
		
		SetLocalString(OBJECT_SELF,"sMess",sMess);
		
	}
	if (sPage == "checkout")
	{
		object oItem = GetItemInSlot(INVENTORY_SLOT_CHEST,oModel);
		if (oItem!=OBJECT_INVALID)
		{
			int nValue = GetGoldPieceValue(oItem)*25;
			TakeGoldFromCreature(nValue, oSpeaker,TRUE,TRUE);
			CopyItem(oItem,oSpeaker);
		}
	}
}


////////////////////////////////////////////////////////////////////////////////////////////
// DO NOT EDIT BELOW HERE WITHOUT READING!!
//
// Below this is reserved for advanced users to build special behavior.  It might be easiest
// to actually just write the script from scratch if you need to alter something down here
// but I have left it in the script for completeness and so not to have re-write a stable
// script package with a proven track record.
////////////////////////////////////////////////////////////////////////////////////////////
void DoOnce()
{
	int nTest = GetLocalInt(OBJECT_SELF, "DLG_ONCE");
	if (nTest) return;
	SetLocalInt(OBJECT_SELF, "DLG_ONCE", TRUE);
	ConfigureConversation();
	BuildStaticPages();	
}

void Init()
{
	DoOnce();
	ConfigureConversation();
	BuildInitPages();
	BuildRefreshPages();
}

void PageInit()
{   
	string sTest;
	string sPage = GetDlgPageString();
	object oHolder = GetLocalObject(OBJECT_SELF, "DLG_HOLDER");
	
	int nRefresh = GetLocalInt(oHolder, "DLG_REFRESH"+sPage);
	if (nRefresh)
		BuildRefreshPages();
	
	string sPrompt = GetLocalString(OBJECT_SELF, sPage + "PROMPT");			
	
	SetDlgPrompt(sPrompt);
	
	sTest = GetLocalString(OBJECT_SELF, sPage + "DLG_REPLY_PAGE");
	if (sTest!="")
	{
		sPage = sTest;	
		SetDlgPageString(sPage);
	}		
	SetDlgResponseList(sPage, oHolder);
}

void HandleSelection()
{
    object oSpeaker = GetPcDlgSpeaker();
	string sPage = GetDlgPageString();
	int nSelection = GetDlgSelection();
	object oHolder = GetLocalObject(OBJECT_SELF, "DLG_HOLDER");
	string sTargetPage = GetStringElement(nSelection, sPage + "TARGET_PAGE", oHolder);
    	
	HandleSpecialBehavior(sPage, nSelection, oHolder); 
		
	if (sTargetPage=="")
		EndDlg();
	else
		SetDlgPageString(sTargetPage);

	if (_HasDlgPrevious( oSpeaker ) || _HasDlgNext( oSpeaker ))
	{
		int nPage = GetLocalInt(oSpeaker, "dlg_num");
	    if (nPage==0) nPage = DLG_CONV_NUM;
		int nCurrent = _GetDlgFirstResponse(oSpeaker);
		int nPickNext = (_HasDlgNext(oSpeaker)) && (nSelection-nCurrent==nPage+1);
		int nPickPrev = (_HasDlgPrevious(oSpeaker)) && (nSelection-nCurrent==nPage+2);
			
		if ((!nPickNext) && (!nPickPrev))
		{
			_SetDlgFirstResponse(oSpeaker, 0);
			PageInit();
		}	
	}
}

void Abort()
{
	_CleanupDlg(GetPcDlgSpeaker());
	SpeakString(GetLocalString(OBJECT_SELF, "DLG_ABORT"));
}	

void End()
{
	_CleanupDlg(GetPcDlgSpeaker());
	SpeakString(GetLocalString(OBJECT_SELF, "DLG_END"));
}	

void main()
{
   	int iEvent = GetDlgEventType();
	switch( iEvent )
        {
        case DLG_INIT:
            Init();
            break;
        case DLG_PAGE_INIT:
            PageInit();
            break;
        case DLG_SELECTION:
            HandleSelection();
            break;
        case DLG_ABORT:
            Abort();
			break;
        case DLG_END:
            End();
			break;
        }
}