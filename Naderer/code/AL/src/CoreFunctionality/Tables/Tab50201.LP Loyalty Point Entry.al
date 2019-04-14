table 50201 "LP Loyalty Point Entry"
{
    DataClassification = AccountData;
    LookupPageId = "LP Loyalty Point Entries";
    DrillDownPageId = "LP Loyalty Point Entries";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            //Let sql-server handle the assignment of the entry no.
            AutoIncrement = true;
            DataClassification = SystemMetadata;
        }
        field(2; "Customer No."; Code[10])
        {
            DataClassification = AccountData;
            TableRelation = Customer;
        }
        field(3; "Posting Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(5; "Entry Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "Marketing","Earned","Spent";
        }
        field(6; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(7; Description; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(8; "Customer Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(9; Points; Integer)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}