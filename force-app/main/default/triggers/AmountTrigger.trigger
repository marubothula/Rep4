trigger AmountTrigger on Opportunity (Before Insert ) {
    AmountTriggerClass.AmountTriggerClass(Trigger.New);
  
}