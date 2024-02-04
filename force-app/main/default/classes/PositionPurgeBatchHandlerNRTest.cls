@isTest
public with sharing class PositionPurgeBatchHandlerNRTest {
    @TestSetup
    static void makeData(){
        //create Positions to fit this query; [SELECT Id, Live__c, End_Date_Time__c FROM Position__c WHERE Live__c=false AND End_Date_Time__c > LAST_N_MONTHS:2]

        list<HR_Manager__c> HRManList = new list<HR_Manager__c>();
        for (Integer i = 0; i < 5; i++) {
            HR_Manager__c h = new HR_Manager__c();
            h.Name='TestMan'+i;
            h.Email__c='test'+i+'@test.com';
            h.Phone__c='567890'+i;
            HRManList.add(h);
        }
        insert HRManList;

        List<Position__c> poslist = new List<Position__c>();
        for (Integer i = 0; i < 200; i++) {
            Position__c c=new Position__c();
            c.End_Date_Time__c = date.today().addMonths(2);
            c.Start_Date_Time__c = Date.today();
            c.Name__c='Test Position'+i;
            c.HR_Manager__c = HRManList.get(1).Id;
            poslist.add(c);
        }
        insert poslist;

    }
    @isTest
    public static void BatchPurgeTest() {
        test.startTest();
        PositionPurgeBatchNR pb = new PositionPurgeBatchNR();
        Database.executeBatch(pb, 300); 
        test.stopTest();
    }
}