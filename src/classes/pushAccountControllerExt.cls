public with sharing class pushAccountControllerExt {

    private ApexPages.StandardController standardController;
 
    public pushAccountControllerExt(ApexPages.StandardController standardController)
    {
        this.standardController = standardController;
    }
    
    public PageReference pushAccount() {
        // can't name saveAccount__x
         
        Id recordId = standardController.getId();
        Account acct = [SELECT Name FROM Account WHERE Id = :recordId];
        Account__x ax = new Account__x(); 
        ax.Name__c = acct.Name;
        Database.SaveResult sr = Database.insertAsync(ax);

        return null;
    }

}