({

    getFlavorRecordsAndSetToTable : function(component) {

        component.set('v.colLabels', [
            {label: 'Flavor Name', fieldName: 'Name', type: 'text'},
                {label: 'Price Per Scoop', fieldName: 'Sale_Price_Per_Scoop__c', type: 'currency'}
            ]);
        var action = component.get("c.getFlavorsForAura");
        action.setParams({
        });

        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.recordData", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    }

})