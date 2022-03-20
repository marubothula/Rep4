trigger prod_sample on Pharma_Product__c (After Update) 
{

    List<Sample__c > pslist = new List<Sample__c >();
               
                    Sample__c psobj = new Sample__c();
                    
       for(Pharma_Product__c pp : trigger.new )
       {
           if((Trigger.oldMap.get(pp.Id).Product_Type__c != pp.Product_Type__c) && pp.Product_Type__c == 'Sample')
                       
               {
               psobj.Pharma_Product__c = pp.id;
               psobj.Quantity__c = 10;   
               pslist.add(psobj); 
               } 
               
                   
       }
   
        Insert pslist;
}