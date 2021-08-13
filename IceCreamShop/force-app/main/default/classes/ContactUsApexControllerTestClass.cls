@isTest
public class ContactUsApexControllerTestClass {

    @isTest
    static void contactUsTestFunction() {
        
        String result1 = ContactUsApexController.createNewCase('First', 'Last', 'EMail', 'subject', 'message');
        
        System.assertEquals('Error: Email Address: invalid email address: EMail', result1);
        
        String result2 = ContactUsApexController.createNewCase('First', 'Last', 'EMail@gmail.com', 'subject', 'message');
        
        System.assertEquals('Success', result2);
        
        List<Case> cases = [SELECT Id, SuppliedName FROM Case];
        System.assertEquals(1, cases.size());
        System.assertEquals('First Last', cases[0].SuppliedName);
    }
}