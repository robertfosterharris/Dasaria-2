/*
*/


#include "std_i0_data"




// recommend time function - hours since the epoch.
int     time_GetTime(); 


// time stamps allow quick measurement of elapsed time (game hours)
void    time_stamp_set      ( object oTarget, string key);
int     time_stamp_elapsed  ( object oTarget, string key);


// time stamp in real life time (only hour accurate though)
int		time_stamp_elapsed_seconds ( object oTarget, string key);


// Time stamp in RL seconds, accurate to the second
void    time_stamp_seconds_set      ( object oTarget, string key);
int		time_stamp_seconds_elapsed	( object oTarget, string key);



/*
	
	std_i0_data is included for 2 reasons:
		Fine precision on clock requires 2 variables
		Per user tracking requires complex matching
		

	Reminder of the key built-in commands:	
		GetTimeHour()
		GetTimeMinute()
		GetTimeSecond()

		Second ticks RL seconds.  Minute ticks RL minutes.
		Hour counts a number based on module properties.
		
				
*/


int time_GetTime()
    {
	
	int iYear = GetCalendarYear();
	int iMonth = GetCalendarMonth();
	int iDay = GetCalendarDay();
	int iHour = GetTimeHour();

	return (iYear)*12*28*24 + (iMonth-1)*28*24 + (iDay-1)*24 + iHour;	
    }


void    time_stamp_set      ( object oTarget, string key)
    {
    int time_now = time_GetTime();
    SetLocalInt( oTarget, key, time_now);
    }

int     time_stamp_elapsed  ( object oTarget, string key)
    {
    int time_now = time_GetTime();
    int time_stamp = GetLocalInt( oTarget, key);

    int time_elapsed = time_now - time_stamp;

    return time_elapsed;
    }


int		time_stamp_elapsed_seconds ( object oTarget, string key)
	{	
	int elapsed = time_stamp_elapsed( oTarget, key );

	// Hours to Seconds can't handle huge numbers	
	if ( elapsed > 500 )
		{
		elapsed = 500;
		//SendMessageToPC(oPC, "Lets cap that at 500" );
		}		
	
	int real_seconds_elapsed = FloatToInt( HoursToSeconds( elapsed ) );
	return real_seconds_elapsed;		
	}


	
string	time_print_pretty()
	{
	
	int iYear = GetCalendarYear();
	int iMonth = GetCalendarMonth();
	int iDay = GetCalendarDay();
	int iHour = GetTimeHour();		
	
	string message = "";
	message += IntToString( iYear );
	message += "/";
	message += IntToString( iMonth );
	message += "/";
	message += IntToString( iDay );
	message += "  ";
	message += IntToString( iHour );
	message += ":00";
	
	return message;
	}

	
		
	
/*
		Accurate with seconds precision
*/
void    time_stamp_seconds_set      ( object oTarget, string key)
    {
    int time_now = time_GetTime();
	tree_leaf_setint( oTarget, key, "hours", time_now);

	int seconds_now = (GetTimeMinute() * 60) + GetTimeSecond();
	tree_leaf_setint( oTarget, key, "seconds", seconds_now);
    }	
	
	
int	time_stamp_seconds_elapsed      ( object oTarget, string key)
	{
	
	// Calculate hour difference
    int time_then = tree_leaf_getint( oTarget, key, "hours");
	int time_now = time_GetTime();
	int elapsed = time_now - time_then;
	
	// Hours to Seconds can't handle huge numbers	
	if ( elapsed > 500 )
		elapsed = 500;
		
	// Convert hour difference to seconds, RL
	elapsed = FloatToInt( HoursToSeconds( elapsed ) );
	
	// Add additional seconds difference
	int seconds_then = tree_leaf_getint( oTarget, key, "seconds");
	int seconds_now = (GetTimeMinute() * 60) + GetTimeSecond();
	elapsed += seconds_now - seconds_then;
		
	return elapsed;
	}


	
	
/*

*/