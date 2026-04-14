unit Unit7;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FMTBcd, SqlExpr, DBClient, Provider, DB, ActnList,
  StdCtrls, Mask, DBCtrls, Buttons, Grids, DBGrids, ComCtrls,
  ExtCtrls, Variants, DateUtils, StdActns, UDBXFilterDialog, UDBXSortDialog,
  UnitGridEnh, UnitValidation, Unit2,
  Unit3, System.Actions, System.UITypes, Unit4,
  System.ImageList, Vcl.ImgList, Unit5, JvExExtCtrls, JvExtComponent,
  JvRollOut, Vcl.Menus, Unit6;

const
  MasterColumns: array [0..31] of TGridColumnSettings =
    ((TableName: 'table1'; FieldName: 'Field1'; Alias: '';
      FieldType: 'ATTRIBUTE'; Width: 0; Alignment: taLeftJustify;
      DisplayType: ctBocText; TitleColor: clBtnFace; TitleCaption: 'Field1';
      TitleFontColor: clBlue; TitleFontStyles: [fsBold]; TitleAlignment: taCenter;
      Visible: True; ReadOnly: True; ImeName: ''; TV_Filtering: False),

     (TableName: 'table1'; FieldName: 'Field2'; Alias: '';
      FieldType: 'ATTRIBUTE'; Width: 0; Alignment: taLeftJustify;
      DisplayType: ctBocText; TitleColor: clBtnFace; TitleCaption: 'Field2';
      TitleFontColor: clBlue; TitleFontStyles: [fsBold]; TitleAlignment: taCenter;
      Visible: True; ReadOnly: True; ImeName: ''; TV_Filtering: False),

     (TableName: 'table1'; FieldName: 'Field2'; Alias: '';
      FieldType: 'ATTRIBUTE'; Width: 0; Alignment: taLeftJustify;
      DisplayType: ctBocText; TitleColor: clBtnFace; TitleCaption: 'Field2';
      TitleFontColor: clBlue; TitleFontStyles: []; TitleAlignment: taCenter;
      Visible: False; ReadOnly: True; ImeName: ''; TV_Filtering: False),

     (TableName: 'table1'; FieldName: 'Field3'; Alias: '';
      FieldType: 'ATTRIBUTE'; Width: 0; Alignment: taLeftJustify;
      DisplayType: ctBocText; TitleColor: clBtnFace; TitleCaption: 'Field3';
      TitleFontColor: clBlue; TitleFontStyles: []; TitleAlignment: taCenter;
      Visible: False; ReadOnly: True; ImeName: 'Lookup1;Field3'; TV_Filtering: False),

     (TableName: 'table1'; FieldName: 'Date1'; Alias: '';
      FieldType: 'ATTRIBUTE'; Width: 0; Alignment: taLeftJustify;
      DisplayType: ctBocText; TitleColor: clBtnFace; TitleCaption: 'Date1';
      TitleFontColor: clBlue; TitleFontStyles: [fsBold]; TitleAlignment: taCenter;
      Visible: True; ReadOnly: True; ImeName: ''; TV_Filtering: False),

     (TableName: 'table1'; FieldName: 'Date2'; Alias: '';
      FieldType: 'ATTRIBUTE'; Width: 0; Alignment: taLeftJustify;
      DisplayType: ctBocText; TitleColor: clBtnFace; TitleCaption: 'Date2';
      TitleFontColor: clBlue; TitleFontStyles: [fsBold]; TitleAlignment: taCenter;
      Visible: False; ReadOnly: True; ImeName: ''; TV_Filtering: False),

     (TableName: 'table1'; FieldName: 'Status1'; Alias: '';
      FieldType: 'ATTRIBUTE'; Width: 0; Alignment: taLeftJustify;
      DisplayType: ctBocText; TitleColor: clBtnFace; TitleCaption: 'Status1';
      TitleFontColor: clBlue; TitleFontStyles: [fsBold]; TitleAlignment: taCenter;
      Visible: True; ReadOnly: True; ImeName: ''; TV_Filtering: False),

     (TableName: 'table1'; FieldName: 'Status2'; Alias: '';
      FieldType: 'ATTRIBUTE'; Width: 0; Alignment: taLeftJustify;
      DisplayType: ctBocText; TitleColor: clBtnFace; TitleCaption: 'Status2';
      TitleFontColor: clBlue; TitleFontStyles: [fsBold]; TitleAlignment: taCenter;
      Visible: False; ReadOnly: True; ImeName: ''; TV_Filtering: False),

     (TableName: 'table1'; FieldName: 'Field4'; Alias: '';
      FieldType: 'ATTRIBUTE'; Width: 0; Alignment: taLeftJustify;
      DisplayType: ctBocText; TitleColor: clBtnFace; TitleCaption: 'Field4';
      TitleFontColor: clBlue; TitleFontStyles: [fsBold]; TitleAlignment: taCenter;
      Visible: False; ReadOnly: True; ImeName: ''; TV_Filtering: False),

     (TableName: 'table1'; FieldName: 'Field5'; Alias: '';
      FieldType: 'ATTRIBUTE'; Width: 0; Alignment: taLeftJustify;
      DisplayType: ctBocText; TitleColor: clBtnFace; TitleCaption: 'Field5';
      TitleFontColor: clBlue; TitleFontStyles: [fsBold]; TitleAlignment: taCenter;
      Visible: False; ReadOnly: True; ImeName: ''; TV_Filtering: False),

     (TableName: 'table1'; FieldName: 'Field6'; Alias: '';
      FieldType: 'ATTRIBUTE'; Width: 0; Alignment: taLeftJustify;
      DisplayType: ctBocText; TitleColor: clBtnFace; TitleCaption: 'Field6';
      TitleFontColor: clBlue; TitleFontStyles: []; TitleAlignment: taCenter;
      Visible: False; ReadOnly: True; ImeName: ''; TV_Filtering: False),

     (TableName: 'table1'; FieldName: 'Field7'; Alias: '';
      FieldType: 'ATTRIBUTE'; Width: 0; Alignment: taLeftJustify;
      DisplayType: ctBocText; TitleColor: clBtnFace; TitleCaption: 'Field7';
      TitleFontColor: clBlue; TitleFontStyles: []; TitleAlignment: taCenter;
      Visible: False; ReadOnly: True; ImeName: ''; TV_Filtering: False),

     (TableName: 'table1'; FieldName: 'Count1'; Alias: '';
      FieldType: 'CALCULATED'; Width: 0; Alignment: taLeftJustify;
      DisplayType: ctBocText; TitleColor: clBtnFace; TitleCaption: 'Count1';
      TitleFontColor: clBlue; TitleFontStyles: []; TitleAlignment: taCenter;
      Visible: True; ReadOnly: True; ImeName: ''; TV_Filtering: False),

     (TableName: 'table1'; FieldName: 'Count2'; Alias: '';
      FieldType: 'CALCULATED'; Width: 0; Alignment: taLeftJustify;
      DisplayType: ctBocText; TitleColor: clBtnFace; TitleCaption: 'Count2';
      TitleFontColor: clBlue; TitleFontStyles: []; TitleAlignment: taCenter;
      Visible: False; ReadOnly: True; ImeName: ''; TV_Filtering: False),

     (TableName: 'table1'; FieldName: 'Field8'; Alias: '';
      FieldType: 'ATTRIBUTE'; Width: 0; Alignment: taLeftJustify;
      DisplayType: ctBocText; TitleColor: clBtnFace; TitleCaption: 'Field8';
      TitleFontColor: clBlue; TitleFontStyles: []; TitleAlignment: taCenter;
      Visible: False; ReadOnly: True; ImeName: ''; TV_Filtering: False),

     (TableName: 'table1'; FieldName: 'Field9'; Alias: '';
      FieldType: 'ATTRIBUTE'; Width: 0; Alignment: taLeftJustify;
      DisplayType: ctBocText; TitleColor: clBtnFace; TitleCaption: 'Field9';
      TitleFontColor: clBlue; TitleFontStyles: []; TitleAlignment: taCenter;
      Visible: False; ReadOnly: True; ImeName: ''; TV_Filtering: False),

     (TableName: 'table1'; FieldName: 'Field10'; Alias: '';
      FieldType: 'ATTRIBUTE'; Width: 0; Alignment: taLeftJustify;
      DisplayType: ctBocText; TitleColor: clBtnFace; TitleCaption: 'Field10';
      TitleFontColor: clBlue; TitleFontStyles: []; TitleAlignment: taCenter;
      Visible: False; ReadOnly: True; ImeName: ''; TV_Filtering: False),

     (TableName: 'table1'; FieldName: 'Field11'; Alias: '';
      FieldType: 'ATTRIBUTE'; Width: 0; Alignment: taLeftJustify;
      DisplayType: ctBocText; TitleColor: clBtnFace; TitleCaption: 'Field11';
      TitleFontColor: clBlue; TitleFontStyles: []; TitleAlignment: taCenter;
      Visible: False; ReadOnly: True; ImeName: ''; TV_Filtering: False),

     (TableName: 'table1'; FieldName: 'Field12'; Alias: '';
      FieldType: 'ATTRIBUTE'; Width: 0; Alignment: taLeftJustify;
      DisplayType: ctBocText; TitleColor: clBtnFace; TitleCaption: 'Field12';
      TitleFontColor: clBlue; TitleFontStyles: []; TitleAlignment: taCenter;
      Visible: False; ReadOnly: True; ImeName: ''; TV_Filtering: False),

     (TableName: 'table1'; FieldName: 'Field12'; Alias: '';
      FieldType: 'ATTRIBUTE'; Width: 0; Alignment: taLeftJustify;
      DisplayType: ctBocText; TitleColor: clBtnFace; TitleCaption: 'Field12';
      TitleFontColor: clBlue; TitleFontStyles: []; TitleAlignment: taCenter;
      Visible: False; ReadOnly: True; ImeName: ''; TV_Filtering: False),

     (TableName: 'table2'; FieldName: 'Field13'; Alias: '';
      FieldType: 'LINK'; Width: 0; Alignment: taLeftJustify;
      DisplayType: ctBocText; TitleColor: clBtnFace; TitleCaption: 'Field13';
      TitleFontColor: clBlue; TitleFontStyles: []; TitleAlignment: taCenter;
      Visible: False; ReadOnly: True; ImeName: ''; TV_Filtering: False),

     (TableName: 'table3'; FieldName: 'Field14'; Alias: '';
      FieldType: 'LINK'; Width: 0; Alignment: taLeftJustify;
      DisplayType: ctBocText; TitleColor: clBtnFace; TitleCaption: 'Field14';
      TitleFontColor: clBlue; TitleFontStyles: []; TitleAlignment: taCenter;
      Visible: False; ReadOnly: True; ImeName: ''; TV_Filtering: False),

     (TableName: 'table3'; FieldName: 'Address1'; Alias: '';
      FieldType: 'LINK'; Width: 0; Alignment: taLeftJustify;
      DisplayType: ctBocText; TitleColor: clBtnFace; TitleCaption: 'Address1';
      TitleFontColor: clBlue; TitleFontStyles: []; TitleAlignment: taCenter;
      Visible: False; ReadOnly: True; ImeName: ''; TV_Filtering: False),

     (TableName: 'table3'; FieldName: 'Address2'; Alias: '';
      FieldType: 'LINK'; Width: 0; Alignment: taLeftJustify;
      DisplayType: ctBocText; TitleColor: clBtnFace; TitleCaption: 'Address2';
      TitleFontColor: clBlue; TitleFontStyles: []; TitleAlignment: taCenter;
      Visible: False; ReadOnly: True; ImeName: ''; TV_Filtering: False),

     (TableName: 'table3'; FieldName: 'Field15'; Alias: '';
      FieldType: 'LINK'; Width: 0; Alignment: taLeftJustify;
      DisplayType: ctBocText; TitleColor: clBtnFace; TitleCaption: 'Field15';
      TitleFontColor: clBlue; TitleFontStyles: []; TitleAlignment: taCenter;
      Visible: False; ReadOnly: True; ImeName: ''; TV_Filtering: False),

     (TableName: 'table3'; FieldName: 'Field16'; Alias: '';
      FieldType: 'LINK'; Width: 0; Alignment: taLeftJustify;
      DisplayType: ctBocText; TitleColor: clBtnFace; TitleCaption: 'Field16';
      TitleFontColor: clBlue; TitleFontStyles: []; TitleAlignment: taCenter;
      Visible: False; ReadOnly: True; ImeName: ''; TV_Filtering: False),

     (TableName: 'table3'; FieldName: 'Field17'; Alias: '';
      FieldType: 'LINK'; Width: 0; Alignment: taLeftJustify;
      DisplayType: ctBocText; TitleColor: clBtnFace; TitleCaption: 'Field17';
      TitleFontColor: clBlue; TitleFontStyles: []; TitleAlignment: taCenter;
      Visible: False; ReadOnly: True; ImeName: ''; TV_Filtering: False),

     (TableName: 'table3'; FieldName: 'Zip'; Alias: '';
      FieldType: 'LINK'; Width: 0; Alignment: taLeftJustify;
      DisplayType: ctBocText; TitleColor: clBtnFace; TitleCaption: 'Zip';
      TitleFontColor: clBlue; TitleFontStyles: []; TitleAlignment: taCenter;
      Visible: False; ReadOnly: True; ImeName: ''; TV_Filtering: False),

     (TableName: 'table3'; FieldName: 'Field18'; Alias: '';
      FieldType: 'LINK'; Width: 0; Alignment: taLeftJustify;
      DisplayType: ctBocText; TitleColor: clBtnFace; TitleCaption: 'Field18';
      TitleFontColor: clBlue; TitleFontStyles: []; TitleAlignment: taCenter;
      Visible: False; ReadOnly: True; ImeName: ''; TV_Filtering: False),

     (TableName: 'table3'; FieldName: 'Field19'; Alias: '';
      FieldType: 'LINK'; Width: 0; Alignment: taLeftJustify;
      DisplayType: ctBocText; TitleColor: clBtnFace; TitleCaption: 'Field19';
      TitleFontColor: clBlue; TitleFontStyles: []; TitleAlignment: taCenter;
      Visible: False; ReadOnly: True; ImeName: ''; TV_Filtering: False),

     (TableName: 'table1'; FieldName: 'LinkID'; Alias: '';
      FieldType: 'ATTRIBUTE'; Width: 0; Alignment: taLeftJustify;
      DisplayType: ctBocText; TitleColor: clBtnFace; TitleCaption: 'LinkID';
      TitleFontColor: clBlue; TitleFontStyles: []; TitleAlignment: taCenter;
      Visible: False; ReadOnly: True; ImeName: ''; TV_Filtering: False),

     (TableName: 'table1'; FieldName: 'ID'; Alias: '';
      FieldType: 'KEY'; Width: 0; Alignment: taLeftJustify;
      DisplayType: ctBocText; TitleColor: clBtnFace; TitleCaption: 'ID';
      TitleFontColor: clBlue; TitleFontStyles: []; TitleAlignment: taCenter;
      Visible: False; ReadOnly: True; ImeName: ''; TV_Filtering: False));

  DetailColumns: array [0..19] of TGridColumnSettings =
    ((TableName: 'table4'; FieldName: 'Field2'; Alias: '';
      FieldType: 'ATTRIBUTE'; Width: 0; Alignment: taLeftJustify;
      DisplayType: ctBocText; TitleColor: clBtnFace; TitleCaption: 'Field2';
      TitleFontColor: clBlue; TitleFontStyles: []; TitleAlignment: taCenter;
      Visible: False; ReadOnly: True; ImeName: ''; TV_Filtering: False),

     (TableName: 'table4'; FieldName: 'Ref'; Alias: '';
      FieldType: 'ATTRIBUTE'; Width: 0; Alignment: taLeftJustify;
      DisplayType: ctBocText; TitleColor: clBtnFace; TitleCaption: 'Ref';
      TitleFontColor: clBlue; TitleFontStyles: []; TitleAlignment: taCenter;
      Visible: True; ReadOnly: True; ImeName: ''; TV_Filtering: False),

     (TableName: 'table4'; FieldName: 'Rev'; Alias: '';
      FieldType: 'ATTRIBUTE'; Width: 0; Alignment: taLeftJustify;
      DisplayType: ctBocText; TitleColor: clBtnFace; TitleCaption: 'Rev';
      TitleFontColor: clBlue; TitleFontStyles: []; TitleAlignment: taCenter;
      Visible: True; ReadOnly: True; ImeName: ''; TV_Filtering: False),

     (TableName: 'table4'; FieldName: 'Field20'; Alias: '';
      FieldType: 'ATTRIBUTE'; Width: 0; Alignment: taLeftJustify;
      DisplayType: ctBocText; TitleColor: clBtnFace; TitleCaption: 'Field20';
      TitleFontColor: clBlue; TitleFontStyles: []; TitleAlignment: taCenter;
      Visible: False; ReadOnly: True; ImeName: ''; TV_Filtering: False),

     (TableName: 'table4'; FieldName: 'FI'; Alias: '';
      FieldType: 'ATTRIBUTE'; Width: 0; Alignment: taLeftJustify;
      DisplayType: ctBocText; TitleColor: clBtnFace; TitleCaption: 'FI';
      TitleFontColor: clBlue; TitleFontStyles: []; TitleAlignment: taCenter;
      Visible: True; ReadOnly: True; ImeName: ''; TV_Filtering: False),

     (TableName: 'table4'; FieldName: 'Pri1'; Alias: '';
      FieldType: 'ATTRIBUTE'; Width: 0; Alignment: taLeftJustify;
      DisplayType: ctBocText; TitleColor: clBtnFace; TitleCaption: 'Pri1';
      TitleFontColor: clBlue; TitleFontStyles: []; TitleAlignment: taCenter;
      Visible: True; ReadOnly: True; ImeName: ''; TV_Filtering: False),

     (TableName: 'table4'; FieldName: 'Pri2'; Alias: '';
      FieldType: 'ATTRIBUTE'; Width: 0; Alignment: taLeftJustify;
      DisplayType: ctBocText; TitleColor: clBtnFace; TitleCaption: 'Pri2';
      TitleFontColor: clBlue; TitleFontStyles: []; TitleAlignment: taCenter;
      Visible: False; ReadOnly: True; ImeName: ''; TV_Filtering: False),

     (TableName: 'table4'; FieldName: 'Zone1'; Alias: '';
      FieldType: 'ATTRIBUTE'; Width: 0; Alignment: taLeftJustify;
      DisplayType: ctBocText; TitleColor: clBtnFace; TitleCaption: 'Zone1';
      TitleFontColor: clBlue; TitleFontStyles: []; TitleAlignment: taCenter;
      Visible: True; ReadOnly: True; ImeName: ''; TV_Filtering: False),

     (TableName: 'table4'; FieldName: 'Zone2'; Alias: '';
      FieldType: 'ATTRIBUTE'; Width: 0; Alignment: taLeftJustify;
      DisplayType: ctBocText; TitleColor: clBtnFace; TitleCaption: 'Zone2';
      TitleFontColor: clBlue; TitleFontStyles: []; TitleAlignment: taCenter;
      Visible: True; ReadOnly: True; ImeName: ''; TV_Filtering: False),

     (TableName: 'table4'; FieldName: 'Zone3'; Alias: '';
      FieldType: 'ATTRIBUTE'; Width: 0; Alignment: taLeftJustify;
      DisplayType: ctBocText; TitleColor: clBtnFace; TitleCaption: 'Zone3';
      TitleFontColor: clBlue; TitleFontStyles: []; TitleAlignment: taCenter;
      Visible: True; ReadOnly: True; ImeName: ''; TV_Filtering: False),

     (TableName: 'table4'; FieldName: 'Zone4'; Alias: '';
      FieldType: 'ATTRIBUTE'; Width: 0; Alignment: taLeftJustify;
      DisplayType: ctBocText; TitleColor: clBtnFace; TitleCaption: 'Zone4';
      TitleFontColor: clBlue; TitleFontStyles: []; TitleAlignment: taCenter;
      Visible: True; ReadOnly: True; ImeName: ''; TV_Filtering: False),

     (TableName: 'table4'; FieldName: 'Field21'; Alias: '';
      FieldType: 'ATTRIBUTE'; Width: 0; Alignment: taLeftJustify;
      DisplayType: ctBocText; TitleColor: clBtnFace; TitleCaption: 'Field21';
      TitleFontColor: clBlue; TitleFontStyles: []; TitleAlignment: taCenter;
      Visible: True; ReadOnly: True; ImeName: ''; TV_Filtering: False),

     (TableName: 'table4'; FieldName: 'Field22'; Alias: '';
      FieldType: 'ATTRIBUTE'; Width: 0; Alignment: taLeftJustify;
      DisplayType: ctBocText; TitleColor: clYellow;
      TitleCaption: 'Field22'; TitleFontColor: clBlue; TitleFontStyles: [fsBold];
      TitleAlignment: taCenter; Visible: False; ReadOnly: True; ImeName: ''; TV_Filtering: False),

     (TableName: 'table4'; FieldName: 'Field23'; Alias: '';
      FieldType: 'ATTRIBUTE'; Width: 0; Alignment: taLeftJustify;
      DisplayType: ctBocText; TitleColor: clYellow;
      TitleCaption: 'Field23'; TitleFontColor: clBlue; TitleFontStyles: [fsBold];
      TitleAlignment: taCenter; Visible: False; ReadOnly: True; ImeName: ''; TV_Filtering: False),

     (TableName: 'table5'; FieldName: 'Field24'; Alias: '';
      FieldType: 'CALCULATED'; Width: 0; Alignment: taCenter;
      DisplayType: ctBocText; TitleColor: clYellow;
      TitleCaption: 'Field24'; TitleFontColor: clBlue; TitleFontStyles: [fsBold];
      TitleAlignment: taCenter; Visible: True; ReadOnly: True; ImeName: ''; TV_Filtering: False),

     (TableName: 'table5'; FieldName: 'Field25'; Alias: '';
      FieldType: 'ATTRIBUTE'; Width: 0; Alignment: taLeftJustify;
      DisplayType: ctBocText; TitleColor: clYellow;
      TitleCaption: 'Field25'; TitleFontColor: clBlue; TitleFontStyles: [fsBold];
      TitleAlignment: taCenter; Visible: False; ReadOnly: True; ImeName: ''; TV_Filtering: False),

     (TableName: 'table5'; FieldName: 'Field26'; Alias: '';
      FieldType: 'CALCULATE'; Width: 0; Alignment: taCenter;
      DisplayType: ctBocText; TitleColor: clYellow;
      TitleCaption: 'Field26'; TitleFontColor: clBlue; TitleFontStyles: [fsBold];
      TitleAlignment: taCenter; Visible: True; ReadOnly: True; ImeName: ''; TV_Filtering: False),

     (TableName: 'table4'; FieldName: 'Field27'; Alias: '';
      FieldType: 'CALCULATED'; Width: 0; Alignment: taLeftJustify;
      DisplayType: ctBocText; TitleColor: clBtnFace;
      TitleCaption: 'Field27'; TitleFontColor: clBlue; TitleFontStyles: [];
      TitleAlignment: taCenter; Visible: True; ReadOnly: True; ImeName: ''; TV_Filtering: False),

     (TableName: 'table4'; FieldName: 'ItemID'; Alias: '';
      FieldType: 'ATTRIBUTE'; Width: 0; Alignment: taLeftJustify;
      DisplayType: ctBocText; TitleColor: clBtnFace; TitleCaption: 'ItemID';
      TitleFontColor: clBlue; TitleFontStyles: []; TitleAlignment: taCenter;
      Visible: False; ReadOnly: True; ImeName: ''; TV_Filtering: False),

     (TableName: 'table5'; FieldName: 'DetailID'; Alias: '';
      FieldType: 'LINK'; Width: 0; Alignment: taLeftJustify;
      DisplayType: ctBocText; TitleColor: clBtnFace; TitleCaption: 'DetailID';
      TitleFontColor: clBlue; TitleFontStyles: []; TitleAlignment: taCenter;
      Visible: False; ReadOnly: True; ImeName: ''; TV_Filtering: False));

