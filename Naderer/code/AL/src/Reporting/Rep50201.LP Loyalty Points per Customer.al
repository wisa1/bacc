report 50201 "LP Loyalty Points per Customer"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Reporting/Rep50201.LP Loyalty Points per Customer.rdlc';

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.", "Name";
            PrintOnlyIfDetail = true;

            column(UserId; UserId()) { }
            column(Filters; Customer.GetFilters()) { }
            column(Customer_No; "No.") { }
            column(Customer_Name; Name) { }
            dataitem(LPEntry; "LP Loyalty Point Entry")
            {
                RequestFilterFields = "Posting Date";
                DataItemLinkReference = Customer;
                DataItemLink = "Customer No." = Field ("No.");

                column(LPEntry_EntryNo; "Entry No.") { }
                column(LPEntry_Description; Description) { }
                column(LPEntry_DocumentNo; "Document No.") { }
                column(LPEntry_EntryType; "Entry Type") { }
                column(LPEntry_Points; Points) { }
                column(LPEntry_PostingDate; "Posting Date") { }
            }
        }
    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {

            }
        }
    }
}