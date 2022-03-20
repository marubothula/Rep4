public class FutureExample{
 
    public void FutureExample()
    {
        system.debug('DC');
    }
    
    @future
public static void call()
{
    system.debug('cal me one');
    system.debug('cal me two');
    system.debug('cal me three');
   
}
}