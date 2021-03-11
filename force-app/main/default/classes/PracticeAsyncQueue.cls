public with sharing class PracticeAsyncQueue implements Queueable {
    
    public void execute(QueueableContext context) {
        List<Account> accounts = [SELECT Id FROM Account 
                                  WHERE BillingStreet != null 
                                    OR BillingCity != null 
                                    OR BillingPostalCode != null 
                                    OR BillingState != null 
                                    OR BillingCountry != null];
                                        
         if (!accounts.isEmpty()) {
             List<Contact> contacts = [SELECT Id, Is_Synced__c, Processed_By_Queue__c 
                                       FROM Contact
                                       WHERE AccountId IN :accounts];
             for (Contact contact : contacts) {
                 contact.Is_Synced__c = false;
                 contact.Processed_By_Queue__c = true;
             }
             update contacts;
         }   
    }
}