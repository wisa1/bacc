page 50200 "LP Loyalty Point Setup"
{

    PageType = Card;
    SourceTable = "LP Loyalty Point Setup";
    Caption = 'Loyalty Point Setup';
    InsertAllowed = false;
    DeleteAllowed = false;
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Discount per Point"; "LP Discount per Point")
                {
                    ApplicationArea = All;
                }
                field("Turnover for Point"; "LP Turnover for Point")
                {
                    ApplicationArea = All;
                }
                field("Webservice Endpoint"; "LP Webservice Endpoint")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        InsertIfNotExists();
    end;

    local procedure InsertIfNotExists()
    begin
        if not Get() then
            Insert(false);
    end;
}
