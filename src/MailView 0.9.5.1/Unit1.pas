unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, OleCtrls, SHDocVw, StdCtrls, Psock, Mail_View,
  ExtCtrls, IniFiles, Menus, ToolWin, Grids, cef, ceflib,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdMessageClient, IdPOP3, IdMessage, Gauges, IdAntiFreezeBase,
  IdAntiFreeze;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    Timer1: TTimer;
    Timer2: TTimer;
    Timer3: TTimer;
    Timer4: TTimer;
    Panel4: TPanel;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    StatusBar1: TStatusBar;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    MReadLinks: TMenuItem;
    MWriteLinks: TMenuItem;
    MClear: TMenuItem;
    MExit: TMenuItem;
    MSettingsEmail: TMenuItem;
    MSettingsSponsors: TMenuItem;
    MSettingsProgram: TMenuItem;
    TabControl1: TTabControl;
    GroupBox3: TGroupBox;
    StringGrid1: TStringGrid;
    Panel2: TPanel;
    Memo1: TMemo;
    SaveDialog1: TSaveDialog;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Browser: TChromium;
    IdPOP31: TIdPOP3;
    IdMessage1: TIdMessage;
    Gauge1: TGauge;
    Gauge2: TGauge;
    IdAntiFreeze1: TIdAntiFreeze;
    buffer: TMemo;
    MFile: TMenuItem;
    MSettings: TMenuItem;
    MHelp: TMenuItem;
    MIndex: TMenuItem;
    MStat: TMenuItem;
    MAbout: TMenuItem;
    TimeOutTimer: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    //-------------------------------------------------------------------------
    procedure LoadEmais;
    procedure LoadSponsors;
    procedure LoadSettings;
    procedure LoadLanguage;
    procedure LoadDefaultDynamicElements;
    procedure LoadPosition;
    procedure WritePosition;
    procedure LoadGetInterval;
    procedure DeleteTempFiles;
    procedure GetLinks;
    procedure ViewLink;
    procedure ClearList;
    procedure WriteLinksIntoFile;
    procedure ReadLinksFromFile;
    procedure ShowInTable(Sender: TObject);
    function GetDate:string;
    //-------------------------------------------------------------------------
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure Timer4Timer(Sender: TObject);
    procedure BrowserBeforeBrowse(Sender: TCustomChromium;
      const browser: ICefBrowser; const frame: ICefFrame;
      const request: ICefRequest; navType: TCefHandlerNavtype;
      isRedirect: Boolean; out Result: TCefRetval);
    procedure BrowserLoadEnd(Sender: TCustomChromium;
      const browser: ICefBrowser; const frame: ICefFrame;
      httpStatusCode: Integer; out Result: TCefRetval);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure MReadLinksClick(Sender: TObject);
    procedure MWriteLinksClick(Sender: TObject);
    procedure MClearClick(Sender: TObject);
    procedure MExitClick(Sender: TObject);
    procedure MSettingsEmailClick(Sender: TObject);
    procedure MSettingsSponsorsClick(Sender: TObject);
    procedure MSettingsProgramClick(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure MStatClick(Sender: TObject);
    procedure MAboutClick(Sender: TObject);
    procedure MIndexClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TimeOutTimerTimer(Sender: TObject);
  published
//gyjg
  private
//    procedure WMWINDOWPOSCHANGING(var Msg: TWMWINDOWPOSCHANGING);
//    message WM_WINDOWPOSCHANGING;
  public
    CurrentLink     : Word;
    MaxLink         : Word;
    AutomaticGet    : boolean;
    GetInterval     : LongWord;
    AutomaticView   : boolean;
    TimeOutInterval : Word;
    ViewDone        : boolean;
    GetProcessing   : boolean;
    settings        : TIniFile;
    TimeLeft        : LongWord;
    SaveLinksOnExit : boolean;
    LanguageFile    : string;
    Language        : TDynamicInterface;
  end;

var
  Form1: TForm1;
//-----------------------------------------------------------------------------
  Sponsor    : array[1..255] of TSponsor;
  Email      : array[1..255] of TEmail;
  Link2Click : array[1..65535] of TLink2Click;
  SPONSORS   : byte;
  EMAILS     : byte;
//-----------------------------------------------------------------------------
implementation

uses Unit2, Unit3, Unit4, Unit5, Unit6;

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  Form1.CurrentLink := 0;
  Form1.MaxLink := 0;

  Form1.LoadEmais;
  Form1.LoadSponsors;
  Form1.LoadSettings;
  Form1.LoadPosition;
  Form1.LoadDefaultDynamicElements;

  Form1.ViewDone := true;
  GetProcessing := false;

  DeleteTempFiles;

  StringGrid1.Cells[0,0] := ' ' + Language.Table.Number;
  StringGrid1.Cells[1,0] := ' ' + Language.Table.Link;
  StringGrid1.Cells[2,0] := ' ' + Language.Table.Interval;
  StringGrid1.Cells[3,0] := ' ' + Language.Table.Status;

  Memo1.Clear;
  SaveDialog1.InitialDir := GetCurrentDir;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  Form1.LoadLanguage;

  StringGrid1.Cells[0,0] := ' ' + Language.Table.Number;
  StringGrid1.Cells[1,0] := ' ' + Language.Table.Link;
  StringGrid1.Cells[2,0] := ' ' + Language.Table.Interval;
  StringGrid1.Cells[3,0] := ' ' + Language.Table.Status;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  StringGrid1.ColWidths[1]:= Form1.Width-380;

  if StringGrid1.Cells[1,1] = '' then
    StringGrid1.RowCount := trunc(1+StringGrid1.Height
    /(StringGrid1.DefaultRowHeight
    +StringGrid1.GridLineWidth));
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Form1.DeleteTempFiles;
  if Form1.SaveLinksOnExit then
  begin
    Form1.WriteLinksIntoFile;
  end;
  Form1.WritePosition;
end;
{
procedure TForm1.WMWINDOWPOSCHANGING(var Msg: TWMWINDOWPOSCHANGING);
var
  rWorkArea: TRect;
  d : Word;
begin
  d := 10;

  SystemParametersInfo(SPI_GETWORKAREA, 0, @rWorkArea, 0);

  with Msg.WindowPos^ do
  with rWorkArea do
  begin
    if (x <= Left + d) then
      x := Left;

    if (x + cx >= Right - d) then
      x := Right - cx;

    if (y <= Top + d) then
      y := Top;

    if (y + cy >= Bottom - d) then
      y := Bottom - cy;

    if (x < Left) then
      x := Left;
    if (x + cx > Right) then
      x := Right - cx;
    if (y < Top) then
      y := Top;
    if (y + cy > Bottom) then
      y := Bottom - cy;
  end;
  inherited;
end;
}
procedure TForm1.LoadEmais;
var
  EmailsFile : TextFile;
  Readstring : string;
  ReadEmail  : TEmail;
begin
  AssignFile(EmailsFile,EmailsFilePath);
  try
    Reset(EmailsFile);
  except
    CloseFile(EmailsFile);
    exit;
  end;

  EMAILS := 0;
  while not eof(EmailsFile) do
  begin
    readln(EmailsFile,Readstring);
    inc(EMAILS);
    ReadEmail := DecodeEmail(Readstring);
    email[EMAILS].name := ReadEmail.name;
    email[EMAILS].host := ReadEmail.host;
    email[EMAILS].port := ReadEmail.port;
    email[EMAILS].login := ReadEmail.login;
    email[EMAILS].password := ReadEmail.password;
  end;

  CloseFile(EmailsFile);
end;

procedure TForm1.LoadSponsors;
var
  SponsorsFile : TextFile;
  Readstring   : string;
  ReadSponsor  : TSponsor;
begin
  AssignFile(SponsorsFile,SponsorsFilePath);
  try
    Reset(SponsorsFile);
  except
    CloseFile(SponsorsFile);
    exit;
  end;

  SPONSORS := 0;
  while not eof(SponsorsFile) do
  begin
    readln(SponsorsFile,Readstring);
    inc(SPONSORS);
    ReadSponsor := DecodeSponsor(Readstring);
    sponsor[SPONSORS].name := ReadSponsor.name;
    sponsor[SPONSORS].mask := ReadSponsor.mask;
    sponsor[SPONSORS].len := ReadSponsor.len;

    if ReadSponsor.interval <> 0
    then
      sponsor[SPONSORS].interval := ReadSponsor.interval
    else
      sponsor[SPONSORS].interval := 120;
  end;

  CloseFile(SponsorsFile);
end;

procedure TForm1.LoadSettings();
var
  sPath : string;
begin
  GetDir(0,sPath);
  settings := TIniFile.Create(sPath+'\settings\settings.ini');

  Form1.AutomaticGet    := settings.ReadBool('MODES','AutomaticGet',false);
  Form1.AutomaticView   := settings.ReadBool('MODES','AutomaticView',false);
  Form1.GetInterval     := settings.ReadInteger('INTERVALS','GetInterval',0);
  Form1.TimeOutInterval := settings.ReadInteger('INTERVALS','TimeOutInterval',180);
  Form1.SaveLinksOnExit := settings.ReadBool('MODES','SaveLinksOnExit',false);
  Form1.LanguageFile    := settings.ReadString('INTERFACE','LanguageFile','Russian.ini');

  settings.Free;
end;

procedure TForm1.LoadLanguage();
var
  sPath : string;
  LangFile : TIniFile;
begin
  GetDir(0,sPath);
  LangFile := TIniFile.Create(sPath+'\languages\' + Form1.LanguageFile);

  //First of all let's load static elements
  //Form1
  //Buttons
  Button1.Caption := LangFile.ReadString('STATIC','GetLinks',Button1.Caption);
  Button2.Caption := LangFile.ReadString('STATIC','ViewLink',Button2.Caption);
  Button3.Caption := LangFile.ReadString('STATIC','ClearList',Button3.Caption);
  Button4.Caption := LangFile.ReadString('STATIC','Clean',Button4.Caption);
  Button5.Caption := LangFile.ReadString('STATIC','Save',Button5.Caption);
  Button6.Caption := LangFile.ReadString('STATIC','ReadLinks',Button6.Caption);
  Button7.Caption := LangFile.ReadString('STATIC','WriteLinks',Button7.Caption);
  //there may be bug
  //already fixed
  GroupBox1.Caption := ' ' + LangFile.ReadString('STATIC','LinksStatistic',copy(GroupBox1.Caption,2,length(GroupBox1.Caption)-1)) + ' ';
  GroupBox2.Caption := ' ' + LangFile.ReadString('STATIC','Actions',copy(GroupBox2.Caption,2,length(GroupBox2.Caption)-1)) + ' ';
  GroupBox3.Caption := ' ' + LangFile.ReadString('STATIC','LinkView',copy(GroupBox3.Caption,2,length(GroupBox3.Caption)-1)) + ' ';
  //Labels
  Label3.Caption := LangFile.ReadString('STATIC','ViewProgress',copy(Label3.Caption,1,length(Label3.Caption)-1)) + ':';
  Label4.Caption := LangFile.ReadString('STATIC','GetProgress',copy(Label4.Caption,1,length(Label4.Caption)-1)) + ':';
  //TabControls
  TabControl1.Tabs[0] := LangFile.ReadString('STATIC','LinkView',TabControl1.Tabs[0]);
  TabControl1.Tabs[1] := LangFile.ReadString('STATIC','ListOfLinks',TabControl1.Tabs[1]);
  TabControl1.Tabs[2] := LangFile.ReadString('STATIC','WorkLog',TabControl1.Tabs[2]);
  //MainMenu Items
  MFile.Caption             := LangFile.ReadString('STATIC','File',MFile.Caption);
  MReadLinks.Caption        := LangFile.ReadString('STATIC','ReadLinksFromFile',MReadLinks.Caption);
  MWriteLinks.Caption       := LangFile.ReadString('STATIC','WriteLinksIntoFile',MWriteLinks.Caption);
  MClear.Caption            := LangFile.ReadString('STATIC','ClearList',MClear.Caption);
  MExit.Caption             := LangFile.ReadString('STATIC','Quit',MExit.Caption);
  MSettings.Caption         := LangFile.ReadString('STATIC','Settings',MSettings.Caption);
  MSettingsEmail.Caption    := LangFile.ReadString('STATIC','EmailSettings',MSettingsEmail.Caption);
  MSettingsSponsors.Caption := LangFile.ReadString('STATIC','SponsorsSettings',MSettingsSponsors.Caption);
  MSettingsProgram.Caption  := LangFile.ReadString('STATIC','ProgramSettings',MSettingsProgram.Caption);
  MHelp.Caption             := LangFile.ReadString('STATIC','Help',MHelp.Caption);
  MIndex.Caption            := LangFile.ReadString('STATIC','Index',MIndex.Caption);
  MStat.Caption             := LangFile.ReadString('STATIC','Statistic',MStat.Caption);
  MAbout.Caption            := LangFile.ReadString('STATIC','About',MAbout.Caption);

  //Form2
  Form2.Caption := LangFile.ReadString('STATIC','EmailSettings',Form2.Caption);
  //Buttons
  Form2.Button1.Caption := LangFile.ReadString('STATIC','Add',Form2.Button1.Caption);
  Form2.Button2.Caption := LangFile.ReadString('STATIC','Rename',Form2.Button2.Caption);
  Form2.Button3.Caption := LangFile.ReadString('STATIC','Delete',Form2.Button3.Caption);
  Form2.Button4.Caption := LangFile.ReadString('STATIC','OK',Form2.Button4.Caption);
  Form2.Button5.Caption := LangFile.ReadString('STATIC','Cancel',Form2.Button5.Caption);
  //Labels
  Form2.Label1.Caption := LangFile.ReadString('STATIC','Host',copy(Form2.Label1.Caption,1,length(Form2.Label1.Caption)-1)) + ':';
  Form2.Label2.Caption := LangFile.ReadString('STATIC','Port',copy(Form2.Label2.Caption,1,length(Form2.Label2.Caption)-1)) + ':';
  Form2.Label3.Caption := LangFile.ReadString('STATIC','Login',copy(Form2.Label3.Caption,1,length(Form2.Label3.Caption)-1)) + ':';
  Form2.Label4.Caption := LangFile.ReadString('STATIC','Password',copy(Form2.Label4.Caption,1,length(Form2.Label4.Caption)-1)) + ':';

  //Form3
  Form3.Caption := LangFile.ReadString('STATIC','SponsorsSettings',Form3.Caption);
  //Buttons
  Form3.Button1.Caption := LangFile.ReadString('STATIC','Add',Form3.Button1.Caption);
  Form3.Button2.Caption := LangFile.ReadString('STATIC','Edit',Form3.Button2.Caption);
  Form3.Button3.Caption := LangFile.ReadString('STATIC','Delete',Form3.Button3.Caption);
  Form3.Button4.Caption := LangFile.ReadString('STATIC','Save',Form3.Button4.Caption);
  Form3.Button5.Caption := LangFile.ReadString('STATIC','Cancel',Form3.Button5.Caption);
  //Labels
  Form3.Label1.Caption := LangFile.ReadString('STATIC','Name',copy(Form3.Label1.Caption,1,length(Form3.Label1.Caption)-1)) + ':';
  Form3.Label2.Caption := LangFile.ReadString('STATIC','Mask',copy(Form3.Label2.Caption,1,length(Form3.Label2.Caption)-1)) + ':';
  Form3.Label3.Caption := LangFile.ReadString('STATIC','LinkLen',copy(Form3.Label3.Caption,1,length(Form3.Label3.Caption)-1)) + ':';
  Form3.Label4.Caption := LangFile.ReadString('STATIC','ViewInterval',copy(Form3.Label4.Caption,1,length(Form3.Label4.Caption)-1)) + ':';
  //GroupBoxes
  Form3.GroupBox2.Caption := ' ' + LangFile.ReadString('STATIC','SponsorsList',copy(Form3.GroupBox2.Caption,2,length(Form3.GroupBox2.Caption)-1)) + ' ';

  //Form4
  Form4.Caption := LangFile.ReadString('STATIC','ProgramSettings',Form4.Caption);
  //CheckBoxes
  Form4.CheckBox1.Caption := LangFile.ReadString('STATIC','AutomaticLinksGetIn',copy(Form4.CheckBox1.Caption,1,length(Form4.CheckBox1.Caption)-1)) + ':';
  Form4.CheckBox2.Caption := LangFile.ReadString('STATIC','AutomaticLinksView',Form4.CheckBox2.Caption);
  Form4.CheckBox3.Caption := LangFile.ReadString('STATIC','SaveLinksListOnExit',Form4.CheckBox3.Caption);
  //Labels
  Form4.Label1.Caption := LangFile.ReadString('STATIC','Min',Form4.Label1.Caption);
  Form4.Label2.Caption := LangFile.ReadString('STATIC','Language',copy(Form4.Label2.Caption,1,length(Form4.Label2.Caption)-1)) + ':';
  //Buttons
  Form4.Button1.Caption := LangFile.ReadString('STATIC','OK',Form4.Button1.Caption);
  Form4.Button2.Caption := LangFile.ReadString('STATIC','Cancel',Form4.Button2.Caption);

  //Form5
  Form5.Caption := LangFile.ReadString('STATIC','Statistic',Form5.Caption);

  //Form6
  Form6.Caption := LangFile.ReadString('STATIC','About',Form6.Caption);
  //Labels
  Form6.Label3.Caption := LangFile.ReadString('STATIC','Description',Form6.Label3.Caption);

  //now we load dynamic elements
  Language.LinkStatistic.Viewed := LangFile.ReadString('DYNAMIC','Viewed',Language.LinkStatistic.Viewed);
  Language.LinkStatistic.Total  := LangFile.ReadString('DYNAMIC','Total',Language.LinkStatistic.Total);

  Language.Table.Number   := LangFile.ReadString('DYNAMIC','Number',Language.Table.Number);
  Language.Table.Link     := LangFile.ReadString('DYNAMIC','Link',Language.Table.Link);
  Language.Table.Interval := LangFile.ReadString('DYNAMIC','Interval',Language.Table.Interval);
  Language.Table.Status   := LangFile.ReadString('DYNAMIC','Status',Language.Table.Status);

  Language.LinkStatus.Ready   := LangFile.ReadString('DYNAMIC','Ready',Language.LinkStatus.Ready);
  Language.LinkStatus.Reading := LangFile.ReadString('DYNAMIC','Reading',Language.LinkStatus.Reading);
  Language.LinkStatus.Done    := LangFile.ReadString('DYNAMIC','Done',Language.LinkStatus.Done);

  Language.LinksGet.StartingLinksCollection  := LangFile.ReadString('DYNAMIC','StartingLinksCollection',Language.LinksGet.StartingLinksCollection);
  Language.LinksGet.ConnectToServer          := LangFile.ReadString('DYNAMIC','ConnentToServer',Language.LinksGet.ConnectToServer);
  Language.LinksGet.ThereAre                 := LangFile.ReadString('DYNAMIC','ThereAre',Language.LinksGet.ThereAre);
  Language.LinksGet.MailsOnServer            := LangFile.ReadString('DYNAMIC','MailsOnServer',Language.LinksGet.MailsOnServer);
  Language.LinksGet.MailsCollectedFromServer := LangFile.ReadString('DYNAMIC','MailsCollectedFromServer',Language.LinksGet.MailsCollectedFromServer);

  Language.Modes.Get.ManuallyLinksCollect              := LangFile.ReadString('DYNAMIC','ManuallyLinksCollect',Language.Modes.Get.ManuallyLinksCollect);
  Language.Modes.Get.NextLinksCollectIn                := LangFile.ReadString('DYNAMIC','NextLinksCollectIn',Language.Modes.Get.NextLinksCollectIn);
  Language.Modes.Get.Sec                               := LangFile.ReadString('DYNAMIC','Sec',Language.Modes.Get.Sec);
  Language.Modes.Get.LinksCollectionProcessedManually  := LangFile.ReadString('DYNAMIC','LinksCollectionProcessedManually',Language.Modes.Get.LinksCollectionProcessedManually);
  Language.Modes.Get.LinksCollectionProcessedAutomatic := LangFile.ReadString('DYNAMIC','LinksCollectionProcessedAutomatic',Language.Modes.Get.LinksCollectionProcessedAutomatic);

  Language.Modes.View.ManuallyView  := LangFile.ReadString('DYNAMIC','ManuallyView',Language.Modes.View.ManuallyView);
  Language.Modes.View.AutomaticView := LangFile.ReadString('DYNAMIC','AutomaticView',Language.Modes.View.AutomaticView);

  Language.ClearList.AreYouSure            := LangFile.ReadString('DYNAMIC','AreYouSure',Language.ClearList.AreYouSure);
  Language.ClearList.ListOfLinksWasCleaned := LangFile.ReadString('DYNAMIC','ListOfLinksWasCleaned',Language.ClearList.ListOfLinksWasCleaned);

  Language.WriteLinksIntoFile.LinksWritedIntoFile := LangFile.ReadString('DYNAMIC','LinksWritedIntoFile',Language.WriteLinksIntoFile.LinksWritedIntoFile);

  Language.ReadLinksFromFile.LoadingLinksFromFile := LangFile.ReadString('DYNAMIC','LoadingLinksFromFile',Language.ReadLinksFromFile.LoadingLinksFromFile);
  Language.ReadLinksFromFile.LinksLoadedFromFile  := LangFile.ReadString('DYNAMIC','LinksLoadedFromFile',Language.ReadLinksFromFile.LinksLoadedFromFile);

  Language.EmailSettings.EmailName        := LangFile.ReadString('DYNAMIC','EmailName',Language.EmailSettings.EmailName);
  Language.EmailSettings.EnterServersName := LangFile.ReadString('DYNAMIC','EnterServersName',Language.EmailSettings.EnterServersName);
  Language.EmailSettings.EmailInfo        := LangFile.ReadString('DYNAMIC','EmailInfo',Language.EmailSettings.EmailInfo);

  Language.SponsorsSettings.SponsorsName      := LangFile.ReadString('DYNAMIC','SponsorsName',Language.SponsorsSettings.SponsorsName);
  Language.SponsorsSettings.EnterSponsorsName := LangFile.ReadString('DYNAMIC','EnterSponsorsName',Language.SponsorsSettings.EnterSponsorsName);
  Language.SponsorsSettings.SponsorInfo       := LangFile.ReadString('DYNAMIC','SponsorInfo',Language.SponsorsSettings.SponsorInfo);

  Language.SponsorsSettings.LinkLengthMustBeLess   := LangFile.ReadString('DYNAMIC','LinkLengthMustBeLess',Language.SponsorsSettings.LinkLengthMustBeLess);
  Language.SponsorsSettings.ViewIntervalMustBeLess := LangFile.ReadString('DYNAMIC','ViewIntervalMustBeLess',Language.SponsorsSettings.ViewIntervalMustBeLess);

  LangFile.Free;

  StringGrid1.Cells[0,0] := ' ' + Language.Table.Number;
  StringGrid1.Cells[1,0] := ' ' + Language.Table.Link;
  StringGrid1.Cells[2,0] := ' ' + Language.Table.Interval;
  StringGrid1.Cells[3,0] := ' ' + Language.Table.Status;
end;

procedure TForm1.LoadDefaultDynamicElements;
begin
  Language.LinkStatistic.Viewed := 'Viewed';
  Language.LinkStatistic.Total  := 'Total';

  Language.Table.Number   := '№';
  Language.Table.Link     := 'Link';
  Language.Table.Interval := 'Interval';
  Language.Table.Status   := 'Status';

  Language.LinkStatus.Ready   := 'ready';
  Language.LinkStatus.Reading := 'reading';
  Language.LinkStatus.Done    := 'done';

  Language.LinksGet.StartingLinksCollection  := 'Начало сбора писем';
  Language.LinksGet.ConnectToServer          := 'Подключение к серверу';
  Language.LinksGet.ThereAre                 := 'На сервере';
  Language.LinksGet.MailsOnServer            := 'писем';
  Language.LinksGet.MailsCollectedFromServer := 'писем собрано с сервера';

  Language.Modes.Get.ManuallyLinksCollect              := 'Сбор писем вручную';
  Language.Modes.Get.NextLinksCollectIn                := 'Сбор писем через';
  Language.Modes.Get.Sec                               := 'сек';
  Language.Modes.Get.LinksCollectionProcessedManually  := 'Идет сбор писем (Вручную)';
  Language.Modes.Get.LinksCollectionProcessedAutomatic := 'Идет сбор писем (Автоматически)';

  Language.Modes.View.ManuallyView  := 'Просмотр вручную';
  Language.Modes.View.AutomaticView := 'Автоматический просмотр';

  Language.ClearList.AreYouSure            := 'Are you sure';
  Language.ClearList.ListOfLinksWasCleaned := 'Список ссылок очищен';

  Language.WriteLinksIntoFile.LinksWritedIntoFile := 'Ссылки записаны в файл';

  Language.ReadLinksFromFile.LoadingLinksFromFile := 'Загрузка ссылок из файла';
  Language.ReadLinksFromFile.LinksLoadedFromFile  := 'ссылок загружено из файла';

  Language.EmailSettings.EmailName        := 'Name';
  Language.EmailSettings.EnterServersName := 'Enter server' + #39 + 's name';
  Language.EmailSettings.EmailInfo        := 'Email Info';

  Language.SponsorsSettings.SponsorsName           := 'Name';
  Language.SponsorsSettings.EnterSponsorsName      := 'Enter sponsor'+#39+'s name';
  Language.SponsorsSettings.SponsorInfo            := 'Sponsor Info';
  Language.SponsorsSettings.LinkLengthMustBeLess   := 'Link length must be less';
  Language.SponsorsSettings.ViewIntervalMustBeLess := 'View interval must be less';
end;

procedure TForm1.LoadPosition();
var
  sPath : string;
begin
  GetDir(0,sPath);
  settings := TIniFile.Create(sPath+'\settings\settings.ini');

  Form1.Left := settings.ReadInteger('POSITION','Left',0);
  Form1.Top  := settings.ReadInteger('POSITION','Top',0);

  settings.Free;
end;

procedure TForm1.WritePosition;
var
  sPath : string;
begin
  GetDir(0,sPath);
  settings := TIniFile.Create(sPath+'\settings\settings.ini');

  settings.WriteInteger('POSITION','Left',Form1.Left);
  settings.WriteInteger('POSITION','Top',Form1.Top);

  settings.Free;
end;

procedure TForm1.LoadGetInterval();
begin
  TimeLeft := GetInterval;
  Timer3.Interval := 1000*GetInterval;
end;

procedure TForm1.DeleteTempFiles;
var
  FileName :TSearchRec;
  r :integer;
begin
  r := FindFirst('*.tmp',faAnyFile,FileName);
  if r = 0
    then
      DeleteFile(FileName.Name);
  while (FindNext(FileName) = 0) do
    DeleteFile(FileName.Name);
end;

procedure TForm1.GetLinks;
var
  m,n : byte;
  p : LongWord;
  i,NumMails : word;
  MessageText : WideString;
  CutLink : string;
  temp_MaxLink : word;
begin
  GetProcessing := true;
  Memo1.Lines.Add('  ' + GetDate + '   '
  + Language.LinksGet.StartingLinksCollection + #13);

  for m := 1 to EMAILS do
  begin
    temp_MaxLink := MaxLink;

    Memo1.Lines.Add('  ' + GetDate + '   '
    + Language.LinksGet.ConnectToServer + ' '
    + email[m].name + ' (' + email[m].host + ')   [' + IntToStr(m) + '/'
    + IntToStr(EMAILS)+ ']' + #13);

    IdPOP31.Host     := email[m].host;
    IdPOP31.Port     := email[m].port;
    IdPOP31.Username := email[m].login;
    IdPOP31.Password := email[m].password;
    IdPOP31.Connect;

    NumMails := IdPOP31.CheckMessages;

    Memo1.Lines.Add('  ' + GetDate + '   ' + Language.LinksGet.ThereAre + ' '
    + IntToStr(NumMails)+ ' ' + Language.LinksGet.MailsOnServer + #13);

    Gauge1.MaxValue := NumMails;

    for i := 1 to NumMails do
    begin
      Gauge1.Progress := i;

      MessageText := '';
      Idmessage1.Clear;
      buffer.Clear;

      IdPOP31.Retrieve(i,IdMessage1);
      buffer.lines.AddStrings(IdMessage1.Body);
      MessageText := buffer.Text;

      for n := 1 to SPONSORS do
      begin
        p := pos(sponsor[n].mask,MessageText);

        if p <> 0 then
        begin
          inc(Form1.MaxLink);
          CutLink := copy(MessageText,p,sponsor[n].len);
          link2click[Form1.MaxLink].link     := CutLink;
          link2click[Form1.MaxLink].interval := sponsor[n].interval;
          IdPOP31.Delete(i);
          break;
        end;
      end;
    end;
    IdPOP31.Disconnect;
    Gauge1.Progress := 0;

    Memo1.Lines.Add('  ' + GetDate + '   ' + IntToStr(MaxLink - temp_MaxLink)
    + ' ' + Language.LinksGet.MailsCollectedFromServer + ' ' + email[m].name
    + ' (' + email[m].host + ')   [' + IntToStr(m) + '/' + IntToStr(EMAILS)
    + ']' + #13);
  end;

  GetProcessing := false;
  ShowInTable(Form1);
end;

procedure TForm1.ViewLink;
begin
  TimeOutTimer.Enabled := false;
  inc(Form1.CurrentLink);
  if Form1.CurrentLink > Form1.MaxLink
  then
    begin
      dec(Form1.CurrentLink);
      if (Form1.MaxLink <> 0) then
        StringGrid1.Cells[3,CurrentLink] := ' ' + Language.LinkStatus.Done
      else
        StringGrid1.Cells[3,CurrentLink] := ' ' + Language.Table.Status;
      exit;
    end
  else
    begin
      TimeOutTimer.Interval := Form1.TimeOutInterval * 1000;
      TimeOutTimer.Enabled := true;

      Form1.ViewDone := false;
      Browser.Load(Link2Click[Form1.CurrentLink].link);
      Timer4.Interval := 1000*(5+Link2Click[Form1.CurrentLink].interval);
      Memo1.Lines.Add('  ' + GetDate + '   ' + 'Link #'
      + IntToStr(Form1.CurrentLink) + ' ['
      + IntToStr(Link2Click[Form1.CurrentLink].interval) + '] sec.' + #13);
    end;
  Form1.ShowInTable(Form1);
end;

procedure TForm1.ClearList;
var
  resp : word;
  i    : word;
  j    : byte;
begin
  resp := MessageDlg(Language.ClearList.AreYouSure + '?',mtConfirmation,[mbYes,mbNo],0);
  if resp = mrYes then
  begin
    for i := 1 to MaxLink do
    begin
      link2click[i].link     := '';
      link2click[i].interval := 0;
    end;
    CurrentLink := 0;
    MaxLink := 0;
    Memo1.Lines.Add('  ' + GetDate + '   '
    + Language.ClearList.ListOfLinksWasCleaned + #13);
  end
  else ;

  ShowInTable(Form1);

  for i := 1 to 2 do
  begin
    for j := 0 to 3 do
    begin
      StringGrid1.Cells[j,i] := '';
    end;
  end;
end;

procedure TForm1.WriteLinksIntoFile;
var
  LinksFile : TextFile;
  i : word;
begin
  AssignFile(LinksFile,'links.txt');
  Rewrite(LinksFile);

  for i := Form1.CurrentLink to Form1.MaxLink do
  begin
    if (Link2Click[i].link <> '') then
    begin
      writeln(LinksFile,EncodeLink2Click(Link2Click[i]));
    end;
  end;

  CloseFile(LinksFile);
  Memo1.Lines.Add('  ' + GetDate + '   '
  + Language.WriteLinksIntoFile.LinksWritedIntoFile + #13);
end;

procedure TForm1.ReadLinksFromFile;
var
  LinksFile : TextFile;
  Link2ClickToRead : string;
  temp_MaxLink : word;
begin
  temp_MaxLink := MaxLink;
  Memo1.Lines.Add('  ' + GetDate + '   '
  + Language.ReadLinksFromFile.LoadingLinksFromFile + #13);

  AssignFile(LinksFile,'links.txt');

  try
    Reset(LinksFile);
  except
    CloseFile(LinksFile);
    exit;
  end;

  while not eof(LinksFile) do
  begin
    readln(LinksFile,Link2ClickToRead);
    if (Link2ClickToRead <> '||0|') then
    begin
      inc(Form1.MaxLink);
      Link2Click[Form1.MaxLink] := DecodeLink2Click(Link2ClickToRead);
    end
  end;

  CloseFile(LinksFile);

  Memo1.Lines.Add('  ' + GetDate + '   ' + IntToStr(MaxLink - temp_MaxLink)
  + ' ' + Language.ReadLinksFromFile.LinksLoadedFromFile + #13);

  ShowInTable(Form1);
end;

procedure TForm1.ShowInTable(Sender: TObject);
var
  i : word;
begin
  StringGrid1.RowCount := MaxLink + 3;

  for i := 1 to MaxLink do
  begin
    StringGrid1.Cells[0,i] := IntToStr(i);
    StringGrid1.Cells[1,i] := Link2Click[i].link;
    StringGrid1.Cells[2,i] := IntToStr(Link2Click[i].interval);
  end;
                                                                                                                     //wdede
  if CurrentLink > 0 then
  begin
    for i := 1 to CurrentLink-1 do
    begin
      StringGrid1.Cells[3,i] := Language.LinkStatus.Done;
    end;

    StringGrid1.Cells[3,CurrentLink] := Language.LinkStatus.Reading;
    StringGrid1.Row := CurrentLink;
  end;

  for i := CurrentLink+1 to MaxLink do
    begin
      StringGrid1.Cells[3,i] := Language.LinkStatus.Ready;
    end;
end;

function TForm1.GetDate:string;
var
  Date, Time        : TDateTime;
  Year, Month, Day  : Word;
  space1, space2    : string;
begin
  Date := Now();
  Time := Now();
  DecodeDate(Date,Year,Month,Day);

  case Day of
    1..9 : space1 := '0'
  else     space1 := '';
  end;

  case Month of
    1..9   : space2 := '0';
    10..12 : space2 := '';
  end;
  result := space1 + IntToStr(Day) + '.' + space2 + IntToStr(Month)
  + '.' +IntToStr(Year) + '   ' + FormatDateTime('hh:mm:ss',Time);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  if AutomaticGet then
  begin
    Timer3.Enabled  := true;
  end
  else
  begin
    Timer3.Enabled := false;
  end;

  Label1.Caption := Language.LinkStatistic.Viewed + ': ' + IntToStr(CurrentLink);
  Label2.Caption := Language.LinkStatistic.Total + ': ' + IntToStr(MaxLink);

  if not GetProcessing then
  begin
    if not Form1.AutomaticGet then
    begin
      StatusBar1.Panels[0].Text := ' ' + Language.Modes.Get.ManuallyLinksCollect;
    end
    else
    begin
      StatusBar1.Panels[0].Text := ' ' + Language.Modes.Get.NextLinksCollectIn + ' '
      + IntToStr(TimeLeft)
      + ' ' + Language.Modes.Get.Sec + '.';
      dec(TimeLeft);
    end;
  end
  else
  begin
    if not Form1.AutomaticGet then
    begin
      StatusBar1.Panels[0].Text := ' ' + Language.Modes.Get.LinksCollectionProcessedManually;
    end
    else
    begin
      StatusBar1.Panels[0].Text := ' ' + Language.Modes.Get.LinksCollectionProcessedAutomatic;
    end;
  end;

  if not Form1.AutomaticView then
  begin
    StatusBar1.Panels[1].Text := ' ' + Language.Modes.View.ManuallyView;
  end
  else
  begin
    StatusBar1.Panels[1].Text := ' ' + Language.Modes.View.AutomaticView;
  end;

  if Form1.AutomaticView and Form1.ViewDone then
    Form1.ViewLink;

  Gauge2.MaxValue := Form1.MaxLink;
  Gauge2.Progress := Form1.CurrentLink;

  StatusBar1.Panels[2].Text := '   ' + GetDate;

  // advanced mode
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
  if TabControl1.TabIndex = 0
  then GroupBox3.Visible := true
  else GroupBox3.Visible := false;

  if TabControl1.TabIndex = 1
  then StringGrid1.Visible := true
  else StringGrid1.Visible := false;

  if TabControl1.TabIndex = 2
  then Panel2.Visible := true
  else Panel2.Visible := false;

  if GetProcessing then
  begin
    Form1.Button1.Enabled := false;
  end
  else
  begin
    Form1.Button1.Enabled := true;
  end;
end;

procedure TForm1.Timer3Timer(Sender: TObject);
begin
  if not GetProcessing then
    GetLinks();
  Form1.LoadGetInterval;
end;

procedure TForm1.Timer4Timer(Sender: TObject);
begin
  Form1.ViewDone := true;
end;

procedure TForm1.BrowserBeforeBrowse(Sender: TCustomChromium;
  const browser: ICefBrowser; const frame: ICefFrame;
  const request: ICefRequest; navType: TCefHandlerNavtype;
  isRedirect: Boolean; out Result: TCefRetval);
begin
  Form1.ViewDone := false;
  Timer4.Enabled := false;
end;

procedure TForm1.BrowserLoadEnd(Sender: TCustomChromium;
  const browser: ICefBrowser; const frame: ICefFrame;
  httpStatusCode: Integer; out Result: TCefRetval);
begin
  Timer4.Enabled := true;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Form1.GetLinks;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Form1.ViewLink;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Form1.ClearList;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  resp : word;
begin              
  resp := MessageDlg(Language.ClearList.AreYouSure + '?',mtConfirmation,[mbYes,mbNo],0);
  if resp = mrYes then
  begin
    Memo1.Clear;
  end;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
  begin
    if pos('.txt',SaveDialog1.FileName) = 0 then
      SaveDialog1.FileName := SaveDialog1.FileName + '.txt';
  end;

  if SaveDialog1.FileName = ''
    then
      Exit;
  if pos('.txt',SaveDialog1.FileName) = 0
    then
      SaveDialog1.FileName := SaveDialog1.FileName + '.txt';

  Memo1.Lines.SaveToFile(SaveDialog1.FileName);
end;

procedure TForm1.MReadLinksClick(Sender: TObject);
begin
  Form1.ReadLinksFromFile;
end;

procedure TForm1.MWriteLinksClick(Sender: TObject);
begin
  Form1.WriteLinksIntoFile;
end;

procedure TForm1.MClearClick(Sender: TObject);
begin
  Form1.ClearList;
end;

procedure TForm1.MExitClick(Sender: TObject);
begin
  Form1.Close;
end;

procedure TForm1.MSettingsEmailClick(Sender: TObject);
begin
  Form2.ShowModal;
end;

procedure TForm1.MSettingsSponsorsClick(Sender: TObject);
begin
  Form3.ShowModal;
end;

procedure TForm1.MSettingsProgramClick(Sender: TObject);
begin
  Form4.ShowModal;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  Form1.ReadLinksFromFile;
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  Form1.WriteLinksIntoFile;
end;

procedure TForm1.MStatClick(Sender: TObject);
begin
  Form5.ShowModal;
end;

procedure TForm1.MAboutClick(Sender: TObject);
begin
  Form6.ShowModal;
end;

procedure TForm1.MIndexClick(Sender: TObject);
begin
  //Show help
end;

procedure TForm1.TimeOutTimerTimer(Sender: TObject);
begin
  Form1.ViewLink;
  TimeOutTimer.Enabled := false;
end;

end.

