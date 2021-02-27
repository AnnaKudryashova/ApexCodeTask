public class AssignTasksToUser {
    @InvocableMethod
    public static void assignTasks(List<Id> accountIds) {     
        Account[] accounts = [Select name from Account Where Account.id in :accountIds];
        Task[] tasks = [Select Id from Task where whatid in :accountIds];
        if(tasks.size() > 3) {
            User[] userList = [SELECT id FROM User];
            Integer randomNumber =  math.round(math.random()*userList.size());
            User user = [SELECT Id, Name FROM User WHERE isActive=true LIMIT:1 OFFSET:randomNumber];
            for (Task task : tasks) {
                   task.OwnerId =  user.id;
                   task.subject = 'Negotitaions with ' + accounts[0].name;
           }
           update tasks;
       }
    }
}