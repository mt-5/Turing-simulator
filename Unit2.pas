unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, Buttons;

type
  TSettings = class(TForm)
    Alphabet: TEdit;
    StepCount: TMaskEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Pos: TMaskEdit;
    FirstPos: TRadioButton;
    LastPos: TRadioButton;
    OtherPos: TRadioButton;
    Deny: TBitBtn;
    Accept: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure OtherPosClick(Sender: TObject);
    procedure LastPosClick(Sender: TObject);
    procedure AcceptClick(Sender: TObject);
    procedure DenyClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Settings: TSettings;

implementation

uses Unit1;

{$R *.dfm}

procedure TSettings.FormShow(Sender: TObject);
begin
  Alphabet.Text:= Main.alphabet;

  if (Main.headStartPos = High(Integer)) then
    LastPos.Checked:= true
  else if (Main.headStartPos = 1) then
    FirstPos.Checked:= true
  else
  Begin
    OtherPos.Checked:= true;
    Pos.Text:= IntToStr(Main.headStartPos);
    Pos.Enabled:= true;
  End;
  StepCount.Text:= IntToStr(Main.stepCount);

end;

procedure TSettings.OtherPosClick(Sender: TObject);
begin
  Pos.Enabled:= true;
end;

procedure TSettings.LastPosClick(Sender: TObject);
begin
  Pos.Enabled:= false;
end;

procedure TSettings.AcceptClick(Sender: TObject);
begin
  if (StrToIntDef(Trim(StepCount.Text),0) <= 100) then
    Main.stepCount:= StrToIntDef(Trim(StepCount.Text),1);
  Main.alphabet:= Alphabet.Text;

  if FirstPos.Checked then
    Main.headStartPos:= 1
  else if LastPos.Checked then
    Main.headStartPos:= High(Integer)
  else
    Main.headStartPos:= StrToIntDef(Trim(Pos.Text),1);

  Settings.Close;
end;

procedure TSettings.DenyClick(Sender: TObject);
begin
  Settings.Close;
end;

end.
