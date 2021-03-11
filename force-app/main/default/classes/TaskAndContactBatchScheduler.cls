public with sharing class TaskAndContactBatchScheduler implements Schedulable {
    
    public void execute(SchedulableContext context) {          
            Database.executeBatch(new TaskBatchProcessor());
            Database.executeBatch(new ContactBatchProcessor());
    }
}