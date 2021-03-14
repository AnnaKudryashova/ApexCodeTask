@isTest
global class AccountHttpCalloutMock implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json;charset=UTF-8');
        response.setBody('{"name" : "Wise Post Moose"}');
        response.setStatusCode(200);
        return response;
    }
}