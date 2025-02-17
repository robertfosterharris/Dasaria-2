#include "drunk_shared"

// This script is for the drunk's OnUserDefined event.
const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;


void main()
{   switch( GetUserDefinedEventNumber())
    {   case 1:   {   string sTag = GetTag( OBJECT_SELF);
                      if( sTag != "")
                      {   object oPost = GetWaypointByTag( sTag +"_Post");
                          DrunkStartActivity( oPost);
                      }
                  }
                  break;
    }
}