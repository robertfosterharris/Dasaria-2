//Recall Stone
//Target Ground: Set Location
//Target Self: Teleport Self
//Ath
void main()
{
object oPC = GetItemActivator();
object oItem = GetItemActivated();
vector vPC = GetPositionFromLocation(GetLocation(oPC));
vector vTarget = GetPositionFromLocation(GetItemActivatedTargetLocation());
if (vPC == vTarget)
    {
        int i = GetLocalInt(oPC, "RECALL_FLAG");
        if (i)
        {
            location loc = GetLocalLocation(oPC, "RECALL_LOC");

            effect eTeleport = EffectNWN2SpecialEffectFile("fx_teleport");
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eTeleport, GetLocation(oPC));
            AssignCommand(oPC, JumpToLocation(loc));
			ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eTeleport, loc);
			
			//Is this a one use item?
			if (GetLocalInt(oItem,"Destructible"))
			{ DestroyObject(oItem); }
        }
        else
        {
            SendMessageToPC(oPC, "You must not be using this correctly...");
        }
    }
    else
    {
        SetLocalInt(oPC, "RECALL_FLAG", 1);
        SetLocalLocation(oPC, "RECALL_LOC", GetItemActivatedTargetLocation());
        SendMessageToPC(oPC, "The stone emits a brief glow.");
    }
}