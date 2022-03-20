trigger DUPAcc on Account (before insert) 
{
    List<Account> Newaccountrecs = trigger.new;
    if(trigger.isInsert){
        if(trigger.isBefore){
            
            for(Account a:Newaccountrecs)
            {
                List<Account> tempc = [select NAME from Account where name=: a.name];
                    if(tempc.size()>0) 
                    {
                         a.addError('duplicate name can not allowed, please insert the other name which is Exist in system');
                      }
                   
            }
                           
        }
    }
}