public with sharing class TaskBatchProcessor implements Database.Batchable<sObject>, Database.Stateful {

    public Integer recordsProcessed = 0;
    
    public Database.QueryLocator start(Database.BatchableContext context) {
        return Database.getQueryLocator('SELECT WhatId, Is_Synced__c FROM Task WHERE Is_Synced__c = false AND WhatId != null');
    }
    
    public void execute(Database.BatchableContext context, List<Task> tasks) {
        List<Id> accountIds = new List<Id>();
        for (Task task : tasks) {
            accountIds.add(task.WhatId);
        }
        List<Account> accounts = [SELECT Owner.Name, Updated_By_Task__c FROM Account WHERE Id IN :accountIds];
        Map<Id, Account> accountsMap = new Map<Id, Account>();
        for (Account account : accounts) {
            accountsMap.put(account.Id, account);
        }
        for (Task task : tasks) {
            Account account = accountsMap.get(task.WhatId);
            task.Account_Owner__c = account.Owner.Name;
            task.Is_Synced__c = true;
            account.Updated_By_Task__c = true;
            recordsProcessed++;
        }
        update tasks;
        update accountsMap.values();
    }
     
    public void finish(Database.BatchableContext context) {
        System.debug(recordsProcessed  + ' task records were processed');    
    }
}