tableextension 50200 "LP Sales Invoice Header" extends "Sales Invoice Header"
{
    fields
    {
        field(50200; "LP Spent Loyalty Points"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(50201; "LP Loyalty Point Discount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
    }

    var
        myInt: Integer;
}