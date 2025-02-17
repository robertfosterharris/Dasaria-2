#include "i_utility"
// =================================================================
// Array
// 
// Provide simple array functions
// Array is stored as a series of local variables like this:
// DataType_ArrayName_Length => 3 (length of the array)
// DataType_ArrayName_0 => 123 (first element)
// DataType_ArrayName_1 => 456 (second element)
// DataType_ArrayName_2 => 789 (third element)
// Arrays of different data type but same name can coexist
// 
// By Nytir
// =================================================================
// Data Prefix/suffix
const string AYS_CYC = "CYC"; //Cycle Index
const string AYS_LEN = "LEN"; //Length
const string AYS_INT = "I_";  //Int
const string AYS_FLT = "F_";  //Float
const string AYS_STR = "S_";  //String
const string AYS_OBJ = "O_";  //Object
const string AYS_LOC = "L_";  //Location

const int AYI_CYC = -2; 
const int AYI_LEN = -1; 
// Data type
const int AYI_INT = 0;  //Int
const int AYI_FLT = 1;  //Float
const int AYI_STR = 2;  //String
const int AYI_OBJ = 3;  //Object
const int AYI_LOC = 4;  //Location
// =================================================================
// Prototypes
// =================================================================

// Common methods
string VarPrefix(int iType);
string VarName(string sName, int iType, int iN);

void ElementShift(object oObj, string sName, int iType, int iN, int iShf);
void ElementDelete(object oObj, string sName, int iType, int iN);
void ElementPrint(object oObj, string sName, int iType, int iN);

int ArrayCycle(object oObj, string sName, int iType);
int ArrayLengthGet(object oObj, string sName, int iType);
void ArrayLengthSet(object oObj, string sName, int iType, int iLen);
void ArrayLengthUpdate(object oObj, string sName, int iType, int iN);
void ArrayShift(object oObj, string sName, int iType, int iN, int iShf);
void ArrayDelete(object oObj, string sName, int iType);
void ArrayPrint(object oObj, string sName, int iType);
// Int Array
int IntArrayGet(object oObj, string sName, int iN);
int IntArrayRand(object oObj, string sName);
int IntArrayCycle(object oObj, string sName);
int IntArrayLen(object oObj, string sName);
int IntArrayFind(object oObj, string sName, int iValue);
void IntArraySet(object oObj, string sName, int iN, int iValue);
void IntArrayPush(object oObj, string sName, int iValue);
void IntArrayInsert(object oObj, string sName, int iN, int iValue);
void IntArrayRemove(object oObj, string sName, int iN);
void IntArrayDelete(object oObj, string sName);
void IntArrayPrint(object oObj, string sName);
// Float Array
float FloatArrayGet(object oObj, string sName, int iN);
float FloatArrayRand(object oObj, string sName);
float FloatArrayCycle(object oObj, string sName);
int FloatArrayLen(object oObj, string sName);
int FloatArrayFind(object oObj, string sName, float fValue);
void FloatArraySet(object oObj, string sName, int iN, float fValue);
void FloatArrayPush(object oObj, string sName, float fValue);
void FloatArrayInsert(object oObj, string sName, int iN, float fValue);
void FloatArrayRemove(object oObj, string sName, int iN);
void FloatArrayDelete(object oObj, string sName);
void FloatArrayPrint(object oObj, string sName);
// String Array
string StringArrayGet(object oObj, string sName, int iN);
string StringArrayRand(object oObj, string sName);
string StringArrayCycle(object oObj, string sName);
int StringArrayLen(object oObj, string sName);
int StringArrayFind(object oObj, string sName, string sValue);
void StringArraySet(object oObj, string sName, int iN, string sValue);
void StringArrayPush(object oObj, string sName, string sValue);
void StringArrayInsert(object oObj, string sName, int iN, string sValue);
void StringArrayRemove(object oObj, string sName, int iN);
void StringArrayDelete(object oObj, string sName);
void StringArrayPrint(object oObj, string sName);
// Object Array
object ObjectArrayGet(object oObj, string sName, int iN);
object ObjectArrayRand(object oObj, string sName);
object ObjectArrayCycle(object oObj, string sName);
int ObjectArrayLen(object oObj, string sName);
int ObjectArrayFind(object oObj, string sName, object oValue);
void ObjectArraySet(object oObj, string sName, int iN, object oValue);
void ObjectArrayPush(object oObj, string sName, object oValue);
void ObjectArrayInsert(object oObj, string sName, int iN, object oValue);
void ObjectArrayRemove(object oObj, string sName, int iN, int iDestroy=FALSE);
void ObjectArrayDelete(object oObj, string sName, int iDestroy=FALSE);
void ObjectArrayPrint(object oObj, string sName);
// Location Array
location LocationArrayGet(object oObj, string sName, int iN);
location LocationArrayRand(object oObj, string sName);
location LocationArrayCycle(object oObj, string sName);
int LocationArrayLen(object oObj, string sName);
int LocationArrayFind(object oObj, string sName, location lValue);
void LocationArraySet(object oObj, string sName, int iN, location lValue);
void LocationArrayPush(object oObj, string sName, location lValue);
void LocationArrayInsert(object oObj, string sName, int iN, location lValue);
void LocationArrayRemove(object oObj, string sName, int iN);
void LocationArrayDelete(object oObj, string sName);
void LocationArrayPrint(object oObj, string sName);
// =================================================================
// Common Methods
// =================================================================

