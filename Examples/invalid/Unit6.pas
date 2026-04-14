unit Unit6;

interface

uses
  CompWin, CompGui, CompData, CompStd, CompGrid, CompDb,
  CompSql, CompProv, CompBcd, CompBtn, CompStr,
  CompClip, CompMenu, CompAct, CompImg, CompImgList,
  CompSplit, CompExt, CompMask, CompVtree,
  UnitBase1, UnitCommon, UnitConst, CompFrame;

const
  GridCols1: array [0..36] of TGridColumnSettings = ((TableName : 't1'; FieldName : 'F1'; FieldType : 'ATR'; Width : 150; Alignment : taLeftJustify; DisplayType : ctBocText; TitleColor : clBtnFace; TitleCaption : 'F1'; TitleFontColor : clWindowText; TitleFontStyles : [fsBold]; TitleAlignment : taCenter; Visible : True; ReadOnly : True; TV_Filtering : True; ),
(TableName : 't1'; FieldName : 'fn_doc( ''X'', ''Y'', b.id, ''NA'' )'; Alias : 'HasDoc'; FieldType : 'ATR'; Width : 100; Alignment : taLeftJustify; DisplayType : ctBocCheckBox; TitleColor : clBtnFace; TitleCaption : 'Doc?'; TitleFontColor : clBlue; TitleFontStyles : [fsBold]; TitleAlignment : taCenter; Visible : True; ReadOnly : True; TV_Filtering : True; ),
(TableName : 't1'; FieldName : 'F2'; FieldType : 'ATR'; Width : 100; Alignment : taLeftJustify; DisplayType : ctBocText; TitleColor : clBtnFace; TitleCaption : 'F2'; TitleFontColor : clWindowText; TitleFontStyles : [fsBold]; TitleAlignment : taCenter; Visible : True; ReadOnly : True; TV_Filtering : True; ),
(TableName : 't1'; FieldName : 'F3'; FieldType : 'ATR'; Width : 100; Alignment : taLeftJustify; DisplayType : ctBocText; TitleColor : clBtnFace; TitleCaption : 'F3'; TitleFontColor : clWindowText; TitleFontStyles : [fsBold]; TitleAlignment : taCenter; Visible : True; ReadOnly : True; TV_Filtering : True; ),
(TableName : 't1'; FieldName : 'F4'; FieldType : 'ATR'; Width : 50; Alignment : taLeftJustify; DisplayType : ctBocText; TitleColor : clBtnFace; TitleCaption : 'F4'; TitleFontColor : clWindowText; TitleFontStyles : [fsBold]; TitleAlignment : taCenter; Visible : True; ReadOnly : True; TV_Filtering : True; ),
(TableName : 't1'; FieldName : 'F5'; FieldType : 'ATR'; Width : 100; Alignment : taLeftJustify; DisplayType : ctBocText; TitleColor : clBtnFace; TitleCaption : 'F5'; TitleFontColor : clWindowText; TitleFontStyles : [fsBold]; TitleAlignment : taCenter; Visible : True; ReadOnly : True; TV_Filtering : True; ),
(TableName : 't1'; FieldName : 'F6'; FieldType : 'ATR'; Width : 100; Alignment : taLeftJustify; DisplayType : ctBocText; TitleColor : clBtnFace; TitleCaption : 'F6'; TitleFontColor : clWindowText; TitleFontStyles : [fsBold]; TitleAlignment : taCenter; Visible : True; ReadOnly : True; TV_Filtering : True; ),
(TableName : 't1'; FieldName : 'F7'; FieldType : 'ATR'; Width : 100; Alignment : taLeftJustify; DisplayType : ctBocText; TitleColor : clBtnFace; TitleCaption : 'F7'; TitleFontColor : clWindowText; TitleFontStyles : [fsBold]; TitleAlignment : taCenter; Visible : True; ReadOnly : True; TV_Filtering : True; ),
(TableName : 't1'; FieldName : 'F8'; FieldType : 'ATR'; Width : 100; Alignment : taLeftJustify; DisplayType : ctBocText; TitleColor : clBtnFace; TitleCaption : 'F8'; TitleFontColor : clBlue; TitleFontStyles : [fsBold]; TitleAlignment : taCenter; Visible : True; ReadOnly : True; TV_Filtering : True; ),
(TableName : 't1'; FieldName : 'F9'; FieldType : 'ATR'; Width : 100; Alignment : taLeftJustify; DisplayType : ctBocText; TitleColor : clBtnFace; TitleCaption : 'F9'; TitleFontColor : clBlue; TitleFontStyles : [fsBold]; TitleAlignment : taCenter; Visible : True; ReadOnly : True; TV_Filtering : True; ),
(TableName : 't2'; FieldName : 'F10'; FieldType : 'LNK'; Width : 100; Alignment : taLeftJustify; DisplayType : ctBocText; TitleColor : clBtnFace; TitleCaption : 'F10'; TitleFontColor : clBlue; TitleFontStyles : [fsBold]; TitleAlignment : taCenter; Visible : True; ReadOnly : True; TV_Filtering : True; ),
(TableName : 't2'; FieldName : 'F11'; Alias : 'F11a'; FieldType : 'LNK'; Width : 150; Alignment : taLeftJustify; DisplayType : ctBocText; TitleColor : clBtnFace; TitleCaption : 'F11'; TitleFontColor : clBlue; TitleFontStyles : [fsBold]; TitleAlignment : taCenter; Visible : True; ReadOnly : True; TV_Filtering : True; ),
(TableName : 't2'; FieldName : 'F12'; Alias : 'F12a'; FieldType : 'LNK'; Width : 100; Alignment : taLeftJustify; DisplayType : ctBocText; TitleColor : clBtnFace; TitleCaption : 'F12'; TitleFontColor : clBlue; TitleFontStyles : [fsBold]; TitleAlignment : taCenter; Visible : True; ReadOnly : True; TV_Filtering : True; ),
(TableName : 't3'; FieldName : 'F13'; FieldType : 'LNK'; Width : 50; Alignment : taLeftJustify; DisplayType : ctBocText; TitleColor : clBtnFace; TitleCaption : 'F13'; TitleFontColor : clBlue; TitleFontStyles : []; TitleAlignment : taCenter; Visible : True; ReadOnly : True; TV_Filtering : True; ),
(TableName : 't3'; FieldName : 'F14'; FieldType : 'LNK'; Width : 50; Alignment : taLeftJustify; DisplayType : ctBocText; TitleColor : clBtnFace; TitleCaption : 'F14'; TitleFontColor : clBlue; TitleFontStyles : []; TitleAlignment : taCenter; Visible : True; ReadOnly : True; TV_Filtering : True; ),
(TableName : 't3'; FieldName : 'F15'; FieldType : 'LNK'; Width : 50; Alignment : taLeftJustify; DisplayType : ctBocText; TitleColor : clBtnFace; TitleCaption : 'F15'; TitleFontColor : clBlue; TitleFontStyles : []; TitleAlignment : taCenter; Visible : True; ReadOnly : True; TV_Filtering : True; ),
(TableName : 't3'; FieldName : 'F16'; FieldType : 'LNK'; Width : 50; Alignment : taLeftJustify; DisplayType : ctBocText; TitleColor : clBtnFace; TitleCaption : 'F16'; TitleFontColor : clBlue; TitleFontStyles : []; TitleAlignment : taCenter; Visible : True; ReadOnly : True; TV_Filtering : True; ),
(TableName : 't4'; FieldName : 'F17'; Alias : 'F17a'; FieldType : 'LNK'; Width : 100; Alignment : taLeftJustify; DisplayType : ctBocText; TitleColor : clBtnFace; TitleCaption : 'F17'; TitleFontColor : clBlue; TitleFontStyles : []; TitleAlignment : taCenter; Visible : True; ReadOnly : True; TV_Filtering : True; ),
(TableName : 't4'; FieldName : 'F18'; FieldType : 'LNK'; Width : 100; Alignment : taLeftJustify; DisplayType : ctBocText; TitleColor : clBtnFace; TitleCaption : 'F18'; TitleFontColor : clBlue; TitleFontStyles : []; TitleAlignment : taCenter; Visible : True; ReadOnly : True; TV_Filtering : True; ),
(TableName : 't5'; FieldName : 'F19'; Alias : 'F19a'; FieldType : 'LNK'; Width : 100; Alignment : taLeftJustify; DisplayType : ctBocText; TitleColor : clBtnFace; TitleCaption : 'F19'; TitleFontColor : clBlue; TitleFontStyles : []; TitleAlignment : taCenter; Visible : True; ReadOnly : True; TV_Filtering : True; ),
(TableName : 't6'; FieldName : 'F20'; Alias : 'F20a'; FieldType : 'LNK'; Width : 100; Alignment : taLeftJustify; DisplayType : ctBocText; TitleColor : clBtnFace; TitleCaption : 'F20'; TitleFontColor : clBlue; TitleFontStyles : [fsBold]; TitleAlignment : taCenter; Visible : False; ReadOnly : True; TV_Filtering : False; ),
(TableName : 't6'; FieldName : 'F21'; FieldType : 'LNK'; Width : 100; Alignment : taLeftJustify; DisplayType : ctBocText; TitleColor : clBtnFace; TitleCaption : 'F21'; TitleFontColor : clBlue; TitleFontStyles : [fsBold]; TitleAlignment : taCenter; Visible : False; ReadOnly : True; TV_Filtering : False; ),
(TableName : 't6'; FieldName : 'F22'; FieldType : 'LNK'; Width : 100; Alignment : taLeftJustify; DisplayType : ctBocText; TitleColor : clBtnFace; TitleCaption : 'F22'; TitleFontColor : clBlue; TitleFontStyles : [fsBold]; TitleAlignment : taCenter; Visible : False; ReadOnly : True; TV_Filtering : False; ),
(TableName : 't6'; FieldName : 'F23'; FieldType : 'LNK'; Width : 100; Alignment : taLeftJustify; DisplayType : ctBocText; TitleColor : clBtnFace; TitleCaption : 'F23'; TitleFontColor : clBlue; TitleFontStyles : [fsBold]; TitleAlignment : taCenter; Visible : False; ReadOnly : True; TV_Filtering : False; ),
(TableName : 't6'; FieldName : 'F24'; FieldType : 'LNK'; Width : 100; Alignment : taLeftJustify; DisplayType : ctBocText; TitleColor : clBtnFace; TitleCaption : 'F24'; TitleFontColor : clBlue; TitleFontStyles : [fsBold]; TitleAlignment : taCenter; Visible : False; ReadOnly : True; TV_Filtering : False; ),
(TableName : 't6'; FieldName : 'F25'; FieldType : 'LNK'; Width : 50; Alignment : taLeftJustify; DisplayType : ctBocCheckBox; TitleColor : clBtnFace; TitleCaption : 'F25'; TitleFontColor : clBlue; TitleFontStyles : [fsBold]; TitleAlignment : taCenter; Visible : False; ReadOnly : True; TV_Filtering : False; ),
(TableName : 't7'; FieldName : 'F26'; Alias : 'F26a'; FieldType : 'LNK'; Width : 100; Alignment : taLeftJustify; DisplayType : ctBocText; TitleColor : clBtnFace; TitleCaption : 'F26'; TitleFontColor : clBlue; TitleFontStyles : [fsBold]; TitleAlignment : taCenter; Visible : False; ReadOnly : True; TV_Filtering : False; ),
(TableName : 't6'; FieldName : 'F27'; FieldType : 'LNK'; Width : 100; Alignment : taLeftJustify; DisplayType : ctBocText; TitleColor : clBtnFace; TitleCaption : 'F27'; TitleFontColor : clBlue; TitleFontStyles : [fsBold]; TitleAlignment : taCenter; Visible : False; ReadOnly : True; TV_Filtering : False; ),
(FieldName : 'IFNULL(t10.F17, t6.F29)'; Alias : 'F28a'; FieldType : 'LNK'; Width : 100; Alignment : taLeftJustify; DisplayType : ctBocText; TitleColor : clBtnFace; TitleCaption : 'F28'; TitleFontColor : clBlue; TitleFontStyles : [fsBold]; TitleAlignment : taCenter; Visible : False; ReadOnly : True; TV_Filtering : False; ),
(TableName : 't6'; FieldName : 'F30'; FieldType : 'LNK'; Width : 100; Alignment : taLeftJustify; DisplayType : ctBocText; TitleColor : clBtnFace; TitleCaption : 'F30'; TitleFontColor : clBlue; TitleFontStyles : [fsBold]; TitleAlignment : taCenter; Visible : False; ReadOnly : True; TV_Filtering : False; ),
(TableName : 't6'; FieldName : 'F31'; FieldType : 'LNK'; Width : 100; Alignment : taLeftJustify; DisplayType : ctBocText; TitleColor : clBtnFace; TitleCaption : 'F31'; TitleFontColor : clBlue; TitleFontStyles : [fsBold]; TitleAlignment : taCenter; Visible : False; ReadOnly : True; TV_Filtering : False; ),
(TableName : 't6'; FieldName : 'F32'; FieldType : 'LNK'; Width : 100; Alignment : taLeftJustify; DisplayType : ctBocText; TitleColor : clBtnFace; TitleCaption : 'F32'; TitleFontColor : clBlue; TitleFontStyles : [fsBold]; TitleAlignment : taCenter; Visible : False; ReadOnly : True; TV_Filtering : False; ),
(TableName : 't6'; FieldName : 'F33'; FieldType : 'LNK'; Width : 100; Alignment : taLeftJustify; DisplayType : ctBocText; TitleColor : clBtnFace; TitleCaption : 'F33'; TitleFontColor : clBlue; TitleFontStyles : [fsBold]; TitleAlignment : taCenter; Visible : False; ReadOnly : True; TV_Filtering : False; ),
(TableName : 't9'; FieldName : 'F34'; FieldType : 'LNK'; Width : 100; Alignment : taLeftJustify; DisplayType : ctBocText; TitleColor : clBtnFace; TitleCaption : 'F34'; TitleFontColor : clBlue; TitleFontStyles : []; TitleAlignment : taCenter; Visible : False; ReadOnly : True; TV_Filtering : False; ),
(TableName : 't9'; FieldName : 'F35'; Alias : 'F35a'; FieldType : 'LNK'; Width : 100; Alignment : taLeftJustify; DisplayType : ctBocText; TitleColor : clBtnFace; TitleCaption : 'F35'; TitleFontColor : clBlue; TitleFontStyles : []; TitleAlignment : taCenter; Visible : False; ReadOnly : True; TV_Filtering : False; ),
(TableName : 't1'; FieldName : 'F36'; FieldType : 'ATR'; Width : 30; Alignment : taLeftJustify; DisplayType : ctBocText; TitleColor : clBtnFace; TitleCaption : 'F36'; TitleFontColor : clBlue; TitleFontStyles : [fsBold]; TitleAlignment : taCenter; Visible : False; ReadOnly : True; TV_Filtering : False; )
);
  GridCols2: array [0..0] of TGridColumnSettings = (());


