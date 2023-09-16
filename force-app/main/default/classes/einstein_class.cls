trigger ContactCountTrigger on Account (after insert, after update, after delete) {
    if (Trigger.isAfter) {
        List<Account> accounts = new List<Account>();
        if (Trigger.isInsert || Trigger.isUpdate) {
            for (Contact c : Trigger.new) {
                accounts.add(new Account(Id = c.AccountId, Contact_Count__c = 0));
            }
        }
        if (Trigger.isDelete) {
            for (Contact c : Trigger.old) {
                accounts.add(new Account(Id = c.AccountId, Contact_Count__c = 0));
            }
        }
        List<AggregateResult> results = [SELECT AccountId, COUNT(Id) ContactCount FROM Contact WHERE AccountId IN :accounts WITH USER_MODE GROUP BY AccountId];
        for (AggregateResult result : results) {
            Id accountId = (Id)result.get('AccountId');
            Integer contactCount = (Integer)result.get('ContactCount');
            for (Account account : accounts) {
                if (account.Id == accountId) {
                    account.Contact_Count__c = contactCount;
                }
            }
        }
        update accounts;
    }
}public with sharing class einstein_class {
    public einstein_class() {

    }
}