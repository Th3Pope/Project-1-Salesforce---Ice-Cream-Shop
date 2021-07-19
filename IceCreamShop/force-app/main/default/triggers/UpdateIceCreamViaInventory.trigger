trigger UpdateIceCreamViaInventory on Inventory__c (before insert) {
	
    new UpdateIceCreamFromInventory().updateIceCreamQuantity(Trigger.new); 

}