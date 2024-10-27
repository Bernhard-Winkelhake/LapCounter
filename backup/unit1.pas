unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  RichMemo, CheckBoxThemed, IniFiles;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    RichMemo1: TRichMemo;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure RichMemo1Change(Sender: TObject); // Event, um Änderungen zu speichern
  private
    Counter: Integer;
    procedure LoadCounter;
    procedure SaveCounter;
    procedure LoadRichMemo;
    procedure SaveRichMemo;
    procedure UpdateLabel;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

// Diese Prozedur lädt den Counter aus der Datei "counter.ini"
procedure TForm1.LoadCounter;
var
  IniFile: TIniFile;
begin
  IniFile := TIniFile.Create('counter.ini');
  try
    Counter := IniFile.ReadInteger('Settings', 'Counter', 0); // Lade Counter, falls nicht vorhanden, wird 0 genommen
  finally
    IniFile.Free;
  end;
end;

// Diese Prozedur speichert den aktuellen Counter-Wert in die Datei "counter.ini"
procedure TForm1.SaveCounter;
var
  IniFile: TIniFile;
begin
  IniFile := TIniFile.Create('counter.ini');
  try
    IniFile.WriteInteger('Settings', 'Counter', Counter); // Speichere Counter
  finally
    IniFile.Free;
  end;
end;

// Diese Prozedur lädt den Inhalt von RichMemo aus der Datei "memo.txt"
procedure TForm1.LoadRichMemo;
begin
  if FileExists('memo.txt') then
    RichMemo1.Lines.LoadFromFile('memo.txt'); // Lade Inhalt, falls Datei vorhanden ist
end;

// Diese Prozedur speichert den aktuellen Inhalt von RichMemo in die Datei "memo.txt"
procedure TForm1.SaveRichMemo;
begin
  RichMemo1.Lines.SaveToFile('memo.txt'); // Speichere den Inhalt des Memos
end;

// Diese Prozedur aktualisiert das Label2 mit dem aktuellen Counter-Wert (3-stellig)
procedure TForm1.UpdateLabel;
begin
  Label2.Caption := Format('%.3d', [Counter]); // Führende Nullen bis 3 Stellen
end;

// Diese Prozedur wird aufgerufen, wenn das Formular erstellt wird
procedure TForm1.FormCreate(Sender: TObject);
begin
  LoadCounter; // Lade den Counter-Wert beim Start
  LoadRichMemo; // Lade den RichMemo-Inhalt beim Start
  UpdateLabel;  // Zeige den initialen Counter-Wert in Label2 an
end;

procedure TForm1.FormResize(Sender: TObject);
begin

end;

// Diese Prozedur wird aufgerufen, wenn der Button geklickt wird
procedure TForm1.Button1Click(Sender: TObject);
begin
  Inc(Counter); // Erhöhe den Counter um 1
  UpdateLabel;  // Zeige den aktualisierten Wert an
  SaveCounter;  // Speichere den neuen Wert in der .ini Datei
end;

// Diese Prozedur wird aufgerufen, wenn der Inhalt von RichMemo geändert wird
procedure TForm1.RichMemo1Change(Sender: TObject);
begin
  SaveRichMemo; // Speichere den neuen Inhalt von RichMemo
end;

end.
