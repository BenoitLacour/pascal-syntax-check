unit Unit4;

interface

uses
  CompWin, CompGui, CompData, CompStd, CompGrid, CompDb,
  CompSql, CompProv, CompBcd, CompBtn, CompStr,
  CompClip, CompMenu, CompAct, CompImg, CompImgList,
  CompSplit, CompExt, CompMask, CompVtree,
  UnitBase1, UnitCommon, UnitConst, CompFrame;

const
  Grid1: array [0..36] of TGridColumnSettings =
    ((TableName: 't1'; FieldName: 'F1'; Alias: '';
      FieldType: 'ATR';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'F1';
      TitleFontColor: clBlue;
      TitleFontStyles: [fsBold];
      TitleAlignment: taCenter;
      Visible: True;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 't1'; FieldName: 'F2'; Alias: '';
      FieldType: 'ATR';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'F2';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: False;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 't1'; FieldName: 'F3'; Alias: '';
      FieldType: 'ATR';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'F3';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: False;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 't1'; FieldName: 'F4'; Alias: '';
      FieldType: 'ATR';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'F4';
      TitleFontColor: clBlue;
      TitleFontStyles: [fsBold];
      TitleAlignment: taCenter;
      Visible: True;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 't1'; FieldName: 'F5'; Alias: '';
      FieldType: 'ATR';
      Width: 0;
      Alignment: taCenter;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'F5';
      TitleFontColor: clBlue;
      TitleFontStyles: [fsBold];
      TitleAlignment: taCenter;
      Visible: True;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 't1'; FieldName: 'F6'; Alias: '';
      FieldType: 'ATR';
      Width: 0;
      Alignment: taCenter;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'F6';
      TitleFontColor: clBlue;
      TitleFontStyles: [fsBold];
      TitleAlignment: taCenter;
      Visible: False;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 't1'; FieldName: 'F7'; Alias: '';
      FieldType: 'ATR';
      Width: 0;
      Alignment: taCenter;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'F7';
      TitleFontColor: clBlue;
      TitleFontStyles: [fsBold];
      TitleAlignment: taCenter;
      Visible: True;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 't1'; FieldName: 'F8'; Alias: '';
      FieldType: 'ATR';
      Width: 0;
      Alignment: taCenter;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'F8';
      TitleFontColor: clBlue;
      TitleFontStyles: [fsBold];
      TitleAlignment: taCenter;
      Visible: False;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 't1'; FieldName: 'F9'; Alias: '';
      FieldType: 'ATR';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'F9';
      TitleFontColor: clBlue;
      TitleFontStyles: [fsBold];
      TitleAlignment: taCenter;
      Visible: False;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 't1'; FieldName: 'F10'; Alias: '';
      FieldType: 'ATR';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'F10';
      TitleFontColor: clBlue;
      TitleFontStyles: [fsBold];
      TitleAlignment: taCenter;
      Visible: False;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 't1'; FieldName: 'F11'; Alias: '';
      FieldType: 'ATR';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'F11';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: False;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 't1'; FieldName: 'F12'; Alias: '';
      FieldType: 'ATR';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'F12';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: False;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 't1'; FieldName: 'F13'; Alias: '';
      FieldType: 'ATR';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'F13';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: True;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 't1'; FieldName: 'F14'; Alias: '';
      FieldType: 'ATR';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'F14';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: True;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 't1'; FieldName: 'F15'; Alias: '';
      FieldType: 'ATR';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'F15';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: True;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 't1'; FieldName: 'F16'; Alias: '';
      FieldType: 'ATR';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'F16';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: True;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 't1'; FieldName: 'F17'; Alias: '';
      FieldType: 'ATR';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'F17';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: True;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 't1'; FieldName: 'F18'; Alias: '';
      FieldType: 'ATR';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'F18';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: True;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 't1'; FieldName: 'F19'; Alias: '';
      FieldType: 'ATR';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'F19';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: False;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 't1'; FieldName: 'F20'; Alias: '';
      FieldType: 'ATR';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'F20';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: False;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 't1'; FieldName: 'F21'; Alias: '';
      FieldType: 'ATR';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'F21';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: False;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 't1'; FieldName: 'F22'; Alias: '';
      FieldType: 'ATR';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'F22';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: False;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 't1'; FieldName: 'F23'; Alias: '';
      FieldType: 'ATR';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'F23';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: False;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 't1'; FieldName: 'F24'; Alias: '';
      FieldType: 'ATR';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'F24';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: False;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 't1'; FieldName: 'F25'; Alias: '';
      FieldType: 'ATR';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'F25';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: False;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 't1'; FieldName: 'F26'; Alias: '';
      FieldType: 'ATR';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'F26';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: False;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 't1'; FieldName: 'F27'; Alias: '';
      FieldType: 'ATR';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'F27';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: False;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 't1'; FieldName: 'F28'; Alias: '';
      FieldType: 'ATR';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'F28';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: False;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 't1'; FieldName: 'F29'; Alias: '';
      FieldType: 'ATR';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'F29';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: False;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 't1'; FieldName: 'F30'; Alias: '';
      FieldType: 'ATR';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'F30';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: False;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 't1'; FieldName: 'F31'; Alias: '';
      FieldType: 'ATR';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'F31';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: False;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 't1'; FieldName: 'F32'; Alias: '';
      FieldType: 'ATR';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'F32';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: False;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 't1'; FieldName: 'F33'; Alias: '';
      FieldType: 'ATR';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'F33';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: True;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 't1'; FieldName: 'F34'; Alias: '';
      FieldType: 'ATR';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'F34';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: False;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 't1'; FieldName: 'F35'; Alias: '';
      FieldType: 'ATR';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'F35';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: False;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 't1'; FieldName: 'F36'; Alias: '';
      FieldType: 'ATR';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'F36';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: False;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 't1'; FieldName: 'F37'; Alias: '';
      FieldType: 'KEY';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'F37';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: False;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False));

