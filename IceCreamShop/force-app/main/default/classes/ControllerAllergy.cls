public class ControllerAllergy
{
    public List <Ice_Cream_Flavor__c> flavorList 
    {
        get 
        {
            if (flavorList != null)
            {
                return flavorList;
            }
            else
            {
                flavorList = [SELECT Id, Name FROM Ice_Cream_Flavor__c ];
                return flavorList;
            }
            
        }
        set;
    }

    public String name {get; set;}
    public Ingredient__c flavorIngredients {get; set;}

    //default constructor needed to extend standard controller. 
    public ControllerAllergy(ApexPages.StandardController controller){}

    public void flavorListClickHandlerApex()
    {
        this.flavorIngredients = [SELECT Ice_Cream_Flavor__r.Name, Name, Allergy__c, Pick_Ingredients__c 
                                  FROM Ingredient__c WHERE Ice_Cream_Flavor__r.Name LIKE :name LIMIT 1];
    }
    //hello
    @AuraEnabled
    public static Ingredient__c testString2(String search){
        String exampleString = search;
        //List<Ingredient__c> example2 = [Select Name, TestField__c FROM Ingredient__c where Name LIKE :exampleString];
        //return example2[0].TestField__c;
        Ingredient__c flavorAllergy = new Ingredient__c();
        flavorAllergy = [SELECT Ice_Cream_Flavor__r.Name, Name, Allergy__c, Pick_Ingredients__c, Calories__c, Fat_g__c, Cholesterol_mg__c, Carbs_g__c, Sugars_g__c, Protein_g__c 
                                  FROM Ingredient__c WHERE Ice_Cream_Flavor__r.Name LIKE :exampleString LIMIT 1];
        return flavorAllergy;
        
    }
}