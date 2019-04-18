codeunit 50202 "LP Transmit WS Data"
{
    procedure TransmitDataForCustomer(var Customer: Record Customer)
    var
        LoyaltyPointSetup: Record "LP Loyalty Point Setup";
        LoyaltyPointEntry: Record "LP Loyalty Point Entry";
        Endpoint: Text[150];
    begin
        if not LoyaltyPointSetup.Get() then
            exit;

        Endpoint := LoyaltyPointSetup."LP Webservice Endpoint" + 'api/LoyaltyPointEntry';
        if Customer.FindSet() then
            repeat
                LoyaltyPointEntry.SetRange("Customer No.", Customer."No.");
                LoyaltyPointEntry.SetRange("Posting Date", Today());
                SendRequests(Endpoint, LoyaltyPointEntry);
            until Customer.Next() = 0;
    end;

    local procedure SendRequests(endpoint: Text; var LoyaltyPointEntry: Record "LP Loyalty Point Entry"): Text
    var
        WebServiceHelper: Codeunit "LP WebServiceHelper";
        EntryObject: JsonObject;
        RequestHeaders: Dictionary of [Text, Text];
        ContentHeaders: Dictionary of [Text, Text];
        Body: Text;
        ResponseMessage: HttpResponseMessage;
    begin
        ContentHeaders.Add('Content-Type', 'application/json');
        With LoyaltyPointEntry do
            if FindSet() then
                repeat
                    Clear(EntryObject);
                    Body := '';
                    EntryObject.Add('entryNo', "Entry No.");
                    EntryObject.Add('customerNo', "Customer No.");
                    EntryObject.Add('postingDate', "Posting Date");
                    EntryObject.Add('entryType', Format("Entry Type"));
                    EntryObject.Add('documentNo', "Document No.");
                    EntryObject.Add('customerName', "Customer Name");
                    EntryObject.Add('points', Points);
                    EntryObject.WriteTo(Body);
                    Message(Body);
                    WebServiceHelper.DoPostRequest('http://c355ed26.ngrok.io/api/LoyaltyEntryPoint', RequestHeaders, ContentHeaders, Body, ResponseMessage);
                until LoyaltyPointEntry.Next() = 0;
    end;
}