////////////////////////////////////////////////////////////////////////////////
// ex_template - Template script for creating new Custom Token Conversations
// Original Scripter:  Paul Speed and Demetrious
//------------------------------------------------------------------------------
// Last Modified By:   Demetrious           10/27/6
//------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////

#include "dmfi_inc_conv"

void ConfigureConversation()
{
	// USE THIS SINGLE FUNCTION HERE.  See function description for details on its use.
	ConfigureConv("FIRSTPAGE", OBJECT_SELF);
}	

void BuildStaticPages()
{
	// ADD PAGES HERE that NEVER NEED TO BE REFRESHED - STATIC FOREVER.
	
}

void BuildInitPages()
{
	// ADD PAGES HERE that need to be refreshed ON INITIATION OF THE CONVERSATION EACH TIME.
	
}

void BuildRefreshPages()
{
	// ADD PAGES HERE that need to be refreshed EVERY TIME they are shown..
}

void HandleSpecialBehavior(string sPage, int nSelection, object oHolder)
{
	// ADD Code for special behavior here - no code for simple page transfers is needed.		
	
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