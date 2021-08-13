({  
    allFlavorsHelper : function(component) {
		let getterAction = component.get("c.getAllWrappers");
        getterAction.setCallback(this, function(response){
            let state = response.getState();
            if (component.isValid() && state == "SUCCESS") {
                 component.set("v.allFlavorWrappers", response.getReturnValue());
            }
        });
        $A.enqueueAction(getterAction);
	},
    
    setFlavorHelper : function(component, event) {
        let flavor = event.getSource().get("v.value");
        let orderComponent = component.find("orderComponent");
        let allergyComponent = component.find("allergyComponent");
        orderComponent.setFlavorId(flavor.Id);
        allergyComponent.setFlavor(flavor.Name);
    }
})