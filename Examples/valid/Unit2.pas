unit Unit2;

interface

uses
  Classes, DB, SqlExpr, Variants, SysUtils, UnitCommon;

type
  TQueryType = (qt1, qt2, qt3, qt4, qt5, qt6, qt7, qt8, qt9, qt10, qt11, qt12, qt13);

  TDataAccess2 = class
  private
    F1: string;
    F2: string;
    F3: string;
    F4: string;
    F5: string;
    F6: string;
    F7: string;
    F8: string;
    F9: string;
    F10: string;
    F11: string;
    F12: string;
    F13: string;
    F14: string;
    F15: string;
    F16: string;
    F17: string;
    F18: string;

    function Q1: string;
    function Q2(Show: Boolean; Filter: string): string;
    function Q3: string;
    function Q4: string;
    function Q5: string;
    function Q6: string;
    function Q7: string;
    function Q8: string;
    function Q9: string;
    function Q10: string;
    function Q11: string;
    function Q12: string;
    function Q13: string;
    procedure S18(const Value: string);
  public
    constructor Create;
    destructor Destroy; override;

    procedure S1(const Value: string);
    procedure S2(const Value: string);
    procedure S3(const Value: string);
    procedure S4(const Value: string);
    procedure S5(const Value: string);
    procedure S6(const Value: string);
    procedure S7(const Value: string);
    procedure S8(const Value: string);
    procedure S9(const Value: string);
    procedure S10(const Value: string);
    procedure S11(const Value: string);
    procedure S12(const Value: string);
    procedure S13(const Value: string);
    procedure S14(const Value: string);
    procedure S15(const Value: string);
    procedure S16(const Value: string);
    procedure S17(const Value: string);

    function B1: string;
    function B2(Show: Boolean; Filter: string): string;
    function B3: string;
    function B4: string;
    function B5: string;
    function B6: string;
    function B7: string;
    function B8: string;
    function B9: string;
    function B10: string;
    function B11: string;
    function B12: string;
    function B13: string;

    function P1: string;
    function P2: string;
    function P3: string;
    function P4: string;

    property P18: string read F18 write S18;
  end;

implementation

uses
  UnitConst;

constructor TDataAccess2.Create;
begin
  F1 := '';
  F2 := '';
  F3 := '';
  F4 := '';
  F5 := '';
  F6 := '';
  F7 := '';
  F8 := '';
  F9 := '';
  F10 := '';
  F11 := '';
  F12 := '';
  F13 := '';
  F14 := '';
  F15 := '';
  F16 := '';
  F17 := '';
  F18 := '';
end;

destructor TDataAccess2.Destroy;
begin
  inherited;
end;

procedure TDataAccess2.S1(const Value: string);
begin
  F1 := Value;
end;

procedure TDataAccess2.S2(const Value: string);
begin
  F2 := Value;
end;

procedure TDataAccess2.S3(const Value: string);
begin
  F3 := Value;
end;

procedure TDataAccess2.S4(const Value: string);
begin
  F4 := Value;
end;

procedure TDataAccess2.S5(const Value: string);
begin
  F5 := Value;
end;

procedure TDataAccess2.S6(const Value: string);
begin
  F6 := Value;
end;

procedure TDataAccess2.S7(const Value: string);
begin
  F7 := Value;
end;

procedure TDataAccess2.S8(const Value: string);
begin
  F8 := Value;
end;

procedure TDataAccess2.S9(const Value: string);
begin
  F9 := Value;
end;

procedure TDataAccess2.S10(const Value: string);
begin
  F10 := Value;
end;

procedure TDataAccess2.S11(const Value: string);
begin
  F11 := Value;
end;

procedure TDataAccess2.S12(const Value: string);
begin
  F12 := Value;
end;

procedure TDataAccess2.S13(const Value: string);
begin
  F13 := Value;
end;

procedure TDataAccess2.S14(const Value: string);
begin
  F14 := Value;
end;

procedure TDataAccess2.S15(const Value: string);
begin
  F15 := Value;
end;

procedure TDataAccess2.S16(const Value: string);
begin
  F16 := Value;
end;

procedure TDataAccess2.S17(const Value: string);
begin
  F17 := Value;
end;

procedure TDataAccess2.S18(const Value: string);
begin
  F18 := Value;
end;

function TDataAccess2.Q1: string;
begin
  Result := 'SELECT col1, col2 FROM table1 ' +
           'WHERE field1 = :P1 ' +
           'AND field2 = :P2 ' +
           'AND field3 = :P3 ' +
           'AND field4 = :P4 ' +
           'AND field5 = :P5 ' +
           'AND field6 = :P6 ' +
           'AND field7 = :P7 ' +
           'AND field8 = :P8';
end;

function TDataAccess2.Q2(Show: Boolean; Filter: string): string;
var
  S1: string;
  S2: string;
