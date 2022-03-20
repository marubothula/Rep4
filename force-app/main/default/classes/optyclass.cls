Public class optyclass{

@InvocableMethod    
    public static void optyclassMethod(){
   
        List<Opportunity> listopt = new List<Opportunity>();
        List<Account> listAcc= new List<Account>();

       
        for(integer i=3;i<5;i++){
            Opportunity opp = new Opportunity();
            Account acc= new Account();

           
                opp.name='SIMPLE'+i;
                opp.stageName='01 - Understand Customer';
                opp.closeDate= date.today()+1;
               
                listopt.add(opp);
                listAcc.add(acc);
                acc.name='INSIDEFOR'+i;

          }
     
         insert listopt;
         insert listAcc;


       
           }
}