/// <summary>
/// Unknown PermissionSet (ID 92950).
/// </summary>
permissionset 92950 "PermissionSet"
{
    Assignable = true;
    Caption = 'Permission Set', MaxLength = 30;
    Permissions =
        table "Exchange Rate API Setup" = X,
        tabledata "Exchange Rate API Setup" = RMID,
        codeunit "XeApi Integration" = X,
        page "Exchange Rate API Setup" = X;
}
