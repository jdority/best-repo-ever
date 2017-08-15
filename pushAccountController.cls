public with sharing class pushAccountController {

    @AuraEnabled
    public static Account getAccount(Id accountId) {
        // Perform isAccessible() checks here
        return [SELECT Name FROM Account WHERE Id = :accountId];
    }
    
    @AuraEnabled
    public static Account saveAccount(Account acctx, Id accountId) {
        // cant name saveAccount__x
         
        Account acct = [SELECT Name FROM Account WHERE Id = :accountId];
        Account__x ax = new Account__x(); 
        ax.Name__c = acct.Name;
        Database.SaveResult sr = Database.insertAsync(ax);

        return acctx;
    }

}