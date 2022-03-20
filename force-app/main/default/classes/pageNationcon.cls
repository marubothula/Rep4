public class pageNationcon{
Integer totcount = 0;
Integer limitrows = 10;  // Per page 5 records
Integer offsetrows = 0;

// Default Constructer 
public pageNationcon(){
//returnt the total no of rercords that will return by SOQL 
   totcount = [select count() from Account limit: Limits.getLimitQueryRows()];
}
  
  public List<Account> getAccount() {
       return [select Name,AccountNumber,Site,Type from Account
       limit: limitrows offset: offsetrows];
  
  }
 public void first()
 {
     offsetrows = 0;
 }
 public void Previous()
 {
 
    offsetrows -= limitrows;
 }
 public void Next()
 {
   offsetrows += limitrows;
 }
 public void Last()
 {
 
 }
 public Boolean gethasprevious()
 {
 
     if(offsetrows == 0)
            return false;
         else
     return true;
 }
  public Boolean gethasNext()
 {
  if(offsetrows+limitrows >= totcount)
            return false;
         else
     return true;
 }
        

}