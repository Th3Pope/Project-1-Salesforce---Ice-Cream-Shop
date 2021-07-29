public virtual class JobController {
    
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

    
    
    //public JobController(ApexPages.StandardController controller){}
    public JobController(){
        
         
    }
    
    public static string jobId{get;set;}
    public void JobListClickHandlerApex(){
        jobId = JobList[rowIndex -1].Name;
        moreInfo = JobList[rowIndex -1].More_Info__c;
        //jobId = JobList[rowIndex -1].Id;
        //String name = ApexPages.currentPage().getParameters().get('textName');

       // System.debug(name+ '   '  +rowIndex);

       // this.moreInfo = [SELECT Name FROM Job_Listing__c Where Name =: name LIMIT 1];
        //System.debug(flavorIngredients.name);
    }
    public static String sendId(){
        //jobId = JobList[rowIndex -1].Id;
        return jobId;
    }
     
    public PageReference application(){
       	
        return Page.JobApplication;
    }


}