/*
*/


#include "std_persist_i0"



void	std_death_mark_give( object oPC );
void	std_death_mark_remove( object oPC );
int 	std_death_mark_check( object oPC );


string	std_death_find_root(object oJournal);

/*
*/



string	std_death_find_root(object oJournal)
	{
	string key = tree_child_use( oJournal, "std", "death");
	return key;
	}

	
	

void	std_death_mark_give( object oPC )
	{
	object oJournal = std_journal_get( oPC );
	string kDeathNode = std_death_find_root( oJournal );

	tree_leaf_setint( oJournal, kDeathNode, "mark", 1 );	
	}

	
	

	

	
int 	std_death_mark_check( object oPC )
	{
	object oJournal = std_journal_get( oPC );
	string kDeathNode = std_death_find_root( oJournal );

	int mark = tree_leaf_getint( oJournal, kDeathNode, "mark" );
	
	if ( mark == 1)
		return TRUE;
		
	return FALSE;
	}
	
	

	
	
	
void	std_death_mark_remove( object oPC )
	{
	object oJournal = std_journal_get( oPC );
	string kDeathNode = std_death_find_root( oJournal );
	
	tree_leaf_setint( oJournal, kDeathNode, "mark", 0 );
	}



/*
*/