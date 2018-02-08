unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Printers, ExtCtrls;

type
  TForm1 = class(TForm)
    btnGenerate: TButton;
    txtLokasi: TEdit;
    lblLokasi: TLabel;
    Browse: TButton;
    OpenDialog1: TOpenDialog;
    grpCode: TRadioGroup;
    grpPaper: TRadioGroup;
    cmbPrinters: TComboBox;
    lblPilihPrinter: TLabel;
    procedure btnGenerateClick(Sender: TObject);
    procedure BrowseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure setPaperSize(index: Integer);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  dpiX, dpiY: integer;
  myData: TStrings;

implementation

uses DelphiZXingQRCode, Barcode, Barcode2;

{$R *.dfm}

procedure TForm1.btnGenerateClick(Sender: TObject);
var boxW, boxH, pageW, pageH, hor, ver, myDataI: Integer;
  codeR, codeC: Integer; myRect: TRect;
  myCode: TDelphiZXingQRCode;
  myBarcode: TAsBarcode;
begin
  if(myData.Count=0)then begin
    Application.MessageBox('Silahkan load data dulu', 'Data belum loaded',
      MB_OK+MB_ICONWARNING);
    exit;
  end;
  if(cmbPrinters.ItemIndex=-1)then begin
    Application.MessageBox('Silahkan pilih printer dulu', 'Printer belum dipilih',
      MB_OK+MB_ICONWARNING);
    cmbPrinters.SetFocus;
  end else begin
    //get dpi
    btnGenerate.Enabled:=false;
    dpiX:=GetDeviceCaps(Printer.Handle, LOGPIXELSX);
    dpiY:=GetDeviceCaps(Printer.Handle, LOGPIXELSY);
    printer.Orientation:=poPortrait;
    printer.PrinterIndex:=cmbPrinters.ItemIndex;
    setPaperSize(grpPaper.ItemIndex);
    pageW:=Printer.PageWidth;
    pageH:=Printer.PageHeight;
    boxW:=Round(dpiX * 1.9685);
    boxH:=Round(dpiY * 1.1811);
    hor:=500;
    ver:=500;

    myCode:=TDelphiZXingQRCode.Create;
    myBarcode:=TAsBarcode.Create(Self);
    myDataI:=0;
    with Printer do begin
      BeginDoc;
      with Canvas do begin
        while((ver+boxH+200)<pageH) do begin
          while((hor+boxW+200)<pageW) do begin
            //myCode.Data:=Concat(IntToStr(hor), IntToStr(ver));
            myCode.Data:='';
            if(myDataI=myData.Count) then break;
            myCode.Data:=myData[myDataI];

            if(grpCode.ItemIndex=0)then begin
              myBarcode.Text:=myCode.Data;
              myBarcode.Left:=hor+20;
              myBarcode.Top:=ver+20;
              myBarcode.Height:=ConvertMmToPixelsY(20);
              myBarcode.Modul:=ConvertMmToPixelsX(0.5);
              myBarcode.Typ:=bcCode_2_5_interleaved;
              myBarcode.DrawBarcode(Canvas);
            end else if(grpCode.ItemIndex=1)then begin
              for codeR:=0 to myCode.Rows - 1 do begin
                for codeC:=0 to myCode.Columns -1 do begin
                  myRect.Left:=hor+(codeC*20);
                  myRect.Top:=ver+(codeR*20);
                  myRect.Right:=myRect.Left+20;
                  myRect.Bottom:=myRect.Top+20;
                  if(myCode.IsBlack[codeR, codeC])then begin
                    Brush.Style:=bsSolid;
                    Brush.Color:=clBlack;
                    FillRect(myRect);
                  end else begin
                    Brush.Style:=bsSolid;
                    Brush.Color:=clWhite;
                    FillRect(myRect);
                  end;
                end;
              end;
            end;
            MoveTo(hor, ver);
            LineTo(hor+boxW, ver);
            LineTo(hor+boxW, ver+boxH);
            LineTo(hor, ver+boxH);
            LineTo(hor, ver);
            hor:=hor+boxW+200;
            Inc(myDataI);
          end;
          hor:=500;
          ver:=ver+boxH+100;
        end;
      end;
      EndDoc;
    end;
  end;
  btnGenerate.Enabled:=True;
  {if(prnDialog.Execute)then begin
    printer:=TPrinter.Create;
    printer.Orientation:=poPortrait;
    ShowMessage(IntToStr(printer.PageWidth));
    printer.BeginDoc;
    printer.EndDoc;
  end;}
end;

procedure TForm1.BrowseClick(Sender: TObject);
begin
  if(OpenDialog1.Execute)then begin
    txtLokasi.Text:=OpenDialog1.FileName;
    txtLokasi.Hint:=OpenDialog1.FileName;
    myData.LoadFromFile(OpenDialog1.FileName);
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  {cmbPrinters.Items:=Printer.Printers;
  cmbPrinters.ItemIndex:=-1;}

  cmbPrinters.Items.Assign(Printer.Printers);
  cmbPrinters.ItemIndex:=0;
  myData:=TStringList.Create;
  myData.Clear;
end;

procedure TForm1.setPaperSize(index: Integer);
var Device, Driver, Port: Array[0..80] of Char;
  DevMode: THandle;
  pDevMode: PDeviceMode;
begin
  Printer.GetPrinter(Device, Driver, Port, DevMode);
  Printer.SetPrinter(Device, Driver, Port, 0);
  Printer.GetPrinter(Device, Driver, Port, DevMode);
  if DevMode<>0 then begin
    pDevMode:=GlobalLock(DevMode);
    if pDevMode<>nil then begin
      try
        with pDevMode^ do begin
          if(index=0) then
            dmPaperSize:=DMPAPER_A4
          else
            dmPaperSize:=DMPAPER_A3;
          dmFields:=dmFields or DM_PAPERSIZE;
        end;
      finally
        GlobalUnlock(DevMode);
      end;
    end;
  end;
end;

end.
