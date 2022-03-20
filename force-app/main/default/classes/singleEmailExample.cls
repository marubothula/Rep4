Global class singleEmailExample
{
    webservice static string sendEmail(String OOPID, String name){
     
     try
     {
         
         Messaging.SingleEmailMessage emasale = new Messaging.SingleEmailMessage();
         
         String[] SendingTo = new String[]{'siva.eim@gmail.com'};
         
         emasale.setToAddresses(SendingTo);
         emasale.setSubject('Test Opty Record');
         emasale.setPlainTextBody ('Hello!!!!!!!!!!This is a test email to test single email message program'); 
         
         Messaging.sendEmail(new Messaging.SingleEmailMessage[] {emasale} );
         return 'Sucess';               
         
     } 
     
     catch(exception e){

         return 'Fail' ;

     }
         
     
     }
 }