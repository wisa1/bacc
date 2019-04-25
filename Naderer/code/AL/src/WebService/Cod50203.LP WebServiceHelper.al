codeunit 50203 "LP WebServiceHelper"
{
    procedure ToBase64String(Bytes: List of [Byte]): Text;
    var
        TempBlob: Record TempBlob;
        OutStr: OutStream;
        SingleByte: Byte;
    begin
        TempBlob.blob.CreateOutStream(OutStr);
        foreach SingleByte in Bytes do
            OutStr.Write(SingleByte, 1);

        Exit(TempBlob.ToBase64String());

    end;

    procedure DoPostRequest(Endpoint: Text;
                            RequestHeaders: Dictionary of [Text, Text];
                            ContentHeaders: Dictionary of [Text, Text];
                            Body: Text;
                            Response: HttpResponseMessage)
    var
        Client: HttpClient;
        Request: HttpRequestMessage;
        Headers: HttpHeaders;
        Content: HttpContent;
        DictKey: Text;
    begin
        Request.Method := 'POST';
        Request.SetRequestUri(Endpoint);
        Request.GetHeaders(Headers);

        foreach DictKey in RequestHeaders.Keys() do
            Headers.Add(DictKey, RequestHeaders.Get(DictKey));

        Content := Request.Content();
        Content.WriteFrom(Body);

        Content.GetHeaders(Headers);
        foreach DictKey in ContentHeaders.Keys() do begin
            Headers.Remove(DictKey);
            Headers.Add(DictKey, ContentHeaders.Get(DictKey));
        end;
        Request.Content(Content);
        Client.Send(Request, Response);
    end;

    procedure DoGetRequest(Endpoint: Text;
                           RequestHeaders: Dictionary of [Text, Text];
                           Response: HttpResponseMessage)
    var
        Client: HttpClient;
        Request: HttpRequestMessage;
        Headers: HttpHeaders;
        DictKey: Text;
    begin
        Request.Method := 'GET';
        Request.SetRequestUri(Endpoint);
        Request.GetHeaders(Headers);

        foreach DictKey in RequestHeaders.Keys() do
            Headers.Add(DictKey, RequestHeaders.Get(DictKey));

        Client.Send(Request, Response);
    end;

    procedure GetErrors(Response: HttpResponseMessage): Text
    var
        ResponseText: Text;
    begin
        if not Format(Response.HttpStatusCode()).StartsWith('2') then begin
            Response.Content().ReadAs(ResponseText);
            Exit(ResponseText);
        end;
    end;
}