public class AddressVerificationCallOutNR {    
    
    @InvocableMethod(label='Verify Address' description='Verifies an address using SmartyStreets API')
    public static void verifyAddress(List<Id> Ids) {
        AddressVerifyFuture(Ids[0]);
    }
    @future(callout=true)
    public static void AddressVerifyFuture(Id LocId) {
            LOCATION__c loc = [SELECT Street__c, City__c, State__c, Postal_Code__c FROM LOCATION__c WHERE Id=:LocId];
            System.debug('Location is '+ loc);
            SmartyStreetCredentials__c authCr = SmartyStreetCredentials__c.getOrgDefaults();
            string endPoint = 'street-address?'
                                +'auth-token=' + authCr.Auth_Token__c
                                +'&auth-id=' + authCr.Auth_Id__c
                                +'&street='+EncodingUtil.urlEncode(loc.Street__c, 'UTF-8')
                                +'&city='+EncodingUtil.urlEncode(loc.City__c, 'UTF-8')
                                +'&state='+EncodingUtil.urlEncode(loc.State__c, 'UTF-8') 
                                +'&zipcode='+loc.Postal_Code__c
                                +'&match=enhanced&license=us-core-cloud';
            System.debug(endPoint);
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint('callout:Smarty_Street/'+endPoint);
            request.setMethod('GET');
            HttpResponse response = http.send(request);
            Boolean isTrue = response.getStatusCode() == 200;            
            LOCATION__c lc = new LOCATION__c();
            lc.Id = LocId;
            lc.Verified__c = isTrue;
        try {
            update lc;
        
        } catch (Exception ex) {
            ErrorLogHelperNR.createErrorLog('Verify Address', ex.getMessage());
        }
    }
}