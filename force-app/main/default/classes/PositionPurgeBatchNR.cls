public class PositionPurgeBatchNR implements Database.Batchable<sObject>{

    public Database.QueryLocator start(Database.BatchableContext BC){
        String query = 'SELECT Id, Live__c, End_Date_Time__c FROM Position__c WHERE Live__c=false AND End_Date_Time__c > LAST_N_MONTHS:2';
       
        return Database.getQueryLocator(query);
    }
    public void execute(Database.BatchableContext BC, List<Position__c> scope){
        if(!scope.isEmpty()){
            System.debug(scope.size() +' records have been deleted!');
            delete scope;
        }else {
            System.debug('No records to delete.');
        }
    }
    public void finish(Database.BatchableContext BC) {
        PositionPurgeBatchHandlerNR.PurgeEmail();

    }
}