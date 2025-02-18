/*

    Functions for data structures:
        Trees, lists, and hashes

	Copyright 2003-2006, Jay Ring <games@transcendent.us>	
		
*/

// List Functions
int     tree_child_count    ( object o, string parent               );
string  tree_child_get      ( object o, string parent, int child    );  //get child by number
string  tree_child_find     ( object o, string parent, string name  ); // get child by name or return failure
string  tree_child_use      ( object o, string parent, string name  ); // get child by name or return new node (with type == name)
string  tree_child_add      ( object o, string parent, string type, string name=""  );
string  tree_child_clone    ( object o, string parent, object oSrc, string kSrc);

int     tree_node_valid     ( object o, string node                 );
string  tree_node_type      ( object o, string node                 );
string  tree_node_name      ( object o, string node                 );
string  tree_node_parent    ( object o, string node                 );

void    tree_node_rehash    ( object o, string node                 );
void    tree_node_delete    ( object o, string node                 );

// Get a node's !v value
void    tree_node_setint    ( object o, string node, int value);
void    tree_node_setfloat  ( object o, string node, float value);
void    tree_node_setstring ( object o, string node, string value);
void    tree_node_setobject ( object o, string node, object value);
int     tree_node_getint    ( object o, string node);
float   tree_node_getfloat  ( object o, string node);
string  tree_node_getstring ( object o, string node);
object  tree_node_getobject ( object o, string node);


// For convience, you can scan for children by name
void    tree_leaf_setint    ( object o, string node, string name, int data);
void    tree_leaf_setfloat  ( object o, string node, string name, float data);
void    tree_leaf_setstring ( object o, string node, string name, string data);
void    tree_leaf_setobject ( object o, string node, string name, object data);
int     tree_leaf_getint    ( object o, string node, string name);
float   tree_leaf_getfloat  ( object o, string node, string name);
string  tree_leaf_getstring ( object o, string node, string name);
object  tree_leaf_getobject ( object o, string node, string name);


/*

Inportant Note:
	The indexes and counts are not zero based, they are 1 based.
	This is counter-intuitive to most of us programmers and 
	right-thinking people everywhere.  Sorry.
	
	Use the following:
    	for( iChild=1; iChild <= count; iChild++)
		
	Is there a good reason for this?  Sort of, not really.

Important Note:
    Whan a node deletes itself, it does not update it's parent's or siblings.

    This means that the keys to various nodes are always valid.  We don't
    compact things because we don't know who is pointing to us.  Adding a
    child will fill in the empty spaces.

    The consequence of this is that you can't just iterate over the
    children and expect them to all be valid. 
	
	

    When deleting a node, it will delete it's hash from it's parent.
    If there are other nodes with the same name (Bad idea), and you want
    them to be found, you need to rehash the parent.  Better yet,
    don't let two nodes have the same name - it is counter to the design.

    If you need a sublist with many nodes which would all have the same name,
    it is better to access them by number and interpret them based on their
    type.

    A leaf is nothing more than a child with no children.  For convience
    you can store leaves directly under their parent in one function call.


Important note:
	It is up to YOU to make sure no inbound pointers to deleted objects!

	
	
----------------------------------------------------------	
Implementaion notes follow




Tree Functions

    Varaibles like this
        prefix!p            node's parent
        prefix!t            node's type
        prefix!c            node's child count

        prefix_1            first child
        prefix_1_1          1st 1st grandchild
        prefix_2            second child

    Unimplemented variables
        prefix!n            child name
        prefix#key1         hash for key1, points to a child with name="key1"
        prefix#key2         hash for key2, etc



    Each node has a type, a string of arbitrary length.  Use as you will, but
    do not leave it empty.  We use an empty type field to detect a empty slots
    in the list.

    Each node has a number of children.  Each node stores the names of
    all it's children in a hash.  Names can be searched for quickly using
    these hashes.

    Each node also has "!" variables.  Predefined types know how to delete
    their "!" variables.  All of  thepredefined {"int", "float", "string"}
    use the a value variable "!v" like this:
        key+"!v" - value

    When you call delete on a unknown node, it will delete all the leaves and
    children. Don't leave any stray variables on custom defined nodes.

*/



int     tree_child_count( object o, string parent )
    {
    return GetLocalInt( o, parent+"!c");
    }




string  tree_child_get( object o, string  parent, int child )
{
  return parent + "_" + IntToString(child);
}




