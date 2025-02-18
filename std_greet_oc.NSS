//:://////////////////////////////////////////////
//:: Created By: Wyvern
//:: Created On: July 29th, 2005
//
// Usage:
// On the NPC, define string variables named thus - std_greet_x, where x is
// a number starting from 1, and incrementing with each additional variable added.
// The value of each of these variables is one of the possible dialogue strings
// that you wish your NPC to say.
// This script willl pick one of the random lines of text entered on one of the
// std_greet_x variables and the npc will speak it to the PC.

//::////////////////////////////s//////////////////
void main()
{
    int i = 1; // one not zero
    int messageCount = 0;

    string messageKey = "std_greet_" + IntToString(i);
    string message = GetLocalString(OBJECT_SELF, messageKey);
    while (message != "")
    {
        messageCount++;
        i++;
        messageKey = "std_greet_" + IntToString(i);
        message = GetLocalString(OBJECT_SELF, messageKey);
    }

    messageKey = "std_greet_" + IntToString(Random(messageCount) + 1);
    message = GetLocalString(OBJECT_SELF, messageKey);
    object oPC = GetLastSpeaker();

    if (GetIsPC(oPC))
    {
        AssignCommand(OBJECT_SELF, SpeakString(message, TALKVOLUME_TALK));
    }
}