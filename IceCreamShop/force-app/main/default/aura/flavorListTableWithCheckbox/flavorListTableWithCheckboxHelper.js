({
    scoopNumber: 0,
    flavorId: '',
    flavorNumSelected: 0,
    noveltyId: '',
  
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
            this.flavorId = flavor[0].Id;
            this.flavorNumSelected = flavor.length;     
        }
    },

    setNovelty : function(selected)
    {
        if (selected != '')
        {
            this.noveltyId = selected; 
        }
    },

    createRecord : function(cmp)
    {
       if(this.scoopNumber > 0 && this.flavorId != '' 
           && this.flavorNumSelected == 1 && this.noveltyId != '')
       {
            let call = cmp.get("c.saveNewOrder");
      
            call.setParams({"numScoops": this.scoopNumber, 
                           "flavId": this.flavorId, "noveltyId": this.noveltyId});
            call.setCallback(this, function(response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    var ret = response.getReturnValue()
                    cmp.set('v.total', ret);
                    alert('Order placed, please arrive in 15 minutes. With the total of: $' + ret);
                }
            });
            $A.enqueueAction(call);
                 
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
        let actionFlavors = component.get("c.getFlavorsForAura");
        actionFlavors.setParams({
        });

        actionFlavors.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.recordData", response.getReturnValue());
            }
        });
        $A.enqueueAction(actionFlavors);
    },

    setRadioButtonsForDish : function(component)
    {
        let action = component.get("c.getNoveltiesForAura");
        action.setParams({
        });

        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {

                var nov = []; 
                let result = response.getReturnValue();
                Object.keys(result).forEach(function(key) 
                {
                    var list =result[key];
                    nov.push({label: list.Name, value: list.Id});
                });
                component.set("v.options", nov);
            }
        });
        $A.enqueueAction(action);
    }

})