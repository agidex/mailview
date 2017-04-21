unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mail_View, ExtCtrls, Spin, Unit1;

type
  TForm2 = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Button3: TButton;
    Button2: TButton;
    Button1: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    ComboBox1: TComboBox;
    Button4: TButton;
    Button5: TButton;
    SpinEdit1: TSpinEdit;
    Edit2: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Edit3: TEdit;
    ListBox1: TListBox;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ClearFields;
    procedure Button1Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ComboBox1Click(Sender: TObject);
    procedure ShowInCombo(Sender: TObject);
  private
   AddMode : boolean;
  public
  end;

var
  Form2: TForm2;
  CurrentEmail : TEmail;

implementation

{$R *.dfm}

procedure TForm2.FormShow(Sender: TObject);
begin
  ListBox1.Items.LoadFromFile(EmailsFilePath);
  ShowInCombo(Form2);
  ClearFields;
  AddMode := false;
  ShowAtCenter(Form1,Form2);
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ListBox1.Items.SaveToFile(EmailsFilePath);
  Form1.LoadEmais;
end;

procedure TForm2.ClearFields;
begin
  Edit1.Clear;        
  Edit2.Clear;
  Edit3.Clear;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  AddMode := true;
  ClearFields;
  SpinEdit1.Text := '110';
  CurrentEmail.name := InputBox(Form1.Language.EmailSettings.EmailName,Form1.Language.EmailSettings.EnterServersName + ':','');
  GroupBox1.Caption := ' ' + Form1.Language.EmailSettings.EmailInfo + ' --> '
  + CurrentEmail.name;
end;

procedure TForm2.ListBox1Click(Sender: TObject);
begin
  Edit1.Text := DecodeEmail(ListBox1.Items[ComboBox1.ItemIndex]).host;
  SpinEdit1.Text := IntToStr(DecodeEmail(ListBox1.Items[ComboBox1.ItemIndex]).port);
  Edit2.Text := DecodeEmail(ListBox1.Items[ComboBox1.ItemIndex]).login;
  Edit3.Text := DecodeEmail(ListBox1.Items[ComboBox1.ItemIndex]).password;

  GroupBox1.Caption := ' ' + Form1.Language.EmailSettings.EmailInfo + ' --> '
  + DecodeEmail(ListBox1.Items[ComboBox1.ItemIndex]).name + ' ';
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  CurrentEmail.name := InputBox(Form1.Language.EmailSettings.EmailName,Form1.Language.EmailSettings.EnterServersName + ':','');
  GroupBox1.Caption := ' ' + Form1.Language.EmailSettings.EmailInfo + ' --> '
  + CurrentEmail.name;

end;

procedure TForm2.Button4Click(Sender: TObject);
begin
  if (CurrentEmail.name = '') then
    exit;

  CurrentEmail.host     := Edit1.Text;
  CurrentEmail.port     := StrToInt(SpinEdit1.Text);
  CurrentEmail.login    := Edit2.Text;
  CurrentEmail.password := Edit3.Text;

  if AddMode then
  begin
    ListBox1.Items.Add(EncodeEmail(CurrentEmail));
    AddMode := false;
  end
  else
  begin
     ListBox1.Items[ComboBox1.ItemIndex] := EncodeEmail(CurrentEmail)
  end;

  ShowInCombo(Form2);
end;

procedure TForm2.Button5Click(Sender: TObject);
begin
  CurrentEmail.name := '';
end;

procedure TForm2.Button3Click(Sender: TObject);
var
s : word;
begin
  s := MessageDlg(Form1.Language.ClearList.AreYouSure + '?',mtConfirmation,[mbYes,mbNo],0);
  if s = mrYes then
  begin
    ListBox1.Items.Delete(ComboBox1.ItemIndex);
    ClearFields;
    ComboBox1.ItemIndex := -1;
    ShowInCombo(Form2);
    GroupBox1.Caption := ' ' + Form1.Language.EmailSettings.EmailInfo + ' ';
  end;
end;

procedure TForm2.ComboBox1Click(Sender: TObject);
begin
  if ComboBox1.ItemIndex > -1 then
  begin
    Button2.Enabled := true;
    Edit1.Text := DecodeEmail(ListBox1.Items[ComboBox1.ItemIndex]).host;
    SpinEdit1.Text := IntToStr(DecodeEmail(ListBox1.Items[ComboBox1.ItemIndex]).port);
    Edit2.Text := DecodeEmail(ListBox1.Items[ComboBox1.ItemIndex]).login;
    Edit3.Text := DecodeEmail(ListBox1.Items[ComboBox1.ItemIndex]).password;

    GroupBox1.Caption := ' ' + Form1.Language.EmailSettings.EmailInfo + ' --> '
    + DecodeEmail(ListBox1.Items[ComboBox1.ItemIndex]).name + ' ';
  end
  else
  begin
    Button2.Enabled := false;
  end;
end;

procedure TForm2.ShowInCombo(Sender: TObject);
var
  i : integer;
begin
  ComboBox1.Clear;
  for i := 0 to ListBox1.Items.Count-1 do
    ComboBox1.Items.Add(DecodeEmail(ListBox1.Items[i]).name);
end;

end.
