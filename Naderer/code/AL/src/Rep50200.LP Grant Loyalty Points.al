report 50200 "LP Grant Loyalty Points"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Customers; Customer)
        {
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            var
                LoyaltyPointManagement: Codeunit "LP Loyalty Point Management";
                FilteredCust: Record Customer;
            begin
                LoyaltyPointManagement.GrantMarketingPoints(Points, Customers, DocumentNo);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    field("Points to Grant"; Points)
                    {
                        ApplicationArea = All;
                    }

                    field("Document No."; DocumentNo)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    var
        Points: Integer;
        DocumentNo: Code[20];
}
