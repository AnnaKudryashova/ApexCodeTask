public with sharing class AccountTriggerHandler {
    public static void handleAfterInsert(Map<Id, Account> newMap) {
        AccountHelper.createTask(newMap.keySet());
    }
    public static void handleAfterUpdate(Map<Id, Account> oldMap, Map<Id, Account> newMap) {                                             
        AccountHelper.updateContacts(oldMap, newMap);
    }
}