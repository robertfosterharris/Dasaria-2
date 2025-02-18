// on disturbed handler for bookshelf
// wired 11/29/2007
// ad-hoc faction event
void main()
{
	object oPC = GetLastDisturbed();
	ActionStartConversation(oPC, "wiredevent_book_removed",FALSE, FALSE, FALSE, FALSE);
}