@isTest (SeeAllData=true)
public class ControllerAllergyTest 
{
    
    @isTest
    static void testController()
    {
        Ingredient__c ing = new Ingredient__c();
        ApexPages.StandardController sc = new ApexPages.StandardController(ing);

        ControllerAllergy control = new ControllerAllergy(sc);
        
        control.name = 'berry';
        
        control.flavorListClickHandlerApex();

        Ingredient__c flavorIngredients = [SELECT Ice_Cream_Flavor__r.Name, Name, Allergy__c, Pick_Ingredients__c 
        FROM Ingredient__c WHERE Ice_Cream_Flavor__r.Name LIKE 'berry' LIMIT 1];

        System.assertEquals(flavorIngredients, control.flavorIngredients);

        System.assertequals([SELECT Id, Name FROM Ice_Cream_Flavor__c ], control.flavorList); //else
        System.assertequals([SELECT Id, Name FROM Ice_Cream_Flavor__c ], control.flavorList); //if
    }
}    