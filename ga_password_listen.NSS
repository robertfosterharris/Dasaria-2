// ga_password_listen
void main(string sPassword)
{    
    SetListening(OBJECT_SELF, TRUE);
    SetListenPattern(OBJECT_SELF, sPassword, 2222);
}