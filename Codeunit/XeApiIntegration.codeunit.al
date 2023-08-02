/// <summary>
/// Codeunit XeApi Integration (ID 92950).
/// </summary>
codeunit 92953 "XeApi Integration"
{
    trigger OnRun()
    var
        ExchangeRateSetup: Record "Exchange Rate API Setup";
    begin
        if ExchangeRateSetup.Get() then
            // SendRequest();
            SendRequest(ExchangeRateSetup."Base Currency", ExchangeRateSetup.domain, ExchangeRateSetup.Password, ExchangeRateSetup.UserName);
        // Message('Successful');

    end;


    /// <summary>
    /// SendRequest.
    /// </summary>
    /// <param name="CurrCode">VAR Code[20].</param>
    /// <param name="Domain">Text.</param>
    /// <param name="Apikey">Text.</param>
    /// <param name="AccountID">Text.</param>
    procedure SendRequest(var CurrCode: Code[20]; Domain: Text; Apikey: Text; AccountID: Text)

    var


        Client: HttpClient;
        Content: HttpClient;
        Request: HttpRequestMessage;
        Response: HttpResponseMessage;
        HttpHeader: HttpHeaders;
        ContentTXT: Text;
        Jobject: JsonObject;
        RootFile: JsonObject;
        RootObj: JsonObject;
        RqToken: Text;
        ParaAmtLbl: Label '&amount=1';
        para2Lbl: Label '.json/';
        ParaVLbl: Label '/v1/';
        RequestString: Text;
        ReqTypeLbl: Label 'historic_rate';
        curRec: Record Currency;
        Rates: JsonToken;
        Rate: JsonToken;
        RateTk: JsonToken;
        RateObj: JsonObject;
        ToJsonArray: JsonArray;
        Qtoken: JsonToken;
        CurRate: Decimal;
        ExchangeRate: Record "Currency Exchange Rate";
        CurDate: Date;
        DateToken: JsonToken;
        Qrate: JsonToken;
        QText: Text;
        RateDec: Decimal;
    //  Domain: Label 'xecdapi.xe.com';
    //ApiKey: Label 'f4hov5mo5n2n59modlk7chrt78';
    //  AccountID: Label 'onpoint921182970';



    begin
        //RequestString := 'https://xecdapi.xe.com/v1/convert_from.json/?from=GBP&to=*&amount=1'; //Domain + ParaVLbl + ReqTypeLbl + para2Lbl + GetLCY('GBP') + dateParam() + 'to=CAD,JPY' + ParaAmtLbl; 
        // Message('%1 %2 %3 %4', Domain, CurrCode, Accountid, Apikey);
        RequestString := Domain + '/v1/convert_from.json/?from=' + CurrCode + '&to=*&amount=1';
        // Message('%1', RequestString);


        Client.DefaultRequestHeaders().Add('Authorization', CreateBaiscAuth(AccountID, ApiKey));
        if Client.Get(RequestString, Response) then begin
            if Response.IsSuccessStatusCode() then begin
                if Response.Content().ReadAs(ContentTXT) then begin
                    // Message('%1', ContentTXT);
                    if RootFile.ReadFrom(ContentTXT) then begin
                        RootFile.SelectToken('to', Rate);
                        ToJsonArray := Rate.AsArray();

                        foreach RateTk in ToJsonArray do begin
                            IF RateTk.IsObject then
                                RateObj := Ratetk.AsObject();
                            if RateObj.Get('quotecurrency', Qtoken) then
                                QText := Qtoken.AsValue().AsText();

                            if RateObj.Get('mid', Qrate) then
                                RateDec := Qrate.AsValue().AsDecimal();



                            if curRec.get(QText) then begin

                                ExchangeRate.init;
                                ExchangeRate."Currency Code" := curRec.Code;
                                ExchangeRate."Starting Date" := Today;
                                ExchangeRate.Insert(true);
                                ExchangeRate.Validate("Exchange Rate Amount", RateDec);
                                ExchangeRate.Validate("Relational Exch. Rate Amount", 1);
                                ExchangeRate.Validate("Adjustment Exch. Rate Amount", RateDec);
                                ExchangeRate.Validate("Relational Adjmt Exch Rate Amt", 1);
                                // if ExchangeRate."Relational Currency Code" <> CurrCode then
                                //     ExchangeRate.Validate("Relational Currency Code", CurrCode);
                                ExchangeRate.modify(true);

                            end;

                        end;

                    end
                    else
                        error('invalid Json FILE(%1)', ContentTXT)
                end else
                    Error('No Data Found');
            end else begin
                if Response.Content().ReadAs(ContentTXT) then
                    error('Http Request Failed, return value(%1)(%2)', Response.HttpStatusCode(), ContentTXT)

            end
        end else
            Error('Could not conect to XE Server');
    end;


    /// <summary>
    /// CreateBaiscAuth.
    /// </summary>
    /// <param name="UserName">Text.</param>
    /// <param name="Password">Text.</param>
    /// <returns>Return value of type Text.</returns>
    procedure CreateBaiscAuth(UserName: Text; Password: Text): Text
    Var
        Base64Convert: Codeunit "Base64 Convert";
    begin
        exit('Basic ' + Base64Convert.ToBase64(UserName + ':' + Password));
    end;

    /// <summary>
    /// GetToken.
    /// </summary>
    /// <param name="EndpointUrl">Text.</param>
    /// <returns>Return variable ResponseTxt of type Text.</returns>
    procedure GetToken(EndpointUrl: Text) ResponseTxt: Text
    var
        Client: HttpClient;
        Response: HttpResponseMessage;
        Jobject: JsonObject;
        JToken: JsonToken;
    begin
        if Client.Get(EndpointUrl, Response) then
            Response.Content().ReadAs(ResponseTxt);
        IF Jobject.ReadFrom(ResponseTxt) then
            GetKeyValue(Jobject, '', ResponseTxt);

    end;

    local procedure GetKeyValue(Jobject: JsonObject; KeyName: Text; var ResponseTxt: Text): Boolean
    var
        Jtoken: JsonToken;
    begin
        if not Jobject.Get(KeyName, Jtoken) then
            exit(false);
        ResponseTxt := Jtoken.AsValue().AsText();
        exit(true);
    end;

    local procedure GetLCY(LCYCode: Code[10]): Text[250]
    var
        FromStrg: text;
    begin
        FromStrg := ('/from=' + LCYCode);
    end;

    local procedure dateParam() returnValue: Text[250]
    var
        DateLbl: Label '&date=';
        DateText: text;
    begin
        returnValue := DateLbl + FORMAT(Today);
    end;

}
