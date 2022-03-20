({
    doInit : function(component) {        
        var pickvar = component.get("c.getPickListValuesIntoList");
        pickvar.setCallback(this, function(response) {
            var state = response.getState();
            if(state === 'SUCCESS'){
                var list = response.getReturnValue();
                component.set("v.picvalue", list);
            }
            else if(state === 'ERROR'){
                //var list = response.getReturnValue();
                //component.set("v.picvalue", list);
                alert('ERROR OCCURED.');
            }
        })
        $A.enqueueAction(pickvar);
    },
    go : function(component){
        var cvar = component.get("v.aname");
        var action = component.get("c.insertValues");
        action.setParams({acc: cvar});
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(state === 'SUCCESS'){
            var list1 = response.getReturnValue();
            //component.set("v.picklistValues", list);
            alert('Record Created Successfully '+list1);
            }
            else if(state === 'INCOMPLETE'){
                alert('Something is missing');   
            }
            else if(state === 'ERROR'){
                alert('Insertion Failed siva');   
            }
        })
        $A.enqueueAction(action);
    }
})