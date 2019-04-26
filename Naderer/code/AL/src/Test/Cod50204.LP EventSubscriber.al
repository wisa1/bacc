codeunit 50204 "LP EventSubscriber"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ReportManagement, 'OnAfterGetPrinterName', '', false, false)]
    local procedure OnGetPrinterName(ReportID: Integer; VAR PrinterName: Text[250])
    begin
        Message('The user selected the following printer: ' + PrinterName);
    end;
}