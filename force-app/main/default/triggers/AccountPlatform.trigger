trigger AccountPlatform on Account (After Update) {
   
    if(Trigger.isAfter && Trigger.isUpdate)
    {
        List<Account_platform_event__e> PEList = new List<Account_platform_event__e>();
		for(Account a: Trigger.new)
        {
            Account_platform_event__e AP =new Account_platform_event__e();
            	
            AP.Account_Name__c = a.name;
            
            PEList.add(AP);
        }
        if(PEList.size()>0)
        {
            EventBus.publish(PEList);
        }
    }

}