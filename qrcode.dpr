program qrcode;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  DelphiZXingQRCode in 'DelphiZXIngQRCode.pas',
  Barcode in 'Barcode.pas',
  Barcode2 in 'Barcode2.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'QR Code dan Barcode Generator';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
