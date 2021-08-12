({
    init: function (cmp, event, helper) 
	{
		helper.getFlavorRecordsAndSetToTable(cmp);
		helper.setRadioButtonsForDish(cmp);
	},

	getSelectedFlavor: function (component, event, helper) 
	{
        let params = event.getParam('arguments');
        if (params) {
            let Id = params.Id;
            helper.setSelectedFlavor(Id); 
        }
	},

	selectedScoopNum: function (cmp, evt, helper) 
	{
		helper.setScoopNumber(cmp.find('select').get('v.value'));
    },

	buttonClickHandler : function(cmp, event, helper)
	{
	//	alert('click'); 
		helper.createRecord(cmp); 
	},

	radioHandler : function(cmp, event, helper)
	{
		//alert(event.getParam("value"));
		helper.setNovelty(event.getParam("value")); 
	}
})