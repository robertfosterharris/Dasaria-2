////////////////////////////////////////////////////////////////////////////////
// dmfi_sc_check - DM Friendly Initiative - Starting Conditional Script for Conversation
// Original Scripter:  Demetrious      Design: Heavily Based on Paul Speeds NWN1 Work
//------------------------------------------------------------------------------
// Last Modified By:   Demetrious           9/5/6
//------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////
/**
 *  $Id: zdlg_check_01.nss,v 1.2 2005/01/26 00:43:01 pspeed Exp $
 *
 *  Entry conditional check for the Z-Dialog system.
 *
 *  Copyright (c) 2004 Paul Speed - BSD licensed.
 *  NWN Tools - http://nwntools.sf.net/
 */
#include "dmfi_inc_conv"

int StartingConditional(int nNum)
{
    object oSpeaker = GetPCSpeaker();
    return( _SetupDlgResponse( nNum - 1, oSpeaker ) );
}