string  tree_child_add      ( object o, string parent, string type, string name="" )
    {
    string key;

    // Find 1st invalid slot
    int child = 1;
    key = parent + "_1";
    while ( GetLocalString(o, key+"!t") != "" )
        {
        child++;
        key = parent + "_" + IntToString(child);
        }

    // Update the parent's count if necessary
    int parent_count = tree_child_count(o, parent);
    if (child > parent_count)
        SetLocalInt(o, parent+"!c", child);

    // Give the child a type and assign it's parent
    SetLocalString( o, key+"!t", type);
    SetLocalString( o, key+"!p", parent);

    if (name != "")
        {
        SetLocalString( o, key+"!n", name);
        SetLocalString( o, parent+"#"+name, key);
        }

    // Uncomment this line to make the dm_dumplocals more readable
    // Comment this line to make the tree smaller and faster on the leaves
    //SetLocalInt( o, key+"!c", 0);

    return key;
    }



string  tree_child_find     ( object o, string parent, string name  )
    {
    return GetLocalString( o, parent+"#"+name);
    }

string  tree_child_use      ( object o, string parent, string name  )
    {
    string kChild = tree_child_find( o, parent, name);

    // if the child exists return it
    if ( tree_node_valid( o, kChild) )
        return kChild;

    // otherwise create a new one and return that
    return tree_child_add( o, parent, name, name);
    }

string  tree_node_type( object o, string node )
{
  return GetLocalString(o, node+"!t");
}

string  tree_node_name      ( object o, string node                )
    {
    return GetLocalString(o, node+"!n");
    }

int     tree_node_valid( object o, string node )
    {
    if ( GetLocalString(o, node+"!t") == "" )
        return FALSE;

      return TRUE;
    }

string  tree_node_parent    ( object o, string node                )
    {
    return GetLocalString( o, node+"!p" );
    }


void    tree_node_setint    ( object o, string node, int value)
{
    SetLocalInt(o, node+"!v", value);
}

void    tree_node_setfloat  ( object o, string node, float value)
{
    SetLocalFloat(o, node+"!v", value);
}

void    tree_node_setstring ( object o, string node, string value)
{
    SetLocalString(o, node+"!v", value);
}

void    tree_node_setobject ( object o, string node, object value)
    {
    SetLocalObject(o, node+"!v", value);
    }


int     tree_node_getint    ( object o, string node)
{
    return GetLocalInt(o, node+"!v");
}

float   tree_node_getfloat  ( object o, string node)
{
    return GetLocalFloat(o, node+"!v");
}

string  tree_node_getstring ( object o, string node)
{
    return GetLocalString(o, node+"!v");
}

object  tree_node_getobject ( object o, string node)
    {
    return GetLocalObject(o, node+"!v");
    }





void    tree_leaf_setint    ( object o, string node, string name, int value)
    {
    string leaf = tree_child_find ( o, node, name);
    if (leaf == "")
        leaf = tree_child_add( o, node, "int", name);
    SetLocalInt(o, leaf+"!v", value);
    }

void    tree_leaf_setfloat  ( object o, string node, string name, float value)
    {
    string leaf = tree_child_find ( o, node, name);
    if (leaf == "")
        leaf = tree_child_add( o, node, "float", name);

    SetLocalFloat(o, leaf+"!v", value);
    }

void    tree_leaf_setstring ( object o, string node, string name, string value)
    {
    string leaf = tree_child_find ( o, node, name);
    if (leaf == "")
        leaf = tree_child_add( o, node, "string", name);

    SetLocalString(o, leaf+"!v", value);
    }

void    tree_leaf_setobject ( object o, string node, string name, object value)
    {
    string leaf = tree_child_find ( o, node, name);
    if (leaf == "")
        leaf = tree_child_add( o, node, "object", name);

    SetLocalObject(o, leaf+"!v", value);
    }

int tree_leaf_getint    ( object o, string node, string name)
    {
    string leaf = tree_child_find ( o, node, name);
    return GetLocalInt(o, leaf+"!v");
    }


float tree_leaf_getfloat    ( object o, string node, string name)
    {
    string leaf = tree_child_find ( o, node, name);
    return GetLocalFloat(o, leaf+"!v");

    }

string tree_leaf_getstring   ( object o, string node, string name)
    {
    string leaf = tree_child_find ( o, node, name);
    return GetLocalString(o, leaf+"!v");
    }

