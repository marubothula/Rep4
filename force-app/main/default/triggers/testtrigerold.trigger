trigger testtrigerold on Account (before update) {
   for(account a:trigger.old)
   {
    system.debug('old name is'+A.name);
   }
    //code 
	for(account a:trigger.new)
    {
    system.debug('old name is'+A.name);        
    }
    

}