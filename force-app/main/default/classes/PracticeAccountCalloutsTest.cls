@isTest
private class PracticeAccountCalloutsTest {
    @isTest static void testGetCallout() {
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GetAccountResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        Test.setMock(HttpCalloutMock.class, mock);
        HttpResponse result = PracticeAccountCallouts.makeGetCallout('0010900000Bwz1LAAR');
        System.assertNotEquals(null, result, 'The callout returned a null response');
        System.assertEquals(200, result.getStatusCode(),
                           'The status code is not 200');
        System.assertEquals('application/json;charset=UTF-8',
                           result.getHeader('Content-Type'),
            			'The content type value is not expected.');
        
        Map<String, Object> results = (Map<String, Object>)JSON.deserializeUntyped(result.getBody());
        System.assertEquals('From Workbench Updated', results.get('Name'));
    }
    @isTest static void testPostCallout() {
        Test.setMock(HttpCalloutMock.class, new AccountHttpCalloutMock());
        HttpResponse response = PracticeAccountCallouts.makePostCallout();
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json;charset=UTF-8');
        String actualValue = response.getBody();
        String expectedValue = '{"name" : "Wise Post Moose"}';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, response.getStatusCode());
    }
    @isTest static void testDeleteCallout() {
        Test.setMock(HttpCalloutMock.class, new AccountHttpCalloutMock());
        HttpResponse response = PracticeAccountCallouts.makeDeleteCallout('0010900000Bwz4EAAR');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json;charset=UTF-8');
        System.assertEquals(200, response.getStatusCode());
    }
    @isTest static void testPutCallout() {
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GetAccountResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        Test.setMock(HttpCalloutMock.class, mock);
        HttpResponse result = PracticeAccountCallouts.makePutCallout('From Workbench Updated', '0010900000Bwz1LAAR');     
        System.assertNotEquals(null, result, 'The callout returned a null response');
        System.assertEquals(200, result.getStatusCode(),
                           'The status code is not 200');
        System.assertEquals('application/json;charset=UTF-8',
                           result.getHeader('Content-Type'),
            			'The content type value is not expected.');   
        Map<String, Object> results = (Map<String, Object>)JSON.deserializeUntyped(result.getBody());
        System.assertEquals('From Workbench Updated', results.get('Name'));
        System.assertEquals('0010900000Bwz1LAAR', results.get('Id'));
    }
    @isTest static void testPatchCallout() {
        Test.setMock(HttpCalloutMock.class, new AccountHttpCalloutMock());
        HttpResponse response = PracticeAccountCallouts.makePatchCallout('0010900000Bwz1LAAR');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json;charset=UTF-8');
        System.assertEquals(200, response.getStatusCode());
        String actualValue = response.getBody();
        String expectedValue = '{"name" : "Wise Post Moose"}';
        System.assertEquals(actualValue, expectedValue);
    }
}