type
  TForm4 = class(TBaseForm1)
    Ctrl1: TEdit;
    Ctrl2: TEdit;
    Ctrl3: TLabel;
    Ctrl4: TRadioGroup;
    Act1: TAction;
    Act2: TAction;
    Act3: TAction;
    Act4: TAction;
    Act5: TAction;
    Act6: TAction;
    Act7: TAction;
    Act8: TAction;
    Tab1: TTabSheet;
    Tab2: TTabSheet;
    Panel1: TPanel;
    Panel2: TPanel;
    Grid1: TGridDb1;
    DS1: TSQLDataSet;
    DS2: TDataSetProvider;
    DS3: TClientDataSet;
    DS4: TDataSource;
    DS5: TSQLDataSet;
    DS6: TDataSetProvider;
    DS7: TClientDataSet;
    DS8: TDataSource;
    Grid2: TGridDb1;
    DS9: TAction;
    DS10: TAction;
    Tab3: TTabSheet;
    Panel3: TPanel;
    Grid3: TGridDb1;
    DS11: TSQLDataSet;
    DS12: TDataSetProvider;
    DS13: TClientDataSet;
    DS14: TDataSource;
    Act9: TAction;
    Act10: TAction;
    Btn1: TBitBtn;
    Btn2: TBitBtn;
    Act11: TAction;
    Act12: TAction;
    Ctrl5: TEdit;
    Ctrl6: TLabel;
    Ctrl7: TEdit;
    Ctrl8: TLabel;
    Ctrl9: TEdit;
    Ctrl10: TLabel;
    Ctrl11: TEdit;
    Ctrl12: TLabel;
    Ctrl13: TEdit;
    Ctrl14: TLabel;
    Ctrl15: TEdit;
    Ctrl16: TLabel;
    Ctrl17: TEdit;
    Ctrl18: TLabel;
    Ctrl19: TEdit;
    Ctrl20: TLabel;
    Ctrl21: TEdit;
    Ctrl22: TLabel;
    Ctrl23: TEdit;
    Ctrl24: TLabel;
    Tab4: TTabSheet;
    Grid4: TGridDb1;
    DS15: TDataSource;
    DS16: TClientDataSet;
    DS17: TDataSetProvider;
    DS18: TSQLDataSet;
    Panel4: TPanel;
    Btn3: TBitBtn;
    Btn4: TBitBtn;
    Btn5: TBitBtn;

    procedure Setup;
    procedure Show;
    procedure Close;
    procedure ReOpenBtn;
    procedure GridSelect;
    procedure GridExit;
    procedure AfterScroll;
    procedure BeforePost;
    procedure AfterPost;
    procedure BeforeInsert;
    procedure AfterInsert;
    procedure BeforeDelete;
    procedure DP1GetTableName;
    procedure DP1BeforeUpdateRecord;
    procedure OpenDetail;
    procedure PageChange;
    procedure SetSplitter;
    procedure FilterDetail;
    procedure FieldWelds;
    procedure PrintStickers;
    procedure FilterClick;
    procedure ReqDDblClick;
    procedure AddBtn;
    procedure RemoveBtn;
    procedure DetAfterScroll;
    procedure GridColor;
    procedure GridColor2;
    procedure GridColor3;
    procedure LoadPicklist;
    procedure PicklistColor;
    procedure PicklistScroll;
    procedure WeldsColor;
    procedure ReportClick;
    procedure ReportDblClick;
    procedure SpoolsColor;
    procedure SelectAllBtn;
    procedure Btn5Click;
    procedure BtnVerify;
    procedure SetQuery2;
    procedure SetQuery3;
    procedure SetQuery4;
    procedure SetQuery5;
  private
    FDlg1: TFilterDialog;
    FDlg2: TFilterDialog;
    FDlg3: TFilterDialog;
    FDlg4: TFilterDialog;
    FDlg5: TFilterDialog;
    F1: Boolean;
    F2: Boolean;
    F3: Boolean;
    F4: Boolean;
    F5: Boolean;
    F6: Boolean;
    F7: Boolean;
    FList: TStringList;

    procedure SetState;
    procedure SetTitles;
    procedure FormatField;
    function  NextNum: Integer;
    function  DoCheck: Boolean;
    procedure ClearMTO;
    procedure CancelAlloc;
    procedure SetQuery;

  protected
    procedure SetupMaster;
    procedure SetupDetail;
    procedure SetRights;
    procedure SetBtnState;

  public
    destructor Destroy; override;
  end;

