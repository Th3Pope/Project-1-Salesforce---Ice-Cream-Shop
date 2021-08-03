@isTest
public class OrderBuilderTest {
   	@TestSetup
    static void testSetup() {
        // Instantiate some test flavors.
        Ice_Cream_Flavor__c vanilla = new Ice_Cream_Flavor__c();
        vanilla.Name = 'Vanilla';
        vanilla.Sale_Price_Per_Scoop__c = 1.50;
        vanilla.Current_Scoops_Removed__c = 0;
        vanilla.Quantity__c = 50;
        vanilla.Color__c = 'white';
        insert vanilla;
        
        Ice_Cream_Flavor__c chocolate = new Ice_Cream_Flavor__c();
        chocolate.Name = 'Chocolate';
        chocolate.Sale_Price_Per_Scoop__c = 2.00;
        chocolate.Current_Scoops_Removed__c = 0;
        chocolate.Quantity__c = 50;
        chocolate.Color__c = 'brown';
        insert chocolate;
        
        Ice_Cream_Flavor__c mint = new Ice_Cream_Flavor__c();
        mint.Name = 'Mint';
        mint.Sale_Price_Per_Scoop__c = 2.00;
        mint.Current_Scoops_Removed__c = 0;
        mint.Quantity__c = 50;
        mint.Color__c = 'green';
        insert mint;
        
        // This flavor shouldn't be included in the controller's queries because it's empty!
        Ice_Cream_Flavor__c emptyFlavor = new Ice_Cream_Flavor__c();
        emptyFlavor.Name = 'Empty Flavor';
        emptyFlavor.Sale_Price_Per_Scoop__c = 0.00;
        emptyFlavor.Current_Scoops_Removed__c = 0;
        emptyFlavor.Quantity__c = 0;
        emptyFlavor.Color__c = 'black';
        insert emptyFlavor;
        
        // Instantiate some novelty inventory items.
        Inventory__c waffleCone = new Inventory__c();
        waffleCone.Name = 'Waffle Cone';
        waffleCone.Quantity__c = 50;
        waffleCone.Is_Ice_Cream__c = false;
        insert waffleCone;
        
        Inventory__c sugarCone = new Inventory__c();
        sugarCone.Name = 'Sugar Cone';
        sugarCone.Quantity__c = 50;
        sugarCone.Is_Ice_Cream__c = false;
        insert sugarCone;
        
        // This item shouldn't be included by the controller's queries because it's empty!
        Inventory__c emptyNovelty = new Inventory__c();
        emptyNovelty.Name = 'Empty Novelty';
        emptyNovelty.Quantity__c = 0;
        emptyNovelty.Is_Ice_Cream__c = false;
        insert emptyNovelty;
        
        // Note: This does not test an inventory item that connects to a flavor quantity!
    }
    
    @isTest
    static void testQueryLogic() {
        // Instantiate a test controller and check its queries.
        OrderBuilderController controller = new OrderBuilderController();
        System.assertEquals(controller.stockedFlavors.size(), 3);
        System.assertEquals(controller.stockedNovelties.size(), 2);
    }
    
    @isTest
    static void testOrderSelections() {
        // Instantiate a test controller and check its order logic.
        OrderBuilderController controller = new OrderBuilderController();
        
        // Test a scenario where no flavor is selected.
        controller.selectedFlavorIndex = null;
        controller.selectedNoveltyIndex = -1;
        controller.customerScoopCount = 1;
        controller.saveOrderRecord();
        List<Sale__c> createdSale = [SELECT Name, Id FROM Sale__c];
        System.assertEquals(createdSale.size(), 0);
        
        // Test a scenario where no novelty is selected.
        controller.selectedFlavorIndex = 0;
        controller.selectedNoveltyIndex = null;
        controller.customerScoopCount = 1;
        controller.saveOrderRecord();
        createdSale = [SELECT Name, Id FROM Sale__c];
        System.assertEquals(createdSale.size(), 0);
        
        // Test a scenario where less than 1 scoop is ordered.
        controller.selectedFlavorIndex = 0;
        controller.selectedNoveltyIndex = -1;
        controller.customerScoopCount = 0;
        controller.saveOrderRecord();
        createdSale = [SELECT Name, Id FROM Sale__c];
        System.assertEquals(createdSale.size(), 0);
        
        // Test a scenario where too many scoops are ordered.
        controller.selectedFlavorIndex = 0;
        controller.selectedNoveltyIndex = -1;
        controller.customerScoopCount = 1000;
        controller.saveOrderRecord();
        createdSale = [SELECT Name, Id FROM Sale__c];
        System.assertEquals(createdSale.size(), 0);
        
        // Test a scenario where a valid order does NOT include a novelty.
        controller.selectedFlavorIndex = 0;
        controller.selectedNoveltyIndex = -1;
        controller.customerScoopCount = 1;
        controller.saveOrderRecord();
        createdSale = [SELECT Name, Id FROM Sale__c WHERE Cone_Or_Bowl__c = null];
        System.assertEquals(createdSale.size(), 1);
        
        // Test a scenario where a valid order does include a novelty.
        controller.selectedFlavorIndex = 0;
        controller.selectedNoveltyIndex = 0;
        controller.customerScoopCount = 1;
        controller.saveOrderRecord();
        createdSale = [SELECT Name, Id FROM Sale__c WHERE Cone_Or_Bowl__c != null];
        System.assertEquals(createdSale.size(), 1);
    }
    
    @isTest
    static void testSelectLists() {
        // Instantiate a test controller and check its selections.
        OrderBuilderController controller = new OrderBuilderController();
        System.assertEquals(controller.getFlavors().size(), 3);
        System.assertEquals(controller.getNovelties().size(), 3);
        System.assertEquals(controller.getNovelties()[0].getValue(), '-1');
    }
}