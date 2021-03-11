public with sharing class PracticeAsyncQueryBatch implements Database.Batchable<SObject>, Database.Stateful {

    public Integer recordsProcessed = 0;
    
    public Database.QueryLocator start(Database.BatchableContext context) {
        return Database.getQueryLocator('SELECT Is_Synced__c, AccountId, MailingStreet, MailingCity, ' +
                                        'MailingPostalCode, MailingState, MailingCountry FROM Contact ' +
                                          'WHERE Is_Synced__c = false AND AccountId != null');
    }
    
    public void execute(Database.BatchableContext context, List<Contact> contacts) {
        List<Id> accountIds = new List<Id>();
        for (Contact contact : contacts) {
            accountIds.add(contact.AccountId);        
        }
        List<Account> accountList = [SELECT BillingStreet, BillingCity, BillingPostalCode, BillingState, BillingCountry
                                     FROM Account WHERE Id IN :accountIds];
        Map<Id, Account> accountMap = new Map<Id, Account>();
        for (Account account : accountList) {
            accountMap.put(account.Id, account);
        }
        for (Contact contact : contacts) {
            Account account = accountMap.get(contact.AccountId);
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
    }
    
    public void finish(Database.BatchableContext context) {
        System.debug(recordsProcessed + ' contact records were processed');
    }   
}