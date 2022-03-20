Global class TarAPIClass{

    webservice String var1 ;
    webservice static void TarAPIMthd(String ProdName, Integer prod_Inventory){
        insert new Pharma_Product__c (Name=ProdName ,  Inventory__c=prod_Inventory);
    
    }

}