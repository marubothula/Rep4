/*
Last_updated : 20-03-2022
 */
public class AccountCreation{

    public static void insertAccount(String Accname)
     {

        Account u = new Account();
        u.name = Accname;
        insert u;
    }
}