type
  TForm6 = class(TBaseForm2)
    DS1: TIntegerField;
    DS2: TStringField;
    DS3: TStringField;
    DS4: TFMTBCDField;
    DS5: TStringField;
    DS6: TStringField;
    DS7: TFMTBCDField;
    DS8: TFMTBCDField;
    DS9: TFMTBCDField;
    DS10: TFMTBCDField;
    DS11: TStringField;
    DS12: TStringField;
    DS13: TStringField;
    DS14: TStringField;
    DS15: TFMTBCDField;
    DS16: TStringField;
    DS17: TStringField;
    DS18: TStringField;
    DS19: TStringField;
    DS20: TStringField;
    DS21: TStringField;
    DS22: TStringField;
    DS23: TStringField;
    DS24: TIntegerField;
    DS25: TShortintField;
    DS26: TStringField;
    DS27: TStringField;
    DS28: TStringField;
    DS29: TFMTBCDField;
    DS30: TStringField;
    DS31: TFMTBCDField;
    DS32: TStringField;
    DS33: TStringField;
    DS34: TStringField;
    DS35: TIntegerField;
    DS36: TIntegerField;
    DS37: TIntegerField;
    DS38: TIntegerField;
    DS39: TMemoField;
    DS40: TStringField;
    DS41: TDateField;
    DS42: TStringField;
    DS43: TDateField;
    CDS1: TIntegerField;
    CDS2: TStringField;
    CDS3: TStringField;
    CDS4: TFMTBCDField;
    CDS5: TStringField;
    CDS6: TStringField;
    CDS7: TFMTBCDField;
    CDS8: TFMTBCDField;
    CDS9: TFMTBCDField;
    CDS10: TFMTBCDField;
    CDS11: TStringField;
    CDS12: TStringField;
    CDS13: TStringField;
    CDS14: TStringField;
    CDS15: TFMTBCDField;
    CDS16: TStringField;
    CDS17: TStringField;
    CDS18: TStringField;
    CDS19: TStringField;
    CDS20: TStringField;
    CDS21: TStringField;
    CDS22: TStringField;
    CDS23: TStringField;
    CDS24: TIntegerField;
    CDS25: TIntegerField;
    CDS26: TIntegerField;
    CDS27: TIntegerField;
    CDS28: TMemoField;
    CDS29: TStringField;
    CDS30: TDateField;
    CDS31: TStringField;
    CDS32: TDateField;
    DS44: TStringField;
    CDS33: TStringField;

    procedure AfterInsert;
    procedure Nav1Click;
    procedure GridDblClick;
    procedure AfterScroll;
    procedure OpenDetail;

  private

  protected
    procedure SetQueries(iLoadType: Integer); override;
    procedure SetDetailQueries(iLoadType: Integer); override;
    procedure SetupMaster; override;
    procedure SetupDetail; override;
    procedure SetBtnState; override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Initialize; override;


