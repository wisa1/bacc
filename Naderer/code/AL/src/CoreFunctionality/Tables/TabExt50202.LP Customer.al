tableextension 50202 "LP Customer" extends "Customer"
{
    fields
    {
        field(50200; "LP Loyalty Points"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = sum ("LP Loyalty Point Entry".Points
                              where ("Customer No." = field ("No."),
                                     "Posting Date" = field ("Date Filter")
                          ));
        }
        field(50201; "LP Points Sum 1"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = sum ("LP Entry".Points
                              where ("Customer No." = field ("No.")
                          ));
        }
        field(50202; "LP Points Sum 2"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = sum ("LP Entry".Points2
                              where ("Customer No." = field ("No.")
                          ));
        }
    }
}