unit Unit5;

interface

uses
  Classes, DB, SqlExpr, Variants, SysUtils;

type
  TDataAccess5 = class
  private
    F1: string;
    F2: Boolean;
    F3: string;
    F4: string;
    F5: string;

    function Q1: string;

  public
    procedure S1(const Value: string);
    procedure S2(const Value: Boolean);
    procedure S3(const Value: string);
    procedure S4(const Value: string);
    procedure S5(const Value: string);

    function B1: string;
    function B2: string;
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
  end;

implementation

uses
  UnitCommon, UnitConst;

procedure TDataAccess5.S1(const Value: string);
begin
  F1 := Value;
end;

procedure TDataAccess5.S3(const Value: string);
begin
  F3 := Value;
end;

procedure TDataAccess5.S4(const Value: string);
begin
  F4 := Value;
end;

procedure TDataAccess5.S5(const Value: string);
begin
  F5 := Value;
end;

function TDataAccess5.Q1: string;
begin
  Result := 'SELECT col1, col2, col3, col4, col5, col6, col7, col8, ' +
           'col9, col10, col11, col12, col13, col14, col15, col16, ' +
           'col17, col18, col19, col20, col21, col22, col23, col24, ' +
           'col25, col26, col27, col28, col29, col30, col31, col32, ' +
           'col33, col34, col35, col36, col37, col38, col39, col40, ' +
           'col41, col42, col43, col44, col45, col46, col47, col48, ' +
           'col49, col50, col51, col52, col53, col54, col55, col56, ' +
           'col57, col58, col59, col60, col61, col62, col63, col64, ' +
           'col65, col66, col67, col68, col69, col70, col71, col72, ' +
           'col73, col74, col75, col76, col77, col78, col79, col80, ' +
           'col81, col82, col83, col84, col85, col86, col87, col88, ' +
           'col89, col90, col91, col92, col93, col94, col95, col96 ' +
           'FROM table_a ' +
           'LEFT JOIN table_b ON table_a.id = table_b.ref_id ' +
           'LEFT JOIN table_c ON table_a.id = table_c.ref_id ' +
           'LEFT JOIN table_d ON table_d.id = table_e.ref_id ' +
           'LEFT JOIN table_f ON table_f.hold_code = table_g.code ' +
           ' (SELECT MIN(col1) FROM table_h LEFT JOIN table_i ON ... ' +
            ' WHERE ... ORDER BY ...)' +
           ' (SELECT MIN(col2) FROM table_h LEFT JOIN table_i ON ... ' +
            ' WHERE ... ORDER BY ...)' +
           ' table_j.description AS status_desc,' +
           ' table_k.doc_flag AS doc_flag,' +
           ' table_a.field1, table_a.field2, table_a.field3, table_a.field4' +
           ' FROM table_a' +
           ' WHERE table_a.field5 = :P1';
end;

function TDataAccess5.F1: string;
begin
  Result := 'FROM table_a ' +
            'LEFT JOIN table_b ON ... ' +
            'LEFT JOIN table_c ON ... ' +
            'LEFT JOIN table_d ON ...';
end;

function TDataAccess5.F2: string;
begin
  Result := 'WHERE table_a.field1 = :P1';
end;

function TDataAccess5.F3: string;
begin
  Result := '';
end;

function TDataAccess5.B1: string;
begin
  Result := Q1() + F1() + F2() + F3();
end;

function TDataAccess5.B2: string;
begin
  Result := Q1();
end;

function TDataAccess5.B3: string;
begin
  Result := 'SELECT * FROM table_a LEFT JOIN table_b ON ... ' +
           'WHERE table_a.field1 = :P1 ' +
              'AND table_a.field2 = :P2 ' +
           'ORDER BY table_a.field3';
end;

function TDataAccess5.B4: string;
begin
  Result := 'SELECT a.F1, a.F2, a.F3 FROM table_a ' +
           'LEFT JOIN table_b ON table_a.id = table_b.ref_id ' +
           'WHERE table_a.field1 = :P1 ' +
              'AND table_a.field2 = :P2 ' +
           'ORDER BY table_a.field3';
end;

function TDataAccess5.B5: string;
begin
  Result := 'SELECT * FROM table_weld ' +
           'LEFT JOIN table_a ON ... ' +
           'WHERE table_a.field1 = :P1 ' +
              'AND table_a.field2 = :P2 ' +
           'ORDER BY table_a.field3, table_weld.field4';
end;

function TDataAccess5.B6: string;
begin
  Result := 'SELECT * FROM table_plate ' +
           'LEFT JOIN table_b ON ... ' +
           'LEFT JOIN table_c ON ... ' +
           'LEFT JOIN table_d ON ... ' +
           'WHERE table_a.field1 = :P1 ' +
              'AND table_a.field2 = :P2 ' +
           'ORDER BY table_a.field3, table_a.field4, table_a.field5';
end;

function TDataAccess5.B7: string;
begin
  Result := 'SELECT col1, SUM(...) AS total FROM table_a ' +
           'WHERE field1 = :P1 ' +
             'AND field2 = ''Y'' ' +
           'GROUP BY field1';
end;

function TDataAccess5.B8: string;
begin
  Result := 'SELECT col1, col2, col3, col4, col5, col6, col7, col8 ' +
           'FROM table_a ' +
           'INNER JOIN table_b ON ... ' +
           'WHERE table_a.field1 = :P1';

  if not F2 then
    Result := Result + ' AND ((table_a.field2 = ''Y'') OR ISNULL(table_a.field2))';
end;

function TDataAccess5.B9: string;
begin
  Result := 'CALL proc1(''MATERIAL'', :P1)';
end;

function TDataAccess5.B10: string;
begin
  Result := 'CALL proc2(:P1, :P2, :P3)';
end;

function TDataAccess5.B11: string;
begin
  Result := 'SELECT col1 FROM table_contract WHERE field1 = :P1';
end;

function TDataAccess5.B12: string;
begin
  Result := 'UPDATE table_a SET field1 = field1 WHERE field2 = :P1 ' +
           'AND (ISNULL(field3) OR (field3 = ''Y''))';
end;

function TDataAccess5.B13: string;
begin
  Result := 'CALL proc3(:P1, :P2, :P3)';
end;

end.
