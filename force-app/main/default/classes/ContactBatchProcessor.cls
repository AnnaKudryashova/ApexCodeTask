public with sharing class ContactBatchProcessor implements Database.Batchable<Contact>, Database.Stateful {

    public Integer recordsProcessed = 0;
    
    public Iterable<Contact> start(Database.BatchableContext context) {
        return [SELECT AccountId, MailingStreet, MailingCity, MailingPostalCode, MailingState, MailingCountry, Is_Synced__c FROM Contact WHERE Is_Synced__c = false AND AccountId != Null];
    }
    
    public void execute(Database.BatchableContext context, List<Contact> contacts) {
        List<Id> accountIds = new List<Id>();
        for (Contact contact: contacts) {
            accountIds.add(contact.AccountId);
        }
        List<Account> accounts = [SELECT BillingStreet, BillingCity, BillingPostalCode, BillingState, BillingCountry, Updated_By_Contact__c FROM Account WHERE Id IN :accountIds];
        Map<Id, Account> accountsMap = new Map<Id, Account>();
        for (Account account : accounts) {
            accountsMap.put(account.Id, account);
        }
        for (Contact contact : contacts) {
            Account account = accountsMap.get(contact.AccountId);
            contact.MailingStreet = account.BillingStreet;
            contact.MailingCity = account.BillingCity;
            contact.MailingPostalCode = account.BillingPostalCode;
            contact.MailingState = account.BillingState;
            contact.MailingCountry = account.BillingCountry;
            contact.Is_Synced__c = true;
            account.Updated_By_Contact__c = true;
            recordsProcessed++;
        }
        update contacts;
        update accountsMap.values();
    }
     
    public void finish(Database.BatchableContext context) {
        System.debug(recordsProcessed  + ' contact records were processed');    
    }
}