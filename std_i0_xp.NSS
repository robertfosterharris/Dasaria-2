/*


	2006/12/10		jhr4n
		Added:
			xp_penalty_nolevelloss
			xp_level_ecl
	2011/08/04 rw
		Added new subrace values to xp_util_level_ecl_modifier

*/


// XP penalty that will never result in level loss
void	xp_penalty_nolevelloss( object oPC, int penalty );


// Get the "effective" level of a player (take ECL into account)
int		xp_level_ecl( object oPC );

// The amount of xp for a level, with ECL
int		xp_level_min( object oPC, int nLevel );


// Get the modifider for a race
int		xp_util_level_ecl_modifier( int race );

// Get the min xp for a specific level (ignores ECL calculations)
int		xp_util_level_min( int level );





// xp scaling with people outside the range clipped to be inside
float 	xp_scale_capped ( int delta, int min, int max );

// xp scaling with people outside the range getting ZERO
float 	xp_scale_blocked (  int delta, int min, int max );

// scale factor from level diff
float	xp_scale_universal( int delta );



/*

	According to the DMG (3.0):
		2 CR levels below is 1/2 xp and
		2 CR above is 2x xp
		
		We can use a geometric spread, sqrt(2), to achieve almost this
		For each level below, multiply by 1/sqtr(2) ~= .707
		For each level above, multiply by sqrt(2) ~= 1.414
		
		This will work perfectly for +/- 2.
		
		For +/- 1, the DMG calls for 2/3 and 3/2, we are "close enough":
			2/3= .6666, which is about .707
			3/2= 1.5, which is about 1.414
			
		It's as good as we are going to get without getting really wierd.
		
	Reductions:
		0	100%
		1	71%
		2	50%
		3	35%
		4	25%
		5	18%
		6	12.5%
		
	My thoughts are to just call it at 4 (25%).  Past that, tough luck.
		
*/


// Scale goes up with delta.  Harder is larger.  delta = CR - level
float	xp_scale_universal( int delta )
	{
	
	float val = 1.0;
	
	while ( delta > 0 )
		{
		val *= 1.414;
		--delta;
		}

	while ( delta < 0 )
		{
		val *= 0.707;
		++delta;
		}
		
	return val;
	}


	
float 	xp_scale_capped ( int delta, int min, int max )
	{
	if ( delta > max )
		delta = max;
		
	if ( delta < min )
		delta = min;
		
	return xp_scale_universal( delta );
	}	

	
	
	
	
	

float	xp_scale_blocked (  int delta, int min, int max )
	{
	// They are too high, but still under max = full credit
	if ( delta >= 0 && delta <= max  )
		return 1.0;
		
	// They are too low, but within range = credit, but scale it down
	if ( delta < 0 && delta >= min )
		return xp_scale_universal( delta );
	
	// They get nothing
	return 0.0;
	}

	
	
	
	
	

// Get the min xp for a specific level (ignores ECL calculations)
int		xp_util_level_min( int level )
	{
	int min = ((level * (level - 1)) / 2) * 1000;
	return min;	
	}

	
	
	
	
	
	
	
	
	
//	GET THE ECL FOR A RACE
int	xp_util_level_ecl_modifier(int race)
{
	switch (race)
	{		
		case RACIAL_SUBTYPE_AASIMAR:
		case RACIAL_SUBTYPE_AIR_GENASI:
		case RACIAL_SUBTYPE_EARTH_GENASI:
		case RACIAL_SUBTYPE_FIRE_GENASI:
		case RACIAL_SUBTYPE_GRAYORC:
		case RACIAL_SUBTYPE_GRAY_DWARF:
		case RACIAL_SUBTYPE_TIEFLING:
		case RACIAL_SUBTYPE_WATER_GENASI:
		case 93://	RACIAL_SUBTYPE_PT_BARAAN
		case 94://	RACIAL_SUBTYPE_PT_REL
		case 95://	RACIAL_SUBTYPE_PT_COLOTH
		case 96://	RACIAL_SUBTYPE_PT_NUARARI
		case 97://	RACIAL_SUBTYPE_PT_INEANIA
		case 98://	RACIAL_SUBTYPE_PT_TESHALIA
		case 99://	RACIAL_SUBTYPE_PT_CHTAIA
		case 100://	RACIAL_SUBTYPE_PT_EXO	
		
		
		
			return 1;
		
		case RACIAL_SUBTYPE_DROW:
		case RACIAL_SUBTYPE_HAGSPAWN:
		case RACIAL_SUBTYPE_YUANTI:
		case 82: //RACIAL_SUBTYPE_ELF_T
			return 2;

		case RACIAL_SUBTYPE_SVIRFNEBLIN:
			return 3;				
	}	
	return 0;
}


	
	
//	RETURN ECL
int	xp_level_ecl(object oPC)
{
	int	level_mod = xp_util_level_ecl_modifier(GetSubRace(oPC));
	int level_effective = GetHitDice(oPC) + level_mod;
	
	return level_effective;
}


	


//		
//	RETURN MINIMUM XP OF CURRENT LEVEL
//
int	xp_level_min(object oPC, int nLevel)
{
	if (nLevel == 1) return 0;
	return xp_util_level_min(xp_level_ecl(oPC));
}
	


	
	

void xp_penalty_nolevelloss(object oPC, int nPenalty)
{
	int xp_min;
    int xp_new;

	xp_new = GetXP(oPC) - nPenalty;
	xp_min = xp_level_min(oPC, GetHitDice(oPC));
		
	//	YOU CAN NOT LOSE A LEVEL
    if (xp_new < xp_min) xp_new = xp_min;

    SetXP(oPC, xp_new);	
}
	



/*
*/