tableextension 50203 "LP Sales Header" extends "Sales Header"
{
    fields
    {
        field(50200; "LP Spent Loyalty Points"; Integer)
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                Customer: Record Customer;
                LoyaltyPointMgmt: Codeunit "LP Loyalty Point Management";
                TooManyPointsAssignedErr: Label 'Too many points assigned! Available: %1';
            begin
                // Make the user can not assign more points, than the customer currently has
                Customer.Get("Bill-to Customer No.");
                Customer.CalcFields("LP Loyalty Points");
                if "LP Spent Loyalty Points" > Customer."LP Loyalty Points" then
                    ERROR(TooManyPointsAssignedErr, FORMAT(Customer."LP Loyalty Points"));

                // Adjust Invoice discount in case there was a loyalty discount beforehand
                if "LP Loyalty Point Discount" <> 0 then
                    Validate("Invoice Discount Amount", "Invoice Discount Amount" - "LP Loyalty Point Discount");

                // Calc new Discount, and assign it to the current invoice
                // Do not assign the discount directly, in case there are already other invoice discounts in place
                Validate("LP Loyalty Point Discount", LoyaltyPointMgmt.CalculateDiscount("LP Spent Loyalty Points"));
                Validate("Invoice Discount Amount", "Invoice Discount Amount" + "LP Loyalty Point Discount");
            end;
        }
        field(50201; "LP Loyalty Point Discount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
    }
}