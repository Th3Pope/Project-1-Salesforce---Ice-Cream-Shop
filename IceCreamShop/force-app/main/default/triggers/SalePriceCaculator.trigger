trigger SalePriceCaculator on Sale__c (before insert) {
    
    List <Sale__c> sale = Trigger.new; 
	new CaculateSalesPriceForTrigger().calculatePrice(sale); 
	new ScoopReducesQuantity().scoopCheck(sale); 
}