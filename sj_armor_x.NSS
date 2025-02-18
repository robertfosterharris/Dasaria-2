// -----------------------------------------------------------------------------
//  sj_armor_x
// -----------------------------------------------------------------------------
/*
    Temporary library for Sunjammer's Armor Functions Library

    This file containing functions which form part of the SJ Framework's Core
    library. This file can be removed and any references to sj_armor_x replaced
    with a reference to sj_core_i if/when the SJ Framework is installed.
*/
// -----------------------------------------------------------------------------
/*
    Version 0.00 - 18 Mar 06 - Sumjammer
    - created
*/
// -----------------------------------------------------------------------------

// -----------------------------------------------------------------------------
//  PROTOTYPES
// -----------------------------------------------------------------------------

// Gets a value from a 2DA file on the server and returns it as an int.
// NOTE: avoid using this function in loops.
//  - s2DA:             name of 2da file, 16 chars max
//  - sColumn:          name of column in 2da file
//  - nRow:             index of row in 2da file
//  * OnError:          returns 0 if file, row, or column not found
int Get2DAInt(string s2DA, string sColumn, int nRow);


// -----------------------------------------------------------------------------
//  FUNCTIONS
// -----------------------------------------------------------------------------

int Get2DAInt(string s2DA, string sColumn, int nRow)
{
    return StringToInt(Get2DAString(s2DA, sColumn, nRow));
}