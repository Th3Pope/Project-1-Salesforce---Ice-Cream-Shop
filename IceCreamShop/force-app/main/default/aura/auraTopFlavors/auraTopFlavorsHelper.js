({
	popularFlavorsHelper : function(component) {
    	let getterAction = component.get("c.popFlavorWrappers");
        getterAction.setCallback(this, function(response){
            let state = response.getState();
            if (component.isValid() && state == "SUCCESS") {
                 component.set("v.popFlavorWrappers", response.getReturnValue());
            }
        });
        $A.enqueueAction(getterAction);
	},
    
    allFlavorsHelper : function(component) {
		let getterAction = component.get("c.allFlavorWrappers");
        getterAction.setCallback(this, function(response){
            let state = response.getState();
            if (component.isValid() && state == "SUCCESS") {
                 component.set("v.allFlavorWrappers", response.getReturnValue());
            }
        });
        $A.enqueueAction(getterAction);
	}
})