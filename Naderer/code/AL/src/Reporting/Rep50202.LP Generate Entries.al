report 50202 "LP Generate Entries"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(IntegerLoop; Integer)
        {
            trigger OnPreDataItem()
            begin
                IntegerLoop.SetRange(Number, 1, 1000000);
            end;

            trigger OnAfterGetRecord()
            var
                CurrentPoints: Integer;
                LoyaltyPointEntry: Record "LP Loyalty Point Entry";
                LoyaltyPointMgmt: Codeunit "LP Loyalty Point Management";

            begin
                if IntegerLoop.Number > 1000 then begin
                    Commit();
                    CurrReport.Quit();

                end;

                CurrentPoints := Random(100);
                if (CurrentPoints > 80) then
                    LoyaltyPointMgmt.GrantMarketingPoints(CurrentPoints, CustomerRec, 'Rand' + Format(IntegerLoop.Number), 'Generated Semi-Randomly');
                if (CurrentPoints <= 80) then
                    CreatePoints(CurrentPoints, IntegerLoop.Number);

                CurrentPoints := Random(100) * -1;
                if (CurrentPoints < -5) then
                    CreatePoints(CurrentPoints, IntegerLoop.Number);

                if IntegerLoop.Number MOD 3 = 0 then
                    globalDate := CalcDate('<+1D>', globalDate);
                IntegerLoop.Number += 1;

                if (IntegerLoop.Number MOD 100) = 0 then
                    Message(Format(IntegerLoop.Number));

                CurrReport.Skip;
            end;
        }
    }

    local procedure CreatePoints(CurrentPoints: Integer; DocNo: Integer)
    var
        myInt: Integer;
        LoyaltyPointEntry: Record "LP Loyalty Point Entry";
    begin
        if CurrentPoints = 0 then exit;

        WITH LoyaltyPointEntry DO BEGIN
            Init;
            Validate("Customer No.", CustomerRec."No.");
            Validate("Posting Date", globalDate);

            if CurrentPoints > 0 then
                Validate("Entry Type", "Entry Type"::Earned)
            else
                Validate("Entry Type", "Entry Type"::Spent);
            Validate("Document No.", 'Rand' + Format(IntegerLoop.Number));
            Validate(Description, 'Generated Semi-Randomly');
            Validate("Customer Name", CustomerRec.Name);
            Validate(Points, CurrentPoints);
            Insert(true);
        END;
    end;

    trigger OnPreReport()
    begin
        CustomerRec.Get('D00010'); //Hagenberg Customer
        globalDate := 20190101D;

    end;

    var
        globalDate: Date;
        CustomerRec: Record Customer;

}