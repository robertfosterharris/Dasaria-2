/*A simple day/night light rotation script
This works pretty simply, follow these instructions:

1. Apply a string variable to your area called "Light_Tag".

2. Tag all of your placed lights the same as the variable + number.

EG:
Light_Tag = "citylight".
Placed lights should be tagged "citylight1", "citylight2" ... "citylight11", etc
-by atharin june 15 2009
*/

void Night(object oArea)
{
if (GetLocalInt(oArea, "LightsAreOn")) return;
SetLocalInt(oArea, "LightsAreOn", 1);
DeleteLocalInt(oArea, "LightsAreOff");
int nCounter = 1; string sLight = GetLocalString(oArea,"Light_Tag");
object oLight = GetObjectByTag(sLight+IntToString(nCounter));
while (GetIsObjectValid(oLight))
{
//SendMessageToPC(GetFirstPC(),"Lighting up "+GetTag(oLight));
SetLightActive(oLight, TRUE); 
nCounter++;
oLight = GetObjectByTag(sLight+IntToString(nCounter));
}
}

void Day(object oArea)
{
if (GetLocalInt(oArea, "LightsAreOff")) return;
SetLocalInt(oArea,"LightsAreOff",1);
DeleteLocalInt(oArea, "LightsAreOn");
int nCounter = 1; string sLight = GetLocalString(oArea,"Light_Tag");
object oLight = GetObjectByTag(sLight+IntToString(nCounter));
while (GetIsObjectValid(oLight))
{
//SendMessageToPC(GetFirstPC(),"Shutting down "+GetTag(oLight));
SetLightActive(oLight, FALSE); 
nCounter++;
oLight = GetObjectByTag(sLight+IntToString(nCounter));
}
}

void main()
{
object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

object oArea = GetArea(oPC);
int nHour = GetTimeHour();

if ((nHour >= 18) ||
(nHour < 6))
{ Night(oArea);  }

if ((nHour >= 6) &&
(nHour < 18))
{ 
Day(oArea); 
}

ExecuteScript("j4acs_ha_enter",oPC);

}