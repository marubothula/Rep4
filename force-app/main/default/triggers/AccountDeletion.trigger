trigger AccountDeletion on Account (before delete)
   {
    //this is edited in VSD
        for(Account a : [SELECT Id from Account 
                         where id in (select Accountid from Opportunity) 
                         AND ID IN :trigger.old])
                {
                   Trigger.oldmap.get(a.id).addError('Cannot delete account with related opportunities.');
                }
    }