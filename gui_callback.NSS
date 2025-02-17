void main(string sField = "Null", string sValue ="Null", string sVariable ="Null" )
{
	object oChar = OBJECT_SELF;
	//SendMessageToPC(oChar, "GUI Script Result 2:"+sValue1+" 2:"+sValue2+" 3:"+sValue3+" 4:"+sValue4);
	if (  GetLocalInt( oChar, "CSL_DATACALLBACK"+sField ) != 0 && GetLocalInt( oChar, "CSL_DATACALLBACK"+sField ) == StringToInt(sVariable) )
	{
		DeleteLocalInt( oChar, "CSL_DATACALLBACK"+sField );
		SetLocalString( oChar, sField, sValue);
		
	}
	else
	{
		SendMessageToPC( oChar, "Bad Var, ignoring" );
	}
}