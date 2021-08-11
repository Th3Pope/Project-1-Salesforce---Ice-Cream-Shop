public class PopularFlavorWrapper {
    public Ice_Cream_Flavor__c flavor {get; set;}
    @AuraEnabled
    public String nameString {get; set;}
    @AuraEnabled
    public Integer numberSold {get; set;}
    @AuraEnabled
    public String priceString {get; set;}
    @AuraEnabled
    public String textureString {get; set;}
}