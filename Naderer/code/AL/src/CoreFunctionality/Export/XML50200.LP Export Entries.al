xmlport 50200 "LP Export Entries"
{
    Direction = Export;
    Format = xml;
    UseRequestPage = false;
    schema
    {
        textelement(LoyaltyPointEntries)
        {
            tableelement(LoyaltyPointEntry; "LP Loyalty Point Entry")
            {
                RequestFilterFields = "Posting Date", "Customer No.";
                fieldelement(EntryNo; LoyaltyPointEntry."Entry No.") { }
                fieldelement(CustomerNo; LoyaltyPointEntry."Customer No.") { }
                fieldelement(CustomerName; LoyaltyPointEntry."Customer Name") { }
                fieldelement(Description; LoyaltyPointEntry.Description) { }
                fieldelement(EntryType; LoyaltyPointEntry."Entry Type") { }
                fieldelement(Points; LoyaltyPointEntry.Points) { }
                fieldelement(DocumentNo; LoyaltyPointEntry."Document No.") { }
                fieldelement(PostingDate; LoyaltyPointEntry."Posting Date") { }
            }
        }
    }
}