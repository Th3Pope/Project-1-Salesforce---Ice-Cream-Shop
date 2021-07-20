public class ScoopReducesQuantity {
    
	public void scoopCheck(List <Sale__c> sale){
        
        //SOQL Query to retrieve current scoops, scooped
		List <Ice_Cream_Flavor__c> flavorList = [SELECT Id, Current_Scoops_Removed__c, Quantity__c FROM Ice_Cream_Flavor__c  
                                             	WHERE Id =: sale[0].Ice_Cream_Flavor__c];     
            
            //Little buckets of ice cream, only hold 10 scoops each. 
            if( ( flavorList[0].Current_Scoops_Removed__c + sale[0].Scoop_Number__c ) >= 9 ){
                
                Integer extraScoops = 0; 
               
                if (flavorList[0].Current_Scoops_Removed__c + sale[0].Scoop_Number__c > 9){
                    extraScoops = (Integer)(flavorList[0].Current_Scoops_Removed__c + sale[0].Scoop_Number__c - 9);
                }else{
                    extraScoops = (Integer)sale[0].Scoop_Number__c; 
                }
                
                flavorList[0].Current_Scoops_Removed__c = extraScoops;
                flavorList[0].Quantity__c = ( flavorList[0].Quantity__c - 1 ); 
            }
    	update flavorList; 
    }
}