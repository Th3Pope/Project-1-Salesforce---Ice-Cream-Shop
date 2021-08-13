@isTest
public class JobAppApexControllerTestClass {
    
    @isTest
    static void runTests() {
        
        Job_Listing__c listing = new Job_Listing__c();
        listing.Name = 'Washer';
        
        insert listing;
        
        List<Job_Listing__c> listings = JobAppApexController.getJobListings();
        System.assertEquals(1, listings.size());
        System.assertEquals('Washer', listings[0].Name);
            
        String result1 = JobAppApexController.createJobAppRecord('first','last',Date.today(),'school',
                                              'add1','add2','city','email@e.com','phone',
                                              'second lang','major','zip','MN','Some college','Yes',listing);
        System.assertEquals('Success', result1);
        
        List<Job_Application__c> applications = [SELECT Id, City__c FROM Job_Application__c];
        System.assertEquals(1, applications.size());
        System.assertEquals('city', applications[0].City__c);
        
        
        
        String result2 = JobAppApexController.createJobAppRecord('first','last',Date.today(),'school',
                                              'add1','add2','city','email','phone',
                                              'second lang','major','zip','MN','Some college','Yes',listing);
        
        System.assertEquals('Error: Email: invalid email address: email', result2);
        
        Map<String,String> states = JobAppApexController.getStatePicklistValues();
        System.assertEquals('MN', states.get('MN'));
        System.assertEquals('CA', states.get('CA'));
        System.assertEquals(NULL, states.get('ZZ'));
        
        Map<String,String> edLevels = JobAppApexController.getEducationLevelPicklistValues();
        Set<String> s = edLevels.keySet();
        System.assert(s.contains('PhD'));
        System.assert(s.size() >= 11);
        
        Map<String,String> gradPicklistVals = JobAppApexController.getGraduatedPicklistValues();
        System.assertEquals(new Set<String>{'Yes', 'No'}, gradPicklistVals.keySet());
    }
}