var
  Form4: TForm4;

implementation

uses
  UnitMain, UnitTraduc, UnitProc, UnitCommon2, UnitDate,
  UnitWizard1,
  Rpt1, Rpt2, Rpt3, Rpt4, Rpt5,
  Rpt6, Rpt7, Rpt8, Rpt9, Rpt10,
  Rpt11, Rpt12, Rpt13, Rpt14, Rpt15,
  UnitAttach;

{$R *.dfm}

destructor TForm4.Destroy;
begin
  if Assigned(FList) then
    FreeAndNil(FList);

  inherited;
end;

procedure TForm4.Setup;
begin
  inherited;

  F1 := nil;

  F8 := 1;
  F9 := 'Out';
  F10 := False;
  F11 := 'OutC';

  inherited;

  F6 := True;
  F7 := True;

  SetRights;

  if F11 = 'OutC' then
    F12 := True
  else
    F12 := False;
end;

procedure TForm4.Show;
begin
  inherited;

  F13.ActivePage := Tab4;

  SetButtons;
  SetState;
end;

procedure TForm4.Close;
begin
  inherited;

  if not DoCheck then Exit;

  ifclosed(F14);

  if (Ctrl1.Text = '') then
    Ctrl1.Text := DateToStr(Date);

  Screen.Cursor := crHourGlass;

  try
    with F15 do
    begin
      if Active then Close;

      SQL.Clear;
      SQL.Add('CALL sp1(:P1, :P2, :P3, :P4, NULL);');

      Params[0].AsString := F14.FieldByName('field1').AsString;
      Params[1].AsString := F14.FieldByName('field2').AsString;
      Params[2].AsDate := StrToDate(Ctrl1.Text);
      Params[3].AsDate := F14.FieldValues['OutDate'];

      ExecSQL;
    end;

    OpenDetail.Click;
    F14.Refresh;

  finally
    SetButtons;
    Screen.Cursor := crDefault;
  end;
end;

procedure TForm4.ReOpenBtn;
begin
  inherited;
  SetButtons;
end;

procedure TForm4.GridSelect;
begin
  inherited;
  SetButtons;
end;

procedure TForm4.GridExit;
begin
  inherited;

  if F14.State in [dsEdit, dsInsert] then F14.Post;
end;

procedure TForm4.AfterScroll;
begin
  inherited;
end;

procedure TForm4.BeforeInsert;
begin
  F16 := NextNum;
end;

procedure TForm4.AfterInsert;
begin
  inherited;

  F14['field1'] := Obj1.field1;
  if F14['field2'] = Null then
    F14['field2'] := Format('%.4d', [F16]);
  F14.FieldValues['field3'] := F17.Text;
  F14['Branch'] := F18;
  F14['SupplierType'] := 'S';

  SetButtons;
end;

procedure TForm4.BeforeDelete;
begin
  inherited;
  SetButtons;
end;