object  tree_leaf_getobject ( object o, string node, string name)
    {
    string leaf = tree_child_find ( o, node, name);
    return GetLocalObject(o, leaf+"!v");
    }

void    tree_node_rehash    ( object o, string node                 )
    {
    int count = tree_child_count( o, node);

    int     iChild;
    string  kChild;
    string  name;

    // Delete the hashes
    for( iChild=1; iChild <= count; iChild++)
        {
        kChild = tree_child_get ( o, node, iChild);
        name = GetLocalString( o, kChild+"!n" );
        DeleteLocalString(o, node+"#"+name);
        }

    // Create all new hashes
    for( iChild=1; iChild <= count; iChild++)
        {
        kChild = tree_child_get ( o, node, iChild);
        name = GetLocalString( o, kChild+"!n" );
        SetLocalString(o, node+"#"+name, kChild);
        }
    }

void    tree_node_delete    ( object o, string node)
    {

    // Iterator variables
    int     count       = tree_child_count    ( o, node );
    int     iChild;
    string  kChild;
    string  name;


    // Delete my hash from my parent
    name = GetLocalString( o, node+"!n" );
    string kParent = GetLocalString( o, node+"!p" );
    DeleteLocalString(o, kParent+"#"+name);

    // Delete my childrens hashes
    for( iChild=1; iChild <= count; iChild++)
        {
        kChild = tree_child_get ( o, node, iChild);
        name = GetLocalString( o, kChild+"!n" );
        DeleteLocalString(o, node+"#"+name);
        }

    // Recursivly delete all the children
    for( iChild=1; iChild <= count; iChild++)
        {
        kChild = tree_child_get ( o, node, iChild);

        if ( tree_node_valid(o, kChild) )
            tree_node_delete(o, kChild);
        }

    // Once all the children are deleted, delete myself
    DeleteLocalInt(o, node+"!c");
    DeleteLocalString(o, node+"!p");
    DeleteLocalString(o, node+"!t");
    DeleteLocalString(o, node+"!n");

    // Faster to delete them all than to do type checking
    DeleteLocalInt(o, node+"!v");
    DeleteLocalFloat(o, node+"!v");
    DeleteLocalString(o, node+"!v");
    DeleteLocalObject(o, node+"!v");


    // Done at last
    return;
    }


string  tree_child_clone    ( object o, string parent, object oSrc, string kSrc)
    {
    // Start with a sanity check to avoid screwing up royally
    if ( !tree_node_valid(oSrc, kSrc) )
        return "";

    // Add a child with the same name and type
    string type = tree_node_type( oSrc, kSrc);
    string name = tree_node_name( oSrc, kSrc);
    string dst_child = tree_child_add( o, parent, type, name);


    // if node is a leaf, copy it over and return
    if ( type == "int" )
        {
        string name = tree_node_name( oSrc, kSrc);
        int value = tree_node_getint( oSrc, kSrc);
        tree_node_setint( o, dst_child, value);
        return dst_child;
        }

    // if node is a leaf, copy it over and return
    if ( type == "float" )
        {
        string name = tree_node_name( oSrc, kSrc);
        float value = tree_node_getfloat( oSrc, kSrc);
        tree_node_setfloat( o, dst_child, value);
        return dst_child;
        }

    // if node is a leaf, copy it over and return
    if ( type == "string" )
        {
        string name = tree_node_name( oSrc, kSrc);
        string value = tree_node_getstring( oSrc, kSrc);
        tree_node_setstring( o, dst_child, value);
        return dst_child;
        }

    // if node is a leaf, copy it over and return
    if ( type == "object" )
        {
        string name = tree_node_name( oSrc, kSrc);
        object value = tree_node_getobject( oSrc, kSrc);
        tree_node_setobject( o, dst_child, value);
        return dst_child;
        }



    // Composite type
    int     count       = tree_child_count    ( oSrc, kSrc );
    int     iChild;
    string  kChild;

    // Recursivly copy all the children
    for( iChild=1; iChild <= count; iChild++)
        {
        kChild = tree_child_get ( oSrc, kSrc, iChild);
        if ( tree_node_valid(oSrc, kChild) )
            {
            tree_child_clone    ( o, dst_child, oSrc, kChild);
            }
        }

    // Done at last
    return dst_child;
    }


/*
    End of file
*/