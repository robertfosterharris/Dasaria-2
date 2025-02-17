//	ga_kill_object
/*
    This script apply EffectDeath to objects to cause their OnDeath script to fire
	Based on ga_destroy
        sTag        = The tag(s) of the object(s) to destroy. You can pass multiple
                      tags, seperated by commas (NO SPACES) to destroy multiple objects
                      (ie. "Object1,Object2,Object3")
                      NOTE: There may eventually be a function to eat white space
                      (See Mantis 3296), but for now do not put spaces in the string.
        iInstance   = The instance of the object to destroy. Pass -1 to destroy
                      all instances.  Pass 0 to destroy the first instance.
					  
	01/29/07	ROBERT HARRIS	ROBERTHARRIS@ROBERTHARRIS.COM					  
*/
void Destroy(string sTagString, int iInstance = 0);

void main(string sTagString, int iInstance)
{
    string sNewString = sTagString;
    int iLen = GetStringLength(sTagString);
    int iCommaPos = FindSubString( sNewString, "," ); //find first comma

    while(iCommaPos != -1)
    {
        // get first tag and destroy it
        string sTempString = GetSubString(sNewString , 0, iCommaPos);
        Destroy(sTempString, iInstance);

        // drop first tag and comma
        sNewString  = GetSubString(sNewString, iCommaPos + 1, iLen);
        // determine new length
        iLen = GetStringLength(sNewString);
        // get next comma position (returns -1 if not found)
        iCommaPos = FindSubString(sNewString, "," );
    }

    //sNewString is equal to last tag to destroy
    Destroy(sNewString, iInstance);
}

void Destroy(string sTagString, int iInstance = 0)
{
	int iInst;
	object oObject;
	
    if (iInstance == -1)
    {
        iInst = 0;
        oObject = GetObjectByTag(sTagString, iInst);
        while (GetIsObjectValid(oObject))
        {
			SetPlotFlag(oObject, FALSE);
			ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oObject);
            iInst ++;
            oObject = GetObjectByTag(sTagString, iInst);
        }
    }
    else
    {
        oObject = GetObjectByTag(sTagString, iInst);
		SetPlotFlag(oObject, FALSE);
		ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oObject);
    }
}