implementation

uses
  UnitMain, UnitProc, CompClip, UnitConst, UnitWizard1;

{$R *.dfm}

constructor TForm6.Create(AOwner: TComponent);
begin
  FiUser_Priv := Integer(C1);

  inherited;

  FbInheritedForm := True;
  Mast_Dataset := CDS1;
  Mast_SQLDS := DS1;
end;

destructor TForm6.Destroy;
begin
  inherited;
end;

procedure TForm6.Initialize;
begin
  inherited;
  F1 := 'Sort1;Sort2';
end;

procedure TForm6.AfterInsert;
begin
  inherited;
  CDS1.FindField('field1_id').AsInteger := Obj1.field1_id;
  CDS1.FindField('Type').AsString := 'ISO';
end;

procedure TForm6.AfterScroll;
begin
  inherited;
end;

procedure TForm6.Nav1Click;
    TNavigateBtn);
var
  Res: TModalResult;

begin
  Res := mrNone;

  if (Button = nbinsert) or (Button = nbedit) then
  begin
    if Assigned(FWizard1) then
      FreeAndNil(FWizard1);

    try
      FWizard1                := TWizard1.Create(Self);
      FWizard1.Calling_Form   := Self;
      FWizard1.Wizard_Dataset := CDS1;
      Res := FWizard1.ShowModal;

    finally
      if Assigned(FWizard1) then
        FreeAndNil(FWizard1);
    end;
  end
  else
    inherited;

  if (Res = mrOk) and (CDS1.Active) and (CDS1.RecordCount > 0) then
    CDS1.Refresh;
