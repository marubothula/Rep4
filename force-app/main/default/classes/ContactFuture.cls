public class ContactFuture {
	@future
    Public static void ContactCreate(String Accjson){
        List<Account> AccList = (List<Account>) JSON.deserialize(Accjson, List<Account>.Class);
        	List<Contact> conlist = new List<Contact>();
        
                for(Account acc : AccList){
            Contact con = new Contact(LastName = acc.Name + '-Con');
                    conlist.add(con);
                   }
        		insert conlist;
        
    }
}