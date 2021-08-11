({
    populatePicklistMap : function(component, controllerActionName,picklistMapName) {
        var action = component.get(controllerActionName);
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                var fieldMap = [];
                for(var key in result){
                    fieldMap.push({key: key, value: result[key]});
                }
                component.set(picklistMapName, fieldMap);
            }
        });
        $A.enqueueAction(action);
    },
    
    getJobListings : function (component) {
        var action = component.get('c.getJobListings');
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                component.set('v.listingTableData',result);
            }
        });
        $A.enqueueAction(action);
    }, 
    
    reportRequiredFieldValidity: function (component) {
        component.find("firstNameIn").reportValidity();
        component.find("lastNameIn").reportValidity();
        component.find("emailIn").reportValidity();
    },
    
    cancelApplication : function(component) {
        
        component.set("v.showingFirstPage", true);
        component.set("v.applyButtonDisabled", true);
    }
})