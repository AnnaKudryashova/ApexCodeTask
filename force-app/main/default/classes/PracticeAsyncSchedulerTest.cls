@isTest
private class PracticeAsyncSchedulerTest {
    public static String CRON_EXP = '0 15 * * * ?';    
    @testSetup
    static void initData() {
        List<Account> accounts = TestDataFactory.createAccounts(2, 'PracticeFutureTest');
        insert accounts;
        List<Contact> contacts = new List<Contact>();
        for (Account account : accounts) {
            contacts.addAll(TestDataFactory.createContacts(1, account.Id));
        }  
        Test.startTest();
        insert contacts;
        Test.stopTest();
    }
    static testmethod void testScheduledJob() {
        List<Account> accounts = [SELECT Id, Name FROM Account WHERE Name LIKE 'PracticeFutureTest%'];
        Map<Id, Account> accountMap = new Map<Id, Account>(accounts);
        List<Id> accountsIds = new List<Id>(accountMap.keySet());
        Test.startTest();
        String jobId = System.schedule('ScheduleApexTest', CRON_EXP, new PracticeAsyncScheduler());
        Test.stopTest();
        List<Contact> contacts = [SELECT Id, Is_Synced__c FROM Contact WHERE AccountId IN :accountsIds AND Is_Synced__c = true];
        System.assertEquals(accountsIds.size(), contacts.size());
    }
}