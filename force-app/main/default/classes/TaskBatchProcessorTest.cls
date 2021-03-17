@isTest
private class TaskBatchProcessorTest {    
	@testSetup
    static void initData() {
       List<Account> accounts = TestDataFactory.createAccounts(100, 'BatchAccount');
       insert accounts;
	}
    @isTest
    static void testBatch() {
        Test.startTest();
        TaskBatchProcessor batch = new TaskBatchProcessor();
        Database.executeBatch(batch);
        Test.stopTest();
        List<String> owners = new List<String>();
        List<Account> accounts = [SELECT Name, Owner.Name FROM Account WHERE Name LIKE 'BatchAccount%'];
        for (Account account : accounts) {
            system.debug('name: ' + account.Name);
        }
        system.debug('Accounts size: ' + accounts.size());
        for (Account account : accounts) {
            owners.add(account.Owner.Name);
        } 
        system.debug(owners.size());
        Integer ownerTaskNumber = [SELECT COUNT() FROM Task WHERE Account_Owner__c IN :owners];
        Integer syncedTaskNumber = [SELECT COUNT() FROM Task WHERE Is_Synced__c = TRUE];
        Integer updAccountNumber = [SELECT COUNT() FROM Account WHERE Updated_By_Task__c = TRUE];
        System.assertEquals(100, ownerTaskNumber);
        System.assertEquals(100, syncedTaskNumber);
        System.assertEquals(100, updAccountNumber);        
    }
}