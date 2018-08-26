unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Menus, Grids, Buttons, Mask;

const
  blankChar= '#';     //char
  jumpInterval= 200 ; //milisecond

type
  TStep = record
    go:byte;
    write:char;
    move:shortint;
  end;

  TMain = class(TForm)
    Tape: TLabel;
    Shape1: TShape;
    Menu: TMainMenu;
    Pli1: TMenuItem;
    Ustawienia1: TMenuItem;
    Pomoc1: TMenuItem;
    Nowy1: TMenuItem;
    Otowrz: TMenuItem;
    Zapisz: TMenuItem;
    Zapiszjako: TMenuItem;
    Wyjd1: TMenuItem;
    Table: TStringGrid;
    Footer: TLabel;
    Panel: TPanel;
    SpeedButton1: TSpeedButton;
    NextStep: TSpeedButton;
    Pause: TSpeedButton;
    Play: TSpeedButton;
    Stop: TSpeedButton;
    Label2: TLabel;
    Interval: TMaskEdit;
    Minus: TSpeedButton;
    Plus: TSpeedButton;
    Input: TMaskEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    SettingsBtn: TSpeedButton;
    Head: TShape;
    Timer: TTimer;
    Label6: TLabel;
    Counter: TLabel;
    Informations: TLabel;
    procedure FormResize(Sender: TObject);
    procedure ObjResize;
    procedure FormCreate(Sender: TObject);
    procedure PlusClick(Sender: TObject);
    procedure MinusClick(Sender: TObject);
    procedure SettingsBtnClick(Sender: TObject);
    procedure FillTable;
    procedure ReadTable;
    procedure InputKeyPress(Sender: TObject; var Key: Char);
    procedure TableSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure SetHeadPos;
    procedure MoveHead(move:shortint);
    procedure InputChange(Sender: TObject);
    procedure PlayClick(Sender: TObject);
    procedure StopClick(Sender: TObject);
    procedure NextStepClick(Sender: TObject);
    function  ActualChar:char;
    procedure TimerTimer(Sender: TObject);
    procedure MakeStep(step:TStep);
    procedure PauseClick(Sender: TObject);
    procedure TableEnter(Sender: TObject);
    procedure Nowy1Click(Sender: TObject);
    procedure TableKeyPress(Sender: TObject; var Key: Char);
    procedure ZapiszClick(Sender: TObject);
    procedure ZapiszjakoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Wyjd1Click(Sender: TObject);
    procedure OtowrzClick(Sender: TObject);
    procedure OpenMTFile(patch:string);

  private

  public
    alphabet:string[255];
    headStartPos:integer;
    headPos:integer;
    actualStep:byte;
    stepCount:byte;
    stepTable: array of array of TStep;
    FileName:string;
    edited:boolean;
  end;

var
  Main: TMain;

implementation

uses Unit2;

{$R *.dfm}

procedure TMain.MakeStep(step:TStep);
var
  tapeStr:string;
  X1,X2,Y1,Y2:integer;
begin

  if step.move = 0 then
    StopClick(Main)
  else Begin
    actualStep:= step.go;

    tapeStr:= Tape.Caption;
    tapeStr[headPos]:= step.write;
    Tape.Caption:= tapeStr;

    MoveHead(step.move);
    Counter.Caption:= IntToStr(StrToInt(Counter.Caption)+1);
  End;

  Table.Repaint;
  Table.Canvas.Brush.Style:= bsClear;
  Table.Canvas.Pen.Color:= clRed;
  Table.Canvas.Pen.Width:= 2;
  Table.Canvas.Pen.Style:= psSolid;

  X1:= (Table.DefaultColWidth+1)*actualStep+Table.ColWidths[0]+1;
  X2:= Table.ColWidths[0]+(Table.DefaultColWidth+1)*(actualStep+1)+1;
  Y1:= (Table.DefaultRowHeight+1)*Pos(actualChar,alphabet);
  Y2:= (Table.DefaultRowHeight+1)*(Pos(actualChar,alphabet)+1);

  Table.Canvas.Rectangle(X1,Y1,X2,Y2);
End;

function TMain.ActualChar:char;
var tapeStr:string;
Begin
  tapeStr:= Tape.Caption;
  ActualChar:= tapeStr[headPos];
End;

procedure TMain.MoveHead(move:shortint);
Begin
  headPos:= headPos+move;
  SetHeadPos;
End;

procedure TMain.SetHeadPos;
Begin
  Head.Left:= 11*(headPos-1)-2;
