unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IniFiles, StdCtrls, Mail_View, ExtCtrls, Unit1;

type
  TForm4 = class(TForm)
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    CheckBox3: TCheckBox;
    ComboBox1: TComboBox;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    procedure ReadSettings;
    procedure WriteSettings;
    procedure LoadLanguageFiles;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure CheckBox1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    LangList : TStringList;
    settings : TIniFile;

    AutomaticGet    : boolean;
    GetInterval     : Word;
    AutomaticView   : boolean;
    SaveLinksOnExit : boolean;
    LanguageFile    : string;
    TimeOutInterval : Word;
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

procedure TForm4.ReadSettings();
begin
  settings := TIniFile.Create(ExtractFilePath(paramstr(0))+'settings\settings.ini');

  AutomaticGet := settings.ReadBool('MODES','AutomaticGet',false);
  GetInterval := settings.ReadInteger('INTERVALS','GetInterval',0);
  AutomaticView := settings.ReadBool('MODES','AutomaticView',false);
  SaveLinksOnExit := settings.ReadBool('MODES','SaveLinksOnExit',false);
  LanguageFile := settings.ReadString('INTERFACE','LanguageFile','Russian.ini');
  TimeOutInterval := settings.ReadInteger('INTERVALS','TimeOutInterval',300);

  settings.Free;
end;

procedure TForm4.WriteSettings();
begin
  settings := TIniFile.Create(ExtractFilePath(paramstr(0))+'settings\settings.ini');

  settings.WriteBool('MODES','AutomaticGet',AutomaticGet);
  settings.WriteInteger('INTERVALS','GetInterval',GetInterval);
  settings.WriteBool('MODES','AutomaticView',AutomaticView);
  settings.WriteBool('MODES','SaveLinksOnExit',SaveLinksOnExit);
  settings.WriteString('INTERFACE','LanguageFile',LanguageFile);
  settings.WriteInteger('INTERVALS','TimeOutInterval',TimeOutInterval);

  settings.Free;
end;

procedure TForm4.LoadLanguageFiles;
var LangDir  : TSearchRec;
    LangFile : TIniFile;
    i        : integer;
begin
  ComboBox1.Clear;

  LangList := TStringList.Create;

  if FindFirst(ExtractFilePath(paramstr(0))+'languages\*.ini', faAnyFile, LangDir) = 0 then
  begin
    repeat
      LangList.Add(LangDir.Name);
    until FindNext(LangDir) <> 0;
    FindClose(LangDir);
  end;

  for i := 0 to LangList.Count-1 do
  begin
    LangFile := TIniFile.Create(ExtractFilePath(paramstr(0))+'\languages\'+LangList.Strings[i]);
    ComboBox1.Items.Add(LangFile.ReadString('INFO','LanguageName','NULL'));
    LangFile.Free;
  end;
end;

procedure TForm4.FormShow(Sender: TObject);
begin
  ReadSettings();
  LoadLanguageFiles;

  CheckBox1.Checked := AutomaticGet;
  CheckBox2.Checked := AutomaticView;
  Edit1.Text := IntToStr(trunc(GetInterval/60));
  CheckBox3.Checked := SaveLinksOnExit;
  ComboBox1.ItemIndex := LangList.IndexOf(LanguageFile);
  Edit2.Text := IntToStr((TimeOutInterval));

  ShowAtCenter(Form1,Form4);
end;

procedure TForm4.Button1Click(Sender: TObject);
begin
  AutomaticGet := CheckBox1.Checked;
  AutomaticView := CheckBox2.Checked;
  GetInterval := 60*StrToInt(Edit1.Text);
  SaveLinksOnExit := CheckBox3.Checked;
  TimeOutInterval := StrToInt(Edit2.Text);

  if ComboBox1.ItemIndex > -1 then
  begin
    LanguageFile := LangList.Strings[ComboBox1.ItemIndex];
  end;

  WriteSettings();

  Form4.Close;
end;

procedure TForm4.Button2Click(Sender: TObject);
begin
  Form4.Close;
end;

procedure TForm4.FormCreate(Sender: TObject);
begin
  ComboBox1.Clear;
  Form4.ReadSettings;
end;

procedure TForm4.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Form4.WriteSettings;
  Form1.LoadSettings;
  Form1.LoadGetInterval;
  Form1.LoadLanguage;
  LangList.Free;
end;

procedure TForm4.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  case Key of
    '0'..'9' : ;
    #8       : ;
  else Key := #0;
  end;
end;

procedure TForm4.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked then
  begin
    Edit1.Enabled := true;
    Label1.Enabled := true;
  end
  else
  begin
    Edit1.Enabled := false;
    Label1.Enabled := false;
  end;
end;

procedure TForm4.FormActivate(Sender: TObject);
begin
  if CheckBox1.Checked then
  begin
    Edit1.Enabled := true;
    Label1.Enabled := true;
  end
  else
  begin
    Edit1.Enabled := false;
    Label1.Enabled := false;
  end;
end;

procedure TForm4.Button3Click(Sender: TObject);
begin
  LoadLanguageFiles;
end;

end.
