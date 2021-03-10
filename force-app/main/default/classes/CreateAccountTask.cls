public with sharing class CreateAccountTask {
    @InvocableMethod
    public static void createTask(List<Account> accounts) {
        List<Task> tasks = new List<Task>();
        for (Account account : accounts) {
        Task newTask = new Task(Subject = 'Negotiations with ' + account.Name,
        WhatId = account.Id);
        tasks.add(newTask );
        }
        insert tasks;
    }
}