@isTest
private class PracticeAsyncIterableBatchTest {
	@testSetup
    static void initData() {
        List<Account> accounts = new List<Account>();
        List<Contact> contacts = new List<Contact>();
        for (Integer i=0;i<10;i++) {
            accounts.add(new Account(name='Account '+i,
                                    BillingCity='Moscow'));
        }
        system.debug('accounts size: ' + accounts.size());
        insert accounts;
        for (Account account : [SELECT Id FROM Account]) {
            contacts.add(new Contact(firstname='first',
                                     lastname='last',
                                     accountId=account.id,
                                     MailingCity='SPb', Is_Synced__c=false));
        }   
        system.debug('Account address: ' + [SELECT Id, BillingCity FROM Account LIMIT 1].BillingCity);
        insert contacts;
        system.debug('contacts size: ' + contacts.size());
        system.debug('Contact address: ' + [SELECT Id, MailingCity FROM Contact LIMIT 1].MailingCity);
    }
    @isTest
    static void testQueryBatch() {
        Test.startTest();
        PracticeAsyncIterableBatch iterableBatch = new PracticeAsyncIterableBatch();
        Id batchId = Database.executeBatch(iterableBatch);
        system.debug('Contact address before stop: ' + [SELECT Id, MailingCity FROM Contact LIMIT 1].MailingCity);
        system.debug('Account address before stop:: ' + [SELECT Id, BillingCity FROM Account LIMIT 1].BillingCity);
        Test.stopTest();
        system.debug('Contact address after stop: ' + [SELECT Id, MailingCity FROM Contact LIMIT 1].MailingCity);
        system.debug('Account address after stop:: ' + [SELECT Id, BillingCity FROM Account LIMIT 1].BillingCity);
        System.assertEquals(10, [SELECT count() FROM Contact WHERE MailingCity='Moscow']);   
    }
}