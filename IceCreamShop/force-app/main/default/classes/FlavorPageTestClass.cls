@isTest
public class FlavorPageTestClass {

    @isTest
    static void testFlavorPage() {
        // Insert a flavor
        Ice_Cream_Flavor__c flavor1 = new Ice_Cream_Flavor__c();
        flavor1.Name = 'blue flavor';
        flavor1.Sale_Price_Per_Scoop__c = 3;
        flavor1.Current_Scoops_Removed__c = 0;
        flavor1.Quantity__c = 50;
        insert flavor1;
        
        // Insert another flavor
        Ice_Cream_Flavor__c flavor2 = new Ice_Cream_Flavor__c();
        flavor2.Name = 'green flavor';
        flavor2.Sale_Price_Per_Scoop__c = 2;
        flavor2.Current_Scoops_Removed__c = 0;
        flavor2.Quantity__c = 50;
        insert flavor2;
        
        // Insert some sales
        Integer i = 0;
        while (i < 5) {
            Sale__c sale = new Sale__c();
            sale.Ice_Cream_Flavor__c = flavor1.Id;
            sale.Scoop_Number__c = i + 1;
            insert sale;
            i += 1;
        }
        i = 0;
        while (i < 3) {
            Sale__c sale = new Sale__c();
            sale.Ice_Cream_Flavor__c = flavor2.Id;
            sale.Scoop_Number__c = 2;
            insert sale;
            i += 1;
        }
        
        // Create controller
        FlavorPageController controller = new FlavorPageController();
        
        // Test that the controller's allFlavors and flavorWrappers are correct
        System.assertEquals(2,controller.allFlavors.size());
        System.assertEquals(15, controller.allFlavorWrappers[0].numberSold);
        System.assertEquals(6, controller.allFlavorWrappers[1].numberSold);
        System.assertEquals('blue flavor', controller.allFlavorWrappers[0].flavor.Name);
    }
}