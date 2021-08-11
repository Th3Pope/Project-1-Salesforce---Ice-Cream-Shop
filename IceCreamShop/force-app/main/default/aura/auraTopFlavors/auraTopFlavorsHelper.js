({
	popFlavorsHelper : function(component) {
    	let getterAction = component.get("c.getPopWrappers");
        getterAction.setCallback(this, function(response){
            let state = response.getState();
            if (component.isValid() && state == "SUCCESS") {
                 component.set("v.popFlavorWrappers", response.getReturnValue());
            }
        });
        $A.enqueueAction(getterAction);
	},
    
    allFlavorsHelper : function(component) {
		let getterAction = component.get("c.getAllWrappers");
        getterAction.setCallback(this, function(response){
            let state = response.getState();
            if (component.isValid() && state == "SUCCESS") {
                 component.set("v.allFlavorWrappers", response.getReturnValue());
            }
        });
        $A.enqueueAction(getterAction);
	}
})