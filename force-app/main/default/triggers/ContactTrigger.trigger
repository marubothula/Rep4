trigger ContactTrigger on Contact (after insert,after Update) 
{
	contact obj = new contact();
    string fname;
    string lname;
    String title;
    String email;
    id id1;
    
    contact obj2 = trigger.new[0];
       
    if(obj2.LastName!=null)
        {
            sendcontactToExternalSystem obj1 = new sendcontactToExternalSystem();
            							obj1.sendContact(obj2.FirstName, obj2.LastName, obj2.Title, obj2.Email,obj2.Id);
            
        }
}