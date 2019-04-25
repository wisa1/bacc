codeunit 50201 MyCodeunit
{
    Subtype = Test;

    [Test]
    procedure "Test-WS"()
    var
        LoyaltyPointEntry: Record "LP Loyalty Point Entry" temporary;
        TransmitWS: codeunit "LP Transmit WS Data";
        i: Integer;
    begin
        with LoyaltyPointEntry do begin
            DeleteAll(false);
            for i := 0 to 10000 do begin
                Init();
                "Customer Name" := 'Testcase ' + format(i);
                "Customer No." := 'D00010';
                Description := 'Testcase ' + format(i);
                "Document No." := '';
                Points := 5;
                "Entry No." := i;
                Insert(false);
            end;
        end;
        TransmitWS.SendRequests('http://localhost:56461/api/LoyaltyPointEntry', LoyaltyPointEntry);
    end;

    [Test]
    procedure CalcSum1()
    var
        Customer: Record Customer;
    begin
        Customer.Setrange("No.", 'CUSTOMER 1', 'CUSTOMER 9');
        IF Customer.findset() then
            repeat
                Customer.CalcFields("LP Points Sum 1");
                if ((customer."LP Points Sum 1" < 50000) or (customer."LP Points Sum 1" > 60000)) then
                    error('bad');
            until Customer.Next() = 0;
    end;

    [Test]
    procedure CalcSum2()
    var
        Customer: Record Customer;
    begin
        Customer.Setrange("No.", 'CUSTOMER 1', 'CUSTOMER 9');
        IF Customer.findset() then
            repeat
                Customer.CalcFields("LP Points Sum 2");
                if ((customer."LP Points Sum 2" < 50000) or (customer."LP Points Sum 2" > 60000)) then
                    error('bad');
            until Customer.Next() = 0;
    end;
}