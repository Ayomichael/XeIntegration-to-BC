/// <summary>
/// Page Exchange Rate API Setup (ID 92950).
/// </summary>
page 92958 "Exchange Rate API Setup"
{
    Caption = 'Exchange Rate API Setup';
    PageType = Card;
    SourceTable = "Exchange Rate API Setup";
    UsageCategory = Lists;
    ApplicationArea = All;


    layout
    {
        area(content)
        {
            group(General)
            {

                field(Domain; Rec.Domain)
                {
                    ToolTip = 'Specifies the Domain Address';
                    ApplicationArea = All;
                }
                field(UserName; Rec.UserName)
                {
                    ToolTip = 'Specifies the value of the UserID field.';
                    ApplicationArea = All;
                }
                field(Password; Rec.Password)
                {
                    ToolTip = 'Specifies the Auth Password';
                    ApplicationArea = All;
                    Caption = 'API Key';
                }
                Field("Base Currency"; Rec."Base Currency")
                {
                    ToolTip = 'Specifies the base currency for conversion';
                    ApplicationArea = All;
                }
            }
        }
    }
}