End;

function Extract(var str:string; c:char):string;
var temp: string;
Begin
  if Pos(c,str) > 0 then
    temp:= Trim(Copy(str,1,Pos(c,str)-1))
  else
    temp:= Trim(str);
  Delete(str,1,Length(temp)+1);
  str:= Trim(str);
  Result:= temp;
End;

procedure TMain.ReadTable;
var
  x,y:integer;
  cell:string;
Begin
  Table.ColCount:= stepCount+1;
  Table.RowCount:= Length(alphabet)+1;
  SetLength(stepTable,Table.ColCount-1, Table.RowCount-1);
  for x:= 0 to Table.ColCount-2 do Begin
    for y:= 0 to Table.RowCount-2 do Begin
      cell:= Trim(Table.Cells[x+1,y+1]);
      if (UpperCase(Copy(cell,1,1)) = 'Q') and (Length(cell) >= 6) and (Length(cell) <= 7) then Begin
        Delete(cell, 1,1);   //delete first char (q)
        stepTable[x,y].go:= StrToIntDef(Extract(cell,' '),0);
        stepTable[x,y].write:= cell[1]; //first char of cell string
        Extract(cell,' ');              //delete first char

        if UpperCase(Copy(cell,1,1)) = 'L' then
          stepTable[x,y].move:= -1
        else if UpperCase(Copy(cell,1,1)) = 'P' then
          stepTable[x,y].move:= 1
        else
          stepTable[x,y].move:= 0;
      End
      Else
        stepTable[x,y].move:= 0
    End;
  End;
End;

procedure TMain.ObjResize;
var i:integer;
Begin
  Tape.Caption:= '';
  Tape.Width:= ClientWidth;

  InputChange(Main);

  Shape1.Width:= ClientWidth;
  Table.Width:= ClientWidth-10;
  Table.Height:= ClientHeight - Table.Top -15;
  Panel.Left:= ClientWidth-Panel.Width-5;
  Footer.Top:= ClientHeight-Footer.Height-2;
  Footer.Width:= ClientWidth;
  Informations.Top:= Footer.Top;
End;

procedure TMain.FormResize(Sender: TObject);
begin
  ObjResize;
end;

procedure TMain.FillTable;
var x,y:integer;
Begin
  for x:= 1 to Table.ColCount-1 do
    Table.Cells[x,0]:= '   q'+IntToStr(x-1);

  for y:= 1 to Table.RowCount-1 do
    Table.Cells[0,y]:= ' '+alphabet[y];

  for x:=0 to Table.ColCount-2 do
    for y:= 0 to Table.RowCount-2 do
      if stepTable[x,y].move = 0 then
        Table.Cells[x+1,y+1]:= '   SB   '
      else  Begin
        Table.Cells[x+1,y+1]:= 'q'+IntToStr(stepTable[x,y].go)+' '+stepTable[x,y].write+' ';
        if(stepTable[x,y].move = -1) then
          Table.Cells[x+1,y+1]:= Table.Cells[x+1,y+1]+'L'
        else
          Table.Cells[x+1,y+1]:= Table.Cells[x+1,y+1]+'P';
      End;

End;

procedure TMain.FormCreate(Sender: TObject);
begin
  alphabet:= '#abc';
  stepCount:= 5;
  headStartPos:= 1;
  Table.ColWidths[0] := 38;
  Input.Text:= '';
  Informations.Caption:= '';
  ReadTable;
  FillTable;
  ObjResize;
  DoubleBuffered:= true;
  edited:= false;
end;

procedure TMain.PlusClick(Sender: TObject);
begin
  if(StrToIntDef(Interval.Text,0) <= 9999-jumpInterval) then
    Interval.Text:= IntToStr(StrToIntDef(Interval.Text,0)+jumpInterval);
  Timer.Interval:= StrToIntDef(Interval.Text,700);
end;

procedure TMain.MinusClick(Sender: TObject);
begin
  if(StrToIntDef(Interval.Text,0) > jumpInterval) then
    Interval.Text:= IntToStr(StrToIntDef(Interval.Text,0)-jumpInterval);
  Timer.Interval:= StrToIntDef(Interval.Text,700);
end;

procedure TMain.SettingsBtnClick(Sender: TObject);
begin
  Settings.ShowModal;
  FillTable;
  InputChange(Main);
end;

procedure TMain.InputKeyPress(Sender: TObject; var Key: Char);
var
  i:integer;
  ok:boolean;