// Get the preffix for a data type
string VarPrefix(int iType){
	switch(iType){
		case AYI_INT: return AYS_INT;
		case AYI_FLT: return AYS_FLT;
		case AYI_STR: return AYS_STR;
		case AYI_OBJ: return AYS_OBJ;
		case AYI_LOC: return AYS_LOC;
	}
	return "";
}
// Construct a Variable Name using the information provided
string VarName(string sName, int iType, int iN){
	string sVN = VarPrefix(iType) + sName;
	switch( iN ){
		// Meta Data
		case AYI_CYC: sVN += "_"+AYS_CYC; break; //cycle index
		case AYI_LEN: sVN += "_"+AYS_LEN; break; //length
		// Elements
		default: sVN += "_"+IntToString(iN); break; 
	}
	return sVN;
}
// -------------------------------------------------------

// Move the element in iN to iN + iShf
// Will overwrite the element in destination if exists
// oObj  : Target Object
// sName : Array Name
// iType : Data Type
// iN    : Index
// iShf  : Shift
void ElementShift(object oObj, string sName, int iType, int iN, int iShf){
	string sID1 = VarName(sName, iType, iN);
	string sID2 = VarName(sName, iType, iN+iShf);
	// Copy var in sID1 to sID2, then delete sID1
	switch(iType){
		case AYI_INT: 
			SetLocalInt(oObj, sID2, GetLocalInt(oObj, sID1));
			DeleteLocalInt(oObj, sID1);
			break;
		case AYI_FLT: 
			SetLocalFloat(oObj, sID2, GetLocalFloat(oObj, sID1));
			DeleteLocalFloat(oObj, sID1);
			break;
		case AYI_STR: 
			SetLocalString(oObj, sID2, GetLocalString(oObj, sID1));
			DeleteLocalString(oObj, sID1);
			break;
		case AYI_OBJ: 
			SetLocalObject(oObj, sID2, GetLocalObject(oObj, sID1));
			DeleteLocalObject(oObj, sID1);
			break;
		case AYI_LOC: 
			SetLocalLocation(oObj, sID2, GetLocalLocation(oObj, sID1));
			DeleteLocalLocation(oObj, sID1);
			break;
	}
}
// -------------------------------------------------------

// Delete the Nth element
// oObj  : Target Object
// sName : Array Name
// iType : Data Type
// iN    : Index
void ElementDelete(object oObj, string sName, int iType, int iN){
	string sID  = VarName(sName, iType, iN);
	if( iN < 0 ){
		// Delete Meta Data
		DeleteLocalInt(oObj, sID);
	}else{
		// Delete Elements
		switch(iType){
			case AYI_INT: DeleteLocalInt(oObj, sID); break;
			case AYI_FLT: DeleteLocalFloat(oObj, sID); break;
			case AYI_STR: DeleteLocalString(oObj, sID); break;
			case AYI_OBJ: DeleteLocalObject(oObj, sID); break;
			case AYI_LOC: DeleteLocalLocation(oObj, sID); break;
		}
	}
}
// -------------------------------------------------------

