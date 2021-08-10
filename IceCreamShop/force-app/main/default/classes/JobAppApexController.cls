public class JobAppApexController {
    
    @AuraEnabled
    public static String createJobAppRecord(String firstName, String lastName, Date graduationDate,
                                            String schoolName, String address, String address2,
                                            String city, String email, String phone,
                                            String secondLanguage, String major, String zip,
                                           String state, String educationLevel, String graduated, Job_Listing__c listing) {
                                                
                                                try {
                                                    Job_Application__c jobApp = new Job_Application__c();
                                                    jobApp.First_Name__c = firstName;
                                                    jobApp.Last_Name__c = lastName;
                                                    jobApp.Graduation_Date_if_applicable__c = graduationDate;
                                                    jobApp.School_Name__c = schoolName;
                                                    jobApp.Address__c = address;
                                                    jobApp.Address_Line_2__c = address2;
                                                    jobApp.City__c = city;
                                                    jobApp.Email__c = email;
                                                    jobApp.Phone_Number__c = phone;
                                                    jobApp.Second_Language_if_applicable__c = secondLanguage;
                                                    jobApp.Major_if_applicable__c = major;
                                                    jobApp.Zip_Code__c = zip;
                                                    jobApp.State__c = state;
                                                    jobApp.Education_Level__c = educationLevel;
                                                    jobApp.Graduated__c = graduated;
                                                    jobApp.Job_Listing__c = listing.Id;
                                                    insert jobApp;
                                                } catch (DMLException e) {
                                                    if (e.getNumDml() > 0) {
                                                        return 'Error: ' + e.getDmlMessage(0);
                                                    }
                                                    return 'Unknown error; please try again.';
                                                }
                                                return 'Success';
                                            }
    
    @AuraEnabled 
    public static Map<String, String> getStatePicklistValues(){
        List<Schema.PicklistEntry> picklistEntries = Job_Application__c.State__c.getDescribe().getPicklistValues();
        return JobAppApexController.picklistEntriesToMap(picklistEntries);
    }
    
    @AuraEnabled 
    public static Map<String, String> getEducationLevelPicklistValues(){
        List<Schema.PicklistEntry> picklistEntries = Job_Application__c.Education_Level__c.getDescribe().getPicklistValues();
        return JobAppApexController.picklistEntriesToMap(picklistEntries);
    }
    
    @AuraEnabled 
    public static Map<String, String> getGraduatedPicklistValues(){
        List<Schema.PicklistEntry> picklistEntries = Job_Application__c.Graduated__c.getDescribe().getPicklistValues();
        return JobAppApexController.picklistEntriesToMap(picklistEntries);
    }
    
    public static Map<String,String> picklistEntriesToMap(List<Schema.PicklistEntry> picklistEntries) {
        Map<String, String> options = new Map<String, String>();
        for (Schema.PicklistEntry p: picklistEntries) {
            options.put(p.getValue(), p.getLabel());
        }
        return options;
    }
    
    @AuraEnabled
    public static List<Job_Listing__c> getJobListings() {
        return [SELECT Name, More_Info__c FROM Job_Listing__c];
    }
}