begin
  if Key <> #08 then Begin//backspace
  ok:= false;
  for i:= 1 to Length(alphabet) do
    if Key = alphabet[i] then
      ok:=true;
  if not ok then
    Key:= #0;
  End;
  edited:= true;
end;

procedure TMain.TableSetEditText(Sender: TObject; ACol, ARow: Integer;
  const Value: String);
begin

  if UpperCase(Trim(Value)) = 'SB' then
    Table.Cells[ACol,ARow]:= '   SB   ';

end;

procedure TMain.InputChange(Sender: TObject);
var
  tapeStr:string;
  i:integer;
  lengthIn,lengthOut:integer;
begin
  lengthIn:= Length(Input.Text);
  lengthOut:= (Width-2) div 11;
  for i:= 1 to ((lengthOut-lengthIn) div 2) do
    tapeStr:= tapeStr+blankChar;

  if headStartPos <> High(Integer) then
    headPos:= i;

  tapeStr:= tapeStr+Input.Text;
  i:= i+lengthIn;

  if headStartPos = High(Integer) then
    headPos:= i-1;

  for i:= i to lengthOut  do
    tapeStr:= tapeStr+blankChar;

  Tape.Caption:= tapeStr;
  SetHeadPos;
end;

procedure TMain.PlayClick(Sender: TObject);
var X1,X2,Y1,Y2:integer;
begin
  if not Stop.Enabled then Begin
    ReadTable;
    Counter.Caption:= '0';
    InputChange(Main);
    NextStep.Enabled:= true;
    Stop.Enabled:= true;
    Input.Enabled:= false;
    Table.Enabled:= false;
    SettingsBtn.Enabled:= false;
    Table.Options:= [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goEditing,goTabs];

    Table.Repaint;
    Table.Canvas.Brush.Style:= bsClear;
    Table.Canvas.Pen.Color:= clRed;
    Table.Canvas.Pen.Width:= 2;
    Table.Canvas.Pen.Style:= psSolid;

    X1:= Table.ColWidths[0]+2;
    X2:= Table.ColWidths[0]+(Table.DefaultColWidth+1)+1;
    Y1:= (Table.DefaultRowHeight+1)*Pos(actualChar,alphabet);
    Y2:= (Table.DefaultRowHeight+1)*(Pos(actualChar,alphabet)+1);

    Table.Canvas.Rectangle(X1,Y1,X2,Y2);
  End;
  Timer.Enabled:= true;
  Pause.Visible:=true;
  Play.Visible:= false;
end;

procedure TMain.StopClick(Sender: TObject);
begin
  Timer.Enabled:= false;
  Play.Visible:= true;
  Pause.Visible:= false;
  NextStep.Enabled:= false;
  SettingsBtn.Enabled:= true;
  Table.Enabled:= true;
  Input.Enabled:= true;
  Table.Options:= [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goEditing,goTabs,goAlwaysShowEditor];
  Stop.Enabled:= false;
end;

procedure TMain.NextStepClick(Sender: TObject);
begin
  PauseClick(Main);
  TimerTimer(Main);
end;

procedure TMain.TimerTimer(Sender: TObject);
begin
  if Pos(actualChar,alphabet) = 0 then
    StopClick(Main)
  else
    MakeStep(stepTable[actualStep,Pos(ActualChar,alphabet)-1]);
end;

procedure TMain.PauseClick(Sender: TObject);
begin
  Timer.Enabled:= false;
  Play.Visible:= true;
  Pause.Visible:= false;
end;

procedure TMain.TableEnter(Sender: TObject);
begin
  Table.Repaint;
end;

procedure TMain.Nowy1Click(Sender: TObject);
begin
  if edited then Begin
    case(MessageBox(Handle, 'Czy zapisaæ zmiany w pliku?', 'Maszyna Turinga', MB_YESNOCANCEL or MB_DEFBUTTON1 or MB_APPLMODAL or MB_ICONWARNING)) of
      IDYES: Begin
        ZapiszClick(Main);
        StopClick(Main);
        stepCount:= 5;
        alphabet:= blankChar+'abc';
        Input.Text:= '';
        InputChange(Main);
        FillTable;
        FileName:= '';
        edited:= false;
      end;
      IDNO: Begin
        StopClick(Main);
        stepCount:= 5;
        alphabet:= blankChar+'abc';
        Input.Text:= '';
        InputChange(Main);
        FillTable;
        FileName:= '';
        edited:= false;
      End;
    End;
  End
  else begin
    StopClick(Main);
    stepCount:= 5;
    alphabet:= blankChar+'abc';
    Input.Text:= '';
    InputChange(Main);
    FillTable;
    FileName:= '';
    edited:= false;
  End;
