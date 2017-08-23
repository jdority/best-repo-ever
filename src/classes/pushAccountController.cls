public with sharing class pushAccountController {
    //class referenced by Lightning Component 
    @AuraEnabled
    public static Account getAccount(Id accountId) {
        return [SELECT Name FROM Account WHERE Id = :accountId];
    }
    
    @AuraEnabled
    public static Account saveAccount(Account acctx, Id accountId) {
        // can't name saveAccount__x
        // External objects are referenced as objectName__x
        // Must use Database method not insert
         
        Account acct = [SELECT Name FROM Account WHERE Id = :accountId];
        Account__x ax = new Account__x(); 
        ax.Name__c = acct.Name;
        Database.SaveResult sr = Database.insertAsync(ax);

        return acctx;
    }

}