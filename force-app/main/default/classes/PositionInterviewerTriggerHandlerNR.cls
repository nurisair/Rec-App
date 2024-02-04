public class PositionInterviewerTriggerHandlerNR {
    public static void positionIntervieverCheck(list<Position_Interviewer__c> triggerNew){
       
        for (Position_Interviewer__c newRecord : triggerNew) {
            // Query to check if a record with the same Interviewer and position exists
            List<Position_Interviewer__c> existingRecords = [
                SELECT Id FROM Position_Interviewer__c
                WHERE Interviewer__c = :newRecord.Interviewer__c 
                AND Position__c = :newRecord.Position__c
                AND Id != :newRecord.Id
                LIMIT 1
            ];
    
            // If an existing record is found, add an error to the new record
            if (!existingRecords.isEmpty()) {
                newRecord.addError('This Interviewer is already associated with this position. An Interviewer cannot register for the same Position twice!');
            }
        }

    }

}