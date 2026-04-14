unit Unit8;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdActns, ActnList, DB, ComCtrls, StdCtrls, Grids, Math,
  DBGrids, DBCtrls, Mask, ExtCtrls, FMTBcd, SqlExpr,
  DBClient, Provider, Buttons, StrUtils, UDBXFilterDialog, UDBXSortDialog,
  UnitDBGRidEnh, uDBXDataValidation, ClipBrd, Menus, System.Actions,
  UFm_T_MasterDetail_PickList_BTC, System.UITypes, BTC_Objects, System.ImageList,
  Vcl.ImgList, cySplitter, JvExExtCtrls, JvExtComponent, JvRollOut,
  Vcl.Samples.Gauges, JvBaseDlg, JvProgressDialog, JvComponentBase,
  JvDBGridExport, ShellApi,
  Unit_BTC_Const, ADOX_TLB, ADODB;

const
  FWO_Prop: array [0..31] of TGridColumnSettings =
    ((TableName: 'table1'; FieldName: 'Field1'; Alias: '';
      FieldType: 'ATTRIBUTE';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'Field1';
      TitleFontColor: clBlue;
      TitleFontStyles: [fsBold];
      TitleAlignment: taCenter;
      Visible: True;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 'table1'; FieldName: 'Field2'; Alias: '';
      FieldType: 'ATTRIBUTE';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'Field2';
      TitleFontColor: clBlue;
      TitleFontStyles: [fsBold];
      TitleAlignment: taCenter;
      Visible: True;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 'table1'; FieldName: 'Field3'; Alias: '';
      FieldType: 'ATTRIBUTE';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'Field3';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: False;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 'table1'; FieldName: 'Field4'; Alias: '';
      FieldType: 'ATTRIBUTE';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'Field4';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: False;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 'table1'; FieldName: 'Field5'; Alias: '';
      FieldType: 'ATTRIBUTE';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'Field5';
      TitleFontColor: clBlue;
      TitleFontStyles: [fsBold];
      TitleAlignment: taCenter;
      Visible: True;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 'table1'; FieldName: 'Field6'; Alias: '';
      FieldType: 'ATTRIBUTE';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'Field6';
      TitleFontColor: clBlue;
      TitleFontStyles: [fsBold];
      TitleAlignment: taCenter;
      Visible: False;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 'table1'; FieldName: 'Field7'; Alias: '';
      FieldType: 'ATTRIBUTE';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'Field7';
      TitleFontColor: clBlue;
      TitleFontStyles: [fsBold];
      TitleAlignment: taCenter;
      Visible: True;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 'table1'; FieldName: 'Field8'; Alias: '';
      FieldType: 'ATTRIBUTE';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'Field8';
      TitleFontColor: clBlue;
      TitleFontStyles: [fsBold];
      TitleAlignment: taCenter;
      Visible: False;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 'table1'; FieldName: 'Field9'; Alias: '';
      FieldType: 'ATTRIBUTE';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'Field9';
      TitleFontColor: clBlue;
      TitleFontStyles: [fsBold];
      TitleAlignment: taCenter;
      Visible: False;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 'table1'; FieldName: 'Field10'; Alias: '';
      FieldType: 'ATTRIBUTE';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'Field10';
      TitleFontColor: clBlue;
      TitleFontStyles: [fsBold];
      TitleAlignment: taCenter;
      Visible: False;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 'table1'; FieldName: 'Field11'; Alias: '';
      FieldType: 'ATTRIBUTE';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'Field11';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: False;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 'table1'; FieldName: 'Field12'; Alias: '';
      FieldType: 'ATTRIBUTE';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'Field12';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: False;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 'table1'; FieldName: 'Field13'; Alias: '';
      FieldType: 'ATTRIBUTE';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'Field13';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: True;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 'table1'; FieldName: 'Field14'; Alias: '';
      FieldType: 'ATTRIBUTE';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'Field14';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: True;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 'table1'; FieldName: 'Field15'; Alias: '';
      FieldType: 'ATTRIBUTE';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'Field15';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: False;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 'table1'; FieldName: 'Field16'; Alias: '';
      FieldType: 'ATTRIBUTE';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'Field16';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: False;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 'table1'; FieldName: 'Field17'; Alias: '';
      FieldType: 'ATTRIBUTE';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'Field17';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: False;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 'table1'; FieldName: 'Field18'; Alias: '';
      FieldType: 'ATTRIBUTE';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'Field18';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: False;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 'table1'; FieldName: 'Field19'; Alias: '';
      FieldType: 'ATTRIBUTE';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'Field19';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: False;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 'table1'; FieldName: 'Field20'; Alias: '';
      FieldType: 'ATTRIBUTE';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'Field20';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: False;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 'table1'; FieldName: 'Field21'; Alias: '';
      FieldType: 'ATTRIBUTE';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'Field21';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: False;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 'table2'; FieldName: 'Field22'; Alias: '';
      FieldType: 'LINK';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'Field22';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: False;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 'table3'; FieldName: 'Field23'; Alias: '';
      FieldType: 'LINK';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'Field23';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: False;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 'table3'; FieldName: 'Field24'; Alias: '';
      FieldType: 'LINK';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'Field24';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: False;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 'table3'; FieldName: 'Field25'; Alias: '';
      FieldType: 'LINK';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'Field25';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: False;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 'table3'; FieldName: 'Field26'; Alias: '';
      FieldType: 'LINK';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'Field26';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: False;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 'table3'; FieldName: 'Field27'; Alias: '';
      FieldType: 'LINK';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'Field27';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: False;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 'table3'; FieldName: 'Field28'; Alias: '';
      FieldType: 'LINK';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'Field28';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: False;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 'table3'; FieldName: 'Field29'; Alias: '';
      FieldType: 'LINK';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'Field29';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: False;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 'table3'; FieldName: 'Field30'; Alias: '';
      FieldType: 'LINK';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'Field30';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: False;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 'table3'; FieldName: 'Field31'; Alias: '';
      FieldType: 'LINK';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'Field31';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: False;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 'table1'; FieldName: 'Field32'; Alias: '';
      FieldType: 'ATTRIBUTE';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'Field32';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: False;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 'table1'; FieldName: 'Field33'; Alias: '';
      FieldType: 'KEY';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'Field33';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: False;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False));

  lstDetailGridColumns: array [0..4] of TGridColumnSettings =
    ((TableName: 'table4'; FieldName: 'Field34'; Alias: '';
      FieldType: 'ATTRIBUTE';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'Field34';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: True;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 'table4'; FieldName: 'Field35'; Alias: '';
      FieldType: 'ATTRIBUTE';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'Field35';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: True;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 'table4'; FieldName: 'Field36'; Alias: '';
      FieldType: 'ATTRIBUTE';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'Field36';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: True;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 'table4'; FieldName: 'Field37'; Alias: '';
      FieldType: 'ATTRIBUTE';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'Field37';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: True;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False),

     (TableName: 'table4'; FieldName: 'Field38'; Alias: '';
      FieldType: 'ATTRIBUTE';
      Width: 0;
      Alignment: taLeftJustify;
      DisplayType: ctBocText;
      TitleColor: clBtnFace;
      TitleCaption: 'Field38';
      TitleFontColor: clBlue;
      TitleFontStyles: [];
      TitleAlignment: taCenter;
      Visible: True;
      ReadOnly: True;
      ImeName: '';
      TV_Filtering: False));

