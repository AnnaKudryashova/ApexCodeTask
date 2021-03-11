public with sharing class ContactsQueueable implements Queueable {
    private List<Id> ids;
    
    public ContactsQueueable(List<Id> ids) {
        this.ids = ids;
    }
    
    public void execute(QueueableContext context) {
        List<Contact> contacts = [SELECT Is_Synced__c, Processed_By_Queue__c FROM Contact WHERE AccountId IN :ids];
        if (!contacts.isEmpty()) {
            for (Contact contact : contacts) {
                contact.Is_Synced__c = false;
                contact.Processed_By_Queue__c = true;
            }
            update contacts;
        }
    }
}