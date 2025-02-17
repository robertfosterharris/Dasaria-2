/*++

Copyright (c) Ken Johnson (Skywing). All rights reserved.

Module Name:

	gui_nwscriptvm_log_stats.nss

Abstract:

	This module logs NWScript usage statistics to AuroraServerNWScript.log when
	it is run.

--*/

void
NWScriptVM_LogStatistics(
	)
/*++

Routine Description:

	This routine logs current NWScript usage statistics to the plugin log file.

Arguments:

	None.

Return Value:

	None.

Environment:

	Any script caller.

--*/
{
	NWNXGetInt( "NWSCRIPTVM", "LOG SCRIPT STATISTICS", "", 0 );
}

void
main(
	)
/*++

Routine Description:

	This routine logs statistics to the plugin log file.

Arguments:

	None.

Return Value:

	None.

Environment:

	GUI script.

--*/
{
	if (!GetIsDM( OBJECT_SELF ) && !GetIsDMPossessed( OBJECT_SELF ))
		return;

	NWScriptVM_LogStatistics( );
}

