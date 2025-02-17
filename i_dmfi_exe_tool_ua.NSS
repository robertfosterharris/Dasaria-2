void main()
{
    object oTool;
	
	oTool = GetModuleItemLost();
	SetPlotFlag(oTool, FALSE);
	DestroyObject(oTool);
}