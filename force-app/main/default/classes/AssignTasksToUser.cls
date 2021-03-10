public with sharing class AssignTasksToUser {
    @InvocableMethod
    public static void assignTasks(List<Account> accounts) {
        List<Task> taskList = [SELECT WhatId FROM Task];
        User[] userList = [SELECT Id, Name FROM User WHERE isActive = true];
        for (Account account : accounts) {
                List<Task> accountsTasks = new List<Task>();    
                for (Task task : taskList) {
                    if (task.WhatId == account.Id) {
                        accountsTasks.add(task);
                    }             
                }
                if (accountsTasks.size() > 3) {
                    Integer randomNumber =  math.round(math.random()*userList.size());
                    User user = userList[randomNumber];
                    for (Task task : accountsTasks) {
                           task.OwnerId =  user.id;
                           task.subject = 'Task for: ' + randomNumber + ' ' + user.Name + ' ' + user.id;
                    }
                update accountsTasks;
                }            
        }
    }
}