({
    scoopNumber: 0,
    flavorName: '',
    flavorNumSelected: 0,

    setScoopNumber : function(num)
    {
        if(num != '')
        {
            this.scoopNumber = num;
        }          
    },

    setSelectedFlavor : function(flavor)
    {
        if(flavor != '')
        {
            this.flavorName = flavor; 
            this.flavorNumSelected = flavor.length;     
        }
    },

    createRecord : function()
    {
        if(this.scoopNumber > 0 && this.flavorName != '' 
            && this.flavorNumSelected == 1)
        {
            //call apex to create record
        }else
        {
            alert('Only one flavor may selected, number of scoops must be 1 or greater');
        }
    },

    

    getFlavorRecordsAndSetToTable : function(component) 
    {

        component.set('v.colLabels', [
            {label: 'Flavor Name', fieldName: 'Name', type: 'text'},
                {label: 'Price Per Scoop', fieldName: 'Sale_Price_Per_Scoop__c', type: 'currency'}
            ]);
        component.set('v.id', [{fieldName: 'Flavor_Index__c'}]);
        let action = component.get("c.getFlavorsForAura");
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