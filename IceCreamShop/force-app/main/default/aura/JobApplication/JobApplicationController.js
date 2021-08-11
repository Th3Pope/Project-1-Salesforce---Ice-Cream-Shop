({
    doInit : function(component, event, helper) {
        
        helper.populatePicklistMap(component,'c.getStatePicklistValues','v.statePicklistFieldMap');
        helper.populatePicklistMap(component,'c.getEducationLevelPicklistValues','v.educationLevelPicklistFieldMap');
        helper.populatePicklistMap(component,'c.getGraduatedPicklistValues','v.graduatedPicklistFieldMap');
        
        component.set('v.columns', [
            {label: 'Name', fieldName: 'Name', type: 'text'},
            {label: 'More Info', fieldName: 'More_Info__c', type: 'text', wrapText: 'True'}
        ]);
        
        helper.getJobListings(component);
    },
    
    submitJobApplication : function(component, event, helper) {
        
        if (component.find("firstNameIn").get('v.value').length < 1) {
            helper.reportRequiredFieldValidity(component);
            alert('Please enter your first name.');
            return;
        } else if (component.find("lastNameIn").get('v.value').length < 1) {
            helper.reportRequiredFieldValidity(component);
            alert('Please enter your last name.');
            return;
        } else if (component.find("emailIn").get('v.value').length < 1) {
            helper.reportRequiredFieldValidity(component);
            alert('Please enter your email.');
            return;
        }
        
        let theListing = component.get("v.selectedJobListing");
        
        let createJobAppRecord = component.get('c.createJobAppRecord');
        createJobAppRecord.setParams({firstName:component.find("firstNameIn").get('v.value'),
                                      lastName:component.find("lastNameIn").get('v.value'),
                                      graduationDate:component.find("expdate").get("v.value"),
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
            if (returnString === 'Success') {
                alert('Job application successfully submitted!');
        		helper.cancelApplication(component);
            } else {
            	alert(returnString);
            }
        });
        
        $A.enqueueAction(createJobAppRecord);
    },
    
    goToFillOutFormPage : function(component, event, helper) {
        
        component.set("v.showingFirstPage", false);
    },
    
    cancelApplication : function(component, event, helper) {
        helper.cancelApplication(component);
    },
    
    handleClickRadioButton : function(component, event, helper) {
        
    	var selectedRows = event.getParam('selectedRows');
        if (selectedRows.length == 1) {
            component.set("v.selectedJobListing", selectedRows[0]);
        }
        
        component.set("v.applyButtonDisabled", false);
    }
})