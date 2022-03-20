Public class sendcontactToExternalSystem
{
    
    public void sendContact(String FirstName, string LastName, string title, string email, Id id2)
    {
        sendTosfdcchildsystem(id2);
    }
    
@future(callout=true)
        public static void sendTosfdcchildsystem(Id id2)
        {
            contact con = [select id,firstname,lastname,title,email from contact where id=:id2];
            
            //authntication of child sfdc system
            //partnerSoapSforceCom (Main class created while patner webservice is imported)
            //soap is child class inside partnerSoapSforceCom
            //mainclass.childclass (syntax below)
            partnerSoapSforceCom.soap mypartnerSoap = new partnerSoapSforceCom.soap();
            
            //login is Method and having parameters(login(String username,String password))
            //login method having return type(partnerSoapSforceCom.LoginResult) check in main class 'partnerSoapSforceCom'
           partnerSoapSforceCom.LoginResult partnerLoginresult = mypartnerSoap.login('light0122@gmail.com','SHIVA@0910BWzVHSAiMbyXwOhlV1d17fj9U');
            system.debug('Generated session id :'+partnerLoginresult.sessionId);
            string sessionIdFetch = partnerLoginresult.sessionId;
                        
            //mainclass.childclass (syntax below)
            //setting session id
            soapSforceComSchemasClassReceivepar.SessionHeader_element webserviceSessionHeader = new soapSforceComSchemasClassReceivepar.SessionHeader_element();
            webserviceSessionHeader.sessionId = sessionIdFetch;
            
            //mainclass.childclass (syntax below)
            soapSforceComSchemasClassReceivepar.receiveParameterOrg2 objA = new soapSforceComSchemasClassReceivepar.receiveParameterOrg2();
            objA.SessionHeader = webserviceSessionHeader;
            string status = objA.CreateContactRecord(con.firstName, con.LastName, con.title, con.email);
            system.debug('Statuc' +status);
            
            
         }
}