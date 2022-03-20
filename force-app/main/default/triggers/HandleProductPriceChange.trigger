trigger HandleProductPriceChange on Merchandies__c (after update) {
List<Line_Item__c> openLineItems =
[SELECT j.Unit_Price__c, j.Merchandies__r.Price__c
FROM Line_Item__c j
WHERE j.Invoice_Statement__r.Status__c = 'Negotiating'
AND j.Merchandies__r.id IN :Trigger.new
FOR UPDATE];
for (Line_Item__c li: openLineItems) {
if ( li.Merchandies__r.Price__c < li.Unit_Price__c ){
li.Unit_Price__c = li.Merchandies__r.Price__c;
}
}
update openLineItems;
}