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
                component.set('v.data',result);
            }
        });
        $A.enqueueAction(action);
    }
})