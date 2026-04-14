unit Unit5;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Unit2, Unit3,
  Data.DB, Data.FMTBcd, Vcl.Menus, Unit4,
  UDBXFilterDialog, UDBXSortDialog, Data.SqlExpr, Datasnap.DBClient, Datasnap.Provider,
  System.Actions, Vcl.ActnList, System.ImageList, Vcl.ImgList, Vcl.StdCtrls,
  Vcl.ExtCtrls, Unit5, Vcl.DBCtrls, Vcl.ComCtrls, JvExExtCtrls,
  JvExtComponent, JvRollOut, Vcl.Grids, Vcl.DBGrids, Unit6, Vcl.Buttons,
  Vcl.Mask;

type
  TCheckbox = class(Vcl.StdCtrls.TCheckBox)
  public
    FCaption: string;
    FFlag: Boolean;
    procedure WmPaint(var Msg: TWMPaint); message WM_PAINT;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
  end;

  TForm1 = class(TForm2)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Edit1: TDBEdit;
    Edit2: TDBEdit;
    Edit3: TDBEdit;
    Edit4: TDBEdit;
    Edit5: TDBEdit;
    Edit6: TDBEdit;
    Edit7: TDBEdit;
    Edit8: TDBEdit;
    Edit9: TDBEdit;
    Edit10: TDBEdit;
    Edit11: TDBEdit;
    Edit12: TDBEdit;
    DataSet1: TSQLDataSet;
    DataSet2: TStringField;
    DataSet3: TStringField;
    DataSet4: TStringField;
    DataSet5: TStringField;
    DataSet6: TStringField;
    DataSet7: TStringField;
    DataSet8: TStringField;
    DataSet9: TStringField;
    DataSet10: TStringField;
    DataSet11: TStringField;
    DataSet12: TStringField;
    DataSet13: TStringField;
    DataSet14: TStringField;
    DataSource1: TDataSource;
    TabSheet1: TTabSheet;
    ComboBox1: TDBLookupComboBox;
    Label13: TLabel;
    DataSource2: TDataSource;
    ClientDataSet1: TClientDataSet;
    DataSetProvider1: TDataSetProvider;
    DataSet15: TSQLDataSet;
    DataSource3: TDataSource;
    ClientDataSet2: TClientDataSet;
    DataSetProvider2: TDataSetProvider;
    DataSet16: TSQLDataSet;
    DataSet17: TStringField;
    DataSet18: TStringField;
    DataSet19: TStringField;
    DataSet20: TStringField;
    DataSet21: TStringField;
    DataSet22: TStringField;
    DataSet23: TStringField;
    DataSet24: TStringField;
    DataSet25: TStringField;
    DataSet26: TStringField;
    DataSet27: TStringField;
    DataSet28: TStringField;
    DataSet29: TStringField;
    DataSet30: TFMTBCDField;
    DataSet31: TFMTBCDField;
    DataSet32: TFMTBCDField;
    DataSet33: TStringField;
    DataSet34: TStringField;
    DataSet35: TStringField;
    DataSet36: TMemoField;
    DataSet37: TStringField;
    DataSet38: TDateField;
    DataSet39: TStringField;
    DataSet40: TDateField;
    DataSet41: TIntegerField;
    DataSet42: TIntegerField;
    DataSet43: TIntegerField;
    DataSet44: TStringField;
    DataSet45: TStringField;
    DataSet46: TStringField;
    DataSet47: TStringField;
    DataSet48: TStringField;
    DataSet49: TStringField;
    DataSet50: TStringField;
    DataSet51: TStringField;
    DataSet52: TStringField;
    DataSet53: TStringField;
    DataSet54: TStringField;
    DataSet55: TStringField;
    DataSet56: TStringField;
    DataSet57: TStringField;
    DataSet58: TStringField;
    DataSet59: TStringField;
    DataSet60: TStringField;
    DataSet61: TStringField;
    DataSet62: TDateField;
    DataSet63: TStringField;
    DataSet64: TIntegerField;
    Label14: TLabel;
    Panel1: TPanel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Edit13: TDBEdit;
    Edit14: TDBEdit;
    Edit15: TDBEdit;
    Edit16: TDBEdit;
    Edit17: TDBEdit;
    Edit18: TDBEdit;
    Edit19: TDBEdit;
    Edit20: TDBEdit;
    Edit21: TDBEdit;
    Edit22: TDBEdit;
    Edit23: TDBEdit;
    Edit24: TDBEdit;
    DataSet65: TStringField;
    DataSet66: TStringField;
    DataSet67: TStringField;
    TabSheet2: TTabSheet;
    Label25: TLabel;
    ComboBox2: TDBLookupComboBox;
    Panel2: TPanel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Edit25: TDBEdit;
    Edit26: TDBEdit;
    Edit27: TDBEdit;
    Edit28: TDBEdit;
    Edit29: TDBEdit;
    Edit30: TDBEdit;
    Edit31: TDBEdit;
    ComboBox3: TDBComboBox;
    Label34: TLabel;
    Label35: TLabel;
    ComboBox4: TDBComboBox;
    Edit32: TDBEdit;
    Label36: TLabel;
    Action1: TAction;
    CheckBox1: TCheckBox;
    Action2: TAction;

    procedure Action1Execute(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
    procedure BtnAddClick(Sender: TObject);
    procedure ClientDataSet1AfterScroll(DataSet: TDataSet);
    procedure BtnCloseClick(Sender: TObject);
    procedure BtnReOpenClick(Sender: TObject);
    procedure ChangeType(Sender: TObject);
    procedure EditChange(Sender: TObject);
    procedure GridDblClick(Sender: TObject);
    procedure GridSelectionChanged(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ReportDblClick(Sender: TObject); override;
    procedure LoadListClick(Sender: TObject);
    procedure LookupDblClick(Sender: TObject);
    procedure DataChange(Sender: TObject; Field: TField);
    procedure ClientDataSet1AfterInsert(DataSet: TDataSet);
    procedure ClientDataSet1BeforeInsert(DataSet: TDataSet);
    procedure ClientDataSet1BeforePost(DataSet: TDataSet);
    procedure GridSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure BtnOpenClick(Sender: TObject);
    procedure OpenDetailClick(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure ListDblClick(Sender: TObject);
    procedure ListSelectionChanged(Sender: TObject);
    procedure BtnRemoveClick(Sender: TObject);
    procedure TypeSelectChange(Sender: TObject);

  private
    FLoadType: Integer;
    FRecordNo: Integer;

    procedure SetDetailQueries(LoadType: Integer);
    procedure LoadData1;
    procedure LoadData2;
    procedure LoadData3;
    procedure LoadData4;
    procedure LoadData5;
    function GetNextNumber(): Integer;

  protected
    procedure SetupMasterColumns; override;
    procedure SetupDetailColumns; override;
    procedure SetButtonsState; override;

  public
    procedure Initialize; override;
  end;

var
  Form1: TForm1;

implementation

uses
  System.UITypes, Unit7, Unit8, Unit9, Unit10, Unit11;

{$R *.dfm}

procedure TForm1.SetupMasterColumns;
begin
end;

procedure TForm1.SetupDetailColumns;
begin
end;

procedure TForm1.BtnAddClick(Sender: TObject);
var
  I: Integer;
  ScrollEvents: TScrollEvents;
  SQL: String;
  OldCursor: TCursor;
begin
  if ClientDataSet1.State in [dsEdit, dsInsert] then
    ClientDataSet1.Post;

  if (Grid1.SelectedRows.Count > 0) then
  begin
    OldCursor := Screen.Cursor;
    try
      Screen.Cursor := crSQLWait;

      DisableDependencies(ListClientDS, ScrollEvents);

      SQL := 'Insert Into table1 (ID1, ID2, F1, F2) Values';

      for I := 0 to Grid1.SelectedRows.Count - 1 do
      begin
        ListClientDS.GotoBookmark(Grid1.SelectedRows.Items[I]);
        if I > 0 then
          SQL := SQL + ',';

        SQL := SQL + ' (' + ClientDataSet1.FieldByName('ID').AsString + ',' + ListClientDS.FieldByName('ID').AsString + ',' +
          QuotedStr(UserName) + ',' + QuotedStr(FormatDateTime(cSQLformatSettings, Now)) + ')';
      end;

      ExecAndCommit(SQL, UpdateQuery);

    finally
      if Assigned(ScrollEvents) then
      begin
        EnableDependencies(ListClientDS, ScrollEvents);
        FreeAndNil(ScrollEvents);
      end;

      Grid1.SelectedRows.Clear;
      OpenDetailClick(Sender);
      LoadListClick(Sender);

      Screen.Cursor := crHourGlass;
      ClientDataSet1.Refresh;

      SetButtonsState;

      Screen.Cursor := OldCursor;
    end;
  end
  else
    MessageDlg('You must at least select one item from list before proceeding!', mtError, [mbOk], 0);
end;

procedure TForm1.ClientDataSet1AfterScroll(DataSet: TDataSet);
begin
  inherited;

  LoadData3;
  LoadData4;
  LoadData2;
end;

procedure TForm1.BtnCloseClick(Sender: TObject);
var
  Command: String;
  DoRefresh: Boolean;
  OldCursor: TCursor;
begin
  FilterCheckBox.Checked := False;
  DetailDataSet.Filtered := False;
  DoRefresh := True;
  OldCursor := Screen.Cursor;

  if ClientDataSet1.FieldByName('Date1').AsString = '' then
  begin
    MessageDlg('You must specify a Date.', mtError, [mbOk], 0);
    ClientDataSet1.Edit;
    Grid1.EditorMode := True;
    Grid1.SelectedField := ClientDataSet1.FieldByName('Date1');
    Grid1.SetFocus;
    Exit;
  end;

  if ClientDataSet1.FieldByName('Ref1').AsInteger < 0 then
  begin
    MessageDlg('You must specify a Reference.', mtError, [mbOk], 0);
    Exit;
  end;

  if ClientDataSet1.FieldByName('Ref2').AsInteger < 0 then
  begin
    MessageDlg('You must specify a Machine.', mtError, [mbOk], 0);
    Exit;
  end;

  if ClientDataSet1.FieldByName('Field1').AsString = '' then
  begin
    MessageDlg('You must specify Field1.', mtError, [mbOk], 0);
    Exit;
  end;

  try
    Screen.Cursor := crSQLWait;

    if not DetailClientDS.Active then
      OpenDetailClick(Sender)
    else
      ApplyUpdates(DetailDataset);

    if (DetailClientDS.RecordCount = 0) then
    begin
      MessageDlg('Record is empty!', mtError, [mbOk], 0);
      Abort;
    end;
    Screen.Cursor := crHourGlass;

    Command := Format('Call proc1(%S, %S, %S)',
      [MastDataset['ID'], QuotedStr(FormatDateTime(cSQLformatSettings, MastDataset['Date1'])),
      QuotedStr(UserName)]);
    ExecAndCommit(Command, UpdateQuery);
    LogAdd('Source', Self.Caption, 'Action1', ClientDataSet1.FindField('Field2').AsString, ClientDataSet1.FindField('ID').AsInteger);

  finally
    if DoRefresh then
    begin
      MastDataset.Refresh;
      OpenDetailClick(Sender);
      SetButtonsState;
    end;

    Screen.Cursor := OldCursor;
  end;
end;

procedure TForm1.BtnReOpenClick(Sender: TObject);
var
  OldCursor: TCursor;
  Command: String;
begin
  OldCursor := Screen.Cursor;

  try
    Screen.Cursor := crHourGlass;

    ApplyUpdates(MastDataset);

    Command := Format('Call proc2(%S, %S, %S)',
      [MastDataset['ID'], QuotedStr(FormatDateTime(cSQLformatSettings, MastDataset['Date1'])),
      QuotedStr(UserName)]);
    ExecAndCommit(Command, UpdateQuery);
    LogAdd('Source', Self.Caption, 'Action2', ClientDataSet1.FindField('Field2').AsString, ClientDataSet1.FindField('ID').AsInteger);

  finally
    MastDataset.Refresh;
    OpenDetailClick(Sender);
    SetButtonsState;

    Screen.Cursor := OldCursor;
  end;
end;

procedure TForm1.ChangeType(Sender: TObject);
begin
  ClientDataSet1.Close;
  LoadData5;

  inherited;

  SetFields;
end;

procedure TForm1.EditChange(Sender: TObject);
begin
  inherited;

  if Assigned(Edit4.Field) then
  begin
    with DataSet1 do
    begin
      if Active then
        Close;

      ParamByName('Param1').AsString := Edit4.Text;

      Open;
    end;
  end
  else
  begin
    with DataSet1 do
    begin
      if Active then
        Close;

      ParamByName('Param1').AsString := '';

      Open;
    end;
  end;
end;

procedure TForm1.GridDblClick(Sender: TObject);
begin
  inherited;

  BtnRemoveClick(Sender);
end;

procedure TForm1.GridSelectionChanged(Sender: TObject);
begin
  inherited;

  SetButtonsState;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  UserPriv := Integer(UserPrivPaintWorkOrders);

  inherited;
end;

function TForm1.GetNextNumber: Integer;
var
  S: String;
  Number: Integer;
  CloneDS: TClientDataset;
  Filtered: Boolean;
begin
  Number := 1;
  Filtered := False;
  CloneDS := nil;

  try
    Filtered := MastDataSet.Filtered;

    if Filtered then
    begin
      MastDataSet.DisableControls;
      MastDataSet.Filtered := False;
    end;

    if (MastDataSet.RecordCount = 0) then Exit;

    CloneDS := TClientDataset.Create(nil);
    CloneDS.Active := False;
    CloneDS.CloneCursor(MastDataSet, False, True);

    Number := 0;
    with CloneDS do
    begin
      First;

      while not CloneDS.Eof do
      begin
        S := CloneDS['Field2'];
        if IsStrANumber(S) then
          Number := StrToInt(S);

        Next;
      end;
    end;

    Inc(Number);

  finally
    if Assigned(CloneDS) then
      FreeAndNil(CloneDS);

    if Filtered then
    begin
      MastDataSet.Filtered := Filtered;
      MastDataSet.EnableControls;
    end;

    Result := Number;
  end;
end;

procedure TForm1.Initialize;
begin
  inherited;

  ClosedField := 'StatusField';

  TypeSelect.Items.Clear;
  TypeSelect.Items.Add('Buy');
  TypeSelect.Items.Add('Fab');
  TypeSelect.ItemIndex := 1;
  WONOField := TypeSelect.Text;

  LoadData5;

  MasterNavigator.DoubleBuffered := True;
  DetailNavigator.DoubleBuffered := True;

  DetailDataset := DetailClientDS;
  DetailSQLDS := DetailSQLDS;

  if is_admin(True) then
    DisplayPrimaryKey := True
  else
  begin
    MasterGrid.Columns[MasterGrid.GetColumnIndexByFieldName('ID')].Visible := False;
    DetailGrid.Columns[DetailGrid.GetColumnIndexByFieldName('DetailID')].Visible := False;
  end;

  FLoadType := cFirstLoad;
end;

procedure TForm1.ReportDblClick(Sender: TObject);
begin
  inherited;

  GetReportAction(Actions, ReportList.Items[ReportList.ItemIndex]).Execute;
end;

procedure TForm1.LoadData1;
begin
  if ClientDataSet1.Active then
    ClientDataSet1.Close;

  if not TabSheet1.TabVisible or not ClientDataSet1.Active then Exit;

  DataSet15.ParamByName('Param1').AsString := ContractValue.Contract;
  ClientDataSet1.Open;
end;

procedure TForm1.LoadData4;
begin
  ComboBox3.Items.Clear;

  if not TabSheet1.TabVisible or not ClientDataSet1.Active then Exit;

  ComboBox3.Items.CommaText := ClientDataSet1.FindField('Field1').AsString;

  if ComboBox3.Items.Count = 1 then
    ComboBox3.ItemIndex := 0
  else
    ComboBox3.ItemIndex := ComboBox3.Items.IndexOf(ClientDataSet1.FindField('Field2').AsString);
end;

procedure TForm1.LoadData3;
begin
  ComboBox4.Items.Clear;

  if not TabSheet1.TabVisible or not ClientDataSet1.Active then Exit;

  ComboBox4.Items.CommaText := ClientDataSet1.FindField('Field3').AsString;

  if ComboBox4.Items.Count = 1 then
    ComboBox4.ItemIndex := 0
  else
    ComboBox4.ItemIndex := ComboBox4.Items.IndexOf(ClientDataSet1.FindField('Field4').AsString);
end;

procedure TForm1.LoadData5;
begin
  ReportList.Items.Clear;

  if RadioButton1.Checked then
  begin
    ReportList.Items.Add('Report1');
  end;

  ReportList.Items.Add('Report2');
end;

procedure TForm1.Action1Execute(Sender: TObject);
var
  Report: TReportClass1;
begin
  if not ClientDataSet1.Active or
     (ClientDataSet1.FieldByName('StatusField').AsString <> 'C') then Exit;

  if not DetailDataset.Active then
  begin
    OpenDetailClick(Sender);
    Application.ProcessMessages;
  end;

  Report := nil;

  try
    Report := TReportClass1.Create(Self, ['Field1'], [ContractValue.Contract]);
    Report.IDValue := ClientDataSet1.FieldByName('ID').AsInteger;
    Report.CodeValue := ClientDataSet1.FieldByName('Field2').AsString;

    if CheckBox1.Checked then
      Report.SaveReport
    else
      Report.GenerateReport();

  finally
    if Assigned(Report) then
      FreeAndNil(Report);
  end;
end;

procedure TForm1.Action2Execute(Sender: TObject);
var
  Report: TReportClass2;
begin
  if not ClientDataSet1.Active or
     (ClientDataSet1.FieldByName('StatusField').AsString <> 'C') then Exit;

  if not DetailDataset.Active then
  begin
    OpenDetailClick(Sender);
    Application.ProcessMessages;
  end;

  Report := nil;
  try
    Report := TReportClass2.Create(Self, ['Field1'], [ContractValue.Contract]);
    Report.IDValue := ClientDataSet1.FieldByName('ID').AsInteger;
    Report.CodeValue := ClientDataSet1.FieldByName('Field2').AsString;
    Report.InValue := RadioButton1.Checked;

    if CheckBox1.Checked then
      Report.SaveReport
    else
      Report.GenerateReport();

  finally
    if Assigned(Report) then
      FreeAndNil(Report);
  end;
end;

procedure TForm1.LoadData2;
begin
  if ClientDataSet2.Active then
    ClientDataSet2.Close;

  if not TabSheet2.TabVisible or not ClientDataSet1.Active then Exit;

  DataSet16.ParamByName('Param1').AsInteger := ClientDataSet1.FindField('RefID').AsInteger;

  if ClientDataSet1.FindField('Date1').AsFloat = 0 then
    DataSet16.ParamByName('DateParam').Value := null
  else
    DataSet16.ParamByName('DateParam').AsDateTime := ClientDataSet1.FindField('Date1').AsDateTime;

  ClientDataSet2.Open;
end;

procedure TForm1.LoadListClick(Sender: TObject);
var
  HavingCriteria: string;
begin
  SetFields;

  if FilterCheckBox.Checked then
    HavingCriteria := FilterDialog.FilterText + ' ';

  if RadioButton1.Checked then
  begin
    SQLString := 'Select t.ID, t.Field2, t.Field49, t.Field50, t.Field51, t.Field52, t.Field53,' +
                    ' w.Field1, w.Field2, w.Field3, w.Field4,' +
                    ' i.Drawing, i.Rev,' +
                    ' z.Field5, z.Field6, z.Field7, z.Field8' +

                  ' From schema1.table2 t ' +
                  ' Inner Join schema1.table3 c On t.Field48 = c.Field48' +
                  ' Inner Join schema2.table4 w On t.Field44 = w.Field44' +
                  ' Inner Join schema1.table5 p On t.Field45 = p.Field45' +
                  ' Inner Join schema1.table6 i On i.Field47 = t.Field47' +
                  ' Inner Join schema1.table7 z On i.Field46 = z.Field46' +

                  ' Where c.Field2 = :Param1' +
                    ' And t.Field3 <> "Y"' +
                    ' And t.Field45 = :RefID' +
                    ' And t.Field5 = :Field5' +
                    ' And w.Field2 = :Field2' +
                    ' And t.Field8 = "ISO"' +
                    ' And t.ID not in (Select d.ID' +
                                          ' From schema1.table8 d' +
                                          ' Inner Join schema1.table9 w On d.Field36 = w.Field36' +
                                          ' Where w.Field8 = :Param2' +
                                            ' And w.Field2 = c.Field2)';
  end
  else
  begin
    SQLString := 'Select t.ID, t.Field2, t.Field49, t.Field50, t.Field51, t.Field52, t.Field53,' +
                    ' w.Field1, w.Field2, w.Field3, w.Field4,' +
                    ' i.Drawing, i.Rev,' +
                    ' z.Field5, z.Field6, z.Field7, z.Field8' +

                  ' From schema1.table2 t' +
                  ' Inner Join schema1.table3 c On t.Field48 = c.Field48' +
                  ' Inner Join schema2.table4 w On t.Field44 = w.Field44' +
                  ' Inner Join schema1.table5 p On t.Field45 = p.Field45' +
                  ' Inner Join schema1.table6 i On i.Field47 = t.Field47' +
                  ' Inner Join schema1.table7 z On i.Field46 = z.Field46' +

                  ' Where t.ID in (Select d.ID' +
                  ' From schema1.table8 d' +
                  ' Inner Join schema1.table9 w On d.Field36 = w.Field36' +

                  ' Where Replace(:Type, ''In'', ''Out'')' +
                    ' And w.Field2 = :Field2)';
  end;

  if not HavingCriteria.IsEmpty then
    SQLString := SQLString + ' Having ' + HavingCriteria;

  SQLString := SQLString + ' Order By Field7, Field2';

  inherited;

  SetButtonsState;
  ListGrid.SetColumnWidths;
end;

procedure TForm1.ClientDataSet1AfterInsert(DataSet: TDataSet);
begin
  inherited;

  if FieldIsNull(MastDataset['Field2']) then
    MastDataset['Field2'] := Format('%.4d', [FRecordNo]);

  MastDataset['Field4'] := WONOField;
  MastDataset['Field5'] := BranchCode;
  LoadData1;
end;

procedure TForm1.LookupDblClick(Sender: TObject);
var
  EditFlag: Boolean;
begin
  EditFlag := False;
  if not (ClientDataSet1.State in [dsEdit, dsInsert]) then
  begin
    ClientDataSet1.Edit;
    EditFlag := True;
  end;

  inherited;

  if EditFlag and (ClientDataSet1.State in [dsEdit, dsInsert]) then
    ClientDataSet1.Post;
end;

procedure TForm1.DataChange(Sender: TObject; Field: TField);
begin
  inherited;

  if Assigned(Field) and Field.FieldName.Equals('Date1') then
    LoadData2;
end;

procedure TForm1.ClientDataSet1BeforeInsert(DataSet: TDataSet);
begin
  inherited;

  FRecordNo := GetNextNumber();
end;

procedure TForm1.ClientDataSet1BeforePost(DataSet: TDataSet);
begin
  inherited;

  if (FieldIsNull(ClientDataSet1.FieldValues['Field1'])) then
  begin
    if not Edit4.Focused then
      PostMessage(Handle, WM_MESSAGE, 0, 0);

    Abort;
  end;
end;

procedure TForm1.GridSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
begin
  inherited;

  SetButtonsState;
end;

procedure TForm1.BtnOpenClick(Sender: TObject);
begin
  try
    if DetailDataset.Active then
      DetailDataset.Close;

    if not MainForm.ContractList.Find(SelectBox.Text, Index) then
    begin
      MessageDlg('Invalid selection', mtError, [mbOk], 0);
      Abort;
    end;

    SetAccessRight;

    ResetFilterDialog;
    ResetSortDialog;
    FilterCheckBox.Checked := False;

    with DataSet17 do
    begin
      if Active then
        Close;

      CommandText := 'Select t.Contract, t.Code, t.Type, t.Field1, t.Field2, t.Field3, t.Field4, t.Field5,' +
                      ' t.Field6, t.Field7, t.Field8, t.Field9, t.Field10, t.Field11, t.Field12, t.Field13,' +
                      ' t.Field14, t.Field15, t.Field16, t.Field17, t.Field18, t.Field19, t.Field20,' +
                      ' s.Name As Supplier, p.Field1, s.Field2, s.Field3, s.Field4, s.Field5, s.Field6, s.Field7 As Attention,' +
                      ' s.Field8, s.Field9, s.Field10, s.Field11, s.Field12, s.Field13, t.Field21, t.Field22,' +
                      ' proc1(t.ID) As Field6' +

                    ' From schema1.table10 t' +
                    ' Left Join schema2.table11 l On t.AddressLinkID = l.AddressLinkID' +
                    ' Left Join schema2.table12 adr On l.AddressID = adr.AddressID' +
                    ' Left Join schema2.table13 s On l.SupplierID = s.SupplierID' +

                    ' Where t.Field2 = :Param1' +
                      ' And t.Type = ' + QuotedStr(WONOField) +

                    ' Order By t.Field2, t.Field8';
    end;

    inherited;

    if (FLoadType = cFirstLoad) then
    begin
      FilterDialog.DataSet := MastDataset;

      FilterDialog.AddNewCriteria('StatusField', fdEqual, 'C', '', '', False, True);
      MastDataset.Filter := FilterDialog.FilterText;
      MastDataset.Filtered := False;
      FilterBox.Checked := False;
      FLoadType := cDefaultLoadScope;
    end;

    LoadData1;
    SetDetailQueries(cDefaultLoadScope);

  finally
    SQLString := '';
    SetButtonsState;
  end;
end;

procedure TForm1.OpenDetailClick(Sender: TObject);
begin
  SetDetailQueries(cDefaultLoadScope);

  inherited;
end;

procedure TForm1.PageControlChange(Sender: TObject);
begin
  inherited;

  if PageControl.ActivePage = TabSheet1 then
    LoadData1
  else if PageControl.ActivePage = TabSheet2 then
    LoadData2;
end;

procedure TForm1.ListDblClick(Sender: TObject);
begin
  inherited;

  BtnAddClick(Sender);
end;

procedure TForm1.ListSelectionChanged(Sender: TObject);
begin
  inherited;

  SetButtonsState;
end;

procedure TForm1.BtnRemoveClick(Sender: TObject);
var
  I: Integer;
  ScrollEvents: TScrollEvents;
  Continue: Boolean;
  SQL: String;
  OldCursor: TCursor;
begin
  Continue := False;

  if ClientDataSet1.State in [dsEdit, dsInsert] then
    ClientDataSet1.Post;

  if (Grid1.SelectedRows.Count > 0) then
  begin
    ifclosed(MastDataset);

    if Grid1.SelectedRows.Count > 1 then
    begin
      if MessageDlg('Are you sure you want to remove all items?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        Continue := True;
    end
    else
      Continue := True;

    if not Continue then
      Exit;

    if not ListClientDS.Active then
      LoadListClick(Sender);

    OldCursor := Screen.Cursor;
    try
      Screen.Cursor := crSQLWait;

      DisableDependencies(DetailClientDS, ScrollEvents);

      SQL := 'Delete From schema1.table8 Where DetailID in (';

      for I := 0 to Grid1.SelectedRows.Count - 1 do
      begin
        DetailClientDS.GotoBookmark(Grid1.SelectedRows.Items[I]);
        if I > 0 then
          SQL := SQL + ',';
        SQL := SQL + DetailClientDS.FieldByName('DetailID').AsString;
      end;
      SQL := SQL + ') ';

      ExecAndCommit(SQL, UpdateQuery);

    finally
      if Assigned(ScrollEvents) then
      begin
        EnableDependencies(DetailClientDS, ScrollEvents);
        FreeAndNil(ScrollEvents);
      end;

      Grid1.SelectedRows.Clear;
      OpenDetailClick(Sender);
      LoadListClick(Sender);

      Screen.Cursor := crHourGlass;
      ClientDataSet1.Refresh;

      SetButtonsState;
      Screen.Cursor := OldCursor;
    end;
  end
  else
    MessageDlg('You must at least select one item from list before proceeding!', mtError, [mbOk], 0);
end;

procedure TForm1.SetButtonsState;
var
  LoadListFlag: Boolean;
  OpenDetailFlag: Boolean;
  AddFlag: Boolean;
  RemoveFlag: Boolean;
  SaveFlag: Boolean;
  ReOpenFlag: Boolean;
  CloseFlag: Boolean;
begin
  inherited;

  LoadListFlag := False;
  OpenDetailFlag := False;
  AddFlag := False;
  RemoveFlag := False;
  SaveFlag := False;
  ReOpenFlag := False;
  CloseFlag := False;

  if ClientDataSet1.Active then
  begin
    if (ClientDataSet1.RecordCount > 0) then
    begin
      SaveFlag := not ReadOnlyAccess;

      if (ClientDataSet1.FieldValues[ClosedField] = 'C') then
        ReOpenFlag := not ReadOnlyAccess
      else
      begin
        CloseFlag := not ReadOnlyAccess;
      end;

      OpenDetailFlag := True;
      if (ClientDataSet1.FindField('Ref1').AsInteger > 0)
        and (ComboBox3.ItemIndex > cUndefined)
        and (ComboBox4.ItemIndex > cUndefined) then
      begin
        LoadListFlag := True;
      end;

      if ListClientDS.Active then
      begin
        if ListGrid.SelectedRows.Count > 0 then
          AddFlag := True;
      end;

      if DetailClientDS.Active then
      begin
        if Grid1.SelectedRows.Count > 0 then
        begin
          if ClientDataSet1.FindField(ClosedField).AsString <> 'C' then
            RemoveFlag := True;
        end;
      end;
    end;
  end;

  BtnClose.Enabled := CloseFlag;
  BtnReOpen.Enabled := ReOpenFlag;
  SaveMast.Enabled := SaveFlag;

  BtnAdd.Enabled := AddFlag;
  BtnRemove.Enabled := RemoveFlag;

  LoadList.Enabled := LoadListFlag;
  BtnFilterList.Enabled := LoadListFlag;
  ListFilterPanel.Enabled := LoadListFlag;
  OpenDetail.Enabled := OpenDetailFlag;
  DetSort.Enabled := OpenDetailFlag;
  BtnFilterDetail.Enabled := OpenDetailFlag;
  DetailFilterPanel.Enabled := OpenDetailFlag;
end;

procedure TForm1.SetDetailQueries(LoadType: Integer);
begin
  DetailSQLDS.CommandText := 'Select d.Field33, t.ID, t.Field2, t.Field49,' +
      't.Field50, t.Field51, t.Field52, t.Field53,' +
      'w.Field1, w.Field2, w.Field3, w.Field4,' +
      'i.Drawing, i.Rev,' +
      'z.Field5, z.Field6, z.Field7, z.Field8,' +
      'd.Field5, d.Field6, d.Field7, d.Field8' +

    ' From schema1.table2 t' +
    ' Inner Join schema1.table3 c On t.Field48 = c.Field48' +
    ' Inner Join schema2.table4 w On t.Field44 = w.Field44' +
    ' Inner Join schema1.table8 d On t.ID = d.ID' +
    ' Inner Join schema1.table6 i On i.Field47 = t.Field47' +
    ' Inner Join schema1.table7 z On i.Field46 = z.Field46' +

    ' Where c.Field2 = :Param1' +
      ' And t.Field8 = "ISO"' +
      ' And d.Field36 = ' + ClientDataSet1.FieldByName('ID').AsString;
end;

procedure TForm1.TypeSelectChange(Sender: TObject);
begin
  WONOField := TypeSelect.Text;
  inherited;
end;

procedure TCheckbox.CMTextChanged(var sMessage: TMessage);
begin
  inherited;

  if FFlag then
    Exit;
  FCaption := Caption;
end;

procedure TCheckbox.WmPaint(var Msg: TWMPaint);
var
  BtnWidth: Integer;
  canv: TControlCanvas;
begin
  BtnWidth := GetSystemMetrics(SM_CXMENUCHECK);

  FFlag := True;
  if not(csDesigning in ComponentState) then
    Caption := '';
  FFlag := False;

  inherited;

  canv := TControlCanvas.Create;

  try
    canv.Control := Self;
    canv.Font := Font;
    SetBkMode(canv.Handle, Ord(TRANSPARENT));
    canv.TextOut(BtnWidth + 1, 2, FCaption);
  finally
    canv.Free;
  end;
end;

end.
