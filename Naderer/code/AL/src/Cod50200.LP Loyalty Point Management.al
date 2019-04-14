codeunit 50200 "LP Loyalty Point Management"
{
    procedure PostLoyaltyPoints(SalesInvoiceHeader: Record "Sales Invoice Header")
    begin
        PostSpentPoints(SalesInvoiceHeader);
        PostEarnedPoints(SalesInvoiceHeader);
    end;

    local procedure PostSpentPoints(SalesInvoiceHeader: Record "Sales Invoice Header")
    var
        LoyaltyPointEntry: Record "LP Loyalty Point Entry";
    begin
        // Posting the spent Loyalty points, using the loyalty points in the posted Document
        WITH LoyaltyPointEntry DO BEGIN
            Init;
            Validate("Customer No.", SalesInvoiceHeader."Bill-to Customer No.");
            Validate("Posting Date", SalesInvoiceHeader."Posting Date");
            Validate("Entry Type", "Entry Type"::Spent);
            Validate("Document No.", SalesInvoiceHeader."No.");
            Validate("Customer Name", SalesInvoiceHeader."Bill-to Name");
            Validate(Points, SalesInvoiceHeader."LP Spent Loyalty Points");
            Insert(true);
        END;
    end;

    local procedure PostEarnedPoints(SalesInvoiceHeader: Record "Sales Invoice Header")
    var
        LoyaltyPointEntry: Record "LP Loyalty Point Entry";
    begin
        // Posting the earned points, using the turnover from the current invoice
        WITH LoyaltyPointEntry DO BEGIN
            Init;
            Validate("Customer No.", SalesInvoiceHeader."Bill-to Customer No.");
            Validate("Posting Date", SalesInvoiceHeader."Posting Date");
            Validate("Entry Type", "Entry Type"::Earned);
            Validate("Document No.", SalesInvoiceHeader."No.");
            Validate("Customer Name", SalesInvoiceHeader."Bill-to Name");
            SalesInvoiceHeader.CALCFIELDS(Amount);
            Validate(Points, CalculateEarnedPoints(SalesInvoiceHeader.Amount));
            Insert(true);
        END;
    end;

    local procedure CalculateEarnedPoints(InvoiceAmount: Decimal): Decimal
    var
        LoyaltySetup: Record "LP Loyalty Point Setup";
    begin
        IF NOT LoyaltySetup.GET THEN
            LoyaltySetup.Init;

        //return zero for invalid setup or null-invoices
        IF (LoyaltySetup."LP Turnover for Point" = 0) OR (InvoiceAmount = 0) THEN
            EXIT(0);

        // Calculate and return earned points according to setup, point values are rounded down to the nearest Integer.
        // InvoiceAmount: 1250.00
        // Turnover for Point: 100
        // Earned Points: 12
        EXIT(ROUND(InvoiceAmount / LoyaltySetup."LP Turnover for Point", 1, '<'));
    end;

    procedure CalculateDiscount(Points: Integer): Decimal
    var
        LoyaltySetup: Record "LP Loyalty Point Setup";
    begin
        IF NOT LoyaltySetup.GET THEN
            LoyaltySetup.Init;

        EXIT(Points * LoyaltySetup."LP Discount per Point");
    end;

    // Retrieves a filtered Customer Record, and assigned Loyalty points to them. 
    // The DocumentNo Parameter is used as the Document No for the entries. 
    procedure GrantMarketingPoints(Points: Integer; Customer: Record Customer; DocumentNo: Code[20])
    var
        LoyaltyPointEntry: Record "LP Loyalty Point Entry";
    begin
        Message(Customer.GetFilters());
        if Customer.FindSet() then
            repeat
                WITH LoyaltyPointEntry DO BEGIN
                    Init;
                    Validate("Entry No.", 0);
                    Validate("Customer No.", Customer."No.");
                    Validate("Posting Date", Today);
                    Validate("Entry Type", "Entry Type"::Marketing);
                    Validate("Document No.", DocumentNo);
                    Validate("Customer Name", Customer.Name);
                    Validate(Points, Points);
                    Insert(True);
                END;
            until Customer.Next() = 0
    end;
}