Public Class PraListclass {

   Public static Integer i = 0;
   
  
    
    Public static void listuse (){
     i++;
    
    //Approch - 1
    List<string> samList = new list<string>();
    samList.add('siva');
    samList.add('raja');
    samList.add('Vijay');
    
    system.debug('Items in List :' +samList+ 'with size' +samList.size());

    //Approch - 2
    List<string> samList2 = new list<string>{'siva','raja','Vijay'};
    system.debug('Items in List :' +samList2 + 'with size' +samList2.size());
    
    //Approch - 3
    List<string> samList3 = samList2.clone();
    system.debug('List3 :' + samList3);
    
        //Approch - 4
  Integer[] ArrayList = new Integer[4];
  
  ArrayList[0] = 100;
    ArrayList[1] = 200;
     ArrayList[2] = 300;
    ArrayList[3] = 400;
   system.debug('NuMBER OF Array :' +ArrayList);
   
   
   // SOSL , TYPING 
   
List<List<SObject>> lstoflst = [FIND 'ABC' IN ALL FIELDS 
                                    RETURNING Account(Name), Contact(FirstName,LastName)];
      
      //typeing 
      List<Account> acclist = (List<Account>)lstoflst[0];
      List<Contact> Conlist = (List<Contact>)lstoflst[1];
      
       system.debug('Before List Of Account' +lstoflst );

      
      system.debug('Typing List Of Account' +acclist);
      system.debug('Typing List Of Account' +Conlist);
                               
      //ENUM
      
   
   }
  }