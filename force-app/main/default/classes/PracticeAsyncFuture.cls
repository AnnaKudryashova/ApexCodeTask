public with sharing class PracticeAsyncFuture {
    @future
    public static void updateContacts() {
        List<Account> accounts = [SELECT Id, BillingAddress FROM Account LIMIT 150];
        List<Account> accountsWithBillingAddress = new List<Account>();
        for (Account account : accounts) {
            if (account.BillingAddress != null) {
                accountsWithBillingAddress.add(account);    
            }
        }
        List<Contact> contacts = [SELECT Id, Is_Synced__c, Processed_By_Future__c FROM Contact WHERE AccountId IN :accountsWithBillingAddress];
        for (Contact contact : contacts) {
            contact.Is_Synced__c = false;
            contact.Processed_By_Future__c = true;
        }
        update contacts;
    }
}