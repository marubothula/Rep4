global class UpdateContactAddresses implements 
Database.Batchable<sObject>, Database.Stateful {
    global Integer AccNum;
    global updateContactAddresses(Integer q)
    {
        AccNum=q;
    }
    // instance member to retain state across transactions
    global Integer recordsProcessed = 0;
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('Select Id from Account where AccountNumber =' + AccNum);
    }
    global void execute(Database.BatchableContext bc, List<Account> scope){
        // process each batch of records
        List<Account> accounts = new List<Account>();
        for (account A : scope) {
            A.AccountNumber = '123455';
            accounts.add(A);
            // increment the instance member counter
            recordsProcessed = recordsProcessed + 1;
        }
        update accounts;
    }    
    global void finish(Database.BatchableContext bc){
        System.debug(recordsProcessed + ' records processed. Shazam!');
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors, 
                            JobItemsProcessed,
                            TotalJobItems, CreatedBy.Email
                            FROM AsyncApexJob
                            WHERE Id = :bc.getJobId()];
        // call some utility to send email
        //EmailUtils.sendMessage(job, recordsProcessed);
    }    
}