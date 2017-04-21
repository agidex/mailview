unit Unit6;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Unit1, Mail_View;

type
  TForm6 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Button1: TButton;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form6: TForm6;

implementation

{$R *.dfm}

procedure TForm6.FormShow(Sender: TObject);
begin
  Label1.Left := round(Form6.Width/2 + Form6.Width/4 - Label1.Width/2-20);
  Label2.Left := round(Form6.Width/2 + Form6.Width/4 - Label2.Width/2-20);
  Label3.Left := round(Form6.Width/2 + Form6.Width/4 - Label3.Width/2-20);
  Button1.Left := round(Form6.Width/2 + Form6.Width/4 - Button1.Width/2-20);
  //----------------------------------------------------------------------
  Label4.Left := round(Form6.Width/2 - Form6.Width/4 - Label4.Width/2);

  ShowAtCenter(Form1,Form6);
end;

procedure TForm6.Button1Click(Sender: TObject);
begin
  Form6.Close;
end;

end.
