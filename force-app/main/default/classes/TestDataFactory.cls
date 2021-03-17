@isTest
public class TestDataFactory {
    
    public static List<Account> createAccounts(Integer numAccts, String name) {
        List<Account> accounts = new List<Account>();
        for (Integer i=0; i<numAccts; i++) {
            Account account  = new Account(Name=name + i, BillingStreet = 'TestBillingStreet '+i,
                                          BillingCity = 'TestBillingCity '+i,
                                          BillingPostalCode = 'TestBillingPCode '+i,
                                          BillingState = 'TestBillingState '+i,
                                          BillingCountry = 'TestBillingCountry '+i);
            accounts.add(account);
        }
        return accounts;      
    }
    
    public static List<Task> createTasks(Integer numTasks, Id whatId) {
        List<Task> tasks = new List<Task>();
        for (Integer i=0; i<numTasks; i++) {
            Task task = new Task(Whatid = whatId);
            tasks.add(task);
        }
        return tasks;
    }
    
    public static List<Contact> createContacts(Integer numContacts, Id accountId) {
        List<Contact> contacts = new List<Contact>();
        for (Integer i=0; i<numContacts; i++) {
            Contact contact = new Contact(LastName = 'TestName ' + i, AccountId = accountId,
                                         MailingStreet = 'TestMailingStreet ' + i,
                                         MailingCity = 'TestMailingCity ' + i,
                                         MailingPostalCode = 'TestMailingPCode ' + i,
                                         MailingState = 'TestMailingState ' + i,
                                         MailingCountry = 'TestMailingCountry ' + i);
            contacts.add(contact);
        }
       return contacts;
    }
}