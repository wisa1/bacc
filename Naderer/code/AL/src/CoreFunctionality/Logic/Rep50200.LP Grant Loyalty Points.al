report 50200 "LP Grant Loyalty Points"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Customers; Customer)
        {
            RequestFilterFields = "No.", "Post Code", "LP Loyalty Points";
            trigger OnAfterGetRecord()
            var
                LoyaltyPointManagement: Codeunit "LP Loyalty Point Management";
            begin
                LoyaltyPointManagement.GrantMarketingPoints(Points, Customers, DocumentNo, Description);
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
                        ShowMandatory = true;
                    }
                    field("Document No."; DocumentNo)
                    {
                        ApplicationArea = All;
                        ShowMandatory = true;
                    }
                    field("Description"; Description)
                    {
                        ApplicationArea = All;
                        ShowMandatory = true;
                    }
                }
            }
        }
    }

    var
        Points: Integer;
        DocumentNo: Code[20];
        Description: Text[100];
}
