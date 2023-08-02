/// <summary>
/// PageExtension Exchange Rate EXT (ID 92950) extends Record Currencies.
/// </summary>
pageextension 92950 "Exchange Rate EXT" extends Currencies
{
    layout
    {

    }
    actions
    {
        addafter("Adjust Exchange Rate")
        {
            action(GetRates)
            {
                Caption = 'Get Rates';
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                Image = NewExchangeRate;
                // RunObject = codeunit "XE API Integration";
                trigger OnAction()
                var
                    ApIntegration: Codeunit "XeApi Integration";
                begin
                    ApIntegration.Run();
                    Message('Exchange Rate Updated Successfully');
                end;
            }
        }

    }
}