end;

procedure TForm6.GridDblClick;
begin
  inherited;

  if CDS1.Active then
  begin
    if CDS1.FindField('ID').AsInteger > cUndefined then
      Master_DBNavigator.BtnClick(nbedit)
    else
      Master_DBNavigator.BtnClick(nbinsert);
  end;
end;

procedure TForm6.OpenDetail;
begin
  SetDetailQueries(cDefaultLoadScope);
  inherited;
end;

procedure TForm6.SetBtnState;
var
  bView: Boolean;
  bAttach: Boolean;

begin
  inherited;

  bView := False;
  bAttach := False;

  if CDS1.Active then
  begin
    if CDS1.RecordCount > 0 then
    begin
      bAttach := not FbReadOnlyAccess;
      bView   := VarToIntDef(CDS1['HasDoc'], 0) > 0;
    end;
  end;
end;

procedure TForm6.SetDetailQueries(iLoadType: Integer);
begin
  inherited;
end;

procedure TForm6.SetQueries(iLoadType: Integer);
begin
  FMasterWhereFilter := EmptyStr;

  if (iLoadType <> cLoadForFilterInit) then
  begin
    if cbShowMasterTreeview.Checked then
    begin
      FMasterWhereFilter := GetMasterTvFilterText(FMasterHaving);
    end;
  end;

  FMain_Query.Clear;
  FMain_Query.Master.DS       := DS1;
  FMain_Query.Master.ClientDS := CDS1;
  FMain_Query.IdField         := 'ID';
  FMain_Query.KeyField        := 'F1';

  FMainSelect := 'SELECT b.ID, c.field1, b.F1, b.F2, b.F3, b.F4, b.F5, b.F6, ' +
    'b.F7, b.F8, ' +
    't.F10, t.F11, t.F12 AS F12a, t.F13 AS F13a, ' +
    'z.Z1, z.Z2, z.Z3, z.Z4, ' +
    'm.F14 AS F14a, m.F15, cc2.F14 AS F16a, ' +
    'IFNULL(t10.F17, t9.F18) AS F17a, t9.F19, t9.F20, t9.F21, t9.F22, t9.F23, ' +
    't8.F24 AS F24a, t9.F25, CAST(AGG(g.F20) AS VARCHAR(100)) AS F25a, ns.F26, ns.F27, ns.F28, ' +
    'q.F29, q.F19 AS F29a, ' +
    'fn_doc( ''X'', ''Y'', b.ID, ''NA'' ) AS F30a, ' +
    'b.f1_id, b.f2_id, b.f3_id, b.f4_id, b.F31, b.F32, b.A1, b.A2, b.L1, b.L2 ';

  FMainFrom := 'FROM t1 b ';
  FMainJoin := 'INNER JOIN t2 c ON b.f1_id = c.f1_id ' +
    'INNER JOIN t3 t10 ON b.f2_id = t10.f2_id ' +
    'INNER JOIN t4 t9 ON t10.f5_id = t9.f5_id ' +
    'INNER JOIN t5 t8 ON t9.f6_id = t8.f6_id ' +
    'INNER JOIN t6 g ON CONTAINS(g.F33,t9.F25) ' +
    'INNER JOIN t7 ns ON t9.f7_id = ns.f7_id ' +
    'LEFT JOIN t8 q ON t9.f5_id = q.f5_id ' +
    'INNER JOIN t9 t ON t.f4_id = b.f4_id ' +
    'INNER JOIN t10 z ON t.f8_id = z.f8_id ' +
    'INNER JOIN t11 t11 ON t11.field1 = t.field1 AND t11.F12 = t.F12 ' +
    'INNER JOIN t12 m ON t11.f9_id = m.f9_id ' +
    'INNER JOIN t13 cc2 ON t11.f10_id = cc2.f10_id ';
  FMainWhere   := 'WHERE c.field1 = ' + QuotedStr(Select_Box.Text) + ' AND b.F31 = ''ISO'' ';
  FMainGroupBy := 'GROUP BY b.ID, t10.f2_id, t9.f5_id ';
  FMainOrderBy := 'ORDER BY F10, F1 ';
end;

procedure TForm6.SetupDetail;
begin
  SetupGridColumns(Detail_Grid, GridCols2);
  inherited;
end;

procedure TForm6.SetupMaster;
begin
  SetupGridColumns(Master_Grid, GridCols1, FMain_Query.MainQuery);
  inherited;
end;

end.
