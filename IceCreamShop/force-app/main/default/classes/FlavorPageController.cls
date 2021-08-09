public class FlavorPageController {

    public List<Ice_Cream_Flavor__c> allFlavors {get; set;}
    public List<PopularFlavorWrapper> popFlavorWrappers {get;set;}
    public List<PopularFlavorWrapper> allFlavorWrappers {get;set;}
    
    public String consoleString {get;set;}
    
    public FlavorPageController() {
        List<Ice_Cream_Flavor__c> allFlavors = [SELECT Name, Sale_Price_Per_Scoop__c, Image_Texture__c FROM Ice_Cream_Flavor__c ORDER BY Name];
        System.debug('All flavors' + allFlavors);
        
        List<AggregateResult> mostPopular = [SELECT Ice_Cream_Flavor__r.Name, SUM(Scoop_Number__c) FROM Sale__c GROUP BY Ice_Cream_Flavor__r.Name ORDER BY SUM(Scoop_Number__c) DESC LIMIT 3];
        
        popFlavorWrappers = new List<PopularFlavorWrapper>();
        for (AggregateResult ar : mostPopular) {
            PopularFlavorWrapper wrapper = new PopularFlavorWrapper();
            for (Ice_Cream_Flavor__c flavor : allFlavors) {
                if (flavor.Name == ar.get('Name')) {
                    wrapper.flavor = flavor;
                    wrapper.priceString = String.valueOf(flavor.Sale_Price_Per_Scoop__c);
                    wrapper.textureString = String.valueOf(flavor.Image_Texture__c);
                    break;
                }
            }
            
            wrapper.numberSold = Integer.valueOf((Decimal)ar.get('expr0'));
            popFlavorWrappers.add(wrapper);
        }
        
        allFlavorWrappers = new List<PopularFlavorWrapper>();
        for (Ice_Cream_Flavor__c flavor : allFlavors) {
            PopularFlavorWrapper wrapper = new PopularFlavorWrapper();
            wrapper.flavor = flavor;
            wrapper.priceString = String.valueOf(flavor.Sale_Price_Per_Scoop__c);
            wrapper.textureString = String.valueOf(flavor.Image_Texture__c);
            allFlavorWrappers.add(wrapper);
        }
    }
}