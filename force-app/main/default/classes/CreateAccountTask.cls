public class CreateAccountTask {
    @InvocableMethod
    public static void createTask(List<Id> accountIds) {
        List<Task> tasks = new List<Task>();
        Task Tsk = new Task();
        Account[] account = [Select name from Account where Account.id in :accountIds];
        Tsk.Subject = 'Negotiations with ' + account[0].Name;
        Tsk.WhatId = account[0].ID;
        tasks.add(Tsk);
        insert tasks;
    }
}