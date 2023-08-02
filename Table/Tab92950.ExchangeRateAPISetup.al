/// <summary>
/// Table Exchange Rate API Setup (ID 92950).
/// </summary>
table 92950 "Exchange Rate API Setup"
{
    Caption = 'Exchange Rate API Setup';
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Key"; Code[20])
        {
            Caption = 'Key';
            DataClassification = SystemMetadata;
        }
        field(2; URL; Text[250])
        {
            Caption = 'URL';
            DataClassification = SystemMetadata;
        }
        field(3; UserName; Text[250])
        {
            Caption = 'UserName';
            DataClassification = SystemMetadata;
        }
        field(4; Password; Text[250])
        {
            Caption = 'API Key';
        }
        field(5; Domain; Text[250])
        {
            Caption = 'Domain Address';
        }
        field(6; "Base Currency"; Code[20])
        {
            Caption = 'Base Currency';
        }
    }
    keys
    {
        key(PK; "Key")
        {
            Clustered = true;
        }
    }

}
