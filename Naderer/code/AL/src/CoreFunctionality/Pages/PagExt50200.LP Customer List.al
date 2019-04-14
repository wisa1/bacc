pageextension 50200 "LP Customer List" extends "Customer List"
{
    actions
    {
        addafter(Workflow)
        {
            group("Loyalty Points")
            {
                action("Grant Loyalty Points")
                {
                    Image = Add;
                    Caption = 'Grant Loyalty Points';
                    ToolTip = 'Opens the dialogue to grant Loyalty Points to this customer. This action will be tracked.';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        GrantPointsReport: Report "LP Grant Loyalty Points";
                    begin
                        GrantPointsReport.RunModal();
                    end;
                }

                action("Loyalty Points per Customer")
                {
                    Image = Report;
                    Caption = 'Loyalty Points per Customer';
                    ApplicationArea = All;
                    RunObject = Report "LP Loyalty Points per Customer";
                }

                action("Generate Loyalty Points")
                {
                    Image = LedgerEntries;
                    Caption = 'Generate Loyalty Points';
                    ApplicationArea = All;
                    RunObject = Report "LP Generate Entries";
                }

                action("Export Loyalty Point Entries as XML")
                {
                    Image = XMLFile;
                    Caption = 'Export Loyalty Point Entries as XML';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Xmlport.run(50200, false, false);

                    end;
                }
            }
        }
    }
}

