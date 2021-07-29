public class FlavorPageController {

    public List<Ice_Cream_Flavor__c> allFlavors {get; set;}
    public List<PopularFlavorWrapper> flavorWrappers {get;set;}
    
    public FlavorPageController() {
        allFlavors = [SELECT Id, Name, Sale_Price_Per_Scoop__c, Color__c FROM Ice_Cream_Flavor__c ORDER BY Name];
        System.debug('All flavors' + allFlavors);
        
        Map<Id, Ice_Cream_Flavor__c> flavorIDMap = new Map<Id, Ice_Cream_Flavor__c>(allFlavors);
        
        List<AggregateResult> mostPopular = [SELECT Ice_Cream_Flavor__r.Id, SUM(Scoop_Number__c)
                                             FROM Sale__c GROUP BY Ice_Cream_Flavor__r.Id
                                            ORDER BY SUM(Scoop_Number__c) DESC LIMIT 3];
        
        flavorWrappers = new List<PopularFlavorWrapper>();
        for (AggregateResult ar : mostPopular) {
            PopularFlavorWrapper wrapper = new PopularFlavorWrapper();
            wrapper.flavor = flavorIDMap.get(ar.Id);
            wrapper.numberSold = Integer.valueOf((Decimal)ar.get('expr0'));
            flavorWrappers.add(wrapper);
        }
        System.debug('Most popular' + mostPopular);
        System.debug('FLavor wrappers' + flavorWrappers);
    }
}