procedure TForm4.BeforePost;
begin
  inherited;

  if (F14.FieldByName('Attn').AsString = '') then
    if (F14.FieldByName('Attention').AsString <> '') then
        F14.FieldByName('Attn').AsString := F14.FieldByName('Attention').AsString;

  F14['SubConNo'] := F14['SupplierNo'];
end;

procedure TForm4.AfterPost;
begin
  inherited;
  SetButtons;
end;

procedure TForm4.DP1GetTableName;
begin
  TableName := 'wo';
end;

procedure TForm4.DP1BeforeUpdateRecord;
begin
  inherited;
end;

function TForm4.NextNum: Integer;
var
  s: String;
  i: Integer;
  Clone: TClientDataset;
  bFilt: Boolean;

begin
  i := 1;
  Result := i;
  bFilt := False;
  Clone := nil;

  try
    bFilt := F14.Filtered;
    if bFilt then
    begin
      F14.DisableControls;
      F14.Filtered := False;
    end;

    if (F14.RecordCount = 0) then Exit;

    Clone := TClientDataset.Create(nil);
    Clone.Active := False;
    Clone.CloneCursor(F14, False, True);

    i := 0;
    with Clone do
    begin
      First;

      while not Clone.Eof do
      begin
        s := Clone['WO'];
        if IsStrANumber(s) then
          i := StrToInt(s);

        Next;
      end;
    end;

    Inc(i);

  finally
    if Assigned(Clone) then
      FreeAndNil(Clone);

    if bFilt then
    begin
      F14.Filtered := bFilt;
      F14.EnableControls;
    end;

    Result := i;
  end;
end;

function TForm4.DoCheck: Boolean;
begin
  Result := True;
end;

procedure TForm4.ClearMTO;
begin
  inherited;
end;

procedure TForm4.CancelAlloc;
begin
  inherited;
end;

procedure TForm4.SetQuery;
var
  S1: String;

begin
  set_Fields;

  S1 := Format('SELECT DISTINCT field1, t1_id, field3, field4, field5, field6, field7, field8, ' +
                               'IF(field8 = 0, ''TypeA'', ''TypeB'') AS field9,' +
                               ' field10, field11, field12, field13, %S,' +
                               ' field14, field15,' +
                               ' zone1, zone2, zone3, zone4',
                               [F19 + F20]);

  Detail_SQLDS.CommandText := S1 +
                     Format(' FROM t1' +
                            ' WHERE field1 = :field1' +
                              ' AND %S = :field2',
                              [F21]);

  Detail_SQLDS.CommandText := Detail_SQLDS.CommandText + ' UNION (SELECT * FROM (' + S1;

  Detail_SQLDS.CommandText := Detail_SQLDS.CommandText +
                     Format(' FROM t1_hist' +
                            ' WHERE field1 = :field1' +
                              ' AND %S = :field2' +
                              ' AND t1_id NOT IN (SELECT t1_id' +
                                                  ' FROM t1' +
                                                  ' WHERE field1 = a.field1' +
                                                    ' AND t1_id = a.t1_id' +
                                                    ' AND %S = a.%S)' +
                            ' ORDER BY a.field8 DESC) x' +
                            ' GROUP BY t1_id)',
                            [F21,
                             F21,
                             F21]);

  Detail_SQLDS.CommandText := Detail_SQLDS.CommandText +
                            ' ORDER BY field4, field5';
end;

procedure TForm4.OpenDetail;
begin
  inherited;
end;

procedure TForm4.PageChange;
begin
  inherited;
end;

procedure TForm4.SetSplitter;
begin
  inherited;
end;

procedure TForm4.FilterDetail;
begin
  inherited;
end;

procedure TForm4.FieldWelds;
begin
  inherited;
end;

procedure TForm4.PrintStickers;
begin
  inherited;
end;

procedure TForm4.FilterClick;
begin
  inherited;
end;

procedure TForm4.ReqDDblClick;
begin
  inherited;
end;

procedure TForm4.AddBtn;
begin
  inherited;
end;

procedure TForm4.RemoveBtn;
begin
  inherited;
end;

procedure TForm4.DetAfterScroll;
begin
  inherited;
end;

procedure TForm4.GridColor;
begin
  inherited;
end;

procedure TForm4.GridColor2;
begin
  inherited;
end;

procedure TForm4.GridColor3;
begin
  inherited;
end;

procedure TForm4.LoadPicklist;
begin
  inherited;
end;

procedure TForm4.PicklistColor;
begin
  inherited;
end;

