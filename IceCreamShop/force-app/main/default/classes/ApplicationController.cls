public class ApplicationController  {
    
    public static List <Job_Listing__c> JobList 
    {
        get 
        {
            if (JobList != null)
            {
                return JobList;
            }
            else
            {
                JobList = [SELECT Id, Name, More_Info__c FROM Job_Listing__c ];
                return JobList;
            }
            
        }
        set;
    }

    public String name {get; set;}
    public static Integer rowIndex {get; set;}
    public String moreInfo {get; set;}

    public string jobId{get;set;}
    public string jobName{get;set;}
    public Job_Application__c jobApp { get; set; }
    
    public void JobListClickHandlerApex(){
        this.jobId = JobList[rowIndex -1].Id;
        this.jobName = JobList[rowIndex -1].Name;
        moreInfo = JobList[rowIndex -1].More_Info__c;
    }

    public PageReference application(){    	
        return Page.JobApplication;
    }

	public ApplicationController(){
        this.jobApp = new Job_Application__c();   
    }
   
    public List<SelectOption> State { get{
        List<Schema.PicklistEntry> appState = Schema.SObjectType.Job_Application__c.Fields.State__c.getPicklistValues();
        State = new List<SelectOption>();
        for(Schema.PicklistEntry tempState: appState){
            State.add(new SelectOption(tempState.getValue(), tempState.getLabel()));
        }
        return State;
    } set;}

    public PageReference submitApp()
    {
        jobApp.Job_Listing__c = jobId;
        insert this.jobApp;
        return Page.SubmitPage;   
    }
    public String fname{get; set;}
    public String lname{get; set;}
    public String address{get; set;}
    public String addressTwo{get; set;}
    public String city{get; set;}
    public String email{get; set;}
    public String zip{get; set;}
    public String phone{get; set;}

    //call from js in jobapppage
    public void submitApex(){
   
        jobApp.Job_Listing__c = jobId;
        jobApp.First_Name__c = fname;
        jobApp.Last_Name__c = lname;
        jobApp.Address__c = address; 
        jobApp.Address_Line_2__c = addressTwo;
        jobApp.City__c = city; 
        jobApp.Email__c = email; 
        jobApp.Zip_Code__c = zip; 
        jobApp.Phone_Number__c = phone; 
        insert jobApp; 
     
    }
}