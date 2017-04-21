unit Mail_View;

interface

uses SysUtils, Windows, Forms;

type
  TSponsor = record
    name     : string;
    mask     : string;
    len      : byte;
    interval : word;
  end;

  TEmail = record
    name     : string;
    host     : string;
    port     : integer;
    login    : string;
    password : string;
  end;

  TLink2Click = record
    link     : string;
    interval : word;
  end;
{
  TStatistic : record
    LinksGetAll : LongWord;
    LinksGetMax : record
      Number : string;
      Date   : string;

    end;


  end;
}
  TDynamicInterface = record
    LinkStatistic : record
      Viewed : string;
      Total  : string;
    end;

    Table    : record
      Number   : string;
      Link     : string;
      Interval : string;
      Status   : string;
    end;

    LinkStatus : record
      Ready   : string;
      Reading : string;
      Done    : string;
    end;

    LinksGet : record
      StartingLinksCollection  : string;
      ConnectToServer          : string;
      ThereAre                 : string;
      MailsOnServer            : string;
      MailsCollectedFromServer : string;
    end;

    Modes : record
      Get : record
        ManuallyLinksCollect                : string;
        NextLinksCollectIn                  : string;
        Sec                                 : string;
        LinksCollectionProcessedManually    : string;
        LinksCollectionProcessedAutomatic   : string;
      end;

      View : record
        ManuallyView  : string;
        AutomaticView : string;
      end;
    end;

    ClearList : record
      AreYouSure            : string;
      ListOfLinksWasCleaned : string;
    end;

    WriteLinksIntoFile : record
      LinksWritedIntoFile : string;
    end;

    ReadLinksFromFile : record
      LoadingLinksFromFile : string;
      LinksLoadedFromFile   : string;
    end;

    EmailSettings : record
      EmailName        : string;
      EnterServersName : string;
      EmailInfo        : string;
    end;

    SponsorsSettings : record
      SponsorsName           : string;
      EnterSponsorsName      : string;
      SponsorInfo            : string;
      LinkLengthMustBeLess   : string;
      ViewIntervalMustBeLess : string;
    end;
  end;

const
  Separator = '|';

  EmailsFilePath = 'settings\emails.dat';
  SponsorsFilePath = 'settings\sponsors.txt';

procedure Delay(dwMilliseconds: LongWord);
procedure ShowAtCenter(MainForm,Form:TForm);
function DecodeSponsor(s:string):TSponsor;
function EncodeSponsor(sponsor:TSponsor):string;
function DecodeEmail(s:string):TEmail;
function EncodeEmail(email:TEmail):string;
function DecodeLink2Click(s:string):TLink2Click;
function EncodeLink2Click(Link2Click:TLink2Click):string;

implementation

procedure Delay(dwMilliseconds: LongWord);
var
  iStart, iStop: DWORD;
begin
  iStart := GetTickCount;
  repeat
    iStop := GetTickCount;
    Application.ProcessMessages;
  until (iStop - iStart) >= dwMilliseconds;
end;

//Form will be always shown at the center of main form
procedure ShowAtCenter(MainForm,Form:TForm);
begin
  Form.Left := round(MainForm.Left + MainForm.Width/2 - Form.Width/2);
  Form.Top := round(MainForm.Top + MainForm.Height/2 - Form.Height/2);
end;


function DecodeSponsor(s:string):TSponsor;
var
  p : byte;
begin
  p := pos(separator,s);
  if p <> 1
    then exit;

  delete(s,1,1);

  p := pos(Separator,s);
  DecodeSponsor.name := copy(s,1,p-1);
  delete(s,1,p);

  p := pos(Separator,s);
  DecodeSponsor.mask := copy(s,1,p-1);
  delete(s,1,p);

  p := pos(Separator,s);
  DecodeSponsor.len := StrToInt(copy(s,1,p-1));
  delete(s,1,p);

  p := pos(Separator,s);
  DecodeSponsor.interval := StrToInt(copy(s,1,p-1));
  delete(s,1,p);
end;

function EncodeSponsor(sponsor:TSponsor):string;
begin
  EncodeSponsor := Separator
  + sponsor.name + Separator
  + sponsor.mask + Separator
  + IntToStr(sponsor.len) + Separator
  + IntToStr(sponsor.interval) + Separator;
end;

function DecodeEmail(s:string):TEmail;
var
  p : byte;
begin
  p := pos(Separator,s);
  if p <> 1
    then exit;

  delete(s,1,1);

  p := pos(Separator,s);
  DecodeEmail.name := copy(s,1,p-1);
  delete(s,1,p);

  p := pos(Separator,s);
  DecodeEmail.host := copy(s,1,p-1);
  delete(s,1,p);

  p := pos(Separator,s);
  DecodeEmail.port := StrToInt(copy(s,1,p-1));
  delete(s,1,p);

  p := pos(Separator,s);
  DecodeEmail.login := copy(s,1,p-1);
  delete(s,1,p);

  p := pos(Separator,s);
  DecodeEmail.password := copy(s,1,p-1);
  delete(s,1,p);
end;

function EncodeEmail(email:TEmail):string;
begin
  EncodeEmail := Separator
  + email.name + Separator
  + email.host + Separator
  + IntToStr(email.port) + Separator
  + email.login + Separator
  + email.password + Separator;
end;

function DecodeLink2Click(s:string):TLink2Click;
var
  p : byte;
begin
  p := pos(Separator,s);
  if p <> 1
    then exit;

  delete(s,1,1);

  p := pos(Separator,s);
  DecodeLink2Click.link := copy(s,1,p-1);
  delete(s,1,p);

  p := pos(Separator,s);
  DecodeLink2Click.interval := StrToInt(copy(s,1,p-1));
  delete(s,1,p);
end;

function EncodeLink2Click(Link2Click:TLink2Click):string;
begin
  EncodeLink2Click := Separator
  + Link2Click.link + Separator
  + IntToStr(Link2Click.interval) + Separator;
end;

end.
