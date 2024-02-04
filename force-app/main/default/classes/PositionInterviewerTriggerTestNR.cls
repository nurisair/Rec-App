@isTest
public with sharing class PositionInterviewerTriggerTestNR {
    @isTest
    public static void dublicateCheck(){
        List<Position_Interviewer__c> listInter = new List<Position_Interviewer__c>();
        List<Position__c> posList = new List<Position__c>();
        List<Interviewer__c> intList = new List<Interviewer__c>();

        HR_Manager__c manager1 = new HR_Manager__c(Name='TestManager', Email__c='t@g.com', Phone__c='873468976');
        insert manager1;

        Position__c p1 = new Position__c(HR_Manager__c= manager1.Id, Name__c='P1', Start_Date_Time__c = DateTime.now());
        Position__c p2 = new Position__c(HR_Manager__c= manager1.Id, Name__c='P2', Start_Date_Time__c = DateTime.now());
        posList.add(p1);
        posList.add(p2);
        insert posList;

        Interviewer__c int1 = new Interviewer__c(Name='Int1', Email__c='t1@g.com', Phone__c='234567');
        Interviewer__c int2 = new Interviewer__c(Name='Int2', Email__c='t2@g.com', Phone__c='467453');
        intList.add(int1);
        intList.add(int2);
        insert intList;


        Position_Interviewer__c pi1 = new Position_Interviewer__c(Position__c=p1.Id, Interviewer__c=int1.Id);
        Position_Interviewer__c pi2 = new Position_Interviewer__c(Position__c=p2.Id, Interviewer__c=int2.Id);
        listInter.add(pi1);
        listInter.add(pi2);

        Test.startTest();        

        insert listInter;
    
        Position_Interviewer__c pi3 = new Position_Interviewer__c(Position__c=p1.Id, Interviewer__c=int1.Id);
        try {
            insert pi3; // This should fail due to the validation rule
            System.assert(false, 'The record should not have been saved');
        } catch (DmlException e) {
            System.assert(e.getMessage().contains('This Interviewer is already associated with this position. An Interviewer cannot register for the same Position twice!'), 'Incorrect error message');
        }

        Test.stopTest();
        
        System.assertEquals(2, listInter.size());
    }
}