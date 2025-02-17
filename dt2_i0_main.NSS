/*
    dt2 -
        Dasarian Treasure 2
        by jhr4n <games@transcendent.us>

    Set these variables on the chest
        dt2_config_master           - string, tag of the master chest to use
        dt2_config_gp               - int, total value to spawn
        dt2_config_max              - int, how many items to spawn
        dt2_config_respawn          - float, seconds; zero for no respawn
        dt2_config_deflator         - float, merchannt markdown multiplier

	2007/1/21	Jay Four
		Added support for NPC generation via tokens
		
*/

// Handle creation of treasure from master chests
void 		dt2_master_init(object oMaster);
object   	dt2_generate_one(object oMaster, int gp);
void 		dt2_generate_all(object oChest, object oMaster, int iGP, int iMax, float fDeflator);

// Request a chest generate according to it's configured variables
void 		dt2_placeable_generate(object oChest);
// Request a respawn on a chest, according to the delay var on the chest
void dt2_placeable_respawn(object oChest);
// The Delayed function that actually does the spawn, remembering custom vars
void dt2_placeable_spawn(   string resref, location loc, string sMasterTag,
                            int iGP, int iMax, float fRespawn, float fDeflator);
							


const float dt2_variance = 2.0f;


/*

Notes:
	Putting tokens into master chests (indirection) doesn't work
	right now.  But it would be easy enough.  
	
	To do it, modify "generate one"	so that if it pulls a token, 
	it skips the % check and does a recursive pull.  This would
	also allow tokens to operate in normal placeable chests.

*/



void dt2_master_init(object oMaster)
{
    int count = GetLocalInt(oMaster, "dt2_init_count");
    if (count > 0) return;

    object oItem = GetFirstItemInInventory( oMaster);
    while ( GetIsObjectValid(oItem) )
        {
        count++;

        // Get the real value
        int id = GetIdentified(oItem);
        SetIdentified(oItem, TRUE);
        int value = GetGoldPieceValue(oItem);
        SetIdentified(oItem, id);

        // Store it away
        SetLocalObject( oMaster, "dt2_itemobj_"+IntToString(count), oItem);
        SetLocalInt(    oMaster, "dt2_itemval_"+IntToString(count), value);

        oItem = GetNextItemInInventory(oMaster);
        }

    SetLocalInt(oMaster, "dt2_init_count", count);
}






object   dt2_generate_one(object oMaster, int gp)
	{
    int count = GetLocalInt(oMaster, "dt2_init_count");

    int select;
    int value;

    int i;
    for(i=0;i<5;i++)
      {
      select = 1+ Random(count);
      value = GetLocalInt( oMaster, "dt2_itemval_"+IntToString(select));
      object oItem = GetLocalObject( oMaster, "dt2_itemobj_"+IntToString(select) );
	  
	  // This should not be strictly required, but many people will forget
	  SetDroppableFlag( oItem, TRUE);
	  
      if (value < gp)
        return oItem;
      }
    return OBJECT_INVALID;
	}





void dt2_generate_all(object oChest, object oMaster, int iGP, int iMax, float fDeflator)
	{
    dt2_master_init(oMaster);

    float fGP;

    // This block does an unbiased geometric spread
    int iRnd = Random(201)-100;
    if (iRnd < 0)
      {
      fGP = -1.0 * IntToFloat(iRnd) / 100.0f;
      fGP = 1.0f + fGP*(dt2_variance-1.0f);
      fGP = IntToFloat(iGP) / fGP;
      iGP = FloatToInt(fGP);
      }
    if (iRnd > 0)
      {
      fGP = IntToFloat(iRnd) / 100.0f;
      fGP = 1.0f + fGP*(dt2_variance-1.0f);
      fGP = IntToFloat(iGP) * fGP;
      iGP = FloatToInt(fGP);
      }

    //SpeakString( "Value: " + IntToString(iGP) );


    // Pull until gold runs "low" or max items have been pulled
    object phat_lewt = dt2_generate_one(oMaster, iGP);
    while ( GetIsObjectValid(phat_lewt) && iMax > 0)
        {
        iGP -= GetGoldPieceValue(phat_lewt);
        CopyItem(phat_lewt, oChest, TRUE);
        phat_lewt = dt2_generate_one(oMaster, iGP);
        iMax--;
        }

    // Deflate gold value (merchant markdown)
    fGP = IntToFloat(iGP);
    fGP *= fDeflator;
    iGP = FloatToInt(fGP);

    // Create gold
    CreateItemOnObject("nw_it_gold001", oChest, iGP );
	}
	
	
	
	
	

