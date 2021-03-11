trigger ForceActive on Account (after insert, after update) {    
    if (Trigger.isInsert && Trigger.isAfter) {
        AccountTriggerHandler.handleAfterInsert(Trigger.newMap);                                  
    }
    if (Trigger.isUpdate && Trigger.isAfter) {
        AccountTriggerHandler.handleAfterUpdate(Trigger.oldMap, Trigger.newMap);
    }
}