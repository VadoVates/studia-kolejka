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
    procedure ButtonPokazKolejkeClick(Sender: TObject);
    procedure ButtonPoliczWezlyClick(Sender: TObject);
    procedure ButtonUsunWezelClick(Sender: TObject);
    procedure DodanieDoKolejki;
  private
    pierwszyWezel, ostatniWezel, tymcz : tWskaznik;
    counter : word;

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

procedure TKolejka.ButtonPokazKolejkeClick(Sender: TObject);
begin
  ListBoxOperacje.Clear;
  tymcz:=pierwszyWezel;
  while (tymcz<>nil) do
  begin
    ListBoxOperacje.Items.Add(IntToStr(tymcz^.kolejnosc) + ' : ' + IntToStr(tymcz^.wartosc));
    tymcz:=tymcz^.nastepny;
  end;
end;

procedure TKolejka.ButtonPoliczWezlyClick(Sender: TObject);
begin
  if (ostatniWezel<>nil) then
    ListBoxOperacje.Items.Add('Ilość węzłów w kolejce to: ' + IntToStr(ostatniWezel^.kolejnosc))
  else
    ListBoxOperacje.Items.Add ('Nie ma węzłów w kolejce');
end;

procedure TKolejka.ButtonUsunWezelClick(Sender: TObject);
begin
  if (pierwszyWezel<>nil) then
     begin
          if (pierwszyWezel^.nastepny=nil) then ostatniWezel:=nil;
          pierwszyWezel:=pierwszyWezel^.nastepny;
          ListBoxKolejka.Clear;
          counter:=0;
          tymcz:=pierwszyWezel;
          while (tymcz<>nil) do
          begin
               counter:=counter+1;
               tymcz^.kolejnosc:=counter;
               ListBoxKolejka.Items.Add(IntToStr(tymcz^.kolejnosc) + ' : ' + IntToStr(tymcz^.wartosc));
               tymcz:=tymcz^.nastepny;
          end;
     end;
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

