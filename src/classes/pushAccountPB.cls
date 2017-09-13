public class pushAccountPB {

    // invocable method that can be executed by Process Builer
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