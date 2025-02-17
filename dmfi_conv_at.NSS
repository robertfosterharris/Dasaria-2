////////////////////////////////////////////////////////////////////////////////
// dmfi_at_action - DM Friendly Initiative - Action Taken Script for Conversation
// Original Scripter:  Demetrious      Design: Heavily Based on Paul Speeds NWN1 Work
//------------------------------------------------------------------------------
// Last Modified By:   Demetrious           9/5/6
//------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////

/**
 *  $Id: zdlg_do_01.nss,v 1.2 2005/01/26 00:43:01 pspeed Exp $
 *
 *  Entry selection script for the Z-Dialog system.
 *
 *  Copyright (c) 2004 Paul Speed - BSD licensed.
 *  NWN Tools - http://nwntools.sf.net/
 */
#include "dmfi_inc_conv"

void main(int nNum)
{
    _DoDlgSelection( GetPCSpeaker(), nNum - 1 );
}