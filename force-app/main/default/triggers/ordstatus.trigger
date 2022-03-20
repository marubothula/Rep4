trigger ordstatus on Order__c (after update) {

//when the order status set Complete create order line item

list<OrderLine_Item__c> invstart = new list<OrderLine_Item__c>();

    for(Order__c ord:trigger.new)
    {
        if(ord.Status__c == 'Complete')
           {
               OrderLine_Item__c cre = new OrderLine_Item__c();
               cre.Order__c=ord.id;
               cre.MobileNumber__c ='9494949494';

               invstart.add(cre);
           }
    }
    insert invstart;

}