({
    doInit : function(component, event, helper) {
        
    },
    
    sendMessage : function(component, event, helper) {
        
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
        
        let createNewCase = component.get('c.createNewCase');
        createNewCase.setParams({firstName:component.find("firstNameIn").get('v.value'),
                                 lastName:component.find("lastNameIn").get('v.value'),
                                 email:component.find("emailIn").get('v.value'),
                                 subject:component.find("subjectIn").get('v.value'),
                                 message:component.find("messageIn").get('v.value')});
        createNewCase.setCallback(this, function(response) {
            let returnString = response.getReturnValue();
            if (returnString === 'Success') {
                alert('Message submitted!  We will get back to you as soon as possible.');
                component.find("firstNameIn").set("v.value", "");
                component.find("lastNameIn").set("v.value", "");
                component.find("emailIn").set("v.value", "");
                component.find("subjectIn").set("v.value", "");
                component.find("messageIn").set("v.value", "");
            } else {
                alert(returnString);
            }
        });
        
        $A.enqueueAction(createNewCase);
    }
})