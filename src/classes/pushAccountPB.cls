public class pushAccountPB {
    // Example Invocable method that can be executed by Process Builer to insert into external object
    // 1) In Process Builder, create an "Apex Action".
    // 2) Under "Apex Class", select/enter this class
    // 3) Under "Set Apex Variables", select the parameter name ids as the "Field", Reference as the "Type", and  "Account_Id" as the Value. 
    @InvocableMethod(label='Copy2ExternalOrg' description='Copies newly created record to Org1')
    public static void inactivatePortalUsers(List<Id> ids) {
        callFuture(ids);
    }
    
    @future
    public static void callFuture(List<Id> ids) {
        Account acct = [SELECT Name FROM Account WHERE Id = :ids[0]];
        Account__x ax = new Account__x(); 
        ax.Name__c = acct.Name;
        
        Database.SaveResult sr = Database.insertAsync(ax);
        //Add Error Handling 
    }




    
    
}