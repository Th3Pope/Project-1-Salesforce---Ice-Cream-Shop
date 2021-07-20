public class CaculateSalesPriceForTrigger {
    
    public void calculatePrice(List <Sale__c> sale){
        
        //SOQL Query to retrieve price per scoop
		List <Ice_Cream_Flavor__c> flavorList = [SELECT Id, Sale_Price_Per_Scoop__c FROM Ice_Cream_Flavor__c  
                                             	WHERE Id =: sale[0].Ice_Cream_Flavor__c];     
    
        //price caculation salePrice*numberOfScoops
    	Double price = ( flavorList[0].Sale_Price_Per_Scoop__c * sale[0].Scoop_Number__c ); 
    	
        //set amount due
        sale[0].Amount_Due__c = price;
    }
}