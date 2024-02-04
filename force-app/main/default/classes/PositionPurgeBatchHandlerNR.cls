public with sharing class PositionPurgeBatchHandlerNR {
   public static void PurgeEmail() {
        
    //Finding group members
    Set<Id> userIds = new set<id>();
    list<GroupMember> dailyJobGroup = [SELECT UserOrGroupId FROM GroupMember WHERE Group.Name = 'Daily Job'];
        for (GroupMember eaIds : dailyJobGroup) {
        userIds.add(eaIds.UserOrGroupId);
    }
    
    //getting group member emails
    Set<String> toAddresses = new Set<String>();
    for (User us : [SELECT Email FROM User WHERE IsActive = TRUE AND Id IN :userIds]) {
        toAddresses.add(us.Email);
    }
    //list<Messaging.SingleEmailMessage> msgs = new list<Messaging.SingleEmailMessage>();
    Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
    email.setToAddresses(new list<string> (toAddresses));
    email.setSubject('Daily Purge Update for Old Positions');
    email.setPlainTextBody('Daily Purge Completed!');
    //msgs.add(email);
    
    Messaging.sendEmail(new list<Messaging.SingleEmailMessage>{email}, false);
    }
}