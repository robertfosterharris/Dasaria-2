void main()
{
object oCash = GetFirstItemInInventory(OBJECT_SELF);

if (oCash == OBJECT_INVALID )
{
DestroyObject(OBJECT_SELF,0.0,FALSE);
}



}