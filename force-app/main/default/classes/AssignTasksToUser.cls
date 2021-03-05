public class AssignTasksToUser {
    @InvocableMethod
    public static void assignTasks(List<Id> accountIds) {     
        Account[] accounts = [Select Id, Name from Account Where Account.id in :accountIds];
        Task[] tasks = [Select WhatId from Task where WhatId in :accountIds];
        if(tasks.size() > 3) {
            User[] userList = [SELECT Id, Name FROM User WHERE isActive = true];
            Integer randomNumber =  math.round(math.random()*userList.size());
            User user = userList[randomNumber];
            for (Task task : tasks) {
                   task.OwnerId =  user.id;
                   task.subject = 'Task for: ' + randomNumber + ' ' + user.Name + ' ' + user.id;
           }
           update tasks;
       }
    }
}
