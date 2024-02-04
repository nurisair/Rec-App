trigger PositionInterviewerTriggerNR on Position_Interviewer__c (before insert, before update) {
    
    if (trigger.isBefore) {
        PositionInterviewerTriggerHandlerNR.positionIntervieverCheck(trigger.new);
    }
    

}