({
    
    reportRequiredFieldValidity: function (component) {
        component.find("firstNameIn").reportValidity();
        component.find("lastNameIn").reportValidity();
        component.find("emailIn").reportValidity();
    }
})