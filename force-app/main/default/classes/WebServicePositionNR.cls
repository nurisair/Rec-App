@RestResource(urlMapping='/Position__c/*')
global with sharing class WebServicePositionNR {
 
    @HttpGet
    global static List<Position__c> getPosition() {
        
        return [SELECT Name__c, Start_Date_Time__c, LOCATION__c, End_Date_Time__c  
                FROM Position__c    
                WHERE Live__c = true AND Start_Date_Time__c >:date.Today() 
                WITH SECURITY_ENFORCED];
    }
}