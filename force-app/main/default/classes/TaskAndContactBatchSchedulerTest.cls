@isTest
private class TaskAndContactBatchSchedulerTest {
    public static String CRON_EXP = '0 30 * * * ?';    
    @testSetup
    static void initData() {
        List<Account> accounts = TestDataFactory.createAccounts(2, 'BatchTestAccount');
        insert accounts;
        List<Task> tasks = new List<Task>();
        for (Account account : accounts) {
            tasks.addAll(TestDataFactory.createTasks(1, account.Id));
        }  
        Test.startTest();
        insert tasks;
        Test.stopTest();
    }
    static testmethod void testScheduledJob() {
        List<Account> accounts = [SELECT Id, Name FROM Account WHERE Name LIKE 'BatchTestAccount%'];
        Map<Id, Account> accountMap = new Map<Id, Account>(accounts);
        List<Id> accountsIds = new List<Id>(accountMap.keySet());
        Test.startTest();
        String jobId = System.schedule('ScheduleApexTest', CRON_EXP, new TaskAndContactBatchScheduler());
        Test.stopTest();
        List<Task> tasks = [SELECT Id, Is_Synced__c FROM Task WHERE WhatId IN :accountsIds AND Is_Synced__c = true];
        System.assertEquals(accountsIds.size(), tasks.size());
    }

}