// Print the Nth element
// oObj  : Target Object
// sName : Array Name
// iType : Data Type
// iN    : Index
void ElementPrint(object oObj, string sName, int iType, int iN){
	string sID = VarName(sName, iType, iN);
	string sMS = sID+" => ";
	if( iN < 0 ){
		// Meta Data
		sMS += IntToString(GetLocalInt(oObj, sID));
	}else{
		// Elements
		switch(iType){
			case AYI_INT: sMS += IntToString(GetLocalInt(oObj, sID)); break;
			case AYI_FLT: sMS += FormatFloat(GetLocalFloat(oObj, sID)); break;
			case AYI_STR: sMS += GetLocalString(oObj, sID); break;
			case AYI_OBJ: sMS += GetTag(GetLocalObject(oObj, sID)); break;
			case AYI_LOC: sMS += FormatLocation(GetLocalLocation(oObj, sID)); break;
		}
	}
	SendMessageToPC(GetFirstPC(FALSE), sMS);
}
// -------------------------------------------------------

// Get the Array Length 
int ArrayLengthGet(object oObj, string sName, int iType){
	return GetLocalInt(oObj, VarName(sName, iType, AYI_LEN));
}
// Set the Array Length 
void ArrayLengthSet(object oObj, string sName, int iType, int iLen){
	SetLocalInt(oObj, VarName(sName, iType, AYI_LEN), iLen);
}
// Update the Array Length
// iN : the index of the element just added/changed
void ArrayLengthUpdate(object oObj, string sName, int iType, int iN){
	if( ArrayLengthGet(oObj, sName, iType) <= iN ){
		ArrayLengthSet(oObj, sName, iType, (iN+1));
	}
}
// -------------------------------------------------------

// Shifts the indexes of the array by iShf starting at N
// oObj   : Target Object
// sName  : Array Name
// iType  : Data Type
// iN     : Starting Index
// iShf : Shift
// 
// e.g. Array => 0:a, 1:b, 2:c, 3:d
// ArrayShift(oObj,sName,iType,0, 1) => 0: , 1:a, 2:b, 3:c, 4:d
// ArrayShift(oObj,sName,iType,0,-1) => 0:b, 1:c, 2:d
// ArrayShift(oObj,sName,iType,2, 1) => 0:a, 1:b, 2: , 3:c, 5:d
// ArrayShift(oObj,sName,iType,2,-1) => 0:a, 1:b, 2:d
void ArrayShift(object oObj, string sName, int iType, int iN, int iShf){
	int iS = iN;
	int iE = ArrayLengthGet(oObj, sName, iType);
	ArrayLengthSet(oObj, sName, iType, iE + iShf);
	if( iShf > 0 ){
		do{
			iE --;
			ElementShift(oObj, sName, iType, iE, iShf);
		}while( iS < iE );
	}
	if( iShf < 0 ){
		iS -= iShf;
		while( iS < iE ){
			ElementShift(oObj, sName, iType, iS, iShf);
			iS ++;
		}
	}
}
// -------------------------------------------------------

// Deletes the Array
void ArrayDelete(object oObj, string sName, int iType){
	int iN;
	int iL = ArrayLengthGet(oObj, sName, iType);
	for( iN = AYI_CYC; iN < iL; iN ++ ){
		ElementDelete(oObj, sName, iType, iN);
	}
}
// Prints the Array
void ArrayPrint(object oObj, string sName, int iType){
	int iN;
	int iL = ArrayLengthGet(oObj, sName, iType);
	for( iN = AYI_CYC; iN < iL; iN ++ ){
		ElementPrint(oObj, sName, iType, iN);
	}
}
// Get Cycle ID 
int ArrayCycle(object oObj, string sName, int iType){
	int iC = GetLocalInt(oObj, VarName(sName, iType, AYI_CYC));
	if( iC >= ArrayLengthGet(oObj, sName, iType) ){ iC = 0; }
	SetLocalInt(oObj, VarName(sName, iType, AYI_CYC), iC+1);
	return iC;
}
// =================================================================
// Int Array Methods
// =================================================================

