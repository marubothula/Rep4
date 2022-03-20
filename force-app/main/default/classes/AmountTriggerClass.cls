Public Class AmountTriggerClass {

    
    Public static void AmountTriggerClass( list<Opportunity> ops ){
        
        Double TotalAmount = 0;
    
       for(Opportunity op :  [select AMOUNT from Opportunity where CreatedDate = TODAY]){
           
            TotalAmount = TotalAmount + op.AMOUNT;
               
       }
       
       
       for(Opportunity op1 :  ops ){
           
            TotalAmount = TotalAmount + op1.AMOUNT;
               
               if( TotalAmount > 20000000)
               
               op1 .addError ('your Target is Completed and Total List Opportuity Amount is Total Amount: ' + TotalAmount);
               
               }
   
  
    
    }

}