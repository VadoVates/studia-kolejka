unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Windows, Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls;

type
  tWskaznik = ^tWezel;
  tWezel = record
    wartosc      : word;
    kolejnosc    : word;
    nastepny     : tWskaznik;
  end;

  { TKolejka }

  TKolejka = class(TForm)
    ButtonKoniec: TButton;
    ButtonInfo: TButton;
    ButtonDodajWezel: TButton;
    ButtonPokazKolejke: TButton;
    ButtonPoliczWezly: TButton;
    ButtonUsunWezel: TButton;
    LabelKolejka: TLabel;
    LabelOperacje: TLabel;
    ListBoxKolejka: TListBox;
    ListBoxOperacje: TListBox;
    procedure ButtonDodajWezelClick(Sender: TObject);
    procedure ButtonInfoClick(Sender: TObject);
    procedure ButtonKoniecClick(Sender: TObject);
    procedure DodanieDoKolejki;
  private
    pierwszyWezel, ostatniWezel : tWskaznik;
    temp                        : word;
    //counter                     : word;

  public

  end;

var
  Kolejka: TKolejka;

implementation

{$R *.lfm}

{ TKolejka }

procedure TKolejka.ButtonDodajWezelClick(Sender: TObject);
begin
  Randomize;
  DodanieDoKolejki;
  temp:=ostatniWezel^.wartosc;
  ListBoxKolejka.Items.Add(IntToStr(ostatniWezel^.kolejnosc) + ' : ' + IntToStr(ostatniWezel^.wartosc));
end;

procedure TKolejka.ButtonInfoClick(Sender: TObject);
var
  komunikat : string;
begin
  komunikat := 'Programista: Marek Górski. Wersja programu v 0.1.1';
  Application.MessageBox(Pchar(komunikat),'Autor',MB_OK);
end;

procedure TKolejka.ButtonKoniecClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TKolejka.DodanieDoKolejki;
var
  wezel : tWskaznik;
begin
  new (wezel);
  wezel^.wartosc := random(1000);
  wezel^.nastepny := nil;
  if (pierwszyWezel = nil) then
     begin
     pierwszyWezel := wezel;
     pierwszyWezel^.kolejnosc:=1;
     ostatniWezel := wezel;
     Exit;
     end;
  wezel^.kolejnosc:=ostatniWezel^.kolejnosc+1;
  ostatniWezel^.nastepny := wezel;
  ostatniWezel := wezel;
end;

end.

