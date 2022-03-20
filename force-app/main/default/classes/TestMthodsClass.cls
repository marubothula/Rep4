Public Class TestMthodsClass {

      Public Void TestMthodsClass()
      {
         // DEFAULT Constructor
         // Given Void retrun type hence not required to retrun anything
      }
  
     Public String stringMthod()
     {
     
         return 'UNITED';
     }
     
     
     Public List<Opportunity> retunlist()
     {
     
         List<Opportunity> opp = new  List<Opportunity>();
         opp = [SELECT NAME FROM Opportunity where name like 'Test%'];
         return opp;
     }
  
  
  
}