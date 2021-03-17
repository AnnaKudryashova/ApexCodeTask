@isTest
private class PracticeAsyncQueueTest {
    @testSetup
    static void initData() {
        List<Account> accounts = TestDataFactory.createAccounts(50, 'QueueAccount');
        insert accounts;
        List<Contact> contacts = new List<Contact>();
        for (Account account : accounts) {
            contacts.addAll(TestDataFactory.createContacts(2, account.Id));
        }  
        Test.startTest();
        insert contacts;
        Test.stopTest();
    }
    @isTest
    static void testUpdateContacts() {
        List<Account> accounts = [SELECT Id FROM Account WHERE Name LIKE 'QueueAccount%'];
        List<Contact> contacts = [SELECT Id, Is_Synced__c, Processed_By_Future__c FROM Contact WHERE AccountId IN :accounts];
        Test.startTest();
        System.enqueueJob(new PracticeAsyncQueue());
        Test.stopTest();
        List<Contact> processedByQueueContacts = [SELECT Name FROM Contact WHERE Processed_By_Queue__c = TRUE AND Is_Synced__c = FALSE];
        System.assertEquals(100, processedByQueueContacts.size());        
    }
}