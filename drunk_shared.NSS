int DrunkRandomGesture()
{   switch( Random( 22))
    {   case 0:  return ANIMATION_FIREFORGET_DODGE_DUCK;
        case 1:  return ANIMATION_FIREFORGET_DODGE_SIDE;
        case 2:  return ANIMATION_FIREFORGET_PAUSE_BORED;
        case 3:  return ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD;
        case 4:  return ANIMATION_FIREFORGET_SALUTE;
        case 5:  return ANIMATION_FIREFORGET_SPASM;
        case 6:  return ANIMATION_FIREFORGET_TAUNT;
        case 7:  return ANIMATION_FIREFORGET_VICTORY1;
        case 8:  return ANIMATION_FIREFORGET_VICTORY2;
        case 9:  return ANIMATION_FIREFORGET_VICTORY3;
        case 10: return ANIMATION_LOOPING_CONJURE1;
        case 11: return ANIMATION_LOOPING_CONJURE2;
        case 12: return ANIMATION_LOOPING_LOOK_FAR;
        case 13: return ANIMATION_LOOPING_PAUSE;
        case 14: return ANIMATION_LOOPING_PAUSE2;
        case 15: return ANIMATION_LOOPING_PAUSE_DRUNK;
        case 16: return ANIMATION_LOOPING_PAUSE_TIRED;
        case 17: return ANIMATION_LOOPING_SIT_CROSS;
        case 18: return ANIMATION_LOOPING_SPASM;
        case 19: return ANIMATION_LOOPING_TALK_LAUGHING;
        case 20: return ANIMATION_LOOPING_TALK_NORMAL;
        case 21: return ANIMATION_LOOPING_TALK_PLEADING;
    }
    return ANIMATION_LOOPING_PAUSE_DRUNK;
}


void aDrunkMumble()
{   switch( Random( 48))
    {   case 0: SpeakString( "Oh Lochwar... oh Tharon... oh Culnul... Oh Coloth!");                       break;
        case 1: SpeakString( "Raffen wazzle enna cuppin bruzzz...");                           break;
        case 2: SpeakString( "Wherez dat damn Leyeth? Owez me a Hunnars!");                                                    break;
        case 3: SpeakString( "Hmff... YOU... hmph... not takin orderz from YOU!");                                        break;
        case 4: SpeakString( "Hic... uuhhhh... Hic...");                                       break;
        case 5: SpeakString( "'scuse me... blahhhhhh arrrrrrf... uhhh... now where wuzzz I?"); break;
        case 6: SpeakString( "Uhhhh.... nasty orcses... very nasty...");              break;
        case 7: SpeakString( "My gold! What's happened to all my gold?!?");                   break;
		default:
		// keep quiet!
		break;
    }
}


void aDrunkArgue()
{   switch( Random( 48))
    {   case 0: SpeakString( "Don't you try 'n tell me... I know wazzz wut n all...");                                                     break;
        case 1: SpeakString( "I told you tha before... you juzzz... neverrr... urp!");                                                     break;
        case 2: SpeakString( "Lizzen to me! We'z all dead, eaten by da Orc!");                                                                                             break;
        case 3: SpeakString( "Shaddup 'n gimme tha drink... thaz wut I told him den I... uhhhh");                                          break;
        case 4: SpeakString( "uhhh... WHAT?... now THAT's juz silly talk!");                                                               break;
        case 5: SpeakString( "It wuzz robbbb ree I say... no boddddy awwwta be allowed ta charge so much... for just a swalla!");          break;
        case 6: SpeakString( "Throw me out will ya... you'll see you won't sell another drink... treatin your best costomers like that!"); break;
        case 7: SpeakString( "I deserrrrve summmm dignity dammit... hmmmf... owwww");                                                      break;
		// keep quiet!
		break;	
    }
}


void aDrunkSaySomething()
{   if( Random( 2) == 0) aDrunkMumble();
    else aDrunkArgue();
}


float DrunkPostThreshold()
{   // Maximum distance drunk will wander from a post if one exists for him.
    // If this number is less than or equal to fMaxStumble the drunk will never leave his post.
    float fPostThreshold = GetLocalFloat( OBJECT_SELF, "PostThreshold");
    if( fPostThreshold < 0.0f) fPostThreshold = 20.0f;
    return fPostThreshold;
}


float DrunkMinStumble()
{   // Minimum distance drunk will stumble before doing something else.
    float fMinStumble = GetLocalFloat( OBJECT_SELF, "MinStumble");
    if( fMinStumble < 0.0f) fMinStumble = 3.0f;
    return fMinStumble;
}