// Get the Nth Element 
int IntArrayGet(object oObj, string sName, int iN){
	return GetLocalInt(oObj, VarName(sName, AYI_INT, iN));
}
// Get the length of Array
int IntArrayLen(object oObj, string sName){
	return ArrayLengthGet(oObj, sName, AYI_INT);
}
// Return a random Element
int IntArrayRand(object oObj, string sName){
	return IntArrayGet(oObj, sName, Random(IntArrayLen(oObj, sName)));
}
// Cycle the Array
int IntArrayCycle(object oObj, string sName){
	return IntArrayGet(oObj, sName, ArrayCycle(oObj, sName, AYI_INT));
}
// Find the first occurence of iValue, return -1 if not found
int IntArrayFind(object oObj, string sName, int iValue){
	int iN;
	int iL = IntArrayLen(oObj, sName);
	for( iN = 0; iN < iL; iN++ ){
		if( IntArrayGet(oObj, sName, iN) == iValue ){ return iN; }
	}
	return -1;
}
// Set value of the Nth Element, gaps are padded with null (undeclared)
void IntArraySet(object oObj, string sName, int iN, int iValue){
	ArrayLengthUpdate(oObj, sName, AYI_INT, iN);
	SetLocalInt(oObj, VarName(sName, AYI_INT, iN), iValue);
}
// Adds an element at the back of the Array
void IntArrayPush(object oObj, string sName, int iValue){
	IntArraySet(oObj, sName, ArrayLengthGet(oObj, sName, AYI_INT), iValue);
}
// Inserts an element at iN
void IntArrayInsert(object oObj, string sName, int iN, int iValue){
	ArrayShift(oObj, sName, AYI_INT, iN, 1);
	SetLocalInt(oObj, VarName(sName, AYI_INT, iN), iValue);
}
// Removes the element at iN
void IntArrayRemove(object oObj, string sName, int iN){
	ArrayShift(oObj, sName, AYI_INT, iN, -1);
}
// Deletes the whole Array
void IntArrayDelete(object oObj, string sName){
	ArrayDelete(oObj, sName, AYI_INT);
}
// Prints the Array
void IntArrayPrint(object oObj, string sName){
	ArrayPrint(oObj, sName, AYI_INT);
}
// =================================================================
// Float Array Methods
// =================================================================

// Get the Nth Element 
float FloatArrayGet(object oObj, string sName, int iN){
	return GetLocalFloat(oObj, VarName(sName, AYI_FLT, iN));
}
// Get the length of Array
int FloatArrayLen(object oObj, string sName){
	return ArrayLengthGet(oObj, sName, AYI_FLT);
}
// Return a random Element
float FloatArrayRand(object oObj, string sName){
	return FloatArrayGet(oObj, sName, Random(FloatArrayLen(oObj, sName)));
}
// Cycle the Array
float FloatArrayCycle(object oObj, string sName){
	return FloatArrayGet(oObj, sName, ArrayCycle(oObj, sName, AYI_FLT));
}
// Find the first occurence of iValue, return -1 if not found
int FloatArrayFind(object oObj, string sName, float fValue){
	int iN;
	int iL = FloatArrayLen(oObj, sName);
	for( iN = 0; iN < iL; iN++ ){
		if( FloatArrayGet(oObj, sName, iN) == fValue ){ return iN; }
	}
	return -1;
}
// Set value of the Nth Element, gaps are padded with null (undeclared)
void FloatArraySet(object oObj, string sName, int iN, float fValue){
	ArrayLengthUpdate(oObj, sName, AYI_FLT, iN);
	SetLocalFloat(oObj, VarName(sName, AYI_FLT, iN), fValue);
}
// Adds an element at the back of the Array
void FloatArrayPush(object oObj, string sName, float fValue){
	FloatArraySet(oObj, sName, ArrayLengthGet(oObj, sName, AYI_FLT), fValue);
}
// Inserts an element at iN
void FloatArrayInsert(object oObj, string sName, int iN, float fValue){
	ArrayShift(oObj, sName, AYI_FLT, iN, 1);
	SetLocalFloat(oObj, VarName(sName, AYI_FLT, iN), fValue);
}
// Removes the element at iN
void FloatArrayRemove(object oObj, string sName, int iN){
	ArrayShift(oObj, sName, AYI_FLT, iN, -1);
}
// Deletes the whole Array
void FloatArrayDelete(object oObj, string sName){
	ArrayDelete(oObj, sName, AYI_FLT);
}
// Prints the Array
void FloatArrayPrint(object oObj, string sName){
	ArrayPrint(oObj, sName, AYI_FLT);
}
// =================================================================
// String Array Methods
// =================================================================

