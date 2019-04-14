pageextension 50201 "LP Customer Card" extends "Customer Card"
{
    layout
    {
        addafter(Name)
        {
            field("LP Loyalty Points"; "LP Loyalty Points")
            {
                ApplicationArea = All;
            }
        }
    }
}