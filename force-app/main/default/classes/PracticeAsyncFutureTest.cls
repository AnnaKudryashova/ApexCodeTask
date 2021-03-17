@isTest
private class PracticeAsyncFutureTest {
	@testSetup
    static void initData() {
        List<Account> accounts = TestDataFactory.createAccounts(200, 'PracticeFutureTest');
        insert accounts;
        List<Contact> contacts = new List<Contact>();
        for (Account account : accounts) {
            contacts.addAll(TestDataFactory.createContacts(1, account.Id));
        }  
        Test.startTest();
        insert contacts;
        Test.stopTest();
    }
    @isTest
    static void testUpdateContacts() {
        List<Account> accounts = [SELECT Id FROM Account LIMIT 150];
        List<Contact> contacts = [SELECT Id, Is_Synced__c, Processed_By_Future__c FROM Contact WHERE AccountId IN :accounts];
        Test.startTest();
        PracticeAsyncFuture.updateContacts();
        Test.stopTest();
        List<Contact> processedByFutureContacts = [SELECT Name FROM Contact WHERE Processed_By_Future__c = TRUE AND Is_Synced__c = FALSE];
         System.assertEquals(150, processedByFutureContacts.size());
    }
}