// Get the Nth Element 
string StringArrayGet(object oObj, string sName, int iN){
	return GetLocalString(oObj, VarName(sName, AYI_STR, iN));
}
// Get the length of Array
int StringArrayLen(object oObj, string sName){
	return ArrayLengthGet(oObj, sName, AYI_STR);
}
// Return a random Element
string StringArrayRand(object oObj, string sName){
	return StringArrayGet(oObj, sName, Random(StringArrayLen(oObj, sName)));
}
// Cycle the Array
string StringArrayCycle(object oObj, string sName){
	return StringArrayGet(oObj, sName, ArrayCycle(oObj, sName, AYI_STR));
}
// Find the first occurence of sValue, return -1 if not found
int StringArrayFind(object oObj, string sName, string sValue){
	int iN;
	int iL = StringArrayLen(oObj, sName);
	for( iN = 0; iN < iL; iN++ ){
		if( StringArrayGet(oObj, sName, iN) == sValue ){ return iN; }
	}
	return -1;
}
// Set value of the Nth Element, gaps are padded with null (undeclared)
void StringArraySet(object oObj, string sName, int iN, string sValue){
	ArrayLengthUpdate(oObj, sName, AYI_STR, iN);
	SetLocalString(oObj, VarName(sName, AYI_STR, iN), sValue);
}
// Adds an element at the back of the Array
void StringArrayPush(object oObj, string sName, string sValue){
	StringArraySet(oObj, sName, ArrayLengthGet(oObj, sName, AYI_STR), sValue);
}
// Inserts an element at iN
void StringArrayInsert(object oObj, string sName, int iN, string sValue){
	ArrayShift(oObj, sName, AYI_STR, iN, 1);
	SetLocalString(oObj, VarName(sName, AYI_STR, iN), sValue);
}
// Removes the element at iN
void StringArrayRemove(object oObj, string sName, int iN){
	ArrayShift(oObj, sName, AYI_STR, iN, -1);
}
// Deletes the whole Array
void StringArrayDelete(object oObj, string sName){
	ArrayDelete(oObj, sName, AYI_STR);
}
// Prints the Array
void StringArrayPrint(object oObj, string sName){
	ArrayPrint(oObj, sName, AYI_STR);
}
// =================================================================
// Object Array Methods
// =================================================================

