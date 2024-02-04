
public with sharing class ErrorLogHelperNR {

    public static void createErrorLog(String processName, String logDetails) {
        Error_Log__c eLog = new Error_Log__c();
        eLog.Process_Name__c=processName;
        eLog.Log_Details__c=logDetails;
        eLog.Log_Date_Time__c=DateTime.now();
        eLog.Apex_Class_Name__c=
        insert eLog;
    }
}