end;

procedure TMain.TableKeyPress(Sender: TObject; var Key: Char);
begin
  edited:= true;
end;


procedure TMain.ZapiszjakoClick(Sender: TObject);
var
  SD:TSaveDialog;
  FS:TFileStream;
begin
  ReadTable;
  SD:= TSaveDialog.Create(self);
  SD.Options:= [ofOverwritePrompt,ofHideReadOnly];
  if FileName = '' then
    SD.FileName:= 'Bez Nazwy.mt'
  else
    SD.FileName:= FileName;
  SD.Filter:= 'Plik z tabel¹ stanów Maszyny Turinga (*.mt)|*.mt';

  if SD.Execute then Begin
    FileName:= SD.FileName;
    FS:= TFileStream.Create(FileName,fmCreate);     //create empty file
    FS.Free;
    ZapiszClick(Main);
  End;

  SD.Destroy;
end;

procedure TMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if edited then Begin
    case(MessageBox(Handle, 'Czy zapisaæ zmiany w pliku?', 'Maszyna Turinga', MB_YESNOCANCEL or MB_DEFBUTTON1 or MB_APPLMODAL or MB_ICONWARNING)) of
      IDYES: ZapiszClick(Main);
      IDCANCEL: Action:= caNone;
    end;
  End;
end;

procedure TMain.Wyjd1Click(Sender: TObject);
begin
  Main.Close;
end;

procedure TMain.OtowrzClick(Sender: TObject);
var OD:TOpenDialog;
begin
  OD:= TOpenDialog.Create(self);
  OD.Filter:= 'Plik z tabel¹ stanów Maszyny Turinga (*.mt)|*.mt';
  OD.InitialDir:= FileName;
  OD.Options:= [ofHideReadOnly,ofFileMustExist];
  if OD.Execute then
    OpenMTFile(OD.FileName);
  OD.Destroy;
end;


procedure TMain.ZapiszClick(Sender: TObject);
var
  FS:TFileStream;
  x,y:integer;
  tempInt:integer;
  tempStr:string[255];
begin
    if FileExists(FileName) then Begin
      Informations.Caption:= 'Zapisywanie...';
      FS:= TFileStream.Create(FileName,fmCreate);
      FS.Write(stepCount,SizeOf(stepCount));
      tempInt:= Length(alphabet);
      FS.Write(alphabet,Length(alphabet)+1);

      for x:= 0 to Length(stepTable)-1 do
        for y:= 0 to Length(stepTable[x])-1 do
          FS.Write(stepTable[x][y], SizeOf(TStep));


      tempStr:= Input.Text;
      FS.Write(tempStr,Length(tempStr)+1);

      tempInt:= StrToIntDef(Interval.Text,700);
      FS.Write(tempInt,SizeOf(tempInt));

      FS.Write(headStartPos,SizeOf(headStartPos));
      FS.Free;
      edited:= false;
      Informations.Caption:= 'Zapisano!';
    End
    else
      ZapiszjakoClick(Main);
end;

procedure TMain.OpenMTFile(patch:string);
var
  x,y,tempInt:integer;
  tempStr:string[255];
  FS:TFileStream;
Begin
  FS:= TFileStream.Create(patch,fmOpenRead);
  Informations.Caption:= 'Otwieranie pliku "'+FileName+'"...';

  FS.Read(stepCount,SizeOf(stepCount));
  FS.Read(tempInt,1);
  FS.Position:= FS.Position-1;
  FS.Read(alphabet,tempInt+1);
  SetLength(stepTable,stepCount,tempInt);

  for x:= 0 to stepCount-1 do
    for y:= 0 to tempInt-1 do
      FS.Read(stepTable[x][y], SizeOf(TStep));

  FS.Read(tempInt,1);
  FS.Position:= FS.Position-1;
  FS.Read(tempStr, tempInt+1);
  Input.Text:= tempStr;

  FS.Read(tempInt,SizeOf(tempInt));
  Interval.Text:= IntToStr(tempInt);

  FS.Read(headStartPos,SizeOf(headStartPos));
  FS.Free;
  edited:= false;
  Informations.Caption:= patch;
  FileName:= patch;
  FillTable;
End;

end.

