@isTest (SeeAllData=true)
public class TestClass {
    
    @isTest
    static void testSalePriceCaculator(){

        List <Sale__c> sale = new List <Sale__c>(); 
        List <Ice_Cream_Flavor__c> flavorList = [SELECT Id, Sale_Price_Per_Scoop__c, Quantity__c 
                                                 FROM Ice_Cream_Flavor__c  LIMIT 1];
        
        //set up new sales obj
        sale.add(new Sale__c());
        sale[0].Ice_Cream_Flavor__c = flavorList[0].Id;
        sale[0].Scoop_Number__c = 9; 
        
        //set up flavor list
        flavorList[0].Current_Scoops_Removed__c = 0; 
        flavorList[0].Quantity__c = 5;
        
        update flavorList; 
        insert sale; 

        Integer quantityExpected = (Integer)(flavorList[0].Quantity__c - 1);

        List <Sale__c> sale2 = [SELECT Id, Amount_Due__c, Ice_Cream_Flavor__c FROM Sale__c WHERE Id =: sale[0].Id];
        
        List <Ice_Cream_Flavor__c> flavorList2 = [SELECT Id, Quantity__c FROM Ice_Cream_Flavor__c  
                                             	 WHERE Id =: sale2[0].Ice_Cream_Flavor__c];
		
        //Check CaculateSalesPriceForTrigger/ calculatePrice
        System.assertEquals( (sale[0].Scoop_Number__c 
                             * flavorList[0].Sale_Price_Per_Scoop__c), 
                            sale2[0].Amount_Due__c); 
        
        //Check ScoopReducesQuantity/ scoopCheck
        System.assertEquals(quantityExpected, flavorList2[0].Quantity__c);    
    }
    
    @isTest
    static void testUpdateIceCreamViaInventoryTrigger(){
        
        List<Inventory__c> inventoryList = new List <Inventory__c>();
        inventoryList.add(new Inventory__c()); 
        
        List <Ice_Cream_Flavor__c> flavorList = [SELECT Id, Quantity__c, Name FROM Ice_Cream_Flavor__c LIMIT 1]; 

        inventoryList[0].Quantity__c = 3;
        inventoryList[0].Is_Ice_Cream__c = true; 
        inventoryList[0].Ice_Cream_Flavor__c = flavorList[0].Id;
        
        Integer total = (Integer)(flavorList[0].Quantity__c + inventoryList[0].Quantity__c);

        insert inventoryList; //trigger test
        
        List <Ice_Cream_Flavor__c> flavorList2 = [SELECT Id, Quantity__c, Name FROM Ice_Cream_Flavor__c  
                                             		WHERE Id =: inventoryList[0].Ice_Cream_Flavor__c]; 
        
        Integer sum = (Integer)(flavorList[0].Quantity__c + inventoryList[0].Quantity__c);
        System.assertEquals(sum, flavorList2[0].Quantity__c);               
    }
    
    
    @isTest
    static void testUpdateIceCreamFromInventory(){
        
        List<Inventory__c> inventoryList = [SELECT Is_Ice_Cream__c, Ice_Cream_Flavor__c, Quantity__c FROM Inventory__c];
        
        List <Ice_Cream_Flavor__c> flavorList = [SELECT Id, Quantity__c, Name FROM Ice_Cream_Flavor__c  
                                             		WHERE Id =: inventoryList[0].Ice_Cream_Flavor__c]; 
        flavorList[0].Quantity__c = 3;
        inventoryList[0].Quantity__c = 3;
        inventoryList[0].Is_Ice_Cream__c = true; 
        
        Integer total = (Integer)(flavorList[0].Quantity__c + inventoryList[0].Quantity__c);
        
        new UpdateIceCreamFromInventory().updateIceCreamQuantity(inventoryList); 
        
        List <Ice_Cream_Flavor__c> flavorList2 = [SELECT Id, Quantity__c, Name FROM Ice_Cream_Flavor__c  
                                             		WHERE Id =: inventoryList[0].Ice_Cream_Flavor__c]; 
        
        System.assertEquals(6, flavorList2[0].Quantity__c);                
    }
      
    @isTest
    static void testCaculateSalesPriceForTrigger(){

        List <Sale__c> sale = [SELECT Id, Scoop_Number__c, Amount_Due__c, Ice_Cream_Flavor__c FROM Sale__c];

        List <Ice_Cream_Flavor__c> flavorList = [SELECT Id, Sale_Price_Per_Scoop__c FROM Ice_Cream_Flavor__c  
                                             	 WHERE Id =: sale[0].Ice_Cream_Flavor__c];
  
        new CaculateSalesPriceForTrigger().calculatePrice(sale);
        
        System.assertEquals( (sale[0].Scoop_Number__c 
                             * flavorList[0].Sale_Price_Per_Scoop__c), 
                            sale[0].Amount_Due__c);    	
    }
    
    @isTest
    static void testScoopReducesQuantity(){

        List <Sale__c> sale = [SELECT Id, Scoop_Number__c, Amount_Due__c, Ice_Cream_Flavor__c FROM Sale__c LIMIT 1];

        //scoop resets at 9 
        sale[0].Scoop_Number__c = 9;
        
        List <Ice_Cream_Flavor__c> flavorList = [SELECT Id, Sale_Price_Per_Scoop__c, Name FROM Ice_Cream_Flavor__c  
                                             	 WHERE Id =: sale[0].Ice_Cream_Flavor__c];
        
        //set up flavor list
        flavorList[0].Current_Scoops_Removed__c = 0; 
        flavorList[0].Quantity__c = 5;
        update flavorList; 
        
        Integer quantityExpected = (Integer)(flavorList[0].Quantity__c - 1);
        
        Test.startTest();
    
        new ScoopReducesQuantity().scoopCheck(sale);
 
        Test.stopTest();
        
        //re-query for new values
        List <Ice_Cream_Flavor__c> flavorList2 = [SELECT Id, Quantity__c, Name FROM Ice_Cream_Flavor__c  
                                             	 WHERE Id =: sale[0].Ice_Cream_Flavor__c];
        
        System.assertEquals(quantityExpected, flavorList2[0].Quantity__c);
    }
}