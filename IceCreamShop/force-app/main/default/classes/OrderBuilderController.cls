public class OrderBuilderController {
    // Lists to hold available flavors and cone/bowl novelties.
    public List<Ice_Cream_Flavor__c> stockedFlavors {get; set;}
    public List<Inventory__c> stockedNovelties {get; set;}
    
    // Properties that store customer choices/input.
    public Integer selectedFlavorIndex {get; set;}
    public Integer selectedNoveltyIndex {get; set;}
    public Integer customerScoopCount {get; set;}
    public Decimal orderPrice {get; set;}
    
    // True/false values that help keep track of an order's progress.
    private boolean inputProblems = true;
    
    public OrderBuilderController() {
        // The controller queries available menu items during construction.
        stockedFlavors = [SELECT Name, Sale_Price_Per_Scoop__c, Quantity__c FROM Ice_Cream_Flavor__c WHERE Quantity__c > 0  ORDER By Name];
        stockedNovelties = [SELECT Name, Quantity__c FROM Inventory__c WHERE Is_Ice_Cream__c = false AND Ice_Cream_Flavor__c = null AND Quantity__c > 0  ORDER By Name];
    }

    // Helper that returns a list of selectable flavors for users to choose from.   
    public List<SelectOption> getFlavors() {
        List<selectOption> flavors = new List<SelectOption>();
        Integer flavorIndex = 0; 
        
        for (Ice_Cream_Flavor__c flavor : stockedFlavors) {
            flavors.add(new SelectOption(String.valueOf(flavorIndex), flavor.name));
            flavorIndex++;
        }
        
        return flavors;
    }
    
    // Helper that returns a list of selectable novelties for customers to choose from.   
    public List<SelectOption> getNovelties() {
        List<selectOption> novelties = new List<SelectOption>();
        Integer noveltyIndex = 0; 
        
        // Add a standard bowl option.
        novelties.add(new SelectOption(String.valueOf(-1), 'Bowl'));
        
        for (Inventory__c novelty : stockedNovelties) {
            novelties.add(new SelectOption(String.valueOf(noveltyIndex), novelty.name));
            noveltyIndex++;
        }
        
        return novelties;
    }
    
    // Helper that validates the scoop input from customers.
    public void inputHandler() {
        inputProblems = true;
        
        if (selectedFlavorIndex == null) {
            ApexPages.addmessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'Please select a flavor before entering scoops or submitting an order.'));
        }
        else if (customerScoopCount < 1) {
            ApexPages.addmessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'Orders must have at least 1 scoop.'));
        }
        else if (customerScoopCount > stockedFlavors[selectedFlavorIndex].Quantity__c) {
            ApexPages.addmessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'Sorry, there is not enough of your selected flavor to fufill your current order.'));
        }
        else if (selectedNoveltyIndex == null) {
            ApexPages.addmessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'Please select a novelty option before submitting an order.'));
        }
        else {
            inputProblems = false;
        }
        
        orderPriceCalculator();
    }
    
    // Helper that submits an sale record based on customer selections.
    public void saveOrderRecord() {
        inputHandler();
        
        if (!inputProblems) {
            Sale__c customerOrder = new Sale__c();
            customerOrder.Ice_Cream_Flavor__c = stockedFlavors[selectedFlavorIndex].Id;
            customerOrder.Scoop_Number__c = customerScoopCount;
            
            if (selectedNoveltyIndex != -1) {
                customerOrder.Cone_Or_Bowl__c = stockedNovelties[selectedNoveltyIndex].Id;
            }
            
            insert customerOrder;
            ApexPages.addmessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Thank you for your order. Please enjoy!'));
        }
    }
    
    // Helper that calculates the price of a customer's order for display purposes.
    private void orderPriceCalculator() {
        if (inputProblems) {
            orderPrice = 0.00;
        }
        else {
            orderPrice = stockedFlavors[selectedFlavorIndex].Sale_Price_Per_Scoop__c * customerScoopCount;
        }
    }
}