({
    init: function (cmp, event, helper) 
	{

		helper.getFlavorRecordsAndSetToTable(cmp);
		
	},

	getSelectedFlavor: function (cmp, event) 
	{
		var selectedFlavorRow = event.getParam('selectedRows');
		// Display that fieldName of the selected rows
		for (var i = 0; i < selectedFlavorRow.length; i++)
		{
			alert("You selected: " + selectedFlavorRow[0].Name);
		}
	},

	onChange: function (cmp, evt, helper) {
        alert(cmp.find('select').get('v.value') + ' pie is good.');
    }	
})