// Get the Nth Element 
object ObjectArrayGet(object oObj, string sName, int iN){
	return GetLocalObject(oObj, VarName(sName, AYI_OBJ, iN));
}
// Get the length of Array
int ObjectArrayLen(object oObj, string sName){
	return ArrayLengthGet(oObj, sName, AYI_OBJ);
}
// Return a random Element
object ObjectArrayRand(object oObj, string sName){
	return ObjectArrayGet(oObj, sName, Random(ObjectArrayLen(oObj, sName)));
}
// Cycle the Array
object ObjectArrayCycle(object oObj, string sName){
	return ObjectArrayGet(oObj, sName, ArrayCycle(oObj, sName, AYI_OBJ));
}
// Find the first occurence of oValue, return -1 if not found
int ObjectArrayFind(object oObj, string sName, object oValue){
	int iN;	
	int iL = ObjectArrayLen(oObj, sName);
	for( iN = 0; iN < iL; iN++ ){
		if( ObjectArrayGet(oObj, sName, iN) == oValue ){ return iN; }
	}
	return -1;
}
// Set value of the Nth Element, gaps are padded with null (undeclared)
void ObjectArraySet(object oObj, string sName, int iN, object oValue){
	ArrayLengthUpdate(oObj, sName, AYI_OBJ, iN);
	SetLocalObject(oObj, VarName(sName, AYI_OBJ, iN), oValue);
}
// Adds an element at the back of the Array
void ObjectArrayPush(object oObj, string sName, object oValue){
	ObjectArraySet(oObj, sName, ArrayLengthGet(oObj, sName, AYI_OBJ), oValue);
}
// Inserts an element at iN
void ObjectArrayInsert(object oObj, string sName, int iN, object oValue){
	ArrayShift(oObj, sName, AYI_OBJ, iN, 1);
	SetLocalObject(oObj, VarName(sName, AYI_OBJ, iN), oValue);
}
// Removes the element at iN
// Destroy the Object the element is pointing to if iDestroy
void ObjectArrayRemove(object oObj, string sName, int iN, int iDestroy=FALSE){
	if( iDestroy ){
		object oTrg = ObjectArrayGet(oObj, sName, iN);
		MyDebug("Destroy "+GetTag(oTrg));
		DestroyObject(oTrg);
	}
	ArrayShift(oObj, sName, AYI_OBJ, iN, -1);
}
// Deletes the whole Array
// Destroy the Objects the elements are pointing to if iDestroy
void ObjectArrayDelete(object oObj, string sName, int iDestroy=FALSE){
	if( iDestroy ){
		int iN;
		int iL = ObjectArrayLen(oObj, sName);
		for( iN = 0; iN < iL; iN++ ){
			object oTrg = ObjectArrayGet(oObj, sName, iN);
			MyDebug("Destroy "+GetTag(oTrg));
			DestroyObject(oTrg);
		}
	}
	ArrayDelete(oObj, sName, AYI_OBJ);
}
// Prints the Array
void ObjectArrayPrint(object oObj, string sName){
	ArrayPrint(oObj, sName, AYI_OBJ);
}
// =================================================================
// Location Array Methods
// =================================================================

// Get the Nth Element 
location LocationArrayGet(object oObj, string sName, int iN){
	return GetLocalLocation(oObj, VarName(sName, AYI_LOC, iN));
}
// Get the length of Array
int LocationArrayLen(object oObj, string sName){
	return ArrayLengthGet(oObj, sName, AYI_LOC);
}
// Return a random Element
location LocationArrayRand(object oObj, string sName){
	return LocationArrayGet(oObj, sName, Random(LocationArrayLen(oObj, sName)));
}
// Cycle the Array
location LocationArrayCycle(object oObj, string sName){
	return LocationArrayGet(oObj, sName, ArrayCycle(oObj, sName, AYI_LOC));
}
// Find the first occurence of lValue, return -1 if not found
int LocationArrayFind(object oObj, string sName, location lValue){
	int iN;	
	int iL = LocationArrayLen(oObj, sName);
	for( iN = 0; iN < iL; iN++ ){
		if( LocationArrayGet(oObj, sName, iN) == lValue ){ return iN; }
	}
	return -1;
}
// Set value of the Nth Element, gaps are padded with null (undeclared)
void LocationArraySet(object oObj, string sName, int iN, location lValue){
	ArrayLengthUpdate(oObj, sName, AYI_LOC, iN);
	SetLocalLocation(oObj, VarName(sName, AYI_LOC, iN), lValue);
}
// Adds an element at the back of the Array
void LocationArrayPush(object oObj, string sName, location lValue){
	LocationArraySet(oObj, sName, ArrayLengthGet(oObj, sName, AYI_LOC), lValue);
}
// Inserts an element at iN
void LocationArrayInsert(object oObj, string sName, int iN, location lValue){
	ArrayShift(oObj, sName, AYI_LOC, iN, 1);
	SetLocalLocation(oObj, VarName(sName, AYI_LOC, iN), lValue);
}
// Removes the element at iN
void LocationArrayRemove(object oObj, string sName, int iN){
	ArrayShift(oObj, sName, AYI_LOC, iN, -1);
}
// Deletes the whole Array
void LocationArrayDelete(object oObj, string sName){
	ArrayDelete(oObj, sName, AYI_LOC);
}
// Prints the Array
void LocationArrayPrint(object oObj, string sName){
	ArrayPrint(oObj, sName, AYI_LOC);
}