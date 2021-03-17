@isTest
private class AccountTriggerTest {
    @testSetup
    static void initData() {
        List<Account> accounts = TestDataFactory.createAccounts(50, 'TestAccount');
        insert accounts;
        system.debug('Number of accounts: ' + accounts.size()); // 50
        List<Task> tasks = new List<Task>();
        List<Contact> contacts = new List<Contact>();
        for (Account account : accounts) {
            tasks.addAll(TestDataFactory.createTasks(5, account.Id));
            contacts.addAll(TestDataFactory.createContacts(2, account.Id));
        }  
        system.debug('Number of tasks: ' + tasks.size()); // 250
        system.debug('Number of contacts: ' + contacts.size()); // 100
        Test.startTest();
        insert tasks;
        insert contacts;
        Test.stopTest();
    }
    
    @isTest
    static void testCreateTask() {
        List<Task> tasks = [SELECT WhatId, Subject, Is_Synced__c FROM Task WHERE Subject LIKE 'Negotiations with TestAccount%'];
        system.debug('Number of tasks from insert: ' + tasks.size()); // 100
        Boolean Is_Synced = false;
        for (Task task : tasks) {
            if (task.Is_Synced__c) {
                Is_Synced = true;
            }
        }
        System.assertEquals(false, Is_Synced);
        System.assertEquals(50, tasks.size());      
    }
    
    @isTest
    static void testUpdateContacts() {
        List<Account> accounts = [SELECT Id, BillingStreet FROM Account LIMIT 30];
        Test.startTest();
        for (Integer i=0; i<30; i++) {
            accounts[i].BillingStreet = 'Updated Street';           
        }
        update accounts;
        Test.stopTest();
        List<Contact> processedByFutureContacts = [SELECT Name FROM Contact WHERE Processed_By_Future__c = TRUE AND Is_Synced__c = FALSE];
        List<Contact> processedByQueueContacts = [SELECT Name FROM Contact WHERE Processed_By_Queue__c = TRUE AND Is_Synced__c = FALSE];
        System.assertEquals(60, processedByFutureContacts.size());
        System.assertEquals(60, processedByQueueContacts.size());            
    }
}