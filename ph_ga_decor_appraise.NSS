
//#include "ginc_item"

void main()
{
	object oItem = OBJECT_SELF;
	string sName = GetName(oItem);
	
	// eat whitespace at the end of a name
	while (GetStringRight(sName,1) == " ")
	{
		sName = GetStringLeft(sName,(GetStringLength(sName)-1)	);
	}	
	
	int nPrice = GetLocalInt(oItem,"nPrice");		
	SetCustomToken(8675308,sName);
	SetCustomToken(8675309,IntToString(nPrice));		
}