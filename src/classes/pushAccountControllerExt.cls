public with sharing class pushAccountControllerExt {
    // Salesforce Classic.
    private ApexPages.StandardController standardController;
    
    public pushAccountControllerExt(ApexPages.StandardController standardController)
    {
        this.standardController = standardController;
    }
    
    public PageReference pushAccount() {
        // can't name saveAccount__x
        // External objects are referenced as objectName__x
        // Must use Database method not insert
        
        Id recordId = standardController.getId();
        Account acct = [SELECT Name FROM Account WHERE Id = :recordId];
        Account__x ax = new Account__x(); 
        ax.Name__c = acct.Name;
        Database.SaveResult sr = Database.insertAsync(ax);
        // SaveResult.isSuccess is always false because external objects DML are background jobs
        // backgroundoperation sObject allows for monitoring of insertAsync background job, but how is it used in this context?
        //  *** Additonal Error Handling would go here **
        
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Account Successfully Copied'));
        return null;
    }
    
}