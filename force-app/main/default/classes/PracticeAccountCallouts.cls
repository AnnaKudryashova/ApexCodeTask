public class PracticeAccountCallouts {
    private static String token = '00D09000007Fjz7!AR4AQHir77h_b1DGc2nSLltttwCQo3O1CukC1C.setAzhIc2XSCtrKnuN4vJ6kdZ1jpGGHYcSgXiUj_tdnQRRK.ETYl3nMM8';
    public static HttpResponse makeGetCallout(Id recordId) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://epam-e4-dev-ed.my.salesforce.com/services/apexrest/Accounts/' + recordId);
        request.setMethod('GET');
        request.setHeader('Authorization', 'Bearer ' + token);
        HttpResponse response = http.send(request);
        if (response.getStatusCode() != 200) {
            System.debug('The status code returned was not expected: ' + 
                        response.getStatusCode() + ' ' + response.getStatus());
        } else {
            System.debug(response.getBody());
        }
        return response;
    }
    public static HttpResponse makePostCallout() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://epam-e4-dev-ed.my.salesforce.com/services/apexrest/Accounts/');
        request.setMethod('POST');
        request.setHeader('Authorization', 'Bearer ' + token);
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody('{"name":"Wise Post Moose"}');
        HttpResponse response = http.send(request);
        if (response.getStatusCode() != 200) {
            System.debug('The status code returned was not expected: ' + 
                        response.getStatusCode() + ' ' + response.getStatus());
        } else {
            System.debug(response.getBody());
        }
        return response;
    }
    public static HttpResponse makeDeleteCallout(Id recordId) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();        
        request.setEndpoint('https://epam-e4-dev-ed.my.salesforce.com/services/apexrest/Accounts/' + recordId);
        request.setMethod('DELETE');
        request.setHeader('Authorization', 'Bearer ' + token);
        HttpResponse response = http.send(request);
        if (response.getStatusCode() != 200) {
            System.debug('The status code returned was not expected: ' + 
                        response.getStatusCode() + ' ' + response.getStatus());
        } else {
            System.debug(response.getBody());
        }
        return response;
    }
    public static HttpResponse makePutCallout(String name, String id) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://epam-e4-dev-ed.my.salesforce.com/services/apexrest/Accounts/');
        request.setMethod('PUT');
        request.setHeader('Authorization', 'Bearer ' + token);
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody('{"name": "' + name + '", "id": "' + id + '"}');
        HttpResponse response = http.send(request);
        if (response.getStatusCode() != 200) {
            System.debug('The status code returned was not expected: ' + 
                        response.getStatusCode() + ' ' + response.getStatus());
        } else {
            System.debug(response.getBody());
        }
        return response;
    }
    public static HttpResponse makePatchCallout(Id recordId) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://epam-e4-dev-ed.my.salesforce.com/services/apexrest/Accounts/' + recordId + '?_HttpMethod=PATCH');
        request.setMethod('POST');
        request.setHeader('Authorization', 'Bearer ' + token);
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody('{"name" : "Wise Post Moose"}');
        HttpResponse response = http.send(request);
         if (response.getStatusCode() != 200) {
            System.debug('The status code returned was not expected: ' + 
                        response.getStatusCode() + ' ' + response.getStatus());
        } else {
            System.debug(response.getBody());
        }
        return response;
    }
}