void main()
{
object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

if (!GetLocalInt(oPC,"CarcQuestCompletedSuccess")) return;
if (GetLocalInt(oPC,"CarcQuestCompleteSet")) return;

SetLocalInt(oPC,"CarcQuestCompleteSet",1);


object oDwarf = GetObjectByTag("carc_drewal_orcsbane");
SetLocalInt(oDwarf,"CarcQuestCompleted",1);


AssignCommand(oDwarf,
ActionStartConversation(oPC,"carc_finale",0,0,0,0));

}
