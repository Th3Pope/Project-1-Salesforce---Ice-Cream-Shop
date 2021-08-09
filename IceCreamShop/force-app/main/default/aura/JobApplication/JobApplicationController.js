({
    doInit : function(component, event, helper) {
        //var today = new Date();
        //component.set('v.today', today.getFullYear() + "-" + (today.getMonth() - 4) + "-" + (today.getDate()));
        
        helper.populatePicklistMap(component,'c.getStatePicklistValues','v.statePicklistFieldMap');
        helper.populatePicklistMap(component,'c.getEducationLevelPicklistValues','v.educationLevelPicklistFieldMap');
        helper.populatePicklistMap(component,'c.getGraduatedPicklistValues','v.graduatedPicklistFieldMap');
        
        component.set('v.columns', [
            {label: 'Name', fieldName: 'Name', type: 'text'},
            {label: 'More Info', fieldName: 'More_Info__c', type: 'text'}
        ]);
        
        helper.getJobListings(component);
    },
    
    submitJobApplication : function(component, event, helper) {
        var cmpMsg = component.find("msg");
        $A.util.removeClass(cmpMsg, 'hide');
        var expdate = component.find("expdate").get("v.value");
        
        var oDate = component.find("oDate");
        oDate.set("v.value", expdate);
        
        let theListing = component.get("v.selectedJobListing");
        
        let createJobAppRecord = component.get('c.createJobAppRecord');
        createJobAppRecord.setParams({firstName:component.find("firstNameIn").get('v.value'),
                                      lastName:component.find("lastNameIn").get('v.value'),
                                      graduationDate:expdate,
                                      schoolName:component.find("schoolNameIn").get('v.value'),
                                      address:component.find("addressIn").get('v.value'),
                                      address2:component.find("address2In").get('v.value'),
                                      city:component.find("cityIn").get('v.value'),
                                      email:component.find("emailIn").get('v.value'),
                                      phone:component.find("phoneIn").get('v.value'),
                                      secondLanguage:component.find("secondLanguageIn").get('v.value'),
                                      major:component.find("majorIn").get('v.value'),
                                      zip:component.find("zipIn").get('v.value'),
                                      state:component.find("stateIn").get('v.value'),
                                      educationLevel:component.find("educationLevelIn").get('v.value'),
                                      graduated:component.find("graduatedIn").get('v.value'),
                                      listing:theListing});
        createJobAppRecord.setCallback(this, function(response) {
            let returnString = response.getReturnValue();
            component.find("oDate").set("v.value", returnString);
        });
        
        oDate.set("v.value", component.find("graduatedIn").get('v.value'));
        oDate.set("v.value", theListing.Id);
        
        $A.enqueueAction(createJobAppRecord);
    },
    
    goToFillOutFormPage : function(component, event, helper) {
        
        component.set("v.showingFirstPage", false);
    },
    
    cancelApplication : function(component, event, helper) {
        
        component.set("v.showingFirstPage", true);
        component.set("v.applyButtonDisabled", true);
    },
    
    handleClickRadioButton : function(component, event, helper) {
        
    	var selectedRows = event.getParam('selectedRows');
        if (selectedRows.length == 1) {
            component.set("v.selectedJobListing", selectedRows[0]);
        }
        
        component.set("v.applyButtonDisabled", false);
    }
})