procedure TForm4.PicklistScroll;
begin
  inherited;
end;

procedure TForm4.WeldsColor;
begin
  inherited;
end;

procedure TForm4.ReportClick;
begin
  inherited;
end;

procedure TForm4.ReportDblClick;
begin
  inherited;
end;

procedure TForm4.SpoolsColor;
begin
  inherited;
end;

procedure TForm4.SelectAllBtn;
begin
  inherited;
  Grid3.SelectAll;
end;

procedure TForm4.Btn5Click;
begin
  inherited;
  Grid3.SelectNone;
end;

procedure TForm4.BtnVerify;
var
  i: integer;
begin
  inherited;

  if Grid3.SelectedRows.Count <= 0 then
    Exit;

  Grid3.DataSource.DataSet.DisableControls;
  try
    with Grid3.DataSource.DataSet do begin
      for i := 0 to Grid3.SelectedRows.Count - 1 do
      begin
        GotoBookmark(Grid3.SelectedRows.Items[i]);
      end;
    end;
  finally
    Grid3.DataSource.DataSet.Refresh;
    Grid3.DataSource.DataSet.EnableControls;
  end;
end;

procedure TForm4.SetupMaster;
begin
  Grid1.TitleLineCount := 2;
  Grid1.TitleAutoWrap := True;

  SetupGridColumns(Grid1, Grid22);

  Grid1.FixedCols := 0;

  Grid1.SetGridColumnWidths;
end;

procedure TForm4.SetupDetail;
begin
end;

procedure TForm4.SetRights;
begin
  inherited;
end;

procedure TForm4.SetBtnState;
begin
  inherited;
end;

procedure TForm4.SetState;
begin
end;

procedure TForm4.SetTitles;
begin
end;

procedure TForm4.FormatField;
begin
end;

procedure TForm4.SetQuery2;
var
  S1: String;
begin
  set_Fields;

  S1 := Format('SELECT field1, field4, field5, field1, field3, field6, ' +
                               'IF(field8 = 0, ''TypeA'', ''TypeB'') AS field9,' +
                               ' field15,' +
                               ' zone1, zone2, zone3, zone4',
                               [F20]);

  Spools_SQLDS.CommandText := S1 +
                     Format(' FROM t1' +
                            ' WHERE field1 = :field1' +
                              ' AND %S = :field2',
                              [F21]);
end;

procedure TForm4.SetQuery3;
begin
  Matl_SQLDS.CommandText := Format('SELECT F1, F2, F3, F4, F5, F6, F7, F8, ' +
                                   'F9, F10, F11, F12, F13, F14, F15, F16, ' +
                                   'F17, F18, F19, F20, F21' +
                                   ' FROM t1 ' +
                                   ' WHERE field1 = :P1' +
                                     ' AND field2 = :P2' +
                                     ' AND (ISNULL(field3) OR (field3 <> ''D''))' +
                                     ' AND (ISNULL(field4) OR (field4 = ''NA''))' +
                                   ' GROUP BY field5, field6, field7, field8, field9' +
                                   ' ORDER BY field5, field10, field11, field12, field13',
                                    ['F14', 'F14']);
end;

procedure TForm4.SetQuery4;
begin
  Tag_Matl_SQLDS.CommandText := Format('SELECT F1, F2, F3, F4, F5 FROM t1 ' +
                                       'WHERE field1 = :P1 ' +
                                         'AND field2 = :P2 ' +
                                         'AND (ISNULL(field3) OR (field3 <> ''D'')) ' +
                                         'AND (ISNULL(field4) OR (field4 = ''NA'')) ' +
                                       'GROUP BY field5, field6, field7, field8, field9 ' +
                                       'ORDER BY field5, field10, field11, field12, field13',
                                        ['F14', 'F14']);
end;

procedure TForm4.SetQuery5;
begin
  Welds_SQLDS.CommandText := 'SELECT F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, F11, F12, F13, ' +
                             'F14, F15, F16, F17, F18, F19, F20, F21 ' +
                             'FROM t2 ' +
                             'LEFT JOIN t1 ON t1.id = t2.ref_id ' +
                             'WHERE t1.field1 = :P1 ' +
                               'AND t1.field2 = :P2 ' +
                               'AND (ISNULL(t1.field3) OR (t1.field3 = ''Y'')) ' +
                               'AND (ISNULL(t2.field4) OR (t2.field4 <> ''C'')) ' +
                             'ORDER BY t2.ref_id, t2.field5';
end;

end.