float DrunkMaxStumble()
{   // Maximum distance drunk will stumble before doing something else.
    float fMaxStumble = GetLocalFloat( OBJECT_SELF, "MaxStumble");
    if( fMaxStumble <= 0.0f) fMaxStumble = 15.0f;
    return fMaxStumble;
}


float DrunkStumbleDistance()
{   // Randomly choose a distance between MinStumble and MaxStumble.
    float fMinStumble = DrunkMinStumble();
    float fMaxStumble = DrunkMaxStumble();
    return (IntToFloat( Random( FloatToInt( (fMaxStumble -fMinStumble) *10.0))) /10.0) +fMinStumble;
}


float DrunkMinPerform()
{   // Minimum time in seconds that the drunk will perform an action before he does something else.
    float fMinPerform = GetLocalFloat( OBJECT_SELF, "MinPerform");
    if( fMinPerform <= 0.0f) fMinPerform = 0.5f;
    return fMinPerform;
}


float DrunkMaxPerform()
{   // Maximum time in seconds that the drunk will perform an action before he does something else.
    float fMaxPerform = GetLocalFloat( OBJECT_SELF, "MaxPerform");
    if( fMaxPerform <= 0.0f) fMaxPerform = 10.0f;
    return fMaxPerform;
}


float DrunkPerformDuration()
{   // Randomly choose a duration between fMinPerform and fMaxPerform.
    float fMinPerform = DrunkMinPerform();
    float fMaxPerform = DrunkMaxPerform();
    return (IntToFloat( Random( FloatToInt( (fMaxPerform -fMinPerform) *10.0))) /10.0) +fMinPerform;
}


void DrunkStartActivity( object oPost)
{   ActionDoCommand( SetFacing( IntToFloat( Random( 3600)) /10.0f));
    switch( Random( 6))
    {   case 0:   // Stumble around.
                  {   SetLocalString( OBJECT_SELF, "Activity", "Stumbling");
                      float fDistance  = DrunkStumbleDistance();
                      float fDirection = IntToFloat( Random( 3600)) /10.0f;

                      // If a post for him exists and he is getting too far from it make him stumble back to it.
                      if( GetIsObjectValid( oPost) && (GetDistanceToObject( oPost) > (DrunkPostThreshold() -fDistance)))
                      {   SetFacingPoint( GetPositionFromLocation( GetLocation( oPost)));
                          fDirection = GetFacing( OBJECT_SELF);
                      }

                      // Stumble randomly.
                      vector vUnit = VectorNormalize( AngleToVector( fDirection));
                      vUnit = Vector( vUnit.x *fDistance, vUnit.y *fDistance, vUnit.z);
                      location lTarget = GetLocation( OBJECT_SELF);
                      vector vTarg = GetPositionFromLocation( lTarget);
                      vTarg.x += vUnit.x;
                      vTarg.y += vUnit.y;
                      ActionDoCommand( ActionMoveToLocation( Location( GetArea( OBJECT_SELF), vTarg, GetFacingFromLocation( lTarget))));
                  }
                  ActionDoCommand( aDrunkSaySomething());
                  break;
        case 1:   // Fall down.
                  {   SetLocalString( OBJECT_SELF, "Activity", "Falling");
                      int iFaceUp = (Random( 2) == 0) ? ANIMATION_LOOPING_DEAD_BACK : ANIMATION_LOOPING_DEAD_FRONT;
                      ActionDoCommand( ActionPlayAnimation( iFaceUp, 1.0f, DrunkPerformDuration()));
                      ActionDoCommand( aDrunkSaySomething());
                  }
                  break;
        case 2:   // Stand still and mumble.
                  SetLocalString( OBJECT_SELF, "Activity", "Mumbling");
                  ActionDoCommand( aDrunkMumble());
                  break;
        case 3:   // Gesture.
                  SetLocalString( OBJECT_SELF, "Activity", "Gesturing");
                  ActionDoCommand( ActionPlayAnimation( DrunkRandomGesture(), 1.0f, DrunkPerformDuration()));
                  ActionDoCommand( aDrunkSaySomething());
                  break;
        case 4:   // Kneel down.
                  SetLocalString( OBJECT_SELF, "Activity", "Kneeling");
                  ActionDoCommand( ActionPlayAnimation( ANIMATION_LOOPING_MEDITATE, 1.0f, DrunkPerformDuration()));
                  ActionDoCommand( aDrunkSaySomething());
                  break;
        case 5:   // Argue.
                  SetLocalString( OBJECT_SELF, "Activity", "Arguing");
                  ActionDoCommand( ActionPlayAnimation( ANIMATION_LOOPING_TALK_FORCEFUL, 1.0f, DrunkPerformDuration()));
                  ActionDoCommand( aDrunkArgue());
                  break;
    }
    ActionDoCommand( SetLocalString( OBJECT_SELF, "Activity", "Idle"));
}