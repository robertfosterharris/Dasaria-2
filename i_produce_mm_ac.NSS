// i_produce_mug_ac

#include "ginc_statbuff"

void main()
{
    object oTarget = GetItemActivator();
	ExecuteScript("nw_s2_detecevil",oTarget);
}