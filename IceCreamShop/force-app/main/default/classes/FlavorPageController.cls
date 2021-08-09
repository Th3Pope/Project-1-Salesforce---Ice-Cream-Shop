public class FlavorPageController {

    public List<Ice_Cream_Flavor__c> allFlavors {get; set;}
    public List<PopularFlavorWrapper> flavorWrappers {get;set;}
    public List<PopularFlavorWrapper> allFlavorWrappers {get;set;}
    
    public String consoleString {get;set;}
    
    public FlavorPageController() {
        List<Ice_Cream_Flavor__c> allFlavors = [SELECT Name, Sale_Price_Per_Scoop__c, Image_Texture__c FROM Ice_Cream_Flavor__c ORDER BY Name];
        System.debug('All flavors' + allFlavors);
        
        List<AggregateResult> mostPopular = [SELECT Ice_Cream_Flavor__r.Name, SUM(Scoop_Number__c) FROM Sale__c GROUP BY Ice_Cream_Flavor__r.Name ORDER BY SUM(Scoop_Number__c) DESC LIMIT 3];
        
        flavorWrappers = new List<PopularFlavorWrapper>();
        for (AggregateResult ar : mostPopular) {
            PopularFlavorWrapper wrapper = new PopularFlavorWrapper();
            for (Ice_Cream_Flavor__c flavor : allFlavors) {
                if (flavor.Name == ar.get('Name')) {
                    wrapper.flavor = flavor;
                    wrapper.priceString = String.valueOf(flavor.Sale_Price_Per_Scoop__c);
                }
            }
            wrapper.numberSold = Integer.valueOf((Decimal)ar.get('expr0'));
            flavorWrappers.add(wrapper);
        }
        
        allFlavorWrappers = new List<PopularFlavorWrapper>();
        for (Ice_Cream_Flavor__c flavor : allFlavors) {
            PopularFlavorWrapper wrapper = new PopularFlavorWrapper();
            wrapper.priceString = String.valueOf(flavor.Sale_Price_Per_Scoop__c);
            wrapper.flavor = flavor;
            allFlavorWrappers.add(wrapper);
        }
        // System.debug('Most popular' + mostPopular);
        // System.debug('FLavor wrappers' + flavorWrappers);
        
        // consoleString = 'flavors[0].Color__c' + allFlavors[0].Color__c + '\n!flavorWrappers[0].flavor.Sale_Price_Per_Scoop__c' + flavorWrappers[0].flavor.Sale_Price_Per_Scoop__c + '\n' +
         //   'Most popular: ' + mostPopular + 'flavor wrappers: ' + popularFlavorWrappers + 'all flavors: ' + allFlavors;
    }
}