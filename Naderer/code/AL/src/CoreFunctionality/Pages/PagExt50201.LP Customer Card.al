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
            field("LP Points Sum 1"; "LP Points Sum 1")
            {
                ApplicationArea = All;
            }

            field("LP Points Sum 2"; "LP Points Sum 2")
            {
                ApplicationArea = All;
            }
        }
    }
}