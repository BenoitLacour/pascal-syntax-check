unit Unit6;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, UDBXFilterDialog, UDBXSortDialog,
  XmlImportDialog, SqlExpr, Provider, DBClient, DB, ActnList, StdCtrls,
  Mask, DBCtrls, Buttons, Grids, DBGrids, UnitGridEnh, ComCtrls, ExtCtrls,
  UnitValidation, Unit2, System.Actions, System.UITypes,
  Unit3, System.ImageList, Vcl.ImgList, Unit4, Unit5,
  JvExExtCtrls, JvExtComponent, JvRollOut, Vcl.Menus, Unit6;

type
  TProcType = (ptType1, ptType2);
  TProcTypes = set of TProcType;

  TForm1 = class(TForm2)
    Query1: TSQLQuery;
    Provider1: TDataSetProvider;
    ClientDataSet1: TClientDataSet;
    Panel1: TPanel;
    Grid1: TDBGridEnh;
    Panel2: TPanel;
    Label1: TLabel;
    DataSet1: TSQLDataSet;
    DataSetProvider1: TDataSetProvider;
    ClientDataSet2: TClientDataSet;
    DataSource1: TDataSource;
    Label2: TLabel;
    TabSheet1: TTabSheet;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Edit1: TDBEdit;
    Edit2: TDBEdit;
    Edit3: TDBEdit;
    Edit4: TDBEdit;
    CheckBox1: TDBCheckBox;
    Splitter1: TcySplitter;
    TabSheet2: TTabSheet;
    Panel3: TPanel;
    Grid2: TDBGridEnh;
    Panel4: TPanel;
    Label7: TLabel;
    Splitter2: TcySplitter;
    Label8: TLabel;
    Panel5: TPanel;
    Grid3: TDBGridEnh;
    Panel6: TPanel;
    DataNavigator1: TDBNavigator;
    Button1: TBitBtn;
    Button2: TBitBtn;
    Button3: TBitBtn;
    Button4: TBitBtn;
    Panel7: TPanel;
    Label9: TLabel;
    CheckBox2: TCheckBox;
    Panel8: TPanel;
    RadioButton1: TRadioButton;
    Label10: TLabel;
    RadioButton2: TRadioButton;
    Label11: TLabel;
    FormDocuments1: TFormDocuments;

    procedure FormCreate(Sender: TObject);
    procedure Initialize; override;
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

    procedure SelectBoxChange(Sender: TObject);
    procedure BtnOpenClick(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure LabelClick(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure Grid1DblClick(Sender: TObject);
    procedure ClientDataSet1BeforeInsert(DataSet: TDataSet);
    procedure ClientDataSet1AfterInsert(DataSet: TDataSet);
    procedure ClientDataSet1BeforeScroll(DataSet: TDataSet);
    procedure ClientDataSet1AfterScroll(DataSet: TDataSet);
    procedure ClientDataSet1AfterPost(DataSet: TDataSet);
    procedure ClientDataSet1BeforePost(DataSet: TDataSet);
    procedure Field1GetText(Sender: TField; var Text: String; DisplayText: Boolean);
    procedure Field1SetText(Sender: TField; const Text: String);
    procedure Provider1GetTableName(Sender: TObject; DataSet: TDataSet; var TableName: String);
    procedure Provider1BeforeUpdateRecord(Sender: TObject; SourceDS: TDataSet;
      DeltaDS: TCustomClientDataSet; UpdateKind: TUpdateKind; var Applied: Boolean);

    procedure PageControlChange(Sender: TObject);
    procedure BtnDetailClick(Sender: TObject);
    procedure DataSet1AfterScroll(DataSet: TDataSet);
    procedure GridDetailDblClick(Sender: TObject);
    procedure GridDetailColExit(Sender: TObject);
    procedure GridDetailColEnter(Sender: TObject);
    procedure DetailAfterScroll(DataSet: TDataSet);
    procedure DetailBeforeInsert(DataSet: TDataSet);
    procedure DetailAfterInsert(DataSet: TDataSet);
    procedure DetailBeforePost(DataSet: TDataSet);
    procedure DetailProviderGetTableName(Sender: TObject; DataSet: TDataSet; var TableName: String);
    procedure DetailProviderBeforeUpdateRecord(Sender: TObject; SourceDS: TDataSet;
      DeltaDS: TCustomClientDataSet; UpdateKind: TUpdateKind; var Applied: Boolean);

    procedure BtnDetail2Click(Sender: TObject);
    procedure GridDetail2DblClick(Sender: TObject);
    procedure GridDetail2ColExit(Sender: TObject);

    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState); override;
    procedure GridDetail2ColEnter(Sender: TObject);
    procedure NotesChange(Sender: TObject);

  private
    DocViewer: TDocViewer;
    Flag1, Flag2: Boolean;
    FProcType: TProcTypes;

    function CheckLocked: Boolean;
    function CheckDates: Boolean;

    procedure OpenWelders();
    procedure DisplayDetails();

    procedure RefreshLookupDiameters();
    procedure RefreshLookupSchedules();

    procedure RefreshCell(Sender: TObject);
    procedure SetDetailGridColumnsAccess;

    procedure TypeSelect(Sender: TObject);
    procedure DoLookupDiameter();
  published
    property ProcType: TProcTypes read FProcType write FProcType default [ptType1, ptType2];

  protected
    List1, List2: TStringList;

    procedure SetupMasterGridColumns; override;
    procedure SetupDetailGridColumns; override;
    procedure SetAccessRight; override;
    procedure SetButtonsState; override;
    procedure SetPanelsSize; overload;

  public

  end;

var
  Form1: TForm1;

implementation

uses
  MainD, UnitConst, UnitProcedures, UnitTraduc, DateUtils,
  UnitDocs, UnitHelp, CommonUnit, UnitLookup;

{$R *.dfm}

function TForm1.CheckDates: Boolean;
begin
  Result := True;

  if (CompareDate(ClientDataSet3.FieldByName('Date1').AsDateTime, Today) > 0) then
  begin
    MessageDlg('Date1 cannot be greater than Current Date.', mtError, [mbOk], 0);

    if FProcType = [ptType1] then
      Grid2.Col := Grid2.GetColumnIndexByFieldName('Date1') + 1
    else
    if FProcType = [ptType2] then
      Grid3.Col := Grid3.GetColumnIndexByFieldName('Date1') + 1;

    Result := False;
  end
  else
  if (CompareDate(ClientDataSet3.FieldByName('Date2').AsDateTime, Today) > 0) then
  begin
    MessageDlg('Date2 cannot be greater than Current Date.', mtError, [mbOk], 0);

    if FProcType = [ptType1] then
      Grid2.Col := Grid2.GetColumnIndexByFieldName('Date2') + 1
    else
    if FProcType = [ptType2] then
      Grid3.Col := Grid3.GetColumnIndexByFieldName('Date2') + 1;

    Result := False;
  end
  else
  if (CompareDate(ClientDataSet3.FieldByName('Date3').AsDateTime, Today) > 0) then
  begin
    MessageDlg('Date3 cannot be greater than Current Date.', mtError, [mbOk], 0);

    if FProcType = [ptType1] then
      Grid2.Col := Grid2.GetColumnIndexByFieldName('Date3') + 1
    else
    if FProcType = [ptType2] then
      Grid3.Col := Grid3.GetColumnIndexByFieldName('Date3') + 1;

    Result := False;
  end;

  if not ClientDataSet3.FieldByName('Date2').IsNull then
  begin
    if ClientDataSet3.FieldByName('Date1').IsNull then
    begin
      MessageDlg('You need to set Date1.', mtError, [mbOk], 0);

      if FProcType = [ptType1] then
        Grid2.Col := Grid2.GetColumnIndexByFieldName('Date1') + 1
      else
      if FProcType = [ptType2] then
        Grid3.Col := Grid3.GetColumnIndexByFieldName('Date1') + 1;

      Result := False;
    end
    else
    if Trim(ClientDataSet3.FieldByName('User1').AsString) = '' then
    begin
      MessageDlg('User1: who verified?', mtError, [mbOk], 0);

      if FProcType = [ptType1] then
        Grid2.Col := Grid2.GetColumnIndexByFieldName('User1') + 1
      else
      if FProcType = [ptType2] then
        Grid3.Col := Grid3.GetColumnIndexByFieldName('User1') + 1;

      Result := False;
    end
    else
    if (CompareDate(ClientDataSet3.FieldByName('Date1').AsDateTime,
      ClientDataSet3.FieldByName('Date2').AsDateTime) > 0) then
    begin
      MessageDlg('Date2 cannot be less than Date1.', mtError, [mbOk], 0);

      if FProcType = [ptType1] then
        Grid2.Col := Grid2.GetColumnIndexByFieldName('Date2') + 1
      else
      if FProcType = [ptType2] then
        Grid3.Col := Grid3.GetColumnIndexByFieldName('Date2') + 1;

      Result := False;
    end;
  end;

  if Result and not ClientDataSet3.FieldByName('Date3').IsNull then
  begin
    if ClientDataSet3.FieldByName('Date2').IsNull then
    begin
      MessageDlg('You need to set Date2.', mtError, [mbOk], 0);

      if FProcType = [ptType1] then
        Grid2.Col := Grid2.GetColumnIndexByFieldName('Date2') + 1
      else
      if FProcType = [ptType2] then
        Grid3.Col := Grid3.GetColumnIndexByFieldName('Date2') + 1;

      Result := False;
    end
    else if Trim(ClientDataSet3.FieldByName('User2').AsString) = '' then
    begin
      MessageDlg('User2: who approved?', mtError, [mbOk], 0);

      if FProcType = [ptType1] then
        Grid2.Col := Grid2.GetColumnIndexByFieldName('User2') + 1
      else
      if FProcType = [ptType2] then
        Grid3.Col := Grid3.GetColumnIndexByFieldName('User2') + 1;

      Result := False;
    end
    else if (CompareDate(ClientDataSet3.FieldByName('Date2').AsDateTime,
      ClientDataSet3.FieldByName('Date3').AsDateTime) > 0) then
    begin
      MessageDlg('Date3 cannot be less than Date2.', mtError, [mbOk], 0);

      if FProcType = [ptType1] then
        Grid2.Col := Grid2.GetColumnIndexByFieldName('Date3') + 1
      else
      if FProcType = [ptType2] then
        Grid3.Col := Grid3.GetColumnIndexByFieldName('Date3') + 1;

      Result := False;
    end;
  end;
end;

function TForm1.CheckLocked: Boolean;
begin
  Result := True;

  if not FieldIsNull(ClientDataSet3.FieldValues['User2']) and
    not FieldIsNull(ClientDataSet3.FieldValues['Date3']) then
  begin
    if not (Flag2 or is_admin(True)) then
    begin
      MessageDlg('These data has already been approved. You are not allowed to change the values!', mtError, [mbOk], 0);
      Result := False;
    end;
  end;
end;

procedure TForm1.NotesChange(Sender: TObject);
begin
  inherited;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  UserPriv := Integer(UserPrivValue);

  ProcType := [ptType1];

  inherited;

  LoadTitles(List1, List2);

  Initialize;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  inherited;

  FreeTitles(List1, List2);
end;

procedure TForm1.Initialize;
var
  NewItem: TMenuItem;
begin
  inherited;

  Form1 := Self;
  FormID := Self.Name;

  MasterNavigator.DoubleBuffered := True;
  DetailNavigator.DoubleBuffered := True;

  MastDataset := ClientDataSet1;
  MastSQLDS := DataSet17;
  DetDataset := ClientDataSet3;
  DetSQLDS := DataSet3;

  Grid1.DisplayAsCheckbox('HasDoc');

  if Grid1.DBPopUpMenu.Items.Find(TXTAttachDocuments) = nil then
  begin
    NewItem := TMenuItem.Create(Self);
    NewItem.Caption := '-';
    Grid1.DBPopUpMenu.Items.Add(NewItem);

    NewItem := TMenuItem.Create(Self);
    NewItem.Caption := TXTAttachDocuments;
    NewItem.OnClick := FormDocuments1.UploadDocuments;
    Grid1.DBPopUpMenu.Items.Add(NewItem);
  end;

  Grid2.DisplayAsCheckbox('Field1');
  Grid3.DisplayAsCheckbox('Field1');
  DisplayDetails;

  FormDocuments1.DocTable := 'table_docs1';
  FormDocuments1.DocSubClass := 'CLASS1';
  FormDocuments1.DocIDField := 'IDField';
  FormDocuments1.DocNameTitle := 'Title1';
  FormDocuments1.DocNameField := 'NameField';
  FormDocuments1.DocAttribute1Title := 'Attr1';
  FormDocuments1.DocAttribute1Field := 'Attr1';
  FormDocuments1.DocAttribute2Title := '';
  FormDocuments1.DocAttribute2Field := '';
  FormDocuments1.LinkTable := '';

  FormDocuments1.DocClientDS := ClientDataSet1;
  FormDocuments1.DocMasterSQLDS := DataSet17;
end;

procedure TForm1.SetPanelsSize;
begin
  if not PanelNotes.Collapsed then
    PanelNotes.Width := PanelMaster.ClientWidth div 4;

  if not PanelDetail.Collapsed then
    if (DetailPageControl.ActivePage = TabDetailMain)
      or (DetailPageControl.ActivePage = TabDetail2) then
      PanelDetail.Height := 3 * PanelMain.ClientHeight div 5
    else
      PanelDetail.Height := 280;
end;

procedure TForm1.SetupMasterGridColumns;
begin
end;

procedure TForm1.SetupDetailGridColumns;
begin
end;

procedure TForm1.RadioButton1Click(Sender: TObject);
begin
  inherited;

  TypeSelect(Sender);

  FormDocuments1.DocSubClass := 'CLASS1';
  FormDocuments1.DocTable := 'table_docs1';
end;

procedure TForm1.LabelClick(Sender: TObject);
begin
  inherited;

  RadioButton1.Checked := True;
end;

procedure TForm1.RadioButton2Click(Sender: TObject);
begin
  inherited;

  TypeSelect(Sender);

  FormDocuments1.DocSubClass := 'CLASS2';
  FormDocuments1.DocTable := 'table_docs2';
end;

procedure TForm1.TypeSelect(Sender: TObject);
begin
  inherited;

  if DetailDataset.Active then DetailDataset.Close;
  if DataSet1.Active then DataSet1.Close;

  if RadioButton1.Checked then
    ProcType := [ptType1]
  else
    ProcType := [ptType2];

  SetupGridColumns(Grid1, MasterColumns);
  SetupGridColumns(Grid2, DetailColumns);
  SetupGridColumns(Grid3, DetailColumns2);

  SetAccessRight;
  SetButtonsState;
  DisplayDetails;
  SetPanelsSize;

  DetailPageControlChange(Self);

  RefreshLookupDiameters();

  BtnOpenClick(Sender);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  inherited;

  SetupGridColumns(Grid1, MasterColumns);
  SetupGridColumns(Grid2, DetailColumns);
  SetupGridColumns(Grid3, DetailColumns2);

  DetailPageControl.ActivePage := TabDetailMain;
  DetailPageControlChange(Self);

  SetPanelsSize;

  if is_admin(True) then
    DisplayPrimaryKey := True
  else
  begin
    if ProcType = [ptType1] then
    begin
      Grid1.GetColumnByFieldName('IDField').Visible := False;
      Grid2.GetColumnByFieldName('DetailIDField').Visible := False
    end
    else
    if ProcType = [ptType2] then
    begin
      Grid1.GetColumnByFieldName('IDField2').Visible := False;
      Grid3.GetColumnByFieldName('DetailIDField2').Visible := False;
    end;

    Grid2.GetColumnByFieldName('DetailIDField').Visible := False;
    Grid3.GetColumnByFieldName('DetailIDField').Visible := False;
  end;

  SetButtonsState;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  inherited;

  SetPanelsSize;
end;

procedure TForm1.SelectBoxChange(Sender: TObject);
begin
  inherited;

  SetupGridColumns(Grid1, MasterColumns);
  SetupGridColumns(Grid2, DetailColumns);
  SetupGridColumns(Grid3, DetailColumns2);

  SetAccessRight;
  SetButtonsState;
  DisplayDetails;
  SetPanelsSize;

  DetailPageControlChange(Self);

  RefreshLookupDiameters();
end;

procedure TForm1.BtnOpenClick(Sender: TObject);
var
  TableName, DocClass: string;
begin
  if MainD.ContractList.Find(SelectBox.Text, Index) then else
  begin
    MessageDlg(TXTInvalidContract, mtError, [mbOk], 0);
    Abort;
  end;

  SetAccessRight;

  if ClientDataSet3.Active then ClientDataSet3.Close;
  if DataSet1.Active then DataSet1.Close;

  with DataSet17 do
  begin
    if Active then Close;

    if ProcType = [ptType1] then
    begin
      TableName := 'table1';
      DocClass := 'CLASS1';
    end
    else
    begin
      TableName := 'table2';
      DocClass := 'CLASS2';
    end;

    CommandText := Format('Select a.ID, a.Field2, d.Field5,' +
                          ' a.Field3, a.Field2 As Field2, b.Field1, b.Field2,' +
                          ' b.Field4, b.Field3, b.Field4,' +
                          ' a.Field5, a.Field6, a.Field7,' +
                          ' a.Field8, a.Field9,' +
                          ' a.Field10, a.Field11,' +
                          ' common.has_document("F", "%S", a.ID, "NA") Has_Doc,' +
                          ' a.Field12,' +
                          ' a.Field13, a.Field14, a.Field15, a.Field16' +

                        ' From schema1.%S a' +
                        ' Left Join schema2.table3 b On a.Field1 = b.Field1' +
                        ' Left Join schema1.table4 d On a.Field2 = d.Field2' +

                        ' Where a.Field2 = :Param1' +
                          ' And d.Field5 = "%S"' +

                        ' Order By a.Field3, a.Field2;', [DocClass, TableName, BranchCode]);
  end;

  inherited;

  SetButtonsState;
end;

procedure TForm1.SetButtonsState;
var
  BtnOpenFlag: Boolean;
  SaveMastFlag: Boolean;
  SaveDetFlag: Boolean;
  BtnAttachFlag: Boolean;
  BtnDisplayFlag: Boolean;
  OpenDetailFlag: Boolean;
  OpenDetail2Flag: Boolean;
begin
  BtnOpenFlag := False;
  SaveMastFlag := False;
  SaveDetFlag := False;
  BtnAttachFlag := False;
  BtnDisplayFlag := False;
  OpenDetailFlag := False;
  OpenDetail2Flag := False;

  if (Trim(SelectBox.Text) <> '') then
    BtnOpenFlag := True;

  if ClientDataSet1.Active then
  begin
    SaveMastFlag := not ReadOnlyAccess;

    if (ClientDataSet1.RecordCount > 0) then
    begin
      BtnAttachFlag := not ReadOnlyAccess;
      BtnDisplayFlag := (ClientDataSet1['HasDoc'] = '1');

      OpenDetailFlag := True;
      OpenDetail2Flag := True;
    end;
  end;

  if DetDataset.Active then
  begin
    SaveDetFlag := not ReadOnlyAccess;
  end;

  BtnOpen.Enabled := BtnOpenFlag;
  SaveMast.Enabled := SaveMastFlag;
  FormDocuments1.BtnAttachDoc.Enabled := BtnAttachFlag;
  FormDocuments1.BtnDisplayDoc.Enabled := BtnDisplayFlag;
  SaveDetail.Enabled := SaveDetFlag;
  SaveDetail2.Enabled := SaveDetFlag;
  BtnDetail.Enabled := OpenDetailFlag;
  BtnDetail2.Enabled := OpenDetail2Flag;
end;

procedure TForm1.GridDetailColEnter(Sender: TObject);
begin
  inherited;

  if (UpperCase(TDBGrid(Sender).SelectedField.FieldName) = UpperCase('Field1')) then
  begin
    RefreshLookupSchedules();
  end;
end;

procedure TForm1.GridDetail2ColEnter(Sender: TObject);
begin
  inherited;
end;

procedure TForm1.GridDetailDblClick(Sender: TObject);
begin
  if not (TDBGrid(Sender).DataSource.State in [dsEdit, dsInsert]) then
    Exit;

  if Grid2.Columns[Grid2.SelectedIndex].ReadOnly then
    Exit;

  if (Grid2.SelectedField.FieldName = 'Field2') then
  begin
    DoLookupDiameter();
    Exit;
  end;
  if (Grid2.SelectedField.FieldName = 'Field1') then
    RefreshLookupSchedules();

  Grid2.DataSource.DataSet.FieldValues['Field2'] := ContractValue.Contract;

  inherited;
end;

procedure TForm1.GridDetail2DblClick(Sender: TObject);
begin
  if not (TDBGrid(Sender).DataSource.State in [dsEdit, dsInsert]) then
    Exit;

  if Grid3.Columns[Grid3.SelectedIndex].ReadOnly then
    Exit;

  if TDBGrid(Sender).DataSource.State in [dsEdit, dsInsert] then
  begin
    DetDataset.FieldValues['Field2'] := ContractValue.Contract;

    DoLookup(Sender);

    RefreshCell(Sender);
  end;
end;

procedure TForm1.GridDetailColExit(Sender: TObject);
begin
  if Grid2.Columns[Grid2.SelectedIndex].ReadOnly then Exit;

  if (Grid2.SelectedField.FieldName = 'Field2') then
    RefreshLookupDiameters();

  if (Grid2.SelectedField.FieldName = 'Field1') then
    RefreshLookupSchedules();

  if (Grid2.SelectedField.FieldName = 'Date1') or
    (Grid2.SelectedField.FieldName = 'Date2') or
    (Grid2.SelectedField.FieldName = 'Date3') then
    if not CheckDates then Abort;

  inherited;
end;

procedure TForm1.GridDetail2ColExit(Sender: TObject);
begin
  if Grid3.Columns[Grid3.SelectedIndex].ReadOnly then Exit;

  if (Grid3.SelectedField.FieldName = 'Date1') or
    (Grid3.SelectedField.FieldName = 'Date2') or
    (Grid3.SelectedField.FieldName = 'Date3') then
     if not CheckDates then Abort;

  inherited GridDetailColExit(Sender);

  if (UpperCase(Grid1.SelectedField.FieldName) = UpperCase('Field1')) then
    if FieldIsNull(Grid1.GetColumnByFieldName('Field2').Field.Value) then
    begin
      Grid1.GetColumnByFieldName('Field2').Field.Value := Grid1.GetColumnByFieldName('Field1').Field.Value;
      Grid1.GetColumnByFieldName('Field3').Field.Value := Grid1.GetColumnByFieldName('Field4').Field.Value;
    end;
end;

procedure TForm1.ClientDataSet1AfterInsert(DataSet: TDataSet);
begin
  inherited;

  ClientDataSet1['Field2'] := ContractValue.Contract;
  ClientDataSet1['Field5'] := BranchCode;
end;

procedure TForm1.ClientDataSet1BeforeScroll(DataSet: TDataSet);
begin
  inherited;

  if DataSet1.Active then DataSet1.Close;
end;

procedure TForm1.ClientDataSet1AfterScroll(DataSet: TDataSet);
begin
  inherited;

  SetButtonsState;

  if DataSet.State in [dsEdit, dsInsert] then Exit;

  Grid2.SetColumnWidths;

  if ProcType = [ptType1] then
    BtnDetailClick(Self)
  else
  if ProcType = [ptType2] then
    BtnDetail2Click(Self);

  FormDocuments1.AfterScroll(DataSet);
end;

procedure TForm1.ClientDataSet1AfterPost(DataSet: TDataSet);
begin
  inherited;
  
  SetButtonsState;
end;

procedure TForm1.OpenWelders;
begin
  if (ClientDataSet3.RecordCount = 0) then Exit;

  Screen.Cursor := crHourGlass;

  try
    with DataSet1 do
    begin
      if Active then Close;

      if FProcType = [ptType1] then
      begin
        SetupGridColumns(Grid2, DetailColumns);

        CommandText :=
        'Select' +
          ' det.ID,' +
          ' det.DetailID,' +
          ' e.Name,' +
          ' pp.Field1,' +
          ' pp.Date1 AS DateA,' +
          ' pp.Date2 AS DateB,' +
          ' det.Date3,' +
          ' det.Date4,' +
          ' det.Date5,' +
          ' det.Field1,' +
          ' det.Field2,' +
          ' det.Field3,' +
       ' det.Field4' +

        ' From schema2.table5 det' +
        ' Inner Join schema2.table6 qual On (det.Field42 = qual.Field42)' +
        ' Inner Join schema1.table7 pp On (pp.Field41 = qual.Field41)' +
        ' Inner Join schema2.table8 e On (e.Field41 = qual.Field41)' +

        ' Where pp.Field2 = :Param1' +
         ' And det.DetailID = :DetailID' +

        ' Order By e.Field3;';
      end
      else
      if FProcType = [ptType2] then
      begin
        SetupGridColumns(Grid3, DetailColumns2);

        CommandText :=
        'Select' +
          ' det.ID,' +
          ' det.DetailID2,' +
          ' e.Name,' +
          ' pp.Field1,' +
          ' pp.Date1 AS DateA,' +
          ' pp.Date2 AS DateB,' +
          ' det.Date3,' +
          ' det.Date4,' +
          ' det.Date5,' +
          ' det.Field1,' +
          ' det.Field2,' +
          ' det.Field3,' +
          ' det.Field4' +

       ' From schema2.table9 det' +
       ' Inner Join schema2.table6 qual On (det.Field42 = qual.Field42)' +
       ' Inner Join schema1.table7 pp On (pp.Field41 = qual.Field41)' +
       ' Inner Join schema2.table8 e On (e.Field41 = qual.Field41)' +

       ' Where pp.Field2 = :Param1' +
        ' And det.DetailID2 = :DetailID2' +

       ' Order By e.Field3;';
      end;

      ParamByName('Param1').AsString := ContractValue.Contract;

      if FProcType = [ptType1] then
         ParamByName('DetailID').AsInteger := ClientDataSet3.FieldByName('DetailID').AsInteger
      else
      if FProcType = [ptType2] then
         ParamByName('DetailID2').AsInteger := ClientDataSet3.FieldByName('DetailID2').AsInteger;
    end;

    with ClientDataSet2 do
    begin
      if Active then Close;
      
      Open;
    end;

    if FProcType = [ptType1] then
      SetupGridColumns(Grid2, DetailColumns)
    else
    if FProcType = [ptType2] then
      SetupGridColumns(Grid3, DetailColumns2);

    Grid2.SetColumnWidths;

    SetButtonsState;

  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TForm1.BtnDetailClick(Sender: TObject);
begin
  with DataSet3 do
  begin
    if Active then Close;

    SetupGridColumns(Grid2, DetailColumns);

    CommandText := 'Select' +
                      ' a.DetailID,' +
                      ' a.ID,' +
                      ' a.Field1,' +
                      ' a.Field2,' +
                      ' a.Field3,' +
                      ' a.Field4,' +
                      ' a.Field5,' +
                      ' e.Description As Desc1,' +
                      ' a.Field6,' +
                      ' a.Field7,' +
                      ' a.Field8,' +
                      ' a.Field9,' +
                      ' a.Field10,' +
                      ' a.Field11,' +
                      ' a.Field12,' +
                      ' a.Field13,' +
                      ' a.Field14,' +
                      ' a.Field15,' +
                      ' a.Field16,' +
                      ' a.Field17,' +
                      ' a.Field18,' +
                      ' a.Field19,' +
                      ' a.Field20,' +
                      ' a.Field21,' +
                      ' a.Field22,' +
                      ' a.Field23,' +
                      ' b.Contract,' +
                       ' "' + BranchCode + '" As Field5,' +
                      ' a.Field24,' +
                      ' a.Field25,' +
                      ' a.Field26,' +
                      ' a.Field27' +

                  ' From schema1.table10 a' +
                  ' Left Join schema1.table1 b On a.ID = b.ID' +
                  ' Left Join schema2.table11 e On a.Field43 = e.Field43' +

                  ' Where a.ID = :ID' +

                  ' Order By a.Field1, a.Field2';
  end;

  inherited;

  SetupGridColumns(Grid2, DetailColumns);

  Grid2.SetColumnWidths;

  SetButtonsState;

  SetDetailGridColumnsAccess;
end;

procedure TForm1.BtnDetail2Click(Sender: TObject);
begin
  with DataSet3 do
  begin
    if Active then Close;

    SetupGridColumns(Grid3, DetailColumns2);

    CommandText := 'Select' +
                      ' a.DetailID2,' +
                      ' a.ID,' +
                      ' a.Field1,' +
                      ' a.Field2,' +
                      ' a.Field3,' +
                      ' a.Field4,' +
                      ' a.Field5,' +
                      ' e1.Description As Desc1,' +
                      ' e2.Description As Desc2,' +
                      ' a.Field6,' +
                      ' a.Field7,' +
                      ' a.Field8,' +
                      ' a.Field9,' +
                      ' a.Field10,' +
                      ' a.Field11,' +
                      ' a.Field12,' +
                      ' a.Field13,' +
                      ' a.Field14,' +
                      ' a.Field15,' +
                      ' a.Field16,' +
                      ' a.Field17,' +
                      ' a.Field18,' +
                      ' a.Field19,' +
                      ' a.Field20,' +
                      ' a.Field21,' +
                      ' a.Field22,' +
                      ' a.Field23,' +
                      ' b.Contract,' +
                       ' "' + BranchCode + '" As Field5,' +
                      ' a.Field24,' +
                      ' a.Field25,' +
                      ' a.Field26,' +
                      ' a.Field27' +

                  ' From schema1.table12 a' +
                  ' Left Join schema1.table2 b On a.ID = b.ID' +
                  ' Left Join schema2.table11 e1 On a.Field44 = e1.Field43' +
                  ' Left Join schema2.table11 e2 On a.Field45 = e2.Field43' +

                  ' Where a.ID = :ID' +

                  ' Order By a.Field1, a.Field2';
  end;

  inherited BtnDetailClick(Self);

  SetupGridColumns(Grid3, DetailColumns2);

  Grid3.SetColumnWidths;

  SetButtonsState;

  SetDetailGridColumnsAccess;
end;

procedure TForm1.DataSet1AfterScroll(DataSet: TDataSet);
begin
  inherited;

  if DetailPageControl.ActivePage = TabDetailMain then
    Label1.Caption := IntToStr(ClientDataSet2.RecNo) + '/' + IntToStr(ClientDataSet2.RecordCount)
  else
    Label2.Caption := IntToStr(ClientDataSet2.RecNo) + '/' + IntToStr(ClientDataSet2.RecordCount)
end;

procedure TForm1.DetailAfterScroll(DataSet: TDataSet);
begin
  inherited;

  if not (Flag2 or is_admin(True)) then
    if not FieldIsNull(ClientDataSet3['User2']) and
      not FieldIsNull(ClientDataSet3['Date3']) then
    DetailNavigator.VisibleButtons := DetailNavigator.VisibleButtons - [nbDelete]
  else
    DetailNavigator.VisibleButtons := DetailNavigator.VisibleButtons + [nbDelete];

  if DetailPageControl.ActivePage = TabDetail2 then
    Label3.Caption := IntToStr(ClientDataSet3.RecNo) + '/' + IntToStr(ClientDataSet3.RecordCount);

  SetButtonsState;

  OpenWelders;

  Grid2.SetColumnWidths;
end;

procedure TForm1.DetailBeforePost(DataSet: TDataSet);
begin
  if not CheckLocked then
  begin
    DataSet.Cancel;
    Abort;
  end;

  if not CheckDates then Abort;

  inherited;
end;

procedure TForm1.ClientDataSet1BeforePost(DataSet: TDataSet);
var
  Valid: Boolean;
begin
  inherited;

  Valid := True;

  if ClientDataSet1.FieldbyName('Field3').IsNull or (Trim(ClientDataSet1.FieldbyName('Field3').Value) = EmptyStr) then
  begin
    MessageDlg('Name cannot be empty.', mtError, [mbOK], 0);
    Valid := False;
  end;

  if ClientDataSet1.FieldbyName('Field1').IsNull or (Trim(ClientDataSet1.FieldbyName('Field1').Value) = EmptyStr) then
  begin
    MessageDlg('Code cannot be empty.', mtError, [mbOK], 0);
    Valid := False;
  end;

  if not Valid then
  begin
    ClientDataSet1.Cancel;
    Abort;
  end;
end;

procedure TForm1.DisplayDetails;
var
  DisplayFlag: Boolean;
  
begin
  DisplayFlag := False;

  if (Select_Box.Text <> '') then
  begin
    with TSQLQuery.Create(nil) do
    begin
      try
        SQLConnection := MainDM.MainDBX;

        SQL.Clear;
        SQL.Add('Select * From schema1.table4');
        SQL.Add('Where Contract = :Contract;');
        ParamByName('Param1').AsString := ContractValue.Contract;

        Open;

        if not IsEmpty then DisplayFlag := (FieldByName('Field4').AsString = 'Y');

      finally
        Close;
        Free;
      end;
    end;
  end;

  if DisplayFlag then
  begin
    if FProcType = [ptType1] then
    begin
      TabDetailMain.TabVisible := True;
      TabDetail2.TabVisible := False;
      DetailPageControl.ActivePage := TabDetailMain;
    end
    else
    begin
      TabDetailMain.TabVisible := False;
      TabDetail2.TabVisible := True;
      DetailPageControl.ActivePage := TabDetail2;
    end;
  end
  else
  begin
    TabDetailMain.TabVisible := False;
    TabDetail2.TabVisible := False;
  end;
end;

procedure TForm1.DoLookupDiameter;
var
  Query: String;
  MatlID: Integer;
  ContractStr: String;
begin
  if MainDM.LookupCDS.Active then MainDM.LookupCDS.Close;

  try
    MainDM.LookupCDS.CommandText := '';

    with MainDM.LookupQuery do
    begin
      Close;
      SQL.Clear;

      ContractStr := Quotedstr(ContractValue.Contract);
      MatlID := ClientDataSet3.FieldByName('RefID').AsInteger;
      Query := 'Call proc1(' + ContractStr + ',' + IntToStr(MatlID) + ')';

      SQL.Add(Query);
    end;

    if MainDM.LookupCDS.Active then MainDM.LookupCDS.Close;

    Application.CreateForm(TDlgLookup, DlgLookup);
    DlgLookup.Caption := 'Please Select a value in the list for [' +
                             Grid1.Columns.Items[Grid1.Col-1].Title.Caption + ']';
    DlgLookup.LookupDS.DataSet := MainDM.lookupCDS;
    DlgLookup.LookupDS.DataSet.Close;

    if (DlgLookup.ShowModal = mrOk) then
    begin
      Grid2.DataSource.DataSet.FieldByName('Field1').AsString := DlgLookup.lookupDS.DataSet.FieldByName('Field1').AsString;
      Grid2.DataSource.DataSet.FieldByName('Field2').AsString := DlgLookup.lookupDS.DataSet.FieldByName('Field2').AsString;
    end;

  finally
    DlgLookup.Free;

    if MainDM.LookupCDS.Active then MainDM.LookupCDS.Close;
  end;
end;

procedure TForm1.ClientDataSet1BeforeInsert(DataSet: TDataSet);
begin
  inherited;

  Grid1.SelectedIndex := Grid1.GetColumnIndexByFieldName('Field3');
end;

procedure TForm1.DetailBeforeInsert(DataSet: TDataSet);
begin
  inherited;

  if FProcType = [ptType1] then
  begin
    DetGrid.SelectedIndex := DetGrid.GetColumnIndexByFieldName('RefID');
  end
  else
  if FProcType = [ptType2] then
  begin
    DetGrid.SelectedIndex := DetGrid.GetColumnIndexByFieldName('RefID1');
  end;
end;

procedure TForm1.DetailAfterInsert(DataSet: TDataSet);
begin
  inherited;

  ClientDataSet3['Field2'] := ContractValue.Contract;
  ClientDataSet3['Field5'] := BranchCode;
end;

procedure TForm1.Field1GetText(Sender: TField; var Text: String; DisplayText: Boolean);
begin
  if Trim(Sender.AsString) = EmptyStr then
    Text := 'S+F'
  else
    Text := Sender.AsString;
end;

procedure TForm1.Field1SetText(Sender: TField; const Text: String);
begin
  if Text = 'S+F' then
    Sender.Clear
  else
    Sender.AsString := Text;
end;

procedure TForm1.RefreshLookupDiameters;
var
  MatlID: Integer;
  ContractStr: String;
begin
  if ClientDataSet3.Active then
  begin
    if FProcType = [ptType1] then
    begin
      ContractStr := Quotedstr(ContractValue.Contract);
      MatlID := ClientDataSet3.FieldByName('RefID').AsInteger;
      ClientDataSet3.FieldByName('Field1').Origin := 'Call proc1(' + ContractStr + ',' + IntToStr(MatlID) + ')';
    end
    else
    if FProcType = [ptType2] then
    begin
    end;
  end;
end;

procedure TForm1.RefreshLookupSchedules;
var
  Diameter: String;
  MatlID: Integer;
  ContractStr: String;
begin
  if ClientDataSet3.Active then
  begin
    if FProcType = [ptType1] then
    begin
      Diameter := ClientDataSet3.FieldByName('Field1').AsString;

      if Diameter = EmptyStr then
        Diameter := '0';

      ContractStr := Quotedstr(ContractValue.Contract);
      MatlID := ClientDataSet3.FieldByName('RefID').AsInteger;
      ClientDataSet3.FieldByName('Field2').Origin := 'Call proc2(' + ContractStr + ',' + Diameter + ',' + IntToStr(MatlID) + ')';
    end
    else
    if FProcType = [ptType2] then
    begin
      ContractStr := Quotedstr(ContractValue.Contract);
      Diameter := '0';
      MatlID := ClientDataSet3.FieldByName('RefID1').AsInteger;
      ClientDataSet3.FieldByName('Field3').Origin := 'Call proc2(' + ContractStr + ',' + Diameter + ',' + IntToStr(MatlID) + ')';

      MatlID := ClientDataSet3.FieldByName('RefID2').AsInteger;
      ClientDataSet3.FieldByName('Field4').Origin := 'Call proc2(' + ContractStr + ',' + Diameter + ',' + IntToStr(MatlID) + ')';
    end;
  end;
end;

procedure TForm1.PageControlChange(Sender: TObject);
begin
  inherited;

  if MastDataset.State in [dsEdit] then MastDataset.Post;

  if DetDataset.Active then DetDataset.Close;
  if DataSet1.Active then DataSet1.Close;

  SelCountLabel.Caption := '0/0';
  Label3.Caption := '0/0';

  if DetailPageControl.ActivePage = TabDetailMain then
  begin
    DetDataset := ClientDataSet3;
    DetSQLDS := DataSet3;
    DetGrid := Grid2;
    SetupGridColumns(Grid2, DetailColumns);
    MasterFieldNames := '';
    FieldNames := 'Field1;Field2;Field3;Field4;Field5;Field6;Field7;Field8;Field9;Field10;Field11;Field12;Field13;Field14';
  end
  else
  if DetailPageControl.ActivePage = TabDetail2 then
  begin
    DetDataset := ClientDataSet3;
    DetSQLDS := DataSet3;
    DetGrid := Grid3;
    SetupGridColumns(Grid3, DetailColumns2);
    MasterFieldNames := '';
    FieldNames := 'Field1;Field2;Field3;Field4;Field5;Field6;Field7;Field8;Field9;Field10;Field11;Field12;Field13;Field14;Field15;Field16;Field17;Field18;Field19;Field20';
  end
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
end;

procedure TForm1.Grid1DblClick(Sender: TObject);
begin
  inherited;

  FormDocuments1.GridDblClick(Sender);
end;

procedure TForm1.SetAccessRight;
var
  TitlesList: TStringList;
  UserTitle: string;
  I: Integer;
begin
  inherited;

  Flag1 := False;
  Flag2 := False;

  TitlesList := nil;
  if GetUserTitles(UserName, ContractValue.Contract, TitlesList) then
  begin
    if Assigned(TitlesList) then
    begin
      for I := 0 to TitlesList.Count-1 do
      begin
        if Assigned(List1) and (List1.IndexOf(UpperCase(TitlesList.Strings[I])) > -1) then
          Flag1 := True
        else
        if Assigned(List2) and (List2.IndexOf(UpperCase(TitlesList.Strings[I])) > -1) then
          Flag2 := True;
      end;

      FreeAndNil(TitlesList);
    end;
  end;

  FormDocuments1.ReadOnlyAccess := ReadOnlyAccess;
end;

procedure TForm1.SetDetailGridColumnsAccess;
begin
  DetGrid.GetColumnByFieldName('User1').ReadOnly := not (Flag1 or Flag2 or is_admin(True));
  DetGrid.GetColumnByFieldName('Date2').ReadOnly := not (Flag1 or Flag2 or is_admin(True));
  DetGrid.GetColumnByFieldName('User2').ReadOnly := not (Flag2 or is_admin(True));
  DetGrid.GetColumnByFieldName('Date3').ReadOnly := not (Flag2 or is_admin(True));

  if not (Flag1 or Flag2 or is_admin(True)) then
  begin
    DetGrid.GetColumnByFieldName('User1').Title.Font.Color := clLtGray;
    DetGrid.GetColumnByFieldName('User1').ImeName := EmptyStr;
    DetDataset.FieldByName('User1').ProviderFlags := [];
    DetGrid.GetColumnByFieldName('Date2').Title.Font.Color := clLtGray;
    DetGrid.GetColumnByFieldName('Date2').ImeName := EmptyStr;
    DetDataset.FieldByName('Date2').ProviderFlags := [];
  end
  else
  begin
    DetGrid.GetColumnByFieldName('User1').Title.Font.Color := clWindowText;
    DetGrid.GetColumnByFieldName('User1').ImeName := EmptyStr;
    DetDataset.FieldByName('User1').ProviderFlags := [pfInUpdate];
    DetGrid.GetColumnByFieldName('Date2').Title.Font.Color := clWindowText;
    DetGrid.GetColumnByFieldName('Date2').ImeName := EmptyStr;
    DetDataset.FieldByName('Date2').ProviderFlags := [pfInUpdate];
  end;

  if not (Flag2 or is_admin(True)) then
  begin
    DetGrid.GetColumnByFieldName('User2').Title.Font.Color := clLtGray;
    DetGrid.GetColumnByFieldName('User2').ImeName := EmptyStr;
    DetDataset.FieldByName('User2').ProviderFlags := [];
    DetGrid.GetColumnByFieldName('Date3').Title.Font.Color := clLtGray;
    DetGrid.GetColumnByFieldName('Date3').ImeName := EmptyStr;
    DetDataset.FieldByName('Date3').ProviderFlags := [];
  end
  else
  begin
    DetGrid.GetColumnByFieldName('User2').Title.Font.Color := clWindowText;
    DetGrid.GetColumnByFieldName('User2').ImeName := 'WP_Approved_By;User2';
    DetDataset.FieldByName('User2').ProviderFlags := [pfInUpdate];
    DetGrid.GetColumnByFieldName('Date3').ImeName := EmptyStr;
    DetGrid.GetColumnByFieldName('Date3').Title.Font.Color := clWindowText;
    DetDataset.FieldByName('Date3').ProviderFlags := [pfInUpdate];
  end;
end;

procedure TForm1.RefreshCell(Sender: TObject);
var
  Width: Integer;
begin
  if not (Sender is TDBGridEnh) then Exit;

  if TDBGridEnh(Sender).SelectedIndex < TDBGridEnh(Sender).Columns.Count-1 then
  begin
    Width := TDBGridEnh(Sender).GetColumnByFieldName(TDBGridEnh(Sender).SelectedField.FieldName).Width;
    TDBGridEnh(Sender).GetColumnByFieldName(TDBGridEnh(Sender).SelectedField.FieldName).Width := Width + 1;
    TDBGridEnh(Sender).GetColumnByFieldName(TDBGridEnh(Sender).SelectedField.FieldName).Width := Width;
  end;
end;

procedure TForm1.Provider1GetTableName(Sender: TObject; DataSet: TDataSet; var TableName: String);
begin
  inherited;

  if FProcType = [ptType1] then
    TableName := 'schema1.table1'
  else
    TableName := 'schema1.table2';
end;

procedure TForm1.Provider1BeforeUpdateRecord(Sender: TObject; SourceDS: TDataSet;
  DeltaDS: TCustomClientDataSet; UpdateKind: TUpdateKind; var Applied: Boolean);
var
  I: Integer;
  FieldType: String;
begin
  inherited;

  for I := 0 to DeltaDS.FieldCount-1 do
  begin
    FieldType := GetFieldType(DeltaDS.Fields[I].FieldName, MasterColumns);

    if (FieldType = 'ATTRIBUTE') then
      DeltaDS.Fields[I].ProviderFlags := [pfInUpdate]
    else
    if FieldType = 'KEY' then
      DeltaDS.Fields[I].ProviderFlags := [pfInWhere, pfInUpdate, pfInKey]
    else
      DeltaDS.Fields[I].ProviderFlags := [];
  end;
end;

procedure TForm1.DetailProviderGetTableName(Sender: TObject; DataSet: TDataSet; var TableName: String);
begin
  inherited;

  if FProcType = [ptType1] then
    TableName := 'schema1.table10'
  else
  if FProcType = [ptType2] then
    TableName := 'schema1.table12';
end;

procedure TForm1.DetailProviderBeforeUpdateRecord(Sender: TObject; SourceDS: TDataSet;
  DeltaDS: TCustomClientDataSet; UpdateKind: TUpdateKind; var Applied: Boolean);
var
  I: Integer;
  FieldType: String;
begin
  inherited;

  for I := 0 to DeltaDS.FieldCount-1 do
  begin
    if FProcType = [ptType1] then
      FieldType := GetFieldType(DeltaDS.Fields[I].FieldName, DetailColumns)
    else
    if FProcType = [ptType2] then
      FieldType := GetFieldType(DeltaDS.Fields[I].FieldName, DetailColumns2);

    if (FieldType = 'ATTRIBUTE') then
      DeltaDS.Fields[I].ProviderFlags := [pfInUpdate]
    else
    if FieldType = 'KEY' then
      DeltaDS.Fields[I].ProviderFlags := [pfInWhere, pfInUpdate, pfInKey]
    else
      DeltaDS.Fields[I].ProviderFlags := [];
  end;
end;

procedure TForm1.GridDetail2ColExit(Sender: TObject);
begin
end;

procedure TForm1.GridDetail2DblClick(Sender: TObject);
begin
end;

end.