begin
  Result := 'SELECT col1, col2, col3, col4, col5, col6, col7, col8, ' +
           'col9, col10, col11, col12, col13, col14, col15, col16, ' +
           'col17, col18, col19, col20, col21, col22, col23, col24, ' +
           'col25, col26, col27, col28, col29, col30, col31, col32, ' +
           'col33, col34, col35, col36, col37, col38, col39, col40, ' +
           'col41, col42, col43, col44, col45, col46, col47, col48, ' +
           'col49, col50, col51, col52, col53, col54, col55, col56, ' +
           'col57, col58, col59, col60, col61, col62, col63, col64, ' +
           'col65, col66, col67, col68, col69, col70, col71, col72 ' +
           'FROM table1 t ' +
           'LEFT JOIN table2 t2 ON t.id = t2.ref_id ' +
           'LEFT JOIN table3 t3 ON t.id = t3.ref_id ' +
           'LEFT JOIN table4 t4 ON t.spec_id = t4.spec_id ' +
           'LEFT JOIN table5 t5 ON t4.code_id = t5.code_id ' +
           'LEFT JOIN table6 t6 ON t.hold_code = t6.code';

  Result := Result + ' WHERE t.field1 = :P1';

  if not Show then
    Result := Result + ' AND ((t.field2 = ''Y'') OR ISNULL(t.field2))';

  if Filter <> '' then
    Result := Result + ' AND t.field3 LIKE ''%' + Filter + '%''';
end;

function TDataAccess2.Q3: string;
begin
  Result := 'SELECT col1, col2 FROM table_a ' +
           'LEFT JOIN table_b ON table_a.id = table_b.ref_id ' +
           'LEFT JOIN table_c ON table_b.id = table_c.ref_id ' +
           'LEFT JOIN table_d ON table_c.id = table_d.ref_id ' +
           'WHERE table_a.field1 = :P1 ' +
           'ORDER BY table_a.field2';
end;

function TDataAccess2.Q4: string;
begin
  Result := 'SELECT col1, col2, col3 FROM table_weld ' +
           'WHERE field1 = :P1 ' +
           'AND field2 = :P2 ' +
           'ORDER BY field3';
end;

function TDataAccess2.Q5: string;
begin
  Result := 'SELECT col1, col2 FROM table_tag ' +
           'WHERE field1 = :P1 ' +
           'AND field2 = :P2 ' +
           'ORDER BY field3';
end;

function TDataAccess2.Q6: string;
begin
  Result := 'SELECT col1, col2 FROM table_bend ' +
           'LEFT JOIN table_iso ON table_iso.field1 = table_bend.field1 ' +
           'AND table_iso.field2 = table_bend.field2 ' +
           'WHERE table_bend.field3 = :P1 ' +
           'AND table_bend.field4 = :P2 ' +
           'ORDER BY table_bend.field5';
end;

function TDataAccess2.Q7: string;
begin
  Result := 'CALL proc1(''%S'', ''%S'')';
  Result := Format(Result, [F1, F3]);
end;

function TDataAccess2.Q8: string;
begin
  Result := 'CALL proc2(:P1)';
end;

function TDataAccess2.Q9: string;
begin
  Result := 'CALL proc3(''MATERIAL'', :P1)';
end;

function TDataAccess2.Q10: string;
begin
  Result := 'SELECT field1 FROM table_contract WHERE field2 = :P1';
end;

function TDataAccess2.Q11: string;
begin
  Result := 'CALL proc4(:P1, :P2, :P3, :P4)';
end;

function TDataAccess2.Q12: string;
begin
  Result := 'SELECT * FROM proc5(:P1, :P2, :P3)';
end;

function TDataAccess2.Q13: string;
begin
  Result := 'SELECT field1 FROM table_contract WHERE field2 = :P1';
end;

function TDataAccess2.B1: string;
begin
  Result := Q1;
end;

function TDataAccess2.B2(Show: Boolean; Filter: string): string;
begin
  Result := Q2(Show, Filter);
end;

function TDataAccess2.B3: string;
begin
  Result := Q3;
end;

function TDataAccess2.B4: string;
begin
  Result := Q4;
end;

function TDataAccess2.B5: string;
begin
  Result := Q5;
end;

function TDataAccess2.B6: string;
begin
  Result := Q6;
end;

function TDataAccess2.B7: string;
begin
  Result := Q7;
end;

function TDataAccess2.B8: string;
begin
  Result := Q8;
end;

function TDataAccess2.B9: string;
begin
  Result := Q9;
end;

function TDataAccess2.B10: string;
begin
  Result := Q10;
end;

function TDataAccess2.B11: string;
begin
  Result := Q11;
end;

function TDataAccess2.B12: string;
begin
  Result := Q12;
end;

function TDataAccess2.B13: string;
begin
  Result := Q13;
end;

function TDataAccess2.P1: string;
begin
  Result := Format('CALL proc1(''%S'', ''%S'')', [F1, F3]);
end;

function TDataAccess2.P2: string;
begin
  Result := 'CALL proc2(:P1)';
end;

function TDataAccess2.P3: string;
begin
  Result := 'CALL proc4(:P1, :P2, :P3, :P4)';
end;

function TDataAccess2.P4: string;
begin
  Result := 'CALL proc6()';
end;

end.