type
  TForm1 = class(TFm_T_MasterDetail_PickList)
    ReportType: TRadioGroup;
    Action1: TAction;
    Action2: TAction;
    tsDetailSupportPlates: TTabSheet;
    PanelPipingMaterial: TPanel;
    Grid2: TDBGridEnh;
    DS2: TSQLDataSet;
    DP2: TDataSetProvider;
    CDS2: TClientDataSet;
    DS3: TDataSource;
    DS1: TSQLDataSet;
    DS1F1: TStringField;
    DS1F2: TStringField;
    DS1F3: TStringField;
    DS1F4: TStringField;
    DS1F5: TStringField;
    DS1F6: TStringField;
    DS1F7: TStringField;
    DS1F8: TStringField;
    DS1F9: TStringField;
    DS1F10: TStringField;
    DS1F11: TStringField;
    DS1F12: TStringField;
    DS1F13: TStringField;
    DS1F14: TStringField;
    DS1DS: TDataSource;
    DS1Branch_Code: TStringField;
    btn1: TBitBtn;
    dlgImportProgress: TJvProgressDialog;
    pnMasterOptions: TPanel;
    btnOpenReportsFolder: TBitBtn;
    lblAnchoredPlate: TLabel;
    rb1: TRadioButton;
    lblPreScealledPlate: TLabel;
    rb2: TRadioButton;
    dbeCarrier: TDBEdit;
    lblCarrier: TLabel;
    dbeVia: TDBEdit;
    lblVia: TLabel;
    dbeEmail: TDBEdit;
    lblEmail: TLabel;
    dbePhone: TDBEdit;
    lblPhone: TLabel;
    dbeCountry: TDBEdit;
    lblCountry: TLabel;
    dbeCity: TDBEdit;
    lblCity: TLabel;
    dbePackageNo: TDBEdit;
    lblPackageNo: TLabel;
    dbeAddress2: TDBEdit;
    lblAddress2: TLabel;
    dbeUnitRate: TDBEdit;
    lblUnitRate: TLabel;
    dbeAddress1: TDBEdit;
    lblAddress1: TLabel;
    dbePayTerms: TDBEdit;
    lblPayTerms: TLabel;
    dbeSubContractor: TDBEdit;
    lblSubContractorName: TLabel;
    dbePoNo: TDBEdit;
    lblPoNo: TLabel;
    dbeAttention: TDBEdit;
    lblAttention: TLabel;
    dbeSendTo: TDBEdit;
    lbSendTo: TLabel;

    procedure FormCreate(Sender: TObject);
    procedure Initialize; override;
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction); override;

    procedure OpenMaster_BtnClick(Sender: TObject);
    procedure Select_BoxChange(Sender: TObject);
    procedure wo_type_selectChange(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnReOpenClick(Sender: TObject);
    procedure btnOpenReportsFolderClick(Sender: TObject);
    procedure Master_GridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure Master_GridExit(Sender: TObject);
    procedure Master_ClientDSAfterScroll(DataSet: TDataSet);
    procedure Master_ClientDSBeforePost(DataSet: TDataSet);
    procedure Master_ClientDSAfterPost(DataSet: TDataSet);
    procedure Master_ClientDSBeforeInsert(DataSet: TDataSet);
    procedure Master_ClientDSAfterInsert(DataSet: TDataSet);
    procedure Master_ClientDSBeforeDelete(DataSet: TDataSet);
    procedure Master_DPGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: String);

    procedure Open_DetailClick(Sender: TObject);
    procedure DetailPageControlChange(Sender: TObject);
    procedure SetDetailGridSplitterPosition;
    procedure btnFilterDetailClick(Sender: TObject);
    procedure cbFilterDetailClick(Sender: TObject);
    procedure Add_ButtonClick(Sender: TObject);
    procedure Remove_ButtonClick(Sender: TObject);
    procedure Detail_ClientDSAfterScroll(DataSet: TDataSet);
    procedure Detail_GridCustomizeColorCell(Sender: TDBGridEnh;
      DataCol: Integer; Column: TColumn; State: TGridDrawState;
      var BackgroundColor, FontColor: TColor);
    procedure Grid2CustomizeColorCell(Sender: TDBGridEnh;
      DataCol: Integer; Column: TColumn; State: TGridDrawState;
      var BackgroundColor, FontColor: TColor);

    procedure Load_PicklistClick(Sender: TObject);
    procedure Picklist_DBGridCustomizeColorCell(Sender: TDBGridEnh;
      DataCol: Integer; Column: TColumn; State: TGridDrawState;
      var BackgroundColor, FontColor: TColor);
    procedure PickList_CDSAfterScroll(DataSet: TDataSet);

    procedure lbReportTypesClick(Sender: TObject); override;
    procedure lbReportTypesDblClick(Sender: TObject); override;
    procedure Action1Execute(Sender: TObject);
    procedure Action2Execute(Sender: TObject);

    procedure LookupDbEditDblClick(Sender: TObject);
    procedure Change_Val1(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure rb2Click(Sender: TObject);
    procedure rb1Click(Sender: TObject);
    procedure Master_GridAfterScroll(DataSet: TDataSet);
    procedure Master_DBNavigatorClick(Sender: TObject; Button: TNavigateBtn);
    procedure Master_DPBeforeUpdateRecord(Sender: TObject; SourceDS: TDataSet;
      DeltaDS: TCustomClientDataSet; UpdateKind: TUpdateKind;
      var Applied: Boolean);

  private
    iLoadType: Integer;
    Drawing_DBXFilterDialog: TDBXFilterDialog;
    Matl_DBXFilterDialog: TDBXFilterDialog;
    bDrawingFiltered, bMatlFiltered: Boolean;
    bRefreshGridInProgress: boolean;
    FType: String;
    FsSelectStatement, FsFromClause, FsWhereClause: string;
    FsFromClauseHist, FsWhereClauseHist: string;

    procedure SetControlState;
    procedure SetGridColumnTitles;
    procedure FormatText(Sender: TField;
      var Text: String; DisplayText: Boolean);
    function  getNextWONumber(): Integer;
    function  DoCheck: Boolean;

    procedure SetDetailSupportsQuery;
    procedure SetDetailSupportPlatesQuery;
    procedure LoadPickList(Sender: TObject; pContract: String = '');

  protected
    procedure SetupMasterGridColumns; override;
    procedure SetupDetailGridColumns; override;
    procedure SetAccessRight; override;
    procedure SetButtonsState;override;
    procedure SetPanelsSize; overload;

  public

  end;

var
  Form1: TForm1;

implementation

uses
  MainD, Unit_Traduc, UnitProcedures, UnitPickdate, CommonUnit,
  Unit7,
  Unit8,
  Unit9;

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  FiUser_Priv := Integer(BTC_User_Priv_Supports_Locating_Work_Orders);

  inherited;

  FType := 'SAS';

  ItemType1 := 1;
  ClosedField := 'Field7';

  Initialize;
end;

procedure TForm1.Initialize;
var
  i: Integer;

begin
  inherited;

  Form1 := Self;
  sForm_ID := Self.Name;

  Master_DBNavigator.DoubleBuffered := True;
  Detail_DBNavigator.DoubleBuffered := True;

  pnWoType.Visible := True;
  rbWoOut.Checked := True;

  Val1_Select.Items.Clear;
  Val1_Select.Items.Add('Val1');
  Val1_Select.Enabled := False;
  Val1_Select.ItemIndex := 0;

  Val1 := 'Val1';

  for i:=0 to Actions.ActionCount - 1 do
    Actions.Actions[i].Enabled := True;

  Action2.Enabled := False;

  lbReportTypes.Clear;
  for i:=0 to Actions.ActionCount - 1 do
  begin
    if Actions.Actions[i].Enabled then
      lbReportTypes.Items.Add(Actions.Actions[i].Caption);
  end;

  Drawing_DBXFilterDialog := TDBXFilterDialog.Create(Self);
  Matl_DBXFilterDialog := TDBXFilterDialog.Create(Self);
  bDrawingFiltered := False;
  bMatlFiltered := False;

  bRefreshGridInProgress := False;

  iLoadType := cFirstLoad;
end;

procedure TForm1.SetPanelsSize;
begin
  pnMaster.Height := pnMasterDetail.ClientHeight div 2;

  roPickList.Width := 2 * pnDetail.ClientWidth div 3;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  inherited;

  Change_Val1(nil);

  pcMasterNotesAndExtras.ActivePage := tsMasterReports;

  Master_Grid.Columns[Master_Grid.GetColumnIndexByFieldName('Field33')].Visible := False;
  Detail_Grid.Columns[Detail_Grid.GetColumnIndexByFieldName('Field38')].Visible := False;
  Grid2.Columns[Grid2.GetColumnIndexByFieldName('Field45')].Visible := False;
  Grid2.Columns[Grid2.GetColumnIndexByFieldName('Field46')].Visible := False;

  btnReOpen.Visible := is_admin(True);

  SQL_STRING := '';
  DetailPageControl.TabIndex := 0;
  Detail_DBNavigator.VisibleButtons := [nbFirst, nbLast, nbNext, nbPrior];
  SetButtonsState;
  SetControlState;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  inherited;

  SetPanelsSize;
end;

procedure TForm1.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  if Assigned(Drawing_DBXFilterDialog) then FreeAndNil(Drawing_DBXFilterDialog);
  if Assigned(Matl_DBXFilterDialog) then FreeAndNil(Matl_DBXFilterDialog);
end;

procedure TForm1.Select_BoxChange(Sender: TObject);
begin
  iLoadType := cFirstLoad;
  ResetMasterFilterDialog;
  ResetMasterSortDialog;

  inherited;

  SetAccessRight;
  SetButtonsState;
end;

procedure TForm1.wo_type_selectChange(Sender: TObject);
begin
  Val1 := Val1_Select.Text;

  inherited;

  SetButtonsState;
  SetControlState;

  OpenMaster_Btn.Click;
end;

procedure TForm1.Change_Val1(Sender: TObject);
begin
  if Det_Dataset.Active then Det_Dataset.Close;

  Set_Fields;

  iLoadType := cFirstLoad;
  ResetMasterFilterDialog;
  ResetMasterSortDialog;

  if Sender <> nil then
    OpenMaster_Btn.Click;

  if rbWoIn.Checked then
    Master_DBNavigator.VisibleButtons := Master_DBNavigator.VisibleButtons - [nbDelete, nbInsert]
  else
    Master_DBNavigator.VisibleButtons := Master_DBNavigator.VisibleButtons + [nbDelete, nbInsert];

  inherited;

  SetButtonsState;
end;

procedure TForm1.SetupMasterGridColumns;
begin
  Master_Grid.TitleLineCount := 2;
  Master_Grid.TitleAutoWrap := True;

  SetupGridColumns(Master_Grid, FWO_Prop);

  if rbWoOut.Checked then
  begin
    ClosedField := 'Field7';
    Master_Grid.Columns.Items[Master_Grid.GetColumnIndexByFieldName('Field5')].Visible := True;
    Master_Grid.Columns.Items[Master_Grid.GetColumnIndexByFieldName('Field6')].Visible := False;
    Master_Grid.Columns.Items[Master_Grid.GetColumnIndexByFieldName('Field7')].Visible := True;
    Master_Grid.Columns.Items[Master_Grid.GetColumnIndexByFieldName('Field8')].Visible := False;
  end
  else
  begin
    ClosedField := 'Field8';
    Master_Grid.Columns.Items[Master_Grid.GetColumnIndexByFieldName('Field5')].Visible := False;
    Master_Grid.Columns.Items[Master_Grid.GetColumnIndexByFieldName('Field6')].Visible := True;
    Master_Grid.Columns.Items[Master_Grid.GetColumnIndexByFieldName('Field7')].Visible := False;
    Master_Grid.Columns.Items[Master_Grid.GetColumnIndexByFieldName('Field8')].Visible := True;
  end;

  Master_Grid.FixedCols := 0;

  Master_Grid.SetGridColumnWidths;
end;

procedure TForm1.OpenMaster_BtnClick(Sender: TObject);
begin
  try
    if MainD.ContractList.Find(Select_Box.Text, index) then else
    begin
      MessageDlg(TXT_InvalidContractSelection, mtError, [mbOk], 0);
      Abort;
    end;

    SetAccessRight;

    if Detail_ClientDS.Active then Detail_ClientDS.Close;
    if CDS2.Active then CDS2.Close;
    cbFilterDetail.Checked := False;
    Detail_ClientDS.Filter := '';
    CDS2.Filter := '';
    Detail_ClientDS.Filtered := False;
    CDS2.Filtered := False;
    bDrawingFiltered := False;
    bMatlFiltered := False;
    FreeAndNil(Drawing_DBXFilterDialog);
    Drawing_DBXFilterDialog := TDBXFilterDialog.Create(Self);
    FreeAndNil(Matl_DBXFilterDialog);
    Matl_DBXFilterDialog := TDBXFilterDialog.Create(Self);

    with Master_SQLDS do
    begin
      if Active then Close;

      CommandText := Format('Select a.Field33, a.Field3, a.Field1, a.Field2,' +
                      ' a.Field9, a.Field10, a.Field4, a.Field32,' +
                      ' a.Field5, a.Field6, a.Field8, a.Field7,' +
                      ' a.Field16, a.Field17, a.Field18, a.Field19, a.Field20, a.Field21,' +
                      ' sp.Name As Field22, sp.Field39, ' + QuotedStr(cSupplierSubcontractor) + ' As Supplier_Type,' +
                      ' adr.Field24, adr.Field25, adr.Field26, adr.Field27, adr.Field28, adr.Field29,' +
                      ' adr.Field23, adr.Field30, adr.Field40, adr.Field31,' +
                      ' "%S" As Branch_Code,' +
                      ' proc1.proc2(a.Field2, a.Field1, a.Field3) As Field13,' +
                      ' proc1.proc3(a.Field2, a.Field1, a.Field3) As Field14,' +
                      ' a.Field41, a.Field42, a.Field43, a.Field44',
                      [Branch_Code]);

      CommandText := CommandText + Format(' From schema1.table1 a' +
                    ' Left Join schema2.table3 l On a.Field32 = l.Field32' +
                    ' Left Join schema2.table2 adr On l.Field47 = adr.Field47' +
                    ' Left Join schema2.table5 sp On l.Field48 = sp.Field48' +

                    ' Where a.Field3 = :Field3' +
                      ' And a.Field2 = "%S"' +

                    ' Order By a.Field1, a.Field2;',
                    [Val1]);
    end;

    inherited;

    SetDetailSupportsQuery;
    SetDetailSupportPlatesQuery;

  finally
    SQL_STRING := '';
    SetButtonsState;
  end;
end;

procedure TForm1.Master_DBNavigatorClick(Sender: TObject;
  Button: TNavigateBtn);
begin
  if (Button = nbInsert) or (Button = nbEdit) then
  begin
    if Assigned(WizardForm) then
      FreeAndNil(WizardForm);
    try
      WizardForm := TWizardForm.Create(Self);
      WizardForm.Calling_Form := Self;
      WizardForm.Wizard_Dataset := Mast_Dataset;
      WizardForm.Source := 'VAL1';
      WizardForm.Caption := 'Wizard';
      WizardForm.In_Out := In_Out;
      WizardForm.pnInOut.Visible := True;
      WizardForm.ShowModal;

      Master_Grid.SetGridColumnWidths;

      if not FieldIsNull(WizardForm.WO) then
        Master_ClientDS.Locate('Field1', WizardForm.WO, []);

    finally
      if Assigned(WizardForm) then
        FreeAndNil(WizardForm);
    end;
  end
  else
    inherited;
end;

procedure TForm1.Master_GridAfterScroll(DataSet: TDataSet);
begin
  inherited;

  Detail_Grid.SetGridColumnWidths;
  Grid2.SetGridColumnWidths;

  SetDetailGridSplitterPosition;
end;

procedure TForm1.Master_GridSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  inherited;

  SetButtonsState;
end;

procedure TForm1.Master_GridExit(Sender: TObject);
begin
  inherited;

  if Master_ClientDS.State in [dsEdit, dsInsert] then Master_ClientDS.Post;
end;

procedure TForm1.Master_ClientDSAfterScroll(DataSet: TDataSet);
begin
  inherited;
end;

procedure TForm1.Master_ClientDSBeforeInsert(
  DataSet: TDataSet);
begin
  mRecNo := getNextWONumber();
end;

procedure TForm1.Master_ClientDSAfterInsert(DataSet: TDataSet);
begin
  inherited;

  Mast_Dataset['Field3'] := Contract.Contract;
  if FieldIsNull(Mast_Dataset['Field1']) then
    Mast_Dataset['Field1'] := Format('%.4d', [mRecNo]);
  Mast_Dataset['Field77'] := Branch_Code;
  Mast_Dataset['Field78'] := cSupplierSubcontractor;

  SetButtonsState;
end;

procedure TForm1.Master_ClientDSBeforeDelete(DataSet: TDataSet);
begin
  inherited;

  SetButtonsState;
end;

procedure TForm1.Master_ClientDSBeforePost(DataSet: TDataSet);
begin
  inherited;

  if (FieldIsNull(Master_ClientDS.FieldValues['Field77'])) then
    Master_ClientDS.FieldValues['Field77'] := Branch_Code;

  if (FieldIsNull(Master_ClientDS.FieldByName('Field19').AsString)) then
    if (not FieldIsNull(Master_ClientDS.FieldByName('Field23').AsString)) then
        Master_ClientDS.FieldByName('Field19').AsString := Master_ClientDS.FieldByName('Field23').AsString;

  Mast_Dataset['Field4'] := Mast_Dataset['Field39'];
end;

procedure TForm1.Master_ClientDSAfterPost(DataSet: TDataSet);
begin
  inherited;

  SetButtonsState;
end;

function TForm1.getNextWONumber(): Integer;
var
  s: String;
  iWONo: Integer;
  CloneDS: TClientDataset;
  bFiltered: Boolean;

begin
  iWONo := 1;
  Result := iWONo;
  bFiltered := False;
  CloneDS := nil;

  try
    bFiltered := Mast_DataSet.Filtered;
    if bFiltered then
    begin
      Mast_DataSet.DisableControls;
      Mast_DataSet.Filtered := False;
    end;

    if (Mast_Dataset.RecordCount = 0) then Exit;

    CloneDS := TClientDataset.Create(nil);
    CloneDS.Active := False;
    CloneDS.CloneCursor(Mast_Dataset, False, True);

    iWONo := 0;
    with CloneDS do
    begin
      First;

      while not CloneDS.Eof do
      begin
        s := CloneDS['Field1'];
        if IsStrANumber(s) then
          iWONo := StrToInt(s);

        Next;
      end;
    end;

    Inc(iWONo);

  finally
    if Assigned(CloneDS) then
      FreeAndNil(CloneDS);

    if bFiltered then
    begin
      Mast_DataSet.Filtered := bFiltered;
      Mast_DataSet.EnableControls;
    end;

    Result := iWONo;
  end;
end;

function TForm1.DoCheck: Boolean;
begin
  Result := True;
end;

procedure TForm1.btnCloseClick(Sender: TObject);
begin
  if not DoCheck then Exit;

  try
    Screen.Cursor := crHourGlass;

    cbFilterDetail.Checked := False;
    Det_Dataset.Filtered := False;

    Set_Fields;

    CLOSE_SQL_STRING_1 := 'Select Field49 From schema2.tableX' +
                         ' Where FieldName = :Param1' +
                          ' And (ModuleID = ' + intToStr(cSupportStatusModuleID) + ')';

    if rbWoOut.Checked then
    begin
      CLOSE_SQL_STRING := Format('Update schema1.table4' +
                                ' Set %S = :Field5, %S = :Field1, LastStatus = :LastStatus, LS = :Field5 '
                                , [In_Out + Stat_Field, WONO_Field]);

      CLOSE_SQL_STRING := CLOSE_SQL_STRING + Format(' Where Field38 = :Field38' +
                                ' And %S Is Null '
                                , [In_Out + Stat_Field]);
    end
    else
    begin
      CLOSE_SQL_STRING := Format('Update schema1.table4' +
                                ' Set %S = :Field6, %S = :Field1, LastStatus = :LastStatus, LS = :Field6' +
                                ' Where Field38 = :Field38' +
                                  ' And %S Is Null '
                                , [In_Out + Stat_Field, WONO_Field, In_Out + Stat_Field]);
    end;

    inherited;

    Apply_Master_Update(Mast_Dataset);
    Master_ClientDS.Refresh;

  finally

    SetButtonsState;

    Screen.Cursor := crDefault;

  end;
end;

procedure TForm1.btnReOpenClick(Sender: TObject);
begin
  inherited;

  SetButtonsState;
end;

procedure TForm1.SetupDetailGridColumns;
begin
end;

procedure TForm1.DetailPageControlChange(Sender: TObject);
var
  sRef: String;

begin
  inherited;

  Det_Grid := nil;

  if (DetailPageControl.ActivePage = tsDetailMainData) and Assigned(Detail_ClientDS) then
  begin
    if Det_Dataset.Active then
      sRef := Det_Dataset.FieldByName('Field34').AsString;

    Det_Dataset := Detail_ClientDS;
    Det_SQLDS := Detail_SQLDS;
    Det_Grid := Detail_Grid;
    Detail_DBXFilterDialog := Drawing_DBXFilterDialog;
    cbFilterDetail.Checked := bDrawingFiltered;

    if Det_Dataset.Active then
    begin
      Det_Dataset.Refresh;
      Det_Dataset.First;
    end;

    if not FieldIsNull(sRef) then
    begin
      Detail_ClientDS.Locate('Field34', sRef, []);
    end;
  end
  else
  if (DetailPageControl.ActivePage = tsDetailSupportPlates) then
  begin
    Det_Dataset := CDS2;
    Det_SQLDS := DS2;
    Det_Grid := Grid2;
    Detail_DBXFilterDialog := Matl_DBXFilterDialog;
    cbFilterDetail.Checked := bMatlFiltered;

    if Det_Dataset.Active then
    begin
      Det_Dataset.Refresh;
      Det_Dataset.First;
    end;

    if Detail_ClientDS.Active then
      if not FieldIsNull(Detail_ClientDS['Field34']) then
        CDS2.Locate('Field34', Detail_ClientDS['Field34'], []);
  end;
end;

procedure TForm1.btnFilterDetailClick(Sender: TObject);
begin
  with Detail_DBXFilterDialog do
  begin
    if (DetailPageControl.TabIndex = 0) then
    begin
      DataSet := Detail_ClientDS;
    end
    else
    if (DetailPageControl.TabIndex = 1) then
    begin
      DataSet := CDS2;
    end;

    if ((Execute) and not(FilterText = '')) then
    begin
      Det_Dataset.Filter := FilterText;
      Det_Dataset.Filtered := True;
      cbFilterDetail.Checked := True;
    end;

    if (FilterText = '') then
      cbFilterDetail.Checked := False;
  end;
end;

procedure TForm1.cbFilterDetailClick(Sender: TObject);
begin
  inherited;

  if (DetailPageControl.TabIndex = 0) then
  begin
    bDrawingFiltered := cbFilterDetail.Checked;
  end
  else
  if (DetailPageControl.TabIndex = 1) then
  begin
    bMatlFiltered := cbFilterDetail.Checked;
  end;
end;

procedure TForm1.SetDetailSupportsQuery;
var
  sSelectStatement: String;

begin
  if Mast_Dataset.RecordCount = 0 then Exit;

  Set_Fields;

  if Detail_SQLDS.Active then Detail_SQLDS.Close;

  sSelectStatement := Format('Select a.Field38, a.Field3, a.Field50 As Field34, a.Field51 As Field35,' +
                             ' b.Field52, b.Field53 As Field54, b.Field45,' +
                             ' a.Field55, a.Field36, a.Field56, a.Field15,' +
                             ' a.Field42, a.Field57, a.Field43, a.Field58,' +
                             ' a.Field59, a.%S',
                             [In_Out + Stat_Field]);

  Detail_SQLDS.CommandText := sSelectStatement +
                     Format(' From schema1.table4 a' +
                            ' Left Join schema1.table6 b On a.Field45 = b.Field45' +

                            ' Where a.Field3 = :Field3' +
                             ' And a.%S = :Field1',
                             [WONO_Field]);

  Detail_SQLDS.CommandText := Detail_SQLDS.CommandText + ' Union (' + sSelectStatement;

  Detail_SQLDS.CommandText := Detail_SQLDS.CommandText +
                     Format(' From schema1.table7 a' +
                            ' Left Join schema1.table6 b On a.Field45 = b.Field45' +
                            ' Where a.Field3 = :Field3' +
                             ' And a.%S = :Field1' +
                             ' And a.Field38 not in (Select Field38 From schema1.table4' +
                                                  ' Where Field3 = a.Field3' +
                                                    ' And Field38 = a.Field38' +
                                                    ' And %S = a.%S)' +
                            ' Group By a.Field38' +
                            ' Order By a.Field55 Desc)',
                             [WONO_Field,
                              WONO_Field,
                              WONO_Field]);

  Detail_SQLDS.CommandText := Detail_SQLDS.CommandText +
                            ' Order By Field34, Field56, Field35';
end;

procedure TForm1.SetDetailSupportPlatesQuery;
var
  sSelectStatement: String;

begin
  if Mast_Dataset.RecordCount = 0 then Exit;

  if DS2.Active then DS2.Close;

  sSelectStatement := 'Select b.Field60, a.Field61, a.Field34, a.Field35,' +
                      ' a.Field62, c.Field63 As Field64,' +
                      ' a.Field65, a.Field66, a.Field67, a.Field68, a.Field69, a.Field70,' +
                      ' a.Field45, a.Field46,' +
                      ' a.Field43, a.Field71, a.Field42, a.Field72';

  DS2.CommandText := sSelectStatement +
              Format(' From schema1.table8 a' +
                     ' Left Join schema1.table4 b On a.Field73 = b.Field38' +
                     ' Left Join schema3.table9 c On a.Field62 = c.Field74' +
                     ' Where b.Field3 = :Field3' +
                      ' And b.%S = :Field1',
                     [WONO_Field]);

  DS2.CommandText := DS2.CommandText + ' Union (' + sSelectStatement;

  DS2.CommandText := DS2.CommandText +
              Format(' From schema1.table10 a' +
                     ' Left Join schema1.table7 b On a.Field73 = b.Field38' +
                     ' Left Join schema3.table9 c On a.Field62 = c.Field74' +
                     ' Where b.Field3 = :Field3' +
                      ' And b.%S = :Field1' +
                      ' And a.Field46 not in (Select Field46 From schema1.table10 ldh' +
                                                    ' Left Join schema1.table7 tdh On ldh.Field73 = tdh.Field38' +
                                                    ' Where ldh.Field3 = a.Field3' +
                                                      ' And %S = b.%S)' +
                     ' Order By a.Field55 Desc' +
                     ' Limit 1)',
                     [WONO_Field,
                      WONO_Field,
                      WONO_Field]);

  DS2.CommandText := DS2.CommandText +
                     ' Order By Field61, Field34, Field65, Field68, Field69, Field70';

  DS2.Params[0].AsString := Mast_Dataset.FieldValues['Field3'];
  DS2.Params[1].AsString := Mast_Dataset.FieldValues['Field1'];
end;

procedure TForm1.Open_DetailClick(Sender: TObject);
var
  bExistCanceledSupport: Boolean;
  idx: Integer;
  ScrollEvents: TScrollEvents;

begin
  if MainD.ContractList.Find(Select_Box.Text, index) then else
  begin
    MessageDlg(TXT_InvalidContractSelection, mtError, [mbOk], 0);
    Abort;
  end;

  Screen.Cursor := crSQLWait;
  bRefreshGridInProgress := True;

  Set_Fields;

  idx := Detail_Grid.Columns.Count-2;
  Detail_Grid.Columns.Items[idx].FieldName := In_Out + Stat_Field;

  Det_Dataset := Detail_ClientDS;
  Det_SQLDS := Detail_SQLDS;
  Detail_Grid.DataSource := DetailDS;
  SetDetailSupportsQuery;

  inherited Open_DetailClick(Sender);

  Drawing_DBXFilterDialog.DataSet := Detail_ClientDS;
  Drawing_DBXFilterDialog.AddNewCriteria('Field55', fdEqual, '0', '', '', False, False);
  Detail_DBXFilterDialog := Drawing_DBXFilterDialog;
  Detail_ClientDS.Filter := Drawing_DBXFilterDialog.FilterText;
  Detail_ClientDS.Filtered := True;
  Det_Dataset := Detail_ClientDS;
  bDrawingFiltered := True;

  if (DetailPageControl.TabIndex = 0) then
    cbFilterDetail.Checked := True;

  Screen.Cursor := crSQLWait;
  SetDetailSupportPlatesQuery;
  if CDS2.Active then CDS2.Close;
  CDS2.Open;

  bExistCanceledSupport := False;
  DisableDependencies(Det_Dataset, ScrollEvents);
  with Det_Dataset do
  begin
    while not Eof do
    begin
      if (FieldValues['Field36'] = 'C') then
      begin
        bExistCanceledSupport := True;
        Break;
      end;

      Next;
    end;
  end;

  EnableDependencies(Det_Dataset, ScrollEvents);
  Det_Dataset.First;

  bRefreshGridInProgress := False;
  Screen.Cursor := crDefault;

  SetGridColumnTitles;

  SetButtonsState;

  Detail_Grid.SetGridColumnWidths;
  Grid2.SetGridColumnWidths;

  SetDetailGridSplitterPosition;

  if bExistCanceledSupport then
    MessageDlg('At least one item has been canceled !', mtWarning, [mbOK], 0);

  if (DetailPageControl.TabIndex <> 0) then
    DetailPageControlChange(nil);
end;

procedure TForm1.LookupDbEditDblClick(Sender: TObject);
begin
  if not (Master_ClientDS.State in [dsEdit, dsInsert]) then
    Master_ClientDS.Edit;

  inherited;

  if (Master_ClientDS.State in [dsEdit, dsInsert]) then
    Master_ClientDS.Post;
end;

procedure TForm1.Detail_ClientDSAfterScroll(DataSet: TDataSet);
begin
  inherited;

  if not bRefreshGridInProgress then
    SetButtonsState;
end;

procedure TForm1.Detail_GridCustomizeColorCell(Sender: TDBGridEnh;
  DataCol: Integer; Column: TColumn; State: TGridDrawState;
  var BackgroundColor, FontColor: TColor);
begin
  inherited;
end;

procedure TForm1.SetDetailGridSplitterPosition;
var
  i, width, width1: Integer;

begin
  if roPickList.Collapsed then Exit;
  width := 0;
  if (DetailPageControl.ActivePage = tsDetailMainData) and Assigned(Detail_ClientDS) then
  begin
    width1 := 0;
    for i:=0 to Detail_Grid.Columns.Count - 1 do
      width1 := width1 + Detail_Grid.Columns.Items[i].Width;
    width := width1 + 60;
  end
  else
  if (DetailPageControl.ActivePage = tsDetailSupportPlates) and Assigned(Detail_ClientDS) then
  begin
    width1 := 0;
    for i:=0 to Grid2.Columns.Count - 1 do
      width1 := width1 + Grid2.Columns.Items[i].Width;
    width := width1 + 80;
  end;

  if (width > DetailPageControl.Width) then
  begin
    roPickList.Width := pnDetail.ClientWidth - width;
    roPickList.Invalidate;
  end;
end;

procedure TForm1.Load_PicklistClick(Sender: TObject);
begin
  LoadPickList(Sender, Contract.Contract);
end;

procedure TForm1.LoadPickList(Sender: TObject; pContract: String = '');
begin
  try
    bRefreshGridInProgress := True;

    Set_Fields;

    if rbWoOut.Checked then
    begin
      FsSelectStatement := Format('Select Distinct a.Field3, a.Field34, a.Field35, b.Field75, b.Field56, a.Field52, a.Field53, b.%S, b.%S,' +
                          ' b.Field38, a.Field45',
                          [WONO_Field,
                           In_Out + Stat_Field]);

      FsFromClause := ' From schema1.table8 a' +
                      ' Left Join schema1.table4 b On a.Field73 = b.Field38' +
                      ' Left Join schema1.table6 d On a.Field45 = d.Field45' +
                      ' Left Join schema1.table11 e On d.Field76 = e.Field76';

      FsWhereClause := Format(' Where a.Field3 = "%S"' +
                        ' And IsNull(b.%S)',
                        [pContract,
                         WONO_Field]);

      if rb2.Checked then
        FsWhereClause := FsWhereClause +
                        ' And a.Field62 = "PSP"'
      else
        FsWhereClause := FsWhereClause +
                        ' And a.Field62 = "SAS"';

      SQL_STRING := FsSelectStatement + FsFromClause + FsWhereClause;

      SQL_STRING := SQL_STRING + ' Order By Field52, Field53, Field34, Field35';
    end
    else
    begin
      FsSelectStatement := format('Select Distinct a.Field3, a.Field34, a.Field35, b.Field75, b.Field56, b.Field55, a.Field52, a.Field53, b.%S, b.%S,' +
                          ' b.Field38, a.Field45',
                          [WONO_Field,
                           In_Out + Stat_Field]);

      FsFromClause := Format(' From schema1.table8 a' +
                      ' Left Join schema1.table4 b On a.Field73 = b.Field38' +
                      ' Inner Join schema1.table1 w On a.Field3 = w.Field3 And w.Field2 = "%S" And w.Field1 = b.%S And w.Field7 = "C"' +
                      ' Left Join schema1.table6 d On a.Field45 = d.Field45' +
                      ' Left Join schema1.table11 e On d.Field76 = e.Field76',
                      [Stat_Field,
                       'Field5' + Stat_Field]);

      FsWhereClause := Format(' Where a.Field3 = "%S"' +
                        ' And b.%S = :Field1 And IsNull(b.%S)' +
                        ' And ((b.Field36 = "Y") Or IsNull(b.Field36))',
                        [pContract,
                         'Field5' + Stat_Field,
                         WONO_Field]);

      if rb2.Checked then
        FsWhereClause := FsWhereClause +
                        ' And a.Field62 = "PSP"'
      else
        FsWhereClause := FsWhereClause +
                        ' And a.Field62 = "SAS"';

      SQL_STRING := FsSelectStatement + FsFromClause + FsWhereClause;

      SQL_STRING := SQL_STRING + ' Order By Field52, Field53, Field34, Field35';
    end;

  finally
    if (DebugHook > 0) then
      Clipboard.AsText := SQL_STRING;

    inherited Load_PicklistClick(Sender);

    bRefreshGridInProgress := False;

    SetGridColumnTitles;

    SetControlState;
    SetButtonsState;

    Picklist_DBGrid.SetGridColumnWidths;
  end;
end;

procedure TForm1.Picklist_DBGridCustomizeColorCell(
  Sender: TDBGridEnh; DataCol: Integer; Column: TColumn;
  State: TGridDrawState; var BackgroundColor, FontColor: TColor);
begin
  inherited;
end;

procedure TForm1.PickList_CDSAfterScroll(DataSet: TDataSet);
begin
  inherited;

  if not bRefreshGridInProgress then
    SetButtonsState;
end;

procedure TForm1.Add_ButtonClick(Sender: TObject);
begin
  try
    Screen.Cursor := crHourGlass;

    ADD_SQL_STRING := Format('Update schema1.table4' +
                      ' Set %S = :Param1' +
                      ' Where Field38 = :Field38'
                      , [WONO_Field]);

    inherited;

  finally

    SetButtonsState;

    Screen.Cursor := crHourGlass;
    if Master_ClientDS.Active then Master_ClientDS.Refresh;
    if CDS2.Active then CDS2.Refresh;
    Screen.Cursor := crDefault;

  end;
end;

procedure TForm1.Remove_ButtonClick(Sender: TObject);
begin
  try
    Screen.Cursor := crHourGlass;

    REM_SQL_STRING := Format('Update schema1.table4' +
                     ' Set %S = Null, %S = Null' +
                     ' Where Field38 = :Field38'
                     , [WONO_Field,
                        In_Out + Stat_Field]);

    inherited;

  finally

    SetButtonsState;

    Screen.Cursor := crHourGlass;
    if Master_ClientDS.Active then Master_ClientDS.Refresh;
    if CDS2.Active then CDS2.Refresh;
    Screen.Cursor := crDefault;

  end;
end;

procedure TForm1.SetButtonsState;
var
  bSave_Mast: Boolean;
  bOpenMaster_Btn: Boolean;
  bBtnReOpen: Boolean;
  bBtnClose: Boolean;
  bOpenReportsFolder: Boolean;
  bOpen_Detail: Boolean;
  bAdd_Button: Boolean;
  bRemove_Button: Boolean;
  bBtnImportSurveys: Boolean;
  bReport_Button: Boolean;

begin
  inherited;

  bSave_Mast := False;
  bOpenMaster_Btn := False;
  bBtnReOpen := False;
  bBtnClose := False;
  bOpenReportsFolder := False;
  bOpen_Detail := False;
  bAdd_Button := False;
  bRemove_Button := False;
  bBtnImportSurveys := False;
  bReport_Button := False;

  if (Trim(Select_Box.Text) <> '') then
    bOpenMaster_Btn := True;

  if Master_ClientDS.Active then
  begin
    if (Master_ClientDS.RecordCount > 0) then
    begin
      bSave_Mast := not FbReadOnlyAccess;

      if (Master_ClientDS.FieldValues[ClosedField] = 'C') then
        bBtnReOpen := not FbReadOnlyAccess
      else
        bBtnClose := not FbReadOnlyAccess;

      pnWoType.Enabled := True;

      bOpen_Detail := True;
      bReport_Button := True;
      bOpenReportsFolder := True;
    end;

    if (DetailPageControl.ActivePageIndex) = 0 then
    begin
      if (Master_ClientDS.FieldValues[ClosedField] <> 'C') then
        if PickList_CDS.Active then
          if (PickList_CDS.RecordCount > 0) then
            bAdd_Button := not FbReadOnlyAccess;

      if (Master_ClientDS.FieldValues[ClosedField] <> 'C') then
        if Detail_Grid.DataSource.DataSet.Active then
          if (Detail_Grid.DataSource.DataSet.RecordCount > 0)
            and (SQL_STRING <> '') then
            bRemove_Button := not FbReadOnlyAccess;
    end;

    btn1.Visible := rbWOIn.Checked;
    if rbWOIn.Checked
      and (Master_ClientDS.FieldValues[ClosedField] <> 'C')
      and Detail_Grid.DataSource.DataSet.Active
      and (Detail_Grid.DataSource.DataSet.RecordCount > 0) then
        bBtnImportSurveys := True;
  end;

  Save_Mast.Enabled := bSave_Mast;
  OpenMaster_Btn.Enabled := bOpenMaster_Btn;
  btnReOpen.Enabled := bBtnReOpen;
  btnClose.Enabled := bBtnClose;
  btnOpenReportsFolder.Enabled := bOpenReportsFolder;
  Open_Detail.Enabled := bOpen_Detail;
  Add_Button.Enabled := bAdd_Button;
  Remove_Button.Enabled := bRemove_Button;
  btn1.Enabled := bBtnImportSurveys;
  Report_Button.Enabled := bReport_Button;
  lbReportTypes.Enabled := bReport_Button;
end;

procedure TForm1.SetControlState;
var
  i: Integer;

begin
  if Picklist_DBGrid.DataSource.DataSet.Active then
  begin
    for i:=0 to Picklist_DBGrid.Columns.Count-1 do
    begin
      if Picklist_DBGrid.Columns[i].FieldName = 'Field60' then
        Picklist_DBGrid.Columns[i].Visible := True;

      if Picklist_DBGrid.Columns[i].FieldName = 'Field37' then
        Picklist_DBGrid.Columns[i].Visible := True;
    end;
  end;
end;

procedure TForm1.SetGridColumnTitles;
var
  i: Integer;

begin
  if Detail_Grid.DataSource.DataSet.Active then
  begin
    for i:=0 to Detail_Grid.Columns.Count-1 do
    begin
      Detail_Grid.Columns[i].Title.Caption := GetFieldCaption(Detail_Grid.Columns[i].FieldName);
      Detail_Grid.Columns[i].Title.Font.Color := clBlue;
    end;
  end;

  if Grid2.DataSource.DataSet.Active then
  begin
    for i:=0 to Grid2.Columns.Count-1 do
    begin
      Grid2.Columns[i].Title.Caption := GetFieldCaption('table8', Grid2.Columns[i].FieldName);
      Grid2.Columns[i].Title.Font.Color := clBlue;
    end;
  end;

  if Picklist_DBGrid.DataSource.DataSet.Active then
  begin
    for i:=0 to Picklist_DBGrid.Columns.Count-1 do
    begin
      Picklist_DBGrid.Columns[i].Title.Caption := GetFieldCaption(Picklist_DBGrid.Columns[i].FieldName);
      Picklist_DBGrid.Columns[i].Title.Font.Color := clBlue;
      Picklist_DBGrid.Columns[i].Title.Alignment := taCenter;
      if (Pos('_ID', Picklist_DBGrid.Columns[i].FieldName) > 0) then
        Picklist_DBGrid.Columns[i].Visible := is_admin(True) or bDisplayPrimaryKey;
    end;
  end;
end;

procedure TForm1.Grid2CustomizeColorCell(Sender: TDBGridEnh;
  DataCol: Integer; Column: TColumn; State: TGridDrawState;
  var BackgroundColor, FontColor: TColor);
begin
  inherited;
end;

procedure TForm1.rb2Click(Sender: TObject);
begin
  inherited;

  FType := 'PSP';
  OpenMaster_Btn.Click;
end;

procedure TForm1.rb1Click(Sender: TObject);
begin
  inherited;

  FType := 'SAS';
  OpenMaster_Btn.Click;
end;

procedure TForm1.FormatText(Sender: TField;
  var Text: String; DisplayText: Boolean);

begin
  inherited;

  if (Sender.DataType = ftFMTBcd) then
    Text := IntToStr(Round(Sender.AsFloat));
end;

procedure TForm1.SetAccessRight;
begin
  inherited;
end;

procedure TForm1.btn1Click(Sender: TObject);
var
  sFilePath: String;
  dlg: TOpenDialog;
  sWO, sField34, sField35, sField52, sField65, sField62: String;
  X1, Y1, Z1, X2, Y2, Z2, X3, Y3, Z3, X4, Y4, Z4, X5, Y5, Z5: String;
  sField46: String;
  bDone, bAbort: Boolean;
  RowCount: Integer;
  iNbError: Integer;
  sSQL, sErrorMessage: String;
  Commands: TStringList;

  ADOConnection: TADOConnection;
  ADOQuery: TADOQuery;

  ScrollEvents: TScrollEvents;
  oBookmark: TBookMark;

begin
  inherited;

  bAbort := False;
  ADOConnection := nil;
  ADOQuery := nil;
  Commands := nil;
  iNbError := 0;
  RowCount := 0;

  oBookmark := nil;

  with CreateMessageDialog(TXT_AskForSurveyImportation, mtConfirmation, [mbYes, mbNo]) do
  try
    Position := poOwnerFormCenter;
    ActiveControl := TWinControl(FindComponent('No'));
    if (ShowModal = mrYes) then
    begin
      sFilePath := IncludeTrailingPathDelimiter(cReportDir) + Master_ClientDS['Field3'] + cProductionDir + cReleaseToErectionDir;
      sFilePath := IncludeTrailingPathDelimiter(getTempDir()) + sFilePath;

      dlg := TOpenDialog.Create(nil);
      try
        dlg.InitialDir := sFilePath;
        dlg.Filter := 'Excel Files|*.xlsx;*.xls;*.xlsm';

        if dlg.Execute(Handle) then
          sFilePath := dlg.FileName;

      finally
        dlg.Free;
      end;
    end
    else
      Exit;

  finally
    Free;
  end;

  if not FileExists(sFilePath) then
  begin
    Exit;
  end
  else
  begin
    try
      dlgImportProgress.Caption := TXT_ImportDataProgress;
      dlgImportProgress.Min := 0;
      dlgImportProgress.Max := 100;
      dlgImportProgress.Text := TXT_Initialization;
      dlgImportProgress.Tag := 0;
      dlgImportProgress.Show;
      dlgImportProgress.Form.FormStyle := fsStayOnTop;

      Self.Enabled := False;

      dlgImportProgress.Position := 0;

      ADOConnection := TADOConnection.Create(nil);
      ADOConnection.Connected := False;
      ADOConnection.ConnectionString := GetExcelConnectionString(sFilePath);
      ADOConnection.LoginPrompt := False;

      ADOQuery := TADOQuery.Create(nil);
      ADOQuery.Connection := ADOConnection;

      ADOQuery.SQL.Clear;
      ADOQuery.SQL.Add('Select * From [Sheet1$]');

      try
        ADOQuery.Open;

        RowCount := ADOQuery.RecordCount;

        Commands := TStringList.Create;
        Commands.Clear;
        sErrorMessage := '';
        bDone := (RowCount = 0);
        bAbort := False;

        dlgImportProgress.Max := RowCount + 1;
        Application.ProcessMessages;

        ADOQuery.First;

      except
        on E: Exception do
        begin
          sErrorMessage := E.Message;
          bDone := True;
          iNbError := -1;
        end;
      end;

      DisableDependencies(CDS2, ScrollEvents);
      oBookmark := CDS2.Bookmark;

      while (not bDone) and (not ADOQuery.Eof) do
      begin
        sWO := Format('%.4d', [ADOQuery.FieldByName('Field1').AsInteger]);
        sField62 := Trim(ADOQuery.FieldByName('Field62').AsString);

        if (sWO <> Master_ClientDS['Field1']) or (sField62 <> FType)  then
        begin
          sErrorMessage := 'Incorrect work order imput file.' + CR + 'The file does not contain the correct work order data!';
          if sField62 <> FType then
            sErrorMessage := sErrorMessage + CR + CR + 'Type codes don''t match.';

          inc(iNbError);
          bDone := True;
          break;
        end;

        sField34 := Trim(ADOQuery.FieldByName('Field34').AsString);
        sField46 := Trim(ADOQuery.FieldByName('Field46').AsString);

        X1 := Trim(ADOQuery.FieldByName('X1').AsString);
        Y1 := Trim(ADOQuery.FieldByName('Y1').AsString);
        Z1 := Trim(ADOQuery.FieldByName('Z1').AsString);

        X2 := Trim(ADOQuery.FieldByName('X2').AsString);
        Y2 := Trim(ADOQuery.FieldByName('Y2').AsString);
        Z2 := Trim(ADOQuery.FieldByName('Z2').AsString);

        X3 := Trim(ADOQuery.FieldByName('X3').AsString);
        Y3 := Trim(ADOQuery.FieldByName('Y3').AsString);
        Z3 := Trim(ADOQuery.FieldByName('Z3').AsString);

        X4 := Trim(ADOQuery.FieldByName('X4').AsString);
        Y4 := Trim(ADOQuery.FieldByName('Y4').AsString);
        Z4 := Trim(ADOQuery.FieldByName('Z4').AsString);

        X5 := Trim(ADOQuery.FieldByName('X5').AsString);
        Y5 := Trim(ADOQuery.FieldByName('Y5').AsString);
        Z5 := Trim(ADOQuery.FieldByName('Z5').AsString);

        if (sField34 = '') then bDone := True;

        dlgImportProgress.Position := dlgImportProgress.Position + 1;
        dlgImportProgress.Text := Format(TXT_ProcessingDataForSupport, [sField34]);

        Application.ProcessMessages;

        if dlgImportProgress.Tag = 1 then
        begin
          bDone := True;
          bAbort := True;
        end;

        if not bDone then
        begin
          if CDS2.Locate('Field46', sField46, []) then
          begin
            sSQL := 'Update schema1.table8' +
                   ' Set Trigger_Active = "N"';

            if not FieldIsNull(X1) and not FieldIsNull(Y1) and not FieldIsNull(Z1) then
            begin
              sSQL := sSQL + Format(', X1 = %S, Y1 = %S, Z1 = %S', [X1, Y1, Z1]);
            end;

            if not FieldIsNull(X2) and not FieldIsNull(Y2) and not FieldIsNull(Z2) then
            begin
              sSQL := sSQL + Format(', X2 = %S, Y2 = %S, Z2 = %S', [X2, Y2, Z2]);
            end;

            if not FieldIsNull(X3) and not FieldIsNull(Y3) and not FieldIsNull(Z3) then
            begin
              sSQL := sSQL + Format(', X3 = %S, Y3 = %S, Z3 = %S', [X3, Y3, Z3]);
            end;

            if not FieldIsNull(X4) and not FieldIsNull(Y4) and not FieldIsNull(Z4) then
            begin
              sSQL := sSQL + Format(', X4 = %S, Y4 = %S, Z4 = %S', [X4, Y4, Z4]);
            end;

            if not FieldIsNull(X5) and not FieldIsNull(Y5) and not FieldIsNull(Z5) then
            begin
              sSQL := sSQL + Format(', X5 = %S, Y5 = %S, Z5 = %S', [X5, Y5, Z5]);
            end;

            sSQL := sSQL + Format(' Where Field46 = %S;',
                                  [sField46]);

            Commands.Add(sSQL);
          end;

          ADOQuery.Next;
        end;
      end;

      if (not bAbort) and (iNbError = 0) then
      begin
        dlgImportProgress.Text := TXT_CommittingData;
        if not ExecAndCommit(Commands, Update_SQLQuery) then
        begin
          sErrorMessage := '';
          inc(iNbError);
        end;

        dlgImportProgress.Position := dlgImportProgress.Position + 1;
        Application.ProcessMessages;
      end;

      if Assigned(ADOQuery) then
      begin
        ADOQuery.Close;
        ADOQuery.Free;
      end;

      if Assigned(ADOConnection) then
      begin
        ADOConnection.Connected := False;
        ADOConnection.KeepConnection := False;
        ADOConnection.Close;
        ADOConnection.Free;
      end;

      dlgImportProgress.Hide;

      if not bAbort then
      begin
        Screen.Cursor := crHourGlass;
        Master_ClientDS.Refresh;

        Screen.Cursor := crDefault;
        if iNbError = 0 then
          MessageDlg(TXT_UpdateSuccessful, mtInformation, [mbOK], 0)
        else
          if sErrorMessage <> '' then
            MessageDlg(Format(TXT_UpdateTerminatedWithErrors + CR + CR + sErrorMessage, [intToStr(Abs(iNbError))]), mtError, [mbOK], 0);
      end
      else
        MessageDlg(TXT_DataImportationAborted, mtInformation, [mbOK], 0);

    finally
      if Assigned(Commands) then
        Commands.Free;

      if CDS2.BookmarkValid(oBookmark) then
      begin
        CDS2.Bookmark := oBookmark;
        EnableDependencies(CDS2, ScrollEvents);
      end;

      Self.Enabled := True;
      Screen.Cursor := crDefault;
    end;
  end;
end;

procedure TForm1.btnOpenReportsFolderClick(Sender: TObject);
var
  sReportPath: string;

begin
  inherited;

  sReportPath := IncludeTrailingPathDelimiter(cReportDir) + Master_ClientDS['Field3'] + cProductionDir + cReleaseToErectionDir;
  sReportPath := IncludeTrailingPathDelimiter(getTempDir()) + sReportPath;

  if not sReportPath.IsEmpty and DirectoryExists(sReportPath) then
    ShellExecute(Application.Handle, PChar('explore'), PChar(sReportPath), nil, nil, SW_SHOWNORMAL)
  else
    MessageDlg('Folder not found.', mtWarning, [mbOK], 0);
end;

procedure TForm1.Master_DPGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: String);
begin
  inherited;

  TableName := 'schema1.table1';
end;

procedure TForm1.Master_DPBeforeUpdateRecord(Sender: TObject;
  SourceDS: TDataSet; DeltaDS: TCustomClientDataSet; UpdateKind: TUpdateKind;
  var Applied: Boolean);
begin
  SetLength(DataF, Length(FWO_Prop));
  Move(FWO_Prop[0], DataF[0], SizeOf(FWO_Prop));

  inherited;
end;

procedure TForm1.lbReportTypesClick(Sender: TObject);
begin
  inherited;
end;

procedure TForm1.lbReportTypesDblClick(Sender: TObject);
begin
  inherited;

  GetReportAction(Actions, lbReportTypes.Items[lbReportTypes.ItemIndex]).Execute;
end;

procedure TForm1.Action2Execute(Sender: TObject);
var
  Report: TErection_Supp_Material_Pull_Ticket_Recap;

begin
  inherited;
end;

procedure TForm1.Action1Execute(Sender: TObject);
var
  Report: TPlates_Locating_per_Support;

begin
  inherited;

  Report := TPlates_Locating_per_Support.create(Self, ['Field3', 'Field1'], [Mast_Dataset['Field3'], Mast_Dataset['Field1']]);
  Report.Generate_Report();
  FreeAndNil(Report);
end;

end.
