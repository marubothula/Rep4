public class rectangle{

    Decimal lenght;
    Decimal width;
    
    public Decimal rectangle()
    {
        lenght= 0;
        width = 0;
        
        return lenght * width;
        
    }
    
     public Decimal area()
    {
        lenght= 2;
        width = 4;
        
        return lenght * width;
        
    }
    
    public void result ()
    {
        system.debug(' @lenght'+ lenght);
        system.debug(' @width '+ width);
    }
}