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
    public Integer rowIndex {get; set;}
    public Ingredient__c flavorIngredients {get; set;}

    //default constructor needed to extend standard controller. 
    public ControllerAllergy(ApexPages.StandardController controller){}

    public void flavorListClickHandlerApex(){
        //String name = ApexPages.currentPage().getParameters().get('textName');

        System.debug(name+ '   '  +rowIndex);

        this.flavorIngredients = [SELECT Ice_Cream_Flavor__r.Name, Name, Allergy__c, Pick_Ingredients__c 
                                  FROM Ingredient__c WHERE Ice_Cream_Flavor__r.Name LIKE :name LIMIT 1];
        System.debug(flavorIngredients.name);
    }
}