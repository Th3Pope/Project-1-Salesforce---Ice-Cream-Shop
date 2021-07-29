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
   // public Job_Listing__c moreIndex = JobList[rowIndex];
    public String moreInfo {get; set;}

    
    
  
    
    public string jobId{get;set;}
    public string jobName{get;set;}
    
    public void JobListClickHandlerApex(){
        this.jobId = JobList[rowIndex -1].Id;
        this.jobName = JobList[rowIndex -1].Name;
        moreInfo = JobList[rowIndex -1].More_Info__c;
        //jobId = JobList[rowIndex -1].Id;
        //String name = ApexPages.currentPage().getParameters().get('textName');

       // System.debug(name+ '   '  +rowIndex);

       // this.moreInfo = [SELECT Name FROM Job_Listing__c Where Name =: name LIMIT 1];
        //System.debug(flavorIngredients.name);
    }
   /* public static String sendId(){
        //jobId = JobList[rowIndex -1].Id;
        return jobId;
    }*/
     
    public PageReference application(){
       	
        return Page.JobApplication;
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
 //   public string appJobId {get;set;}
  //  public virtual void changeId(string id){
    //    jobId = id;
    //}
	public ApplicationController(){
        this.jobApp = new Job_Application__c();
      //  appJobId = sendId(); 
        
    }
   // public ApplicationController(ApexPages.StandardController controller){}
    
    //public String test3{get;set;}
    

    
    public List<SelectOption> State {get{
        List<Schema.PicklistEntry> appState = Schema.SObjectType.Job_Application__c.Fields.State__c.getPicklistValues();
        State = new List<SelectOption>();
        for(Schema.PicklistEntry tempState: appState){
            State.add(new SelectOption(tempState.getValue(), tempState.getLabel()));
        }
        return State;
    } set;}

    
    
    
   // public String applicantFirstName {get;set;}
    //public String applicantLastName {get;set;}
    //public Integer i = 2;
    
  // public String applicantAddress{get;set;}
  //  public String applicantAddress2{get;set;}
   // Public String applicantCity{get;set;}
//    Public String applicantZip{get;set;}
    
   // public String appFullName = applicantFirstName + applicantLastName;
   
  /*  public void testingMethod(){
        System.debug('hi');
        jobApp.First_Name__c = appFullName;
        
    }*/
    
   
    
    
    
    
    
    
    
    
    public Job_Application__c jobApp { get; set; }
    

    
  
    
    
    //   public Job_Application__c jobApp = new Job_Application__c();
  //   jobApp.State__c = State;
  //   jobApp.First_Name__c = applicantFirstName;
    public PageReference submitApp(){
        jobApp.Job_Listing__c = jobId;
        insert this.jobApp;

        return Page.SubmitPage;
        
    }
    

}