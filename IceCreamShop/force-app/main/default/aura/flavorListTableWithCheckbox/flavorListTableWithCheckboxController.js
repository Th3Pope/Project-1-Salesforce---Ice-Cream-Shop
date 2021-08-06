({
    init: function (cmp, event, helper) 
	{
		helper.getFlavorRecordsAndSetToTable(cmp);
	},

	getSelectedFlavor: function (cmp, event, helper) 
	{
		//var selectedFlavorRow = event.getParam('selectedRows');
		// Display that fieldName of the selected rows
		//for (var i = 0; i < selectedFlavorRow.length; i++)
		//{
		//	alert("You selected: " + selectedFlavorRow[0].Name + selectedFlavorRow[0].Flavor_Index__c);
		//}
		helper.setSelectedFlavor(event.getParam('selectedRows')); 
	},

	selectedScoopNum: function (cmp, evt, helper) 
	{
		helper.setScoopNumber(cmp.find('select').get('v.value'));
    },

	buttonClickHandler : function(cmp, event, helper)
	{
		helper.createRecord(); 
	}
})