public class DynamicApexSN {
    
    public Account acc { get; set;}
    public List<SelectOption> accSources{get{
        List<Schema.PicklistEntry> sources = Schema.SObjectType.Account.Fields.AccountSource.getPicklistValues();
        accSources = new List<SelectOption>();
        for(Schema.PicklistEntry pe: sources){
            accSources.add(new SelectOption(pe.getValue(), pe.getLabel()));
        }
        return accSources;
    } set;}
    
   /*
    public List<SelectOption> accSources{ get{
        accSources = new List<SelectOption>();
        accSources.add(new SelectOption('Web', 'Web'));
        accSources.add(new SelectOption('Phone Inquiry', 'Phone Inquirey'));
        accSources.add(new SelectOption('Partner Referral', 'Partner Referral'));
        accSources.add(new SelectOption('Purchased List', 'Purchased List'));
        accSources.add(new SelectOption('Other', 'Other'));
        return accSources;
    } set;}
 */   
    public DynamicApexSN(){
        this.acc = new Account();
    }
    
    public void saveAccount(){
        insert this.acc;
    }

}