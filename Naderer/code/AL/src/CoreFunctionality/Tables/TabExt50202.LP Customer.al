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
    }
}