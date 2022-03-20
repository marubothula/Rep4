trigger test_acc_1 on Account (Before Insert, Before Update) {
        for (Account a : Trigger.New){
            if(Trigger.isInsert && a.AnnualRevenue < 5000)
            a.addError('AnnualRevenue should be greater than 5000');
            else if (Trigger.isUpdate && a.AnnualRevenue < 3000)
            a.addError('AnnualRevenue should be greater than 3000');
        }
        
 }