type
  TForm1 = class(TForm3)
    Edit1: TDBEdit;
    Edit2: TDBEdit;
    Edit3: TDBEdit;
    Edit4: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Edit5: TDBEdit;
    Label7: TLabel;
    Edit6: TDBEdit;
    Label8: TLabel;
    Edit7: TDBEdit;
    Label9: TLabel;
    Edit8: TDBEdit;
    Label10: TLabel;
    Edit9: TDBEdit;
    Label11: TLabel;
    Edit10: TDBEdit;
    Label12: TLabel;
    Edit11: TDBEdit;
    Edit12: TDBEdit;
    Label13: TLabel;
    Edit13: TDBEdit;
    Label14: TLabel;
    RadioGroup1: TRadioGroup;
    Action1: TAction;
    Action2: TAction;
    Action3: TAction;
    Action4: TAction;
    Action5: TAction;
    Action6: TAction;
    Action7: TAction;
    Action8: TAction;
    FormDocs1: TFormDocs;
    Edit14: TEdit;
    Label15: TLabel;
    Edit15: TEdit;
    Label16: TLabel;
    Label17: TLabel;
    CheckBox1: TCheckBox;
    Label18: TLabel;
    CheckBox2: TCheckBox;

    procedure FormCreate(Sender: TObject);
    procedure Initialize; override;
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

    procedure SelectBoxChange(Sender: TObject);
    procedure BtnOpenClick(Sender: TObject);
    procedure TypeSelectChange(Sender: TObject);
    procedure ChangeType(Sender: TObject);
    procedure EditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BtnCloseClick(Sender: TObject);
    procedure BtnReOpenClick(Sender: TObject);
    procedure LookupDblClick(Sender: TObject);
    procedure NavigatorClick(Sender: TObject; Button: TNavigateBtn);
    procedure GridSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure GridCustomColor(Sender: TDBGridEnh; DataCol: Integer; Column: TColumn;
      State: TGridDrawState; var BackgroundColor, FontColor: TColor);
    procedure GridExit(Sender: TObject);
    procedure ClientDSBeforePost(DataSet: TDataSet);
    procedure ClientDSAfterPost(DataSet: TDataSet);
    procedure ClientDSBeforeInsert(DataSet: TDataSet);
    procedure ClientDSAfterInsert(DataSet: TDataSet);
    procedure ClientDSBeforeDelete(DataSet: TDataSet);
    procedure ClientDSAfterScroll(DataSet: TDataSet);
    procedure ProviderGetTable(Sender: TObject; DataSet: TDataSet; var TableName: string);
    procedure ProviderBeforeUpdate(Sender: TObject; SourceDS: TDataSet;
      DeltaDS: TCustomClientDataSet; UpdateKind: TUpdateKind; var Applied: Boolean);

    procedure BtnDetailClick(Sender: TObject);
    procedure OpenDetails(Sender: TObject; Contract: String = '');
    procedure DetailNavigatorClick(Sender: TObject; Button: TNavigateBtn);
    procedure BtnFilterDetailClick(Sender: TObject);
    procedure BtnAddClick(Sender: TObject);
    procedure BtnRemoveClick(Sender: TObject);
    procedure IsoSelectClick(Sender: TObject);
    procedure SetDetailSplitterPosition;
    procedure DetailGridColor(Sender: TDBGridEnh; DataCol: Integer; Column: TColumn;
      State: TGridDrawState; var BackgroundColor, FontColor: TColor);
    procedure DetailCellClick(Column: TColumn);
    procedure DetailAfterScroll(DataSet: TDataSet);
    procedure DetailProviderGetTable(Sender: TObject; DataSet: TDataSet; var TableName: string);
    procedure DetailProviderBeforeUpdate(Sender: TObject; SourceDS: TDataSet;
      DeltaDS: TCustomClientDataSet; UpdateKind: TUpdateKind; var Applied: Boolean);

    procedure LoadListClick(Sender: TObject);
    procedure LoadList(Sender: TObject; Contract: String = '');
    procedure CheckBoxClick(Sender: TObject);
    procedure LabelClick(Sender: TObject);
    procedure EditEnter(Sender: TObject);
    procedure EditKeyUp2(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditExit(Sender: TObject);
    procedure BtnFilterListClick(Sender: TObject);
    procedure ListGridColor(Sender: TDBGridEnh; DataCol: Integer; Column: TColumn;
      State: TGridDrawState; var BackgroundColor, FontColor: TColor);
    procedure ListAfterScroll(DataSet: TDataSet);
    procedure ListCellClick(Column: TColumn);

    procedure ReportClick(Sender: TObject); override;
    procedure ReportDblClick(Sender: TObject); override;
    procedure Action1Execute(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
    procedure Action3Execute(Sender: TObject);
    procedure Action4Execute(Sender: TObject);
    procedure Action5Execute(Sender: TObject);
    procedure Action6Execute(Sender: TObject);
    procedure Action7Execute(Sender: TObject);
    procedure Action8Execute(Sender: TObject);

    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState); override;

  private
    LoadType: Integer;
    RefreshInProgress: boolean;
    ListToPrint: TStringList;
    WOType: String;
    KeyState: Smallint;
    ForceCaps: Boolean;

    procedure SetControlState;
    procedure SetGridTitles;
    procedure SetFieldsState;
    function GetNextNumber(): Integer;
    function DoCheck: Boolean;
    procedure SetDetailQuery(Contract: String = '');
    function SetListOutQuery(Contract: String): String;
    function SetListInQuery(Contract: String): String;
    function CompleteDataEntry: Boolean;
    procedure PrepareBarcode;
    procedure SelectScannedCode;
    procedure SelectScannedCode2;

  protected
    procedure SetupMasterColumns; override;
    procedure SetupDetailColumns; override;
    procedure SetupListColumns;
    procedure SetAccessRight; override;
    procedure SetButtonsState; override;

  public
    destructor Destroy; override;
  end;

var
  Form1: TForm1;

implementation

uses
  MainD, UnitConst, UnitTraduc, UnitProcedures, CommonUnit, UnitConfig, UnitHelp,
  UnitWizard1, UnitWizard2, UnitWizard3,
  Report1, Report2, Report3, Report4,
  Report5, Report6, Report7, Report8;
{$R *.dfm}

destructor TForm1.Destroy;
begin
  if Assigned(ListToPrint) then
  begin
    ListToPrint.Clear;
    FreeAndNil(ListToPrint);
  end;

  inherited;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  UserPriv := Integer(UserPrivValue);

  inherited;

  ListToPrint := nil;

  Edit14.Text := '';
  ForceCaps := Config.ReadBool('OPTIONS', 'Key1', True);

  ItemType := 1;
  ClosedField := 'Status1';
end;

procedure TForm1.Initialize;
begin
  inherited;

  Form1 := Self;
  FormID := Self.Name;

  MasterNavigator.DoubleBuffered := True;
  DetailNavigator.DoubleBuffered := True;

  DetDataset := DetailClientDS;
  DetSQLDS := DetailSQLDS;

  if not Assigned(ListToPrint) then
    ListToPrint := TStringList.Create;
  ListToPrint.Duplicates := dupIgnore;
  ListToPrint.Sorted := True;

  RefreshInProgress := False;

  LoadType := cFirstLoad;

  FormDocs1.DocClientDS := DetailClientDS;
  FormDocs1.DocMasterSQLDS := DetailSQLDS;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  WONOTypeSelect.Items.Clear;
  WONOTypeSelect.Items.Add('Val1');
  WONOTypeSelect.ItemIndex := 0;
  WONOTypeSelect.Enabled := (WONOTypeSelect.Items.Count > 1);
  WONOField := WONOTypeSelect.Text;

  inherited;

  PageControl.ActivePage := TabReports;

  RadioButton1.Checked := True;

  ChangeType(nil);

  MasterGrid.Columns[MasterGrid.GetColumnIndexByFieldName('ID')].Visible := False;
  DetailGrid.Columns[DetailGrid.GetColumnIndexByFieldName('ItemID')].Visible := False;
  DetailGrid.Columns[DetailGrid.GetColumnIndexByFieldName('DetailID')].Visible := False;

  SQLString := '';
  SetButtonsState;
  SetControlState;

  KeyState := GetKeyState(VK_CAPITAL);
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  inherited;

  SetControlState;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  if (KeyState = 0) and (GetKeyState(VK_CAPITAL) <> 0) then
    ToggleCapsLock;
end;

procedure TForm1.SelectBoxChange(Sender: TObject);
begin
  LoadType := cFirstLoad;
  ResetMasterFilterDialog;
  ResetMasterSortDialog;

  inherited;

  SetAccessRight;
  SetButtonsState;
end;

procedure TForm1.TypeSelectChange(Sender: TObject);
begin
  WONOField := WONOTypeSelect.Text;

  if WONOField = 'Val1' then
    RadioButton1.Checked := True;

  inherited;

  SetControlState;

  if MastDataset.IsEmpty then
    BtnOpenClick(Sender);

  SetButtonsState;
end;

procedure TForm1.ChangeType(Sender: TObject);
var
  WO, RefStr: string;
  OpenMaster, OpenDetail: Boolean;
begin
  if MastDataset.Active then WO := Trim(MastDataset.FieldByName('Field1').AsString);
  OpenMaster := (Sender <> nil);
  OpenDetail := (Sender <> nil) and DetDataset.Active;

  RefStr := '';
  if OpenDetail and (DetDataset.FindField('Ref') <> nil) then
    RefStr := DetDataset.FieldByName('Ref').AsString;

  if MastDataset.Active then MastDataset.Close;
  if DetDataset.Active then DetDataset.Close;

  SetFields;

  LoadType := cFirstLoad;
  ResetMasterFilterDialog;
  ResetMasterSortDialog;

  if OpenMaster then
    BtnOpenClick(Sender);

  Label17.Visible := RadioButton1.Checked;
  CheckBox1.Visible := RadioButton1.Checked;

  Label16.Visible := RadioButton2.Checked;
  Edit15.Visible := RadioButton2.Checked;

  ReportList.Clear;
  if (WONOTypeSelect.Text = 'Val1') then
  begin
    if RadioButton2.Checked then
    begin
      ReportList.Items.Add(Action3.Caption);
      ReportList.Items.Add(Action4.Caption);
    end
    else
    begin
      ReportList.Items.Add(Action1.Caption);
      ReportList.Items.Add(Action3.Caption);
      ReportList.Items.Add(Action4.Caption);
      ReportList.Items.Add(Action5.Caption);
      ReportList.Items.Add(Action6.Caption);
      ReportList.Items.Add(Action7.Caption);
      ReportList.Items.Add(Action8.Caption);
    end;
  end;

  if MastDataset.Active and not FieldIsNull(WO) then
    MastDataset.Locate('Field1', WO, []);

  SetupDetailColumns;

  inherited;

  if OpenDetail then
  begin
    BtnDetailClick(Sender);

    if DetDataset.Active and not FieldIsNull(RefStr) then
      DetDataset.Locate('Ref', RefStr, []);
  end;

  SetButtonsState;
end;

procedure TForm1.SetupMasterColumns;
begin
  MasterGrid.TitleLineCount := 2;
  MasterGrid.TitleAutoWrap := True;

  SetupGridColumns(MasterGrid, MasterColumns);

  if RadioButton1.Checked then
  begin
    ClosedField := 'Status1';
    MasterGrid.Columns.Items[MasterGrid.GetColumnIndexByFieldName('Date1')].Visible := True;
    MasterGrid.Columns.Items[MasterGrid.GetColumnIndexByFieldName('Date2')].Visible := False;
    MasterGrid.Columns.Items[MasterGrid.GetColumnIndexByFieldName('Status1')].Visible := True;
    MasterGrid.Columns.Items[MasterGrid.GetColumnIndexByFieldName('Status2')].Visible := False;

    if (WONOTypeSelect.Text = 'Val1') then
      MasterGrid.Columns.Items[MasterGrid.GetColumnIndexByFieldName('Count2')].Visible := True;
  end
  else
  begin
    ClosedField := 'Status2';
    MasterGrid.Columns.Items[MasterGrid.GetColumnIndexByFieldName('Date1')].Visible := False;
    MasterGrid.Columns.Items[MasterGrid.GetColumnIndexByFieldName('Date2')].Visible := True;
    MasterGrid.Columns.Items[MasterGrid.GetColumnIndexByFieldName('Status1')].Visible := False;
    MasterGrid.Columns.Items[MasterGrid.GetColumnIndexByFieldName('Status2')].Visible := True;
    MasterGrid.Columns.Items[MasterGrid.GetColumnIndexByFieldName('Count2')].Visible := True;
  end;

  MasterGrid.FixedCols := 0;
  MasterGrid.SetColumnWidths;
end;

procedure TForm1.BtnOpenClick(Sender: TObject);
begin
  try
    if DetDataset.Active then DetDataset.Close;

    if MainD.ContractList.Find(SelectBox.Text, Index) then else
    begin
      MessageDlg(TXTInvalidContract, mtError, [mbOk], 0);
      Abort;
    end;

    SetAccessRight;

    ResetDetailFilterDialog;
    ResetDetailSortDialog;
    FilterDetailCheck.Checked := False;

    SetFields;

    with MasterSQLDS do
    begin
      if Active then Close;

      CommandText := Format('Select a.Field2, a.Field1, a.ID, a.Field2,' +
                            ' a.Field4, a.Field5, a.Field6, a.Field7, a.Field3, a.Field8,' +
                            ' a.Date1, a.Date2, a.Field35, a.Field34,' +
                            ' a.Field8, a.Field9, a.Field10, a.Field11, a.Field12, a.Field12,' +
                            ' sp.Field3 As Field22, sp.Field4, ' + QuotedStr(cSupplierType) + ' As Field24,' +
                            ' adr.Field1, adr.Field2, adr.Field25, adr.Field26, adr.Field27, adr.Zip,' +
                            ' adr.Field28, adr.Field29, adr.Field30, adr.Field31,' +
                            ' "%S" As Field5,' +
                            ' proc1(a.Field2, a.Field1, a.Field2) As Field18,' +
                            ' proc2(a.Field2, a.Field1, a.Field2) As Field19,' +
                            ' a.Field13, a.Field14, a.Field15, a.Field16' +

                           ' From schema1.table1 a' +
                           ' Left Join schema2.table6 l On a.Field38 = l.Field38' +
                           ' Left Join schema2.table7 adr On l.Field39 = adr.Field39' +
                           ' Left Join schema2.table8 sp On l.Field40 = sp.Field40' +

                           ' Where a.Field2 = :Param1' +
                            ' And a.Field2 = "%S"' +

                           ' Order By a.Field1, a.Field2',
                           [BranchCode, WONOField]);
    end;

    inherited;

    if (LoadType = cFirstLoad) then
    begin
      FilterDialog.DataSet := MastDataset;

      if RadioButton1.Checked then
        FilterDialog.AddNewCriteria('Status1', fdEqual, 'C', '', '', False, True)
      else
        FilterDialog.AddNewCriteria('Status2', fdEqual, 'C', '', '', False, True);

      MastDataset.Filter := FilterDialog.FilterText;
      MastDataset.Filtered := False;
      FilterBox.Checked := False;
      LoadType := cDefaultLoadScope;
    end;

    SetControlState;
    SetFields;

  finally
    SQLString := '';
    SetDetailQuery(ContractValue.Contract);
    SetButtonsState;
  end;
end;

procedure TForm1.NavigatorClick(Sender: TObject; Button: TNavigateBtn);
begin
  if (Button = nbInsert) or (Button = nbEdit) then
  begin
    if Assigned(Wizard1) then
      FreeAndNil(Wizard1);
    try
      Wizard1 := TWizard1.Create(Self);
      Wizard1.CallingForm := Self;
      Wizard1.WizardDataset := MastDataset;
      Wizard1.Source := 'CHECKING';
      Wizard1.Caption := 'Wizard';
      Wizard1.InOut := InOut;

      if RadioButton2.Checked then
        Wizard1.LockNumber;

      Wizard1.Panel1.Visible := True;
      Wizard1.ShowModal;

      MasterGrid.SetColumnWidths;

      if not FieldIsNull(Wizard1.Code) then
        ClientDataSet1.Locate('Field1', Wizard1.Code, []);

    finally
      if Assigned(Wizard1) then
        FreeAndNil(Wizard1);
    end;
  end
  else
    inherited;
end;

procedure TForm1.GridSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
begin
  inherited;

  SetButtonsState;
end;

procedure TForm1.GridCustomColor(Sender: TDBGridEnh; DataCol: Integer; Column: TColumn;
  State: TGridDrawState; var BackgroundColor, FontColor: TColor);
begin
  inherited;

  if Column.FieldName = 'Field30' + InOut then
  begin
    if (MasterGrid.DataSource.DataSet['Field30' + InOut] = 'E') then
    begin
      BackgroundColor := clRed;
      FontColor := clWhite;
    end;
  end;
end;

procedure TForm1.GridExit(Sender: TObject);
begin
  inherited;

  if ClientDataSet1.State in [dsEdit, dsInsert] then ClientDataSet1.Post;
end;

procedure TForm1.ClientDSAfterScroll(DataSet: TDataSet);
begin
  inherited;
end;

procedure TForm1.ClientDSBeforeInsert(DataSet: TDataSet);
begin
  FRecordNo := GetNextNumber();
end;

procedure TForm1.ClientDSAfterInsert(DataSet: TDataSet);
begin
  inherited;

  MastDataset['Field2'] := ContractValue.Contract;
  if FieldIsNull(MastDataset['Field1']) then
    MastDataset['Field1'] := Format('%.4d', [FRecordNo]);
  MastDataset.FieldValues['Field2'] := WONOTypeSelect.Text;
  MastDataset['Field5'] := BranchCode;
  MastDataset['Field10'] := cSupplierType;
end;

procedure TForm1.ClientDSBeforeDelete(DataSet: TDataSet);
begin
  inherited;

  SetButtonsState;
end;

procedure TForm1.ClientDSBeforePost(DataSet: TDataSet);
begin
  inherited;

  if (FieldIsNull(ClientDataSet1.FieldValues['Field5'])) then
    ClientDataSet1.FieldValues['Field5'] := BranchCode;

  if (FieldIsNull(ClientDataSet1.FieldByName('Field11').AsString)) then
    if (not FieldIsNull(ClientDataSet1.FieldByName('Field14').AsString)) then
        ClientDataSet1.FieldByName('Field11').AsString := ClientDataSet1.FieldByName('Field14').AsString;

  MastDataset['Field3'] := MastDataset['Field11'];

  if FieldIsNull(MastDataset[ClosedField]) then
    MastDataset[ClosedField] := Null;
end;

procedure TForm1.ClientDSAfterPost(DataSet: TDataSet);
begin
  inherited;

  SetButtonsState;
end;

function TForm1.GetNextNumber: Integer;
var
  S: String;
  Number: Integer;
  CloneDS: TClientDataset;
  Filtered: Boolean;
begin
  Number := 1;
  Result := Number;
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
        S := CloneDS['Field1'];
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

function TForm1.DoCheck: Boolean;
begin
  Result := True;
end;

procedure TForm1.BtnCloseClick(Sender: TObject);
begin
  if not DoCheck then Exit;

  ifclosed(MastDataset);

  Screen.Cursor := crHourGlass;

  try
    with UpdateQuery do
    begin
      if Active then Close;

      SQL.Clear;
      SQL.Add('Call proc1(:ID, :Param3, :InOut, :Param4);');

      ParamByName('ID').Value := ClientDataSet1.FieldByName('ID').Value;
      ParamByName('Field28').AsDate := Now;
      ParamByName('InOut').AsString := InOut;
      ParamByName('Field29').AsString := UserName;

      ExecSQL;
    end;

    BtnDetailClick(Sender);
    ClientDataSet1.Refresh;

  finally

    SetButtonsState;

    Screen.Cursor := crDefault;

  end;
end;

procedure TForm1.BtnReOpenClick(Sender: TObject);
begin
  if RadioButton1.Checked then
  begin
    if (ClientDataSet1.FieldValues['Status2'] = 'C') then
    begin
      MessageDlg('Access denied!', mtError, [mbOk], 0);
      Abort;
    end;
  end;

  inherited;

  SetButtonsState;
end;

procedure TForm1.SetupDetailColumns;
begin
  DetailGrid.TitleLineCount := 2;
  DetailGrid.TitleAutoWrap := True;

  SetupGridColumns(DetailGrid, DetailColumns);

  DetailGrid.GetColumnByFieldName('FI').Visible := False;
  DetailGrid.GetColumnByFieldName('Pri1').Visible := False;
  DetailGrid.GetColumnByFieldName('Pri2').Visible := True;

  DetailGrid.GetColumnByFieldName(InOut + StatField).Visible := True;

  DetailGrid.FixedCols := 0;
  DetailGrid.SetColumnWidths;
end;

procedure TForm1.SetDetailQuery(Contract: String = '');
var
  SelectStmt: String;
begin
  SetFields;

  SelectStmt := Format('Select Distinct s.Field31, s.Field32, s.Field33, s.Field20, s.Field15, s.Field56, s.Field21,' +
      ' (Select Min(f.Pri1)' +
       ' From schema1.table9 e' +
       ' Left Join schema1.table10 f On e.Field2 = f.Field2' +
        ' And e.Field7 = f.Field7' +
       ' Where e.Field2 = s.Field2' +
        ' And e.Field32 = s.Field32' +
        ' And (IsNull(f.Field21) Or (f.Field21 = "Y"))' +
        ' Order By f.Pri2, f.Pri1) As Pri1,' +

      ' (Select Min(f.Pri2)' +
       ' From schema1.table9 e' +
       ' Left Join schema1.table10 f On e.Field2 = f.Field2' +
        ' And e.Field7 = f.Field7' +
       ' Where e.Field2 = s.Field2' +
        ' And e.Field32 = s.Field32' +
        ' And (IsNull(f.Field21) Or (f.Field21 = "Y"))' +
       ' Order By f.Pri2, f.Field7) As Pri2,' +

      ' proc3(s.Field2, s.Field32, "1") As Zone1,' +
      ' proc3(s.Field2, s.Field32, "2") As Zone2,' +
      ' proc3(s.Field2, s.Field32, "3") As Zone3,' +
      ' proc3(s.Field2, s.Field32, "4") As Zone4,' +

      ' d.Date1 As OutDate, d.Date2 As InDate,' +
      ' d.Complete, if(IsNull(d.Complete), "N", "Y") As Conform,' +

      ' s.Field55, if(s.Field33 = d.Field33, "Applicable", "Revised") As RevState,' +

      ' w.Field2, w.Field1, d.Field33, w.Field2, w.Date2,' +

      ' c.Field1, c.Field33,' +

      ' d.Field12,' +

      ' d.Field1,' +
      ' d.Field2, d.Field3, d.Field4,' +
      ' d.Field5, d.Field6, d.Field7,' +

      ' d.Field10,' +

      ' if(IsNull(d.Field10), "N", "Y") As EntryDone,' +

      ' common.has_document("F", "CLASS1", d.Field33, "NA") As HasDoc,' +

      ' d.Field8, d.Field9, d.Field10, d.Field11',
      [InOut + StatField]);

  DetailSQLDS.CommandText := SelectStmt +
    ' From schema1.table5 d' +
    ' Inner Join schema1.table1 w On d.Field36 = w.ID' +
    ' Left Join schema1.table4 s On d.Field31 = s.Field31' +
    ' Left Join schema1.table11 c On w.Field2 = c.Field2 And c.Field8 = "TYPE1" And c.Field7 = "OBJ1" And c.Field6 = "STAGE1"' +

    ' Where w.Field2 = :Param1' +
      ' And w.Field2 = ' + QuotedStr(WONOField) +
      ' And w.Field1 = :Field1' +

      ' And not IsNull(d.Date' + InOut + ')';

  DetailSQLDS.CommandText := DetailSQLDS.CommandText +
    ' Order By Ref, Received, Rev';
end;

procedure TForm1.BtnDetailClick(Sender: TObject);
begin
  OpenDetails(Sender, ContractValue.Contract);
end;

procedure TForm1.OpenDetails(Sender: TObject; Contract: String = '');
var
  Idx: Integer;
begin
  RefreshInProgress := True;

  SetFields;

  Idx := DetailGrid.Columns.Count-2;
  DetailGrid.Columns.Items[Idx].FieldName := InOut + StatField;

  if DetailSQLDS.Active then DetailSQLDS.Close;
  DetDataset := DetailClientDS;
  DetSQLDS := DetailSQLDS;
  DetailGrid.DataSource := DetailDS;
  SetDetailQuery(Contract);

  inherited BtnDetailClick(Sender);

  RefreshInProgress := False;

  SetupDetailColumns;

  SetButtonsState;

  SetDetailSplitterPosition;
end;

procedure TForm1.BtnFilterDetailClick(Sender: TObject);
begin
  if not DetDataset.Active then OpenDetails(Sender);

  inherited;
end;

procedure TForm1.IsoSelectClick(Sender: TObject);
begin
  inherited;
end;

procedure TForm1.DetailGridColor(Sender: TDBGridEnh; DataCol: Integer; Column: TColumn;
  State: TGridDrawState; var BackgroundColor, FontColor: TColor);
begin
  inherited;

  if (DetailGrid.DataSource.DataSet['Field21'] = 'C') then
  begin
    BackgroundColor := clRed;
    FontColor := clWhite;
  end;
end;

procedure TForm1.PrepareBarcode;
begin
  if RadioButton2.Checked And Edit14.Visible And Edit14.Enabled then
    Edit14.SetFocus;
end;

procedure TForm1.DetailNavigatorClick(Sender: TObject; Button: TNavigateBtn);
begin
  inherited;

  if (Button = nbEdit) then
  begin
    if (WONOField = 'Val1') and RadioButton2.Checked then
      CompleteDataEntry;
  end
  else
    inherited;
end;

function TForm1.CompleteDataEntry: Boolean;
var
  ItemID: Integer;
  Report: TReportClass1;
  ReCheck: Boolean;
  PrevID, PrevNo, PrevDate: Variant;
begin
  Result := False;
  ReCheck := False;

  if Assigned(Wizard2) then
    FreeAndNil(Wizard2);

  try
    ItemID := DetailClientDS['ItemID'];

    with UpdateQuery do
    begin
      if Active then Close;

      CommandText := 'Call proc4(:DetailID);';

      ParamByName('DetailID').Value := DetailClientDS.FieldByName('DetailID').Value;

      Open;
      First;

      if not UpdateQuery.Eof then
      begin
        if UpdateQuery.FieldByName('Field30').Value = 'Val4' then
        begin
          ReCheck := True;
          PrevID := UpdateQuery.FieldByName('DetailID').Value;
          PrevNo := UpdateQuery.FieldByName('Field1').Value;
          PrevDate := UpdateQuery.FieldByName('Field28').Value;

          DetailClientDS.Edit;
          DetailClientDS.FieldByName('Field12').Value := UpdateQuery.FieldByName('Field12').Value;
          DetailClientDS.FieldByName('Field1').Value := UpdateQuery.FieldByName('Field1').Value;
          DetailClientDS.FieldByName('Field2').Value := UpdateQuery.FieldByName('Field2').Value;
          DetailClientDS.FieldByName('Field3').Value := UpdateQuery.FieldByName('Field3').Value;
          DetailClientDS.FieldByName('Field4').Value := UpdateQuery.FieldByName('Field4').Value;
          DetailClientDS.FieldByName('Field5').Value := UpdateQuery.FieldByName('Field5').Value;
          DetailClientDS.FieldByName('Field6').Value := UpdateQuery.FieldByName('Field6').Value;
          DetailClientDS.FieldByName('Field7').Value := UpdateQuery.FieldByName('Field7').Value;
        end;
      end;
    end;

    Wizard2 := TWizard2.Create(Self);
    Wizard2.CallingForm := Self;
    Wizard2.WizardDataset := DetailClientDS;

    if (Wizard2.ShowModal = mrOk) then
    begin
      if ReCheck then
      begin
        Report := TReportClass1.create(Self,
          ['Field2', 'DetailID', 'Field28', 'Val5', 'Val6'],
          [MastDataset['Field2'], PrevID, PrevDate, '0', 'Y']);

        Report.SaveReport(DetailClientDS.FieldByName('DetailID').Value);
        FreeAndNil(Report);
      end;

      DetailClientDS.Refresh;
      DetailClientDS.Locate('ItemID', ItemID, []);

      Result := True;
    end;

    DetailGrid.SetColumnWidths;

  finally
    if Assigned(Wizard2) then
      FreeAndNil(Wizard2);
  end;
end;

procedure TForm1.DetailAfterScroll(DataSet: TDataSet);
begin
  inherited;

  if not RefreshInProgress then
  begin
    SetButtonsState;

    if (DetailClientDS.FindField('HasDoc') <> nil) then
      FormDocs1.AfterScroll(DataSet);
  end;
end;

procedure TForm1.SetupListColumns;
begin
  ListGrid.TitleLineCount := 2;
  ListGrid.TitleAutoWrap := True;

  ListGrid.FixedCols := 0;
  ListGrid.SetColumnWidths;

  ListGrid.GetColumnByFieldName('ItemID').Visible := False;
end;

procedure TForm1.LoadListClick(Sender: TObject);
begin
  LoadList(Sender, ContractValue.Contract);
end;

function TForm1.SetListOutQuery(Contract: String): String;
begin
  try
    Result := Format('Select Distinct s.Field32, s.Field33, s.Field1, s.Field2, %S, %S,' +
                      ' s.Complete, s.Field21,' +
                      ' proc3(s.Field2, s.Field32, "1") As Zone1,' +
                      ' proc3(s.Field2, s.Field32, "2") As Zone2,' +
                      ' proc3(s.Field2, s.Field32, "3") As Zone3,' +
                      ' proc3(s.Field2, s.Field32, "4") As Zone4,' +
                      ' s.Field31',

                     ['s.' + WONOField,
                      's.Out' + StatField]);

    if CheckBox2.Visible and CheckBox2.Checked then begin

      Result := Result + Format(' From schema1.table4 s' +
                    ' Where s.Field2 = "%S"' +
                     ' And s.Flag1 = "Y"' +
                     ' And not IsNull(s.Field3)' +
                     ' And not IsNull(s.Field4)' +
                     ' And ((s.Field21 = "Y") Or IsNull(s.Field21))' +
                     ' And s.Field31 not in (Select d.Field31' +
                                          ' From schema1.table5 d' +
                                          ' Where d.Field36 = :WOID)',

                    [Contract]);
    end else begin
      Result := Result + Format(' From schema1.table4 s' +
                    ' Where s.Field2 = "%S"' +
                     ' And s.Flag1 = "Y"' +
                     ' And not IsNull(s.Field5)' +
                     ' And not IsNull(s.Field4)' +
                     ' And not IsNull(s.Field6)' +
                     ' And ((s.Field21 = "Y") Or IsNull(s.Field21))' +
                     ' And s.Field31 not in (Select d.Field31' +
                                          ' From schema1.table5 d' +
                                          ' Where d.Field36 = :WOID)',

                    [Contract]);
    end;

    if not CheckBox1.Checked then
      Result := Result + Format(' And IsNull(%S)',

                    ['s.' + WONOField]);

    Result := Result + ' Order By s.Field32, s.Field33, s.Field1, s.Field2';

  except
    Result := '';
  end;
end;

function TForm1.SetListInQuery(Contract: String): String;
begin
  try
    Result := 'Select Distinct s.Field32, s.Field33, s.Field1, s.Field2,' +
                ' w.Field1 As OutCode, d.Date1 As OutDate,' +
                ' s.Complete, s.Field21,' +
                ' proc3(s.Field2, s.Field32, "1") As Zone1,' +
                ' proc3(s.Field2, s.Field32, "2") As Zone2,' +
                ' proc3(s.Field2, s.Field32, "3") As Zone3,' +
                ' proc3(s.Field2, s.Field32, "4") As Zone4,' +
                ' s.Field31' +

             ' From schema1.table5 d' +
             ' Inner Join schema1.table1 w On d.Field36 = w.ID And w.Field34 = "C"' +
             ' Inner Join schema1.table4 s On d.Field31 = s.Field31' +

             ' Where w.Field36 = :WOID' +
                ' And IsNull(d.Date2)' +
                ' And ((s.Field21 = "Y") Or IsNull(s.Field21))' +

             ' Order By s.Field32, s.Field1, s.Field2, s.Field33';

  except
    Result := '';
  end;
end;

procedure TForm1.LoadList(Sender: TObject; Contract: String = '');
begin
  try
    RefreshInProgress := True;

    SetFields;

    if RadioButton1.Checked then
    begin
      SQLString := SetListOutQuery(Contract);
    end
    else
    begin
      SQLString := SetListInQuery(Contract);
    end;

    inherited LoadListClick(Sender);

    RefreshInProgress := False;

    SetGridTitles;
    ListGrid.SetColumnWidths;

  except

  end;

  SetupListColumns;

  SetControlState;
  SetButtonsState;
end;

procedure TForm1.CheckBoxClick(Sender: TObject);
begin
  inherited;

  LoadListClick(Sender);
end;

procedure TForm1.LabelClick(Sender: TObject);
begin
  inherited;

  CheckBox1.Enabled := not CheckBox1.Enabled;
end;

procedure TForm1.EditEnter(Sender: TObject);
begin
  inherited;

  SetButtonsState();

  KeyState := GetKeyState(VK_CAPITAL);
  if (GetKeyState(VK_CAPITAL) = 0) then
    if ForceCaps then ToggleCapsLock;
end;

procedure TForm1.EditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  if (Key = VK_RETURN) then
  begin
    SelectScannedCode;
  end;
end;

procedure TForm1.EditExit(Sender: TObject);
begin
  inherited;

  if (KeyState = 0) and (GetKeyState(VK_CAPITAL) <> 0) then
    ToggleCapsLock;
end;

procedure TForm1.SelectScannedCode;
var
  Code, CodeCopy: String;
  CodeID, I: Integer;
  Message: String;
begin
  try
    Code := Trim(Edit14.Text);

    CodeCopy := Copy(Code, 0, Code.Length);

    for I := (CodeCopy.Length -1) downto 0 do
    begin
      if CodeCopy[I] = '-' then
      begin
         Code := Copy(CodeCopy, I+1, CodeCopy.Length-I);
         Break;
      end;
    end;

    if (Code = EmptyStr) then
      Message := 'Field is required';

    if not TryStrToInt(Code, CodeID) then
      raise Exception.Create('Value must be an integer.'#13#10'(Verify CAPS LOCK is set ON).');

    if not ListClientDS.Active then LoadListClick(Sender);

    if ListClientDS.Locate('ItemID', CodeID, []) then
    begin
      ListGrid.SelectedRows.CurrentRowSelected := True;

      if RadioButton2.Enabled then
        BtnAddClick(Sender);
    end
    else
    if DetailClientDS.Locate('ItemID', CodeID, []) then
    begin
      DetailGrid.SelectedRows.CurrentRowSelected := True;

      MessageDlg('Data already entered!', mtInformation, [mbOk], 0);
    end
    else
    begin
      MessageDlg('Item not in work order!', mtInformation, [mbOk], 0);
    end;

  finally
    SetButtonsState;

    Edit14.Text := EmptyStr;
  end;
end;

procedure TForm1.EditKeyUp2(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  if (Key = VK_RETURN) and RadioButton2.Checked then
  begin
    SelectScannedCode2;
  end;
end;

procedure TForm1.SelectScannedCode2;
var
  Code, CodeCopy, ItemCode: String;
  CodeID, ItemID, I: Integer;
begin
  try
    Code := Trim(Edit15.Text);
    ItemCode := '';

    CodeCopy := Copy(Code, 0, Code.Length);

    for I := (CodeCopy.Length -1) downto 0 do
    begin
      if CodeCopy[I] = '-' then
      begin
         Code := Copy(CodeCopy, I+1, CodeCopy.Length-I);
         Break;
      end;
    end;

    if (Code = EmptyStr) then
      ItemCode := 'Field is required';

    if not TryStrToInt(Code, CodeID) then
      raise Exception.Create('Value must be integer.'#13#10'(Verify CAPS LOCK is set ON).');

    with UpdateQuery do
    begin
      if Active then Close;

      CommandText := 'Select w.WOID, d.DetailID, d.ItemID' +
                    ' From schema1.table5 d' +
                    ' Inner Join schema1.table1 w On d.WOID = w.ID' +
                    ' Where d.DetailID = :DetailID' +
                      ' And w.Field2 = :Param2' +
                      ' And (IsNull(w.Status2) Or (w.Status2 = "P"))';

      ParamByName('DetailID').Value := CodeID;
      ParamByName('Field8').AsString := WONOField;

      Open;
      First;

      if not UpdateQuery.Eof then
      begin
        Code := UpdateQuery.FieldByName('WOID').AsString;
        CodeID := UpdateQuery.FieldByName('WOID').AsInteger;
        ItemCode := UpdateQuery.FieldByName('ItemID').AsString;
        ItemID := UpdateQuery.FieldByName('ItemID').AsInteger;
      end;

      if not FieldIsNull(Code) and not FieldIsNull(ItemCode) then
      begin
        if not ClientDataSet1.Active then BtnOpenClick(Sender);

        if ClientDataSet1.Locate('ID', CodeID, []) then
        begin
          MasterGrid.SelectedRows.CurrentRowSelected := True;

          if not DetailClientDS.Active then BtnDetailClick(Sender);
          if not ListClientDS.Active then LoadListClick(Sender);

          if ListClientDS.Locate('ItemID', ItemID, []) then
          begin
            ListGrid.SelectedRows.CurrentRowSelected := True;

            if RadioButton2.Enabled then
              BtnAddClick(Sender);
          end
          else
          if DetailClientDS.Locate('ItemID', ItemID, []) then
          begin
            DetailGrid.SelectedRows.CurrentRowSelected := True;

            MessageDlg('Data already entered!', mtInformation, [mbOk], 0);
          end;
        end;
      end
      else
      begin
        MessageDlg('Item could not be found!' + CR + CR +
          'Check barcode or work order status!', mtError, [mbOk], 0);
      end;
    end;

  finally
    SetButtonsState;

    Edit15.Text := EmptyStr;
  end;
end;

procedure TForm1.BtnFilterListClick(Sender: TObject);
begin
  if not ListClientDS.Active then LoadList(Sender);

  inherited;
end;

procedure TForm1.ListGridColor(Sender: TDBGridEnh; DataCol: Integer; Column: TColumn;
  State: TGridDrawState; var BackgroundColor, FontColor: TColor);
begin
  inherited;

  if (ListGrid.DataSource.DataSet['Field21'] = 'Y') then
  begin
    BackgroundColor := clRed;
    FontColor := clWhite;
  end;
end;

procedure TForm1.ListAfterScroll(DataSet: TDataSet);
begin
  inherited;

  if not RefreshInProgress then
    SetButtonsState;
end;

procedure TForm1.ListCellClick(Column: TColumn);
begin
  inherited;

  SetButtonsState;
end;

procedure TForm1.BtnAddClick(Sender: TObject);
var
  SQL: String;
  I, ID, ItemID: Integer;
begin
  try
    Screen.Cursor := crHourGlass;

    SetFields;

    ID := ListGrid.SelectedRows.Count;
    ItemID := 0;

    if (WONOField = 'Val1') or
      (WONOField = 'Val2') then
    begin
      if (ListGrid.SelectedRows.Count > 0) then
      begin
        ifclosed(MastDataset);
        CheckDate();

        Screen.Cursor := crSQLWait;

        if RadioButton1.Checked then
        begin
          for I := 0 to ListGrid.SelectedRows.Count - 1 do
          begin
            SQL := 'Insert Into schema1.table5(WOID, Date1, ItemID, Ref, Rev, User1, Date2) Values ';

            ListClientDS.GotoBookmark(ListGrid.SelectedRows.Items[I]);
            ItemID := ListClientDS.FieldByName('ItemID').AsInteger;

            SQL := SQL + '(' + ClientDataSet1.FieldByName('ID').AsString + ', ' +
              QuotedStr(FormatDateTime(cSQLformatSettings, Now)) + ', ' +
              ListClientDS.FieldByName('ItemID').AsString + ', ' +
              QuotedStr(ListClientDS.FieldByName('Ref').AsString) + ', ' +
              QuotedStr(ListClientDS.FieldByName('Rev').AsString) + ', ' +
              QuotedStr(UserName) + ', ' +
              QuotedStr(FormatDateTime(cSQLformatSettings, Now)) + ')';

            ExecAndCommit(SQL, UpdateQuery);
          end;
        end
        else
        begin
          for I := 0 to ListGrid.SelectedRows.Count - 1 do
          begin
            SQL := 'Update schema1.table5' +
                   ' Set Date2 = ' + QuotedStr(FormatDateTime(cSQLformatSettings, Now)) +
                    ', Date3 = Null, Complete = Null' +
                   ' Where WOID = ' + ClientDataSet1.FieldByName('ID').AsString;

            ListClientDS.GotoBookmark(ListGrid.SelectedRows.Items[I]);
            ItemID := ListClientDS.FieldByName('ItemID').AsInteger;

            SQL := SQL + ' And ItemID = ' + ListClientDS.FieldByName('ItemID').AsString;

            ExecAndCommit(SQL, UpdateQuery);
          end;
        end;

        BtnDetailClick(Sender);
        LoadListClick(Sender);

        if RadioButton2.Checked and (ID = 1) and (ItemID > 0) then
        begin
          if DetailClientDS.Locate('ItemID', ItemID, []) then
            if not CompleteDataEntry then
            begin
              DetailGrid.SelectedRows.CurrentRowSelected := True;
              BtnRemoveClick(Sender);
            end;
        end;
      end;
    end
    else
    begin
      MessageDlg('Unexpected work order type!', mtInformation, [mbOk], 0);
    end;

  finally
    SetButtonsState;

    Screen.Cursor := crHourGlass;

    if ClientDataSet1.Active then ClientDataSet1.Refresh;

    Screen.Cursor := crDefault;
  end;
end;

procedure TForm1.BtnRemoveClick(Sender: TObject);
var
  SQL1, SQL2, SQL3, SQL4: String;
  I, ItemID: Integer;
begin
  try
    Screen.Cursor := crHourGlass;

    SetFields;

    ItemID := DetailClientDS.FieldByName('ItemID').AsInteger;

    if (WONOField = 'Val1') or
      (WONOField = 'Val2') then
    begin
      if DetailGrid.SelectedRows.Count > 0 then
      begin
        SQL1 := 'Delete From schema1.table5' +
                ' Where DetailID In (';

        SQL2 := 'Delete From schema1.table6' +
                ' Where DetailID In (';

        SQL3 := 'Update schema1.table5';

        SQL4 := 'Update schema1.table4';

        if RadioButton1.Checked then
        begin
          SQL3 := SQL3 + ' Set Date1 = Null, Date3 = Null';

          SQL4 := SQL4 + Format(' Set %S = Null, %S = Null, %S = Null, %S = Null, Complete = Null',
            ['Out' + StatField, 'Out' + StatField, 'In' + StatField, 'In' + StatField]);

          SQL4 := SQL4 + Format(', %S = Null', [ClientDataSet1.FieldValues['Field2'] + '_Val1']);
          SQL4 := SQL4 + Format(', %S = Null', [ClientDataSet1.FieldValues['Field2'] + '_Val2']);
          SQL4 := SQL4 + Format(', %S = Null', [ClientDataSet1.FieldValues['Field2'] + '_Val3']);
        end
        else
        begin
          SQL3 := SQL3 + ' Set Date2 = Null, Date3 = Null,' +
            ' Field12 = Null,' +
            ' Field1 = Null, Field2 = Null, Field3 = Null,' +
            ' Field4 = Null, Field5 = Null, Field6 = Null,' +
            ' Field7 = Null, Field8 = Null, Field9 = Null,' +
            ' Field10 = Null';

          SQL4 := SQL4 + Format(' Set %S = Null, %S = Null, Field25 = Null',
            [WONOField, InOut + StatField]);
        end;

        SQL3 := SQL3 + ' Where DetailID In (';

        SQL4 := SQL4 + ' Where ItemID In (';

        for I := 0 to DetailGrid.SelectedRows.Count - 1 do
        begin
          DetailClientDS.GotoBookmark(DetailGrid.SelectedRows.Items[I]);

          if I > 0 then
          begin
            SQL1 := SQL1 + ', ';
            SQL2 := SQL2 + ', ';
            SQL3 := SQL3 + ', ';
            SQL4 := SQL4 + ', ';
          end;

          SQL1 := SQL1 + DetailClientDS.FieldByName('DetailID').AsString;
          SQL2 := SQL2 + DetailClientDS.FieldByName('DetailID').AsString;
          SQL3 := SQL3 + DetailClientDS.FieldByName('DetailID').AsString;
          SQL4 := SQL4 + DetailClientDS.FieldByName('ItemID').AsString;
        end;

        SQL1 := SQL1 + ');';
        SQL2 := SQL2 + ');';
        SQL3 := SQL3 + ');';
        SQL4 := SQL4 + ');';

        if RadioButton1.Checked then
        begin
          ExecAndCommit(SQL1, UpdateQuery);
          ExecAndCommit(SQL4, UpdateQuery);
        end
        else
        begin
          ExecAndCommit(SQL2, UpdateQuery);
          ExecAndCommit(SQL3, UpdateQuery);
          ExecAndCommit(SQL4, UpdateQuery);
        end;

        BtnDetailClick(Sender);
        LoadListClick(Sender);
      end;
    end
    else
    begin
      MessageDlg('Unexpected work order type!', mtInformation, [mbOk], 0);
    end;

  finally

    SetButtonsState;

    Screen.Cursor := crHourGlass;

    if ClientDataSet1.Active then ClientDataSet1.Refresh;

    Screen.Cursor := crDefault;

  end;
end;

procedure TForm1.SetControlState;
var
  I, Idx: Integer;
  CountIn: Boolean;
begin
  ReportList.Clear;
  if RadioButton2.Checked then
  begin
    ReportList.Items.Add(Action3.Caption);
    ReportList.Items.Add(Action4.Caption);

    Action1.Enabled := False;
    Action3.Enabled := True;
    Action4.Enabled := True;
    Action5.Enabled := False;
    Action6.Enabled := False;
    Action7.Enabled := False;
    Action8.Enabled := False;
  end
  else
  begin
    ReportList.Items.Add(Action1.Caption);
    ReportList.Items.Add(Action3.Caption);
    ReportList.Items.Add(Action4.Caption);
    ReportList.Items.Add(Action5.Caption);
    ReportList.Items.Add(Action6.Caption);
    ReportList.Items.Add(Action7.Caption);
    ReportList.Items.Add(Action8.Caption);

    Action1.Enabled := True;
    Action3.Enabled := True;
    Action4.Enabled := True;
    Action5.Enabled := True;
    Action6.Enabled := True;
    Action7.Enabled := True;
    Action8.Enabled := True;
  end;

  if RadioButton2.Checked then
  begin
    FormDocs1.DocTable := 'table_docs';
    FormDocs1.DocSubClass := cDocClass;
    FormDocs1.DocIDField := 'DetailID';
    FormDocs1.DocNameTitle := 'Ref';
    FormDocs1.DocNameField := 'Ref';
    FormDocs1.DocAttribute1Title := 'Rev';
    FormDocs1.DocAttribute1Field := 'Rev';
    FormDocs1.DocAttribute2Title := '';
    FormDocs1.DocAttribute2Field := '';
    FormDocs1.LinkTable := 'table5';
    FormDocs1.DocClientDS := DetailClientDS;
    FormDocs1.DocMasterSQLDS := DetailSQLDS;
  end;
end;

procedure TForm1.SetFieldsState;
var
  Idx: Integer;
begin
  Idx := ListGrid.GetColumnIndexByFieldName('Field1');
  if (Idx <> -1) then ListGrid.Columns[Idx].Visible := False;
end;

procedure TForm1.SetGridTitles;
var
  I: Integer;
begin
  if (ListGrid.Columns.Count > 1) then
  begin
    for I := 0 to ListGrid.Columns.Count-1 do
    begin
      ListGrid.Columns[I].Title.Caption := GetFieldCaption(ListGrid.Columns[I].FieldName);
      ListGrid.Columns[I].Title.Font.Color := clBlue;
      ListGrid.Columns[I].Title.Alignment := taCenter;
    end;
  end;
end;

procedure TForm1.SetDetailSplitterPosition;
var
  I, Width: Integer;
begin
  if PanelList.Collapsed then Exit;

  Width := 0;
  for I := 0 to DetailGrid.Columns.Count - 1 do
    Width := Width + DetailGrid.Columns.Items[I].Width;

  Width := Width + 56;
  if (Width > DetailPageControl.Width) then
  begin
    PanelList.Width := PanelDetail.ClientWidth - Width;
    PanelList.Invalidate;
  end;
end;

procedure TForm1.SetButtonsState;
var
  SaveMastFlag: Boolean;
  BtnOpenFlag: Boolean;
  BtnReOpenFlag: Boolean;
  BtnCloseFlag: Boolean;
  OpenDetailFlag: Boolean;
  AddFlag: Boolean;
  RemoveFlag: Boolean;
  ReportFlag: Boolean;
  BtnAttachFlag: Boolean;
  BtnDisplayFlag: Boolean;
begin
  inherited;

  SaveMastFlag := False;
  BtnOpenFlag := False;
  BtnReOpenFlag := False;
  BtnCloseFlag := False;
  OpenDetailFlag := False;
  AddFlag := False;
  RemoveFlag := False;
  ReportFlag := False;
  BtnAttachFlag := False;
  BtnDisplayFlag := False;

  if (Trim(SelectBox.Text) <> '') then
    BtnOpenFlag := True;

  MasterNavigator.VisibleButtons := MasterNavigator.VisibleButtons - [nbDelete];

  if ClientDataSet1.Active then
  begin
    if (ClientDataSet1.RecordCount > 0) then
    begin
      if RadioButton2.Checked then
        MasterNavigator.VisibleButtons := MasterNavigator.VisibleButtons - [nbDelete, nbInsert]
      else
      begin
        MasterNavigator.VisibleButtons := MasterNavigator.VisibleButtons + [nbInsert];
        if (ClientDataSet1.FieldValues[ClosedField] <> 'C') then
          MasterNavigator.VisibleButtons := MasterNavigator.VisibleButtons + [nbDelete];
      end;

      SaveMastFlag := not ReadOnlyAccess;

      if (ClientDataSet1.FieldValues[ClosedField] = 'C') then
        BtnReOpenFlag := not ReadOnlyAccess
      else
        BtnCloseFlag := not ReadOnlyAccess;

      OpenDetailFlag := True;
      ReportFlag := True;

      if (ClientDataSet1.FieldValues[ClosedField] <> 'C') then
        if ListClientDS.Active then
          if (ListClientDS.RecordCount > 0)
            and (ListGrid.SelectedRows.Count > 0)
            and FieldIsNull(ListClientDS['Field21']) then
            AddFlag := not ReadOnlyAccess;

      if (ClientDataSet1.FieldValues[ClosedField] <> 'C') then
        if DetailGrid.DataSource.DataSet.Active then
          if (DetailGrid.DataSource.DataSet.RecordCount > 0)
            and (SQLString <> '')
            and (DetailGrid.SelectedRows.Count > 0) then
            RemoveFlag := not ReadOnlyAccess;

      if DetailGrid.DataSource.DataSet.Active then
        if (DetailGrid.DataSource.DataSet.RecordCount > 0) then
          if (WONOField = 'Val1') and RadioButton2.Checked then
          begin
            BtnAttachFlag := True;
            BtnDisplayFlag := (DetailClientDS['HasDoc'] = '1');
          end;
    end;

    if (DetailPageControl.ActivePage = TabDetailMain)
      and (WONOField = 'Val1')
      and RadioButton2.Checked
      and (ClientDataSet1.FieldValues[ClosedField] <> 'C')
      and DetailGrid.DataSource.DataSet.Active
      and (DetailGrid.DataSource.DataSet.RecordCount > 0) then
      DetailNavigator.VisibleButtons := DetailNavigator.VisibleButtons + [nbEdit]
    else
      DetailNavigator.VisibleButtons := DetailNavigator.VisibleButtons - [nbEdit];
  end;

  SaveMast.Enabled := SaveMastFlag;
  BtnOpen.Enabled := BtnOpenFlag;
  BtnReOpen.Enabled := BtnReOpenFlag;
  BtnClose.Enabled := BtnCloseFlag;
  BtnDetail.Enabled := OpenDetailFlag;
  BtnAdd.Enabled := AddFlag;
  BtnRemove.Enabled := RemoveFlag;
  ReportButton.Enabled := ReportFlag;
  ReportList.Enabled := ReportFlag;

  Label15.Visible := (DetailPageControl.ActivePage = TabDetailMain) and RadioButton2.Checked;
  Edit14.Visible := (DetailPageControl.ActivePage = TabDetailMain) and RadioButton2.Checked;

  FormDocs1.Visible := RadioButton2.Checked and (WONOField = 'Val1');
  FormDocs1.BtnAttachDoc.Enabled := BtnAttachFlag;
  FormDocs1.BtnDisplayDoc.Enabled := BtnDisplayFlag;

  CheckBox2.Visible := (GetUserRights(UserPrivFinalCheck, True) = 'Y');;
  Label18.Visible := (GetUserRights(UserPrivFinalCheck, True) = 'Y');;

  if RadioButton2.Checked then begin
    CheckBox2.Visible := False;
    Label18.Visible := False;
  end;
end;

procedure TForm1.LookupDblClick(Sender: TObject);
begin
  if not (ClientDataSet1.State in [dsEdit, dsInsert]) then
    ClientDataSet1.Edit;

  inherited;
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
end;

procedure TForm1.SetAccessRight;
begin
  inherited;
end;

procedure TForm1.ProviderGetTable(Sender: TObject; DataSet: TDataSet; var TableName: string);
begin
  inherited;

  TableName := 'schema1.table1';
end;

procedure TForm1.ProviderBeforeUpdate(Sender: TObject; SourceDS: TDataSet;
  DeltaDS: TCustomClientDataSet; UpdateKind: TUpdateKind; var Applied: Boolean);
begin
  SetLength(DataF, Length(MasterColumns));
  Move(MasterColumns[0], DataF[0], SizeOf(MasterColumns));

  inherited;
end;

procedure TForm1.DetailProviderGetTable(Sender: TObject; DataSet: TDataSet; var TableName: string);
begin
  inherited;

  TableName := 'schema1.table4';
end;

procedure TForm1.DetailProviderBeforeUpdate(Sender: TObject; SourceDS: TDataSet;
  DeltaDS: TCustomClientDataSet; UpdateKind: TUpdateKind; var Applied: Boolean);
begin
  SetLength(DataF, Length(DetailColumns));
  Move(DetailColumns[0], DataF[0], SizeOf(DetailColumns));

  inherited;
end;

procedure TForm1.ReportClick(Sender: TObject);
begin
  inherited;
end;

procedure TForm1.ReportDblClick(Sender: TObject);
begin
  inherited;

  GetReportAction(Actions, ReportList.Items[ReportList.ItemIndex]).Execute;
end;

procedure TForm1.Action1Execute(Sender: TObject);
begin
  GetUserRights(Ord(UserPrivReports));
end;

procedure TForm1.Action2Execute(Sender: TObject);
var
  Report: TReportClass2;
begin
  inherited;

  Report := TReportClass2.create(Self, ['Field2', 'Field1'], [MastDataset['Field2'], MastDataset['Field1']]);
  Report.GenerateReport();
  FreeAndNil(Report);
end;

procedure TForm1.Action3Execute(Sender: TObject);
var
  I: Integer;
  ScrollEvents: TScrollEvents;
  Bookmark: TBookmark;
  Report: TReportClass3;
begin
  inherited;

  if not DetDataset.Active then
  begin
    BtnDetailClick(Sender);
    Application.ProcessMessages;
  end;

  Report := nil;
  try
    Screen.Cursor := crSQLWait;

    try
      Bookmark := DetailGrid.DataSource.DataSet.Bookmark;
      DisableDependencies(DetailGrid.DataSource.DataSet, ScrollEvents);

      ListToPrint.Clear;
      DetailGrid.DataSource.DataSet.First;

      while not DetailGrid.DataSource.DataSet.Eof do
      begin
        ListToPrint.Add(DetailGrid.DataSource.DataSet.FieldByName('ItemID').AsString);
        DetailGrid.DataSource.DataSet.Next;
      end;

    finally
      if Assigned(ScrollEvents) then
      begin
        EnableDependencies(DetailGrid.DataSource.DataSet, ScrollEvents);
        FreeAndNil(ScrollEvents);
      end;

      if DetailGrid.DataSource.DataSet.BookmarkValid(Bookmark) then
        DetailGrid.DataSource.DataSet.Bookmark := Bookmark;
    end;

    if ListToPrint.Count > 0 then
    begin
      Report := TReportClass3.create(Self, ['Field2'], [ContractValue.Contract]);
      Report.ListID := ListToPrint;

      Report.SaveReport;
    end
    else
      MessageDlg('No drawings to print!', mtInformation, [mbOk], 0);

    Screen.Cursor := crDefault;

  finally
    if Assigned(Report) then
      FreeAndNil(Report);
  end;
end;

procedure TForm1.Action4Execute(Sender: TObject);
var
  Report: TReportClass4;
  Draft, Fill: string;
begin
  inherited;

  if (MastDataset[ClosedField] = 'C') or (MastDataset[ClosedField] = 'P') then
    Draft := '0'
  else
    Draft := '1';

  if RadioButton2.Checked then
    Fill := 'Y'
  else
    Fill := 'N';

  Report := TReportClass4.create(Self,
                                     ['Field2', 'ID', 'Field28', 'Val5', 'Val6'],
                                     [MastDataset['Field2'], MastDataset['ID'], MastDataset['Date1'], Draft, Fill]);
  Report.GenerateReport();
  FreeAndNil(Report);
end;

procedure TForm1.Action5Execute(Sender: TObject);
var
  Report: TReportClass5;
begin
  Report := TReportClass5.Create(Self, ['Field2', 'Col1', 'Col2'], [ContractValue.Contract, 'N', IntToStr(SecID)]);
  Report.GenerateReport();
  FreeAndNil(Report);
end;

procedure TForm1.Action6Execute(Sender: TObject);
var
  Report: TReportClass6;
begin
  Report := TReportClass6.Create(Self, ['Field2', 'Col1', 'Col2', 'Col3'], [ContractValue.Contract, 'N', IntToStr(SecID), 'Val7']);
  Report.GenerateReport();
  FreeAndNil(Report);
end;

procedure TForm1.Action7Execute(Sender: TObject);
var
  Report: TReportClass7;
begin
  Report := TReportClass7.Create(Self, ['Field2', 'Col1', 'Col2', 'Col3'], [ContractValue.Contract, 'N', IntToStr(SecID), 'Val8']);
  Report.GenerateReport();
  FreeAndNil(Report);
end;

procedure TForm1.Action8Execute(Sender: TObject);
var
  Report: TReportClass8;
begin
  Report := TReportClass8.Create(Self, ['Field2', 'Col1', 'Col2', 'Col4'], [ContractValue.Contract, 'N', IntToStr(SecID), '1']);
  Report.GenerateReport();
  FreeAndNil(Report);
end;

procedure TForm1.DetailCellClick(Column: TColumn);
begin
  inherited;

  SetButtonsState;
end;

end.
