global class UpdateAccphon implements 
    Database.Batchable<sObject> {
    
    // instance member to retain state across transactions
    global Integer recordsProcessed = 0;
    global Database.QueryLocator start(Database.BatchableContext bc) {
           
          return Database.getQueryLocator('SELECT ID,AccountNumber FROM Account');          
       
    }
    global void execute(Database.BatchableContext bc, List<Account> scope){
        // process each batch of records
        List<Account> Al = new List<Account>();
        for (Account acc : scope) {
                acc.Phone= '8885137323';
                Al.add(acc);

            }
        update Al;
    }    
    global void finish(Database.BatchableContext bc){
        System.debug(recordsProcessed + ' records processed. Shazam!');
        

    }    
}