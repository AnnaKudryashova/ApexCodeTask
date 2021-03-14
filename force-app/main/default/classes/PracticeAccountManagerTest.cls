@IsTest
private class PracticeAccountManagerTest {
    @isTest static void testGetAccountById() {
        Id recordId = createTestRecord();
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://yourInstance.salesforce.com/services/apexrest/Cases/'
            + recordId;
        request.httpMethod = 'GET';
        RestContext.request = request;
        Account thisAccount = PracticeAccountManager.getAccountById();
        System.assert(thisAccount != null);
        System.assertEquals('From Test', thisAccount.Name);
    }
    @isTest static void testCreateAccount() {
        ID thisAccountId = PracticeAccountManager.createAccount('Test Squirrel');
        System.assert(thisAccountId != null);
        Account thisAccount = [SELECT Id, Name FROM Account WHERE Id = :thisAccountId];
        System.assert(thisAccount != null);
        System.assertEquals(thisAccount.Name, 'Test Squirrel');
    }
    @isTest static void testDeleteAccount() {
        Id recordId = createTestRecord();
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://yourInstance.salesforce.com/services/apexrest/Cases/'
            + recordId;
        request.httpMethod = 'GET';
        RestContext.request = request;
        PracticeAccountManager.deleteAccount();
        List<Account> accounts = [SELECT Id FROM Account WHERE Id = :recordId];
        System.assert(accounts.size() == 0);
    }
    @isTest static void testUpsertAccount() {
        // insert new record
        ID account1Id = PracticeAccountManager.upsertAccount('Test Squirrel', null);
        System.assert(account1Id != null);
        Account account1 = [SELECT Id, Name FROM Account WHERE Id = :account1Id];
        System.assert(account1 != null);
        System.assertEquals(account1.Name, 'Test Squirrel');
        // update name of existing account
        ID account2Id = PracticeAccountManager.upsertAccount('Test Chipmunk', account1Id);
        System.assertEquals(account1Id, account2Id);
        Account account2 = [SELECT Id, Name FROM Account WHERE Id = :account2Id];
        System.assert(account2 != null);
        System.assertEquals(account2.Name, 'Test Chipmunk');
    }
    @isTest static void testUpdateAccountFields() {
        Id recordId = createTestRecord();
        RestRequest request = new RestRequest();
         request.requestUri =
            'https://yourInstance.salesforce.com/services/apexrest/Cases/'
            + recordId;
        request.httpMethod = 'PATCH';
        request.addHeader('Content-Type', 'application/json');
        request.requestBody = Blob.valueOf('{"Active__c": "yes"}');
        RestContext.request = request;
        ID thisAccountId = PracticeAccountManager.updateAccountFields();
        System.assert(thisAccountId != null);
        Account thisAccount = [SELECT Id, Active__c FROM Account WHERE Id = :thisAccountId];
        System.assert(thisAccount != null);
        System.assertEquals(thisAccount.Active__c, 'Yes');   
    }   
    // Helper method
    static Id createTestRecord() {
        Account accountTest = new Account(
        	Name = 'From Test', Active__c = 'yes');
        insert accountTest;
        return accountTest.Id;
    }
}