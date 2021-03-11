public with sharing class AccountHelper {
    public static Boolean isDisabled = false;
    public static void createTask(Set<Id> ids) {
        if (!isDisabled) {
        createFutureTask(ids);
        isDisabled = true;
        }    
    }
    
    @future
    public static void createFutureTask(Set<Id> ids) {
        List<Task> tasks = new List<Task>();
        for (Account account : [SELECT Name FROM Account WHERE Id IN :ids]) {
            Task task = new Task(Subject = 'Negotiations with ' + account.Name,
                                 WhatId = account.Id,
                                 Is_Synced__c = false);
            tasks.add(task);
        }
        if (!tasks.isEmpty()) {
            insert tasks;
        }   
    }
        
    public static void updateContacts(Map<Id, Account> oldMap, Map<Id, Account> newMap) {
        List<Id> ids = new List<Id>();
        for (Account account : newMap.values()) {
            Account oldAccount = oldMap.get(account.id);
            if (account.BillingStreet != oldAccount.BillingStreet ||
                account.BillingCity != oldAccount.BillingCity ||
                account.BillingPostalCode != oldAccount.BillingPostalCode ||
                account.BillingState != oldAccount.BillingState ||
                account.BillingCountry != oldAccount.BillingCountry) {
                    ids.add(account.id);
                }        
        }
        if (!ids.isEmpty()) {
            updateFutureContacts(ids);
            System.enqueueJob(new ContactsQueueable(ids));         
        }
    }
     
    @future
    public static void updateFutureContacts(List<Id> ids) {
        if (!ids.isEmpty()) {
            List<Contact> contacts = [SELECT Is_Synced__c, Processed_By_Future__c FROM Contact WHERE AccountId IN :ids];
            for (Contact contact : contacts ) {
                contact.Is_Synced__c = false;
                contact.Processed_By_Future__c = true;
            }
            update contacts;
        }        
    }
}