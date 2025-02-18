// bastard son of.. ga_create_obj(string sObjectType, string sTemplate, string sLocationTag, int bUseAppearAnimation, string sNewTag, float fDelay)

#include "ginc_param_const"
#include "ginc_actions"

void main()
{
	object oLocation = GetObjectByTag("frontier_return");
    location lLocation = GetLocation(oLocation);
    int iObjType = GetObjectTypes("P");
	ActionCreateObject(iObjType,"arc_frontier", lLocation, 1);
}