table 50200 "LP Loyalty Point Setup"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; PrimaryKey; Code[10])
        {
            DataClassification = SystemMetadata;
        }
        field(2; "LP Discount per Point"; Decimal)
        {
            DataClassification = SystemMetadata;
        }
        field(3; "LP Turnover for Point"; Decimal)
        {
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; PrimaryKey)
        {
            Clustered = true;
        }
    }
}