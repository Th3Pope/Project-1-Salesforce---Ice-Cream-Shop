({
	getInfoHelper : function(component, event) {
		       
        let params = event.getParam('arguments');
        if (params) {
            let flavorName = params.flavorName;
            let queryTerm = component.get('c.testString2');
            
            queryTerm.setParams({search : flavorName});
            queryTerm.setCallback(this, function(response){
            	console.log(response.getReturnValue());
            	if(response.getState() == "SUCCESS"){
                	component.set("v.flavor", response.getReturnValue());
            	}
        	});
            
            $A.enqueueAction(queryTerm);
        }
	}
})