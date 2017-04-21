unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mail_View, ExtCtrls, Unit1;

type
  TForm3 = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    GroupBox2: TGroupBox;
    ListBox1: TListBox;
    procedure ClearFields;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
    procedure Edit4KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    AddMode    : boolean;
    EditMode   : boolean;
  public
  end;

var
  Form3: TForm3;
  CurrentSponsor : TSponsor;
  MaxLinkLen : byte;
  MaxViewInterval : word;

implementation

{$R *.dfm}

procedure TForm3.FormShow(Sender: TObject);
begin
  ListBox1.Items.LoadFromFile(SponsorsFilePath);
  Button2.Enabled := False;
  Button3.Enabled := False;
  Button4.Enabled := False;
  Button5.Enabled := False;
  AddMode := False;
  EditMode := False;
  ClearFields;

  ShowAtCenter(Form1,Form3);
end;

procedure TForm3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ListBox1.Items.SaveToFile(SponsorsFilePath);
  Form1.LoadSponsors;
end;

procedure TForm3.ClearFields;
begin
  Edit1.Clear;
  Edit2.Clear;
  Edit3.Clear;
  Edit4.Clear;
end;

procedure TForm3.Button1Click(Sender: TObject);
begin
  AddMode := true;
  ClearFields;
  ListBox1.ItemIndex := -1;
  CurrentSponsor.name := InputBox(Form1.Language.SponsorsSettings.SponsorsName,Form1.Language.SponsorsSettings.EnterSponsorsName + ':','');
  Edit1.Text := CurrentSponsor.name;
  Button4.Enabled := true;
  Button5.Enabled := true;
  GroupBox1.Caption := ' ' + Form1.Language.SponsorsSettings.SponsorInfo + ' --> '
  + CurrentSponsor.name;
end;

procedure TForm3.ListBox1Click(Sender: TObject);
begin
  Button2.Enabled := True;
  Button3.Enabled := True;

  Edit1.Text := DecodeSponsor(ListBox1.Items[ListBox1.ItemIndex]).name;
  Edit2.Text := DecodeSponsor(ListBox1.Items[ListBox1.ItemIndex]).mask;
  Edit3.Text := IntToStr(DecodeSponsor(ListBox1.Items[ListBox1.ItemIndex]).len);
  Edit4.Text := IntToStr(DecodeSponsor(ListBox1.Items[ListBox1.ItemIndex]).interval);

  GroupBox1.Caption := ' ' + Form1.Language.SponsorsSettings.SponsorInfo + ' --> '
  + DecodeSponsor(ListBox1.Items[ListBox1.ItemIndex]).name + ' ';
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
  EditMode := true;
  Button4.Enabled := true;
  Button5.Enabled := true;
end;

procedure TForm3.Button4Click(Sender: TObject);
begin
  CurrentSponsor.name := Edit1.Text;
  CurrentSponsor.mask := Edit2.Text;

  if StrToInt(Edit3.Text) > MaxLinkLen then
  begin         
    ShowMessage(Form1.Language.SponsorsSettings.LinkLengthMustBeLess + ' ' + IntToStr(MaxLinkLen));
    exit;
  end;
  CurrentSponsor.len := StrToInt(Edit3.Text);

  if StrToInt(Edit4.Text) > MaxViewInterval then
  begin
    ShowMessage(Form1.Language.SponsorsSettings.ViewIntervalMustBeLess + ' ' + IntToStr(MaxViewInterval));
    exit;
  end;
  CurrentSponsor.interval := StrToInt(Edit4.Text);

  if AddMode
  then
  begin
    ListBox1.Items.Add(EncodeSponsor(CurrentSponsor));
    ListBox1.Selected[ListBox1.Count - 1] := True;
    AddMode := False;
  end
  else
  if EditMode
  then
  begin
    ListBox1.Items[ListBox1.ItemIndex] := EncodeSponsor(CurrentSponsor);
    EditMode := False;
  end;
  Button4.Enabled := false;
  Button5.Enabled := false;
end;

procedure TForm3.Button5Click(Sender: TObject);
begin
   if AddMode
  then
  begin
    AddMode := False;
  end
  else
  if EditMode
  then
  begin
    EditMode := False;
  end;
  Button4.Enabled := false;
  Button5.Enabled := false;
  ClearFields;
  ListBox1.Selected[ListBox1.Count - 1] := True;
end;

procedure TForm3.Button3Click(Sender: TObject);
var
s : word;
begin
  s := MessageDlg(Form1.Language.ClearList.AreYouSure + '?',mtConfirmation,[mbYes,mbNo],0);
  if s = mrYes
  then
  begin
    ListBox1.Items.Delete(ListBox1.ItemIndex);
    ClearFields;
    ListBox1.ItemIndex := -1;
    GroupBox1.Caption := ' ' + Form1.Language.SponsorsSettings.SponsorInfo + ' ';
  end;
end;

procedure TForm3.Edit3KeyPress(Sender: TObject; var Key: Char);
begin
  case Key of
    '0'..'9' : ;
    #8       :
  else Key := #0;
  end;
end;

procedure TForm3.Edit4KeyPress(Sender: TObject; var Key: Char);
begin
  case Key of
    '0'..'9' : ;
    #8       :
  else Key := #0;
  end;
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
  MaxLinkLen := 255;
  MaxViewInterval := 65535;
end;

end.
