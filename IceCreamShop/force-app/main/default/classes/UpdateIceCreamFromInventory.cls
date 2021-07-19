public class UpdateIceCreamFromInventory {

    public void updateIceCreamQuantity(List<Inventory__c> inventoryList){
           
        //check box to see if it is ice cream or not.
    	if(inventoryList[0].Is_Ice_Cream__c){
        
        	//SOQL Query to retrieve flavor for update
			List <Ice_Cream_Flavor__c> flavorList = [SELECT Id, Quantity__c, Name FROM Ice_Cream_Flavor__c  
                                             		WHERE Id =: inventoryList[0].Ice_Cream_Flavor__c]; 

            //increase quantity of the ice cream buckets, based on new inventory. 
        	flavorList[0].Quantity__c = ( inventoryList[0].Quantity__c + flavorList[0].Quantity__c );
        
            //updates the Ice_Cream_Flavors_c object. 
        	update flavorList; 

    	}
    }
}