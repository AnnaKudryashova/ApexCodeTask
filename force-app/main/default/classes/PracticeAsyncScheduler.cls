public with sharing class PracticeAsyncScheduler implements Schedulable {

    public void execute(SchedulableContext context) {
        Database.executeBatch(new PracticeAsyncQueryBatch());
        Database.executeBatch(new PracticeAsyncIterableBatch());
    }
}