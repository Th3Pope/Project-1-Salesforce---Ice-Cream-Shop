public class SubmitHome extends JobController{
    
    public SubmitHome(ApexPages.StandardController controller){}
    public SubmitHome(){}
    
    public PageReference returnHome(){
        return Page.JobListingMainPage;
    }

}