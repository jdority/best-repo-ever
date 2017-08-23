({
    doInit : function(component, event, helper) {

        // Prepare the action to load account record
        var action = component.get("c.getAccount");
        action.setParams({"accountId": component.get("v.recordId")});

        // Configure response handler
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(state === "SUCCESS") {
                component.set("v.account", response.getReturnValue());
            } else {
                console.log('Problem getting account, response state: ' + state);
            }
        });
        $A.enqueueAction(action);
    },

    handleSaveAccount: function(component, event, helper) {
        if(helper.validateAccountForm(component)) {
            
            // Prepare the action to create the new account
            var saveAccountAction = component.get("c.saveAccount");
            saveAccountAction.setParams({
                "Account__x": component.get("v.newAccount__x"),   //case sensitive "A"
                "accountId": component.get("v.recordId")
            });

            // Configure the response handler for the action
            saveAccountAction.setCallback(this, function(response) {
                var state = response.getState();
                if(state === "SUCCESS") {

                    // Prepare a toast UI message
                    var resultsToast = $A.get("e.force:showToast");
                    resultsToast.setParams({
                        "title": "Account Copy:",
                        "message": "Account Successfully Copied to Org1."
                    });

                    // Update the UI: close panel, show toast, refresh account page
                    $A.get("e.force:closeQuickAction").fire();
                    resultsToast.fire();
                    $A.get("e.force:refreshView").fire();
                }
                else if (state === "ERROR") {
                    console.log('Problem saving Account to Org1, response state: ' + state);
                }
                else {
                    console.log('Unknown problem, response state: ' + state);
                }
            });

            // Send the request to insert record in external org
            $A.enqueueAction(saveAccountAction);
        }
        
    },

	handleCancel: function(component, event, helper) {
	    $A.get("e.force:closeQuickAction").fire();
    }})