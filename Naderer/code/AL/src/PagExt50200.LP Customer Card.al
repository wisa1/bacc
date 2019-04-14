pageextension 50201 "LP Customer Card" extends "Customer List"
{
    actions
    {
        addafter("Sales Journal")
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
        }
    }
}