void dt2_placeable_generate(object oChest)
{
    // Only Generate the items one time
    if ( GetLocalInt(oChest, "dt2_depleated") != 0 )
      return;
    else
      SetLocalInt(oChest, "dt2_depleated", TRUE);

    //Load master chest
    string  sMasterTag = GetLocalString(oChest, "dt2_config_master");
    object oMaster = GetObjectByTag(sMasterTag);
    if ( !GetIsObjectValid(oMaster) || sMasterTag == "")
        {
        // Severe Error!
        return;
        }

    // Load value to distribute
    int iGP = GetLocalInt(oChest, "dt2_config_gp");
    if ( iGP < 1)
      {
      // Severe Error
      return;
      }

    // Load up maximum items
    int iMax = GetLocalInt(oChest, "dt2_config_max");
    if ( iMax < 1 )
      {
      // Severe Error
      return;
      }
	  
	float fDeflator = GetLocalFloat(oChest, "dt2_config_deflator");
		

    // Ok, generate
    dt2_generate_all(oChest, oMaster, iGP, iMax, fDeflator);
}







void dt2_placeable_spawn(   string resref, location loc, string sMasterTag,
                            int iGP, int iMax, float fRespawn, float fDeflator)
{
  object oChild = CreateObject(OBJECT_TYPE_PLACEABLE, resref, loc, FALSE);
  SetLocalString    (oChild, "dt2_config_master",   sMasterTag);
  SetLocalInt       (oChild, "dt2_config_gp",       iGP);
  SetLocalInt       (oChild, "dt2_config_max",      iMax);
  SetLocalFloat     (oChild, "dt2_config_respawn",  fRespawn);
  SetLocalFloat     (oChild, "dt2_config_deflator", fDeflator);
}





void dt2_placeable_respawn(object oChest)
{
  string    resref      = GetResRef(oChest);
  location  loc         = GetLocation(oChest);

  string    sMasterTag  = GetLocalString    (oChest, "dt2_config_master");
  int       iGP         = GetLocalInt       (oChest, "dt2_config_gp");
  int       iMax        = GetLocalInt       (oChest, "dt2_config_max");
  float     fRespawn    = GetLocalFloat     (oChest, "dt2_config_respawn");
  float     fDeflator   = GetLocalFloat     (oChest, "dt2_config_deflator");

  // Call as many times as you like, no double chests
  if ( GetLocalInt(oChest, "dt2_respawning") != 0 )
    return;
  else
    SetLocalInt(oChest, "dt2_respawning", TRUE);

  // Respawn times less than 60 seconds don't respawn at all
  if ( fRespawn < 60.0 )
    return;

  AssignCommand(GetModule(), DelayCommand(fRespawn,
      dt2_placeable_spawn(resref, loc, sMasterTag, iGP, iMax, fRespawn, fDeflator)
    ));

}




void	dt2_token_generate( object oToken, object oCreature )
	{
	
	// Roll the dice - not all tokens come into being
	float fAppear = GetLocalFloat(oToken, "dt2_config_spawn");
	fAppear *= 1000;
	int iBeat = FloatToInt( fAppear );
	if ( Random(1000) >= iBeat )
		return;
	
	
	
    //Load master chest
    string  sMasterTag = GetLocalString(oToken, "dt2_config_master");
    object oMaster = GetObjectByTag(sMasterTag);
    if ( !GetIsObjectValid(oMaster) || sMasterTag == "")
        {
        // Severe Error!
        return;
        }

    // Load value to distribute
    int iGP = GetLocalInt(oToken, "dt2_config_gp");
    if ( iGP < 1)
      {
      // Error
      return;
      }

    // Load up maximum items
    int iMax = GetLocalInt(oToken, "dt2_config_max");
    if ( iMax < 1 )
      {
      // Error
      return;
      }

    // Ok, generate
    dt2_generate_all( oCreature, oMaster, iGP, iMax, 0.0 );	
	}








/*
*/