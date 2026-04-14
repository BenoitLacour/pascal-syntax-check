unit Unit3;

interface

uses
  Classes, DB, SqlExpr, Variants, SysUtils, UnitCommon;

type

  TDataAccess3 = class
  private
    F1: string;
    F2: string;
    F3: string;
    F4: string;
    F5: string;

    function Q1(const Param1:string): string;
    function Q2: string;
    function Q3: string;
    function Q4: string;
    function Q5: string;
    function Q6: string;
    function Q7(const field1: string): string;
    function Q8: string;

  public
    procedure S1(const Value: string);
    procedure S2(const Value: string);
    procedure S3(const Value: string);
    procedure S4(const Value: string);
    procedure S5(const Value: string);

    function B1(const Param1:string): string;
    function B2: string;
    function B3: string;
    function B4: string;
    function B5(const field1: string): string;

    function E1(): string;
    function E2(const type1: string; dir1: string; flag1: Boolean): string;
    function E3(const field1, field2: string; dir1: string; flag1: Boolean): string;
    function E4(const type1: string; field2: string): string;
    function E5(const field2: string): string;

    function R1(const field2, field1: string): string;
    function R2(const type1: string; dir1: string): string;
    function R3(const field2, field1: string): string;

    function U1(): string;
    function U2(): string;
    function U3(): string;
  end;

implementation

uses
  UnitConst;

procedure TDataAccess3.S1(const Value: string);
begin
  F1 := Value;
end;

procedure TDataAccess3.S2(const Value: string);
begin
  F2 := Value;
end;

procedure TDataAccess3.S3(const Value: string);
begin
  F3 := Value;
end;

procedure TDataAccess3.S4(const Value: string);
begin
  F4 := Value;
end;

procedure TDataAccess3.S5(const Value: string);
begin
  F5 := Value;
end;

function TDataAccess3.Q1(const Param1:string): string;
begin
  Result := Format('SELECT col1, col2 FROM table1 ' +
             'WHERE field1 = :P1 ' +
             'AND field2 = :P2 ' +
             'AND field3 = :P3 ' +
             'AND field4 = :P4 ' +
             'AND field5 = :P5 ' +
             'AND field6 = :P6 ' +
             'AND field7 = :P7 ' +
             'AND field8 = :P8 ' +
             'AND field9 = :P9 ' +
             'AND field10 = :P10',
             [Param1]);
end;

function TDataAccess3.Q2: string;
var
  S1: string;
begin
  if (F1 = 'Type1') then
  begin
    S1 := 'SELECT col1, col2, col3 FROM t1 ' +
      'LEFT JOIN t2 ON t1.id = t2.ref_id ' +
      'LEFT JOIN t3 ON t2.id = t3.ref_id';

    Result := S1 +
     ' WHERE t1.field1 = :P1' +
      ' AND t1.field2 = :P2' +
      ' AND t1.field3 = :P3';

    Result := Result + ' UNION (SELECT * FROM (' + S1;

    Result := Result +
     ' FROM t1_hist ' +
     ' WHERE field1 = :P1' +
      ' AND field2 = :P2' +
      ' AND field3 = :P3' +
      ' AND NOT EXISTS (SELECT id FROM t1 WHERE id = a.id)' +
     ' ORDER BY field4 DESC) x' +
     ' GROUP BY id)';
  end
  else if (F1 = 'Type2') then
  begin
    S1 := 'SELECT col1, col2 FROM t1 ' +
      'LEFT JOIN t2 ON t1.id = t2.ref_id';

    Result := S1 +
      ' WHERE t1.field1 = :P1' +
        ' AND t1.field2 = :P2' +
        ' AND t1.field3 = :P3';

    Result := Result + ' UNION (SELECT * FROM (' + S1;

    Result := Result +
     ' FROM t1_hist ' +
     ' WHERE field1 = :P1' +
      ' AND field2 = :P2' +
      ' AND field3 = :P3' +
      ' AND NOT EXISTS (SELECT id FROM t1 WHERE id = a.id)' +
     ' ORDER BY field4 DESC) x' +
     ' GROUP BY id)';
  end
  else
    Result := '';
end;

function TDataAccess3.Q3: string;
var
  S1: string;
begin
  if (F1 = 'Type3') then
  begin
    S1 := Format('SELECT col1, col2, col3 FROM t1 ' +
      'LEFT JOIN t2 ON t1.id = t2.ref_id ' +
      'LEFT JOIN t3 ON t2.id = t3.ref_id',
      [F1 + F2]);

    Result := S1 +
      ' WHERE t1.field1 = :P1' +
        ' AND t1.field2 = :P2' +
        ' AND t1.field3 = :P3';

    Result := Result + ' UNION (SELECT * FROM (' + S1;

    Result := Result +
      Format(' FROM t1_hist ' +
             ' WHERE field1 = :P1' +
              ' AND field2 = :P2' +
              ' AND field3 = :P3' +
              ' AND NOT EXISTS (SELECT id FROM t1 WHERE id = a.id)' +
             ' ORDER BY field4 DESC) x' +
             ' GROUP BY id)',
              [F5,
               F5]);
  end
  else
    Result := '';
end;

function TDataAccess3.Q4: string;
var
  S1: string;
begin
  S1 := Format('SELECT col1, col2, col3 FROM t1 ' +
    'LEFT JOIN t2 ON t1.id = t2.ref_id',
    [F1 + F2]);

  Result := S1 +
    Format(' FROM t1 ' +
           ' WHERE t1.field1 = :P1' +
            ' AND t1.field2 = :P2',
           [F5]);

  Result := Result + ' UNION (SELECT * FROM (' + S1;

  Result := Result +
    Format(' FROM t1_hist ' +
           ' WHERE field1 = :P1' +
            ' AND field2 = :P2' +
            ' AND NOT EXISTS (SELECT id FROM t1 WHERE id = a.id)' +
           ' ORDER BY field3 DESC) x' +
           ' GROUP BY id)',
            [F5,
             F5,
             F5]);
end;

function TDataAccess3.Q5: string;
begin
  Result := Format('SELECT col1, col2, col3, col4, col5 FROM t1 ' +
                  'LEFT JOIN t2 ON t2.id = t1.ref_id ' +
                  'LEFT JOIN t3 ON t3.id = t1.ref_id ' +
                  'WHERE t2.field1 = :P1' +
                    ' AND t1.field2 = :P2' +
                    ' AND (ISNULL(t1.stat) OR (t1.stat <> ''D''))' +
                    ' AND (ISNULL(t1.field3) OR (t1.field3 = ''NA''))'
                  , ['b.' + F5,
                     'b.' + F5]);

  if (F1 = 'Type3') then
    Result := Result + ' AND t3.field4 = ''Y'''
  else
  begin
    Result := Result + ' AND t1.field5 = ''F''' +
                    ' AND t3.field6 = ''BUY''';
  end;

  Result := Result +
                  ' GROUP BY t1.ref_id, t1.id, t1.ref_id2, t1.qty, t1.field7, t1.field5,' +
                    ' t3.field8, t3.field9, t3.field10, t3.field11,' +
                    ' t1.field12, t1.field13, t1.field14, t1.field15' +
                  ' ORDER BY ref_id, t3.field8, t3.field9, t3.field10';
end;

function TDataAccess3.Q6: string;
begin
  Result := 'SELECT col1, col2, col3, col4, col5, col6 FROM t4 ' +
                  'LEFT JOIN t1 ON t1.id = t4.ref_id ' +
                  ' WHERE t1.field1 = :P1' +
                   ' AND t1.field2 = :P2' +
                   ' AND (ISNULL(t1.field3) OR (t1.field3 = ''Y''))' +
                   ' AND (ISNULL(t4.stat) OR (t4.stat <> ''C''))' +
                  ' ORDER BY t4.ref_id, t4.field4';
end;

function TDataAccess3.Q7(const field1: string): string;
begin
  Result := 'SELECT col1, col2, col3, col4, col5, col6 FROM t1 ' +

                ' (SELECT MIN(col1) FROM t2 LEFT JOIN t3 ON ... ' +
                 ' WHERE ... ORDER BY ...)' +

                ' proc1(a.field1, a.field2, 1) AS zone1,' +
                ' proc1(a.field1, a.field2, 2) AS zone2,' +
                ' proc1(a.field1, a.field2, 3) AS zone3,' +
                ' proc1(a.field1, a.field2, 4) AS zone4,' +

                ' a.id' +

               ' FROM t1 a' +

               ' WHERE a.field1 = ' + QuotedStr(field1);

  if (F1 = 'Type4') then
    Result := Result +
                ' AND a.field2 = ''Y'''
  else
  if (F1 = 'Type2') then
    Result := Result +
                ' AND a.field3 = ''Y''' +
                ' AND ISNULL(a.field4)' +
                ' AND ISNULL(a.field5)'
  else
  if (F1 = 'Type5') then
    Result := Result +
                ' AND a.field3 = ''Y''' +
                ' AND ISNULL(a.field4)' +
                ' AND ISNULL(a.field5)' +
                ' AND ISNULL(a.field6)'
  else
  if (F1 = 'Type3') then
    Result := Result +
                ' AND a.field2 = ''Y''' +
                ' AND ISNULL(a.field7)' +
                ' AND ISNULL(a.field8)' +
                ' AND proc2(a.id) = ''Y'''
  else
    Result := Result +
     Format(' AND a.field3 = ''Y''' +
            ' AND ISNULL(a.%S)',
           [F5]);

  if (F1 = 'Type1') then
    Result := Result + ' AND NOT ISNULL(a.field9)';

  Result := Result +
                ' AND ((a.field10 = ''Y'') OR ISNULL(a.field10))' +
               ' ORDER BY a.field11, a.field12, a.field13, a.field14;';
end;

function TDataAccess3.Q8: string;
begin
  Result := '';

  if (F1 = 'Type2') then
  begin
    Result := Format('SELECT col1, col2, col3 FROM t1 ' +
                    ' WHERE field1 = :P1',
                   [F1 + F2]);

    Result := Result +
           (' FROM t1 a' +
            ' INNER JOIN t2 w ON ... ' +
            ' WHERE a.field1 = :P1' +
              ' AND a.field2 = :P2' +
              ' AND a.field3 = :P3' +
              ' AND ISNULL(a.field4)' +
              ' AND ISNULL(a.field5)' +
              ' AND ((a.field6 = ''Y'') OR ISNULL(a.field6))' +
            ' ORDER BY a.field7, a.field8, a.field9, a.field10;');
  end
  else
  if (F1 = 'Type5') then
  begin
    Result := Format('SELECT col1, col2, col3 FROM t1 ' +
                    ' WHERE field1 = :P1',
                   [F1 + F2]);

    Result := Result +
           (' FROM t1 a' +
            ' INNER JOIN t2 w ON ... ' +
            ' WHERE a.field1 = :P1' +
              ' AND a.field2 = :P2' +
              ' AND a.field3 = :P3' +
              ' AND a.field4 = :P4' +
              ' AND ISNULL(a.field5)' +
              ' AND ISNULL(a.field6)' +
              ' AND ISNULL(a.field7)' +
              ' AND ((a.field8 = ''Y'') OR ISNULL(a.field8))' +
            ' ORDER BY a.field9, a.field10, a.field11, a.field12;');
  end
  else
  begin
    Result := Format('SELECT col1, col2, col3 FROM t1 ' +
                    ' WHERE field1 = :P1',
                   [F1 + F2]);

    Result := Result +
      Format(' FROM t1 a' +
            ' INNER JOIN t2 w ON ... ' +
            ' WHERE a.field1 = :P1' +
              ' AND a.field2 = :P2' +
              ' AND ISNULL(a.field3)' +
              ' AND ((a.field4 = ''Y'') OR ISNULL(a.field4))' +
            ' ORDER BY a.field5, a.field6, a.field7, a.field8;',
             [F2,
              'WoOut' + F2,
              'WoOut' + F2,
              F5]);
  end;
end;

function TDataAccess3.B1(const Param1:string): string;
begin
  Result := Q1(Param1) +
            Format(' FROM t1 ' +
            ' LEFT JOIN t2 ON ... ' +
            ' LEFT JOIN t3 ON ... ' +
            ' LEFT JOIN table_d ON ... ' +
            ' WHERE t1.field1 = :P1' +
              ' AND t1.field2 = "%S"' +
            ' ORDER BY t1.field3, t1.field2;',[F1]);
end;

function TDataAccess3.B2: string;
begin
  if (F1 = 'Type5') or (F1 = 'Type2') then
    Result := Q2
  else if (F1 = 'Type3') then
    Result := Q3
  else
    Result := Q4;

  if Result <> '' then
    Result := Result +
              ' ORDER BY field1, field2';
end;

function TDataAccess3.B3: string;
begin
  Result := Q5;
end;

function TDataAccess3.B4: string;
begin
  Result := Q6;
end;

function TDataAccess3.B5(const field1: string): string;
begin
  if UpperCase(F3) = 'OUT' then
    Result := Q7(field1)
  else
    Result := Q8;
end;

function TDataAccess3.E1(): string;
begin
  Result := 'CALL proc_tag(:P1, :P2, :P3, :P4, NULL);';
end;

function TDataAccess3.E2(const type1: string; dir1: string; flag1: Boolean): string;
begin
  if flag1 then
  begin
    if (type1 = 'Type2') then
    begin
      Result := 'UPDATE t1 ' +
                 ' SET field1 = :P1, field2 = :P1, field3 = :P2, field4 = :P2, ' +
                  ' field5 = field3, field6 = :P3' +
                 ' WHERE id = :P4' +
                   ' AND ISNULL(field1)' +
                   ' AND ISNULL(field2)';
    end
    else
    begin
      Result := 'UPDATE t1 ' +
                 ' SET field1 = :P1, field2 = :P1, field7 = :P1, field3 = :P2, field4 = :P2, ' +
                  ' field8 = :P2, field5 = field8, field6 = :P3' +
                 ' WHERE id = :P4' +
                   ' AND ISNULL(field1)' +
                   ' AND ISNULL(field2)' +
                   ' AND ISNULL(field7)';
    end;
  end
  else
  begin
    if (type1 = 'Type2') then
    begin
      Result := 'UPDATE t1 ' +
                 ' SET field9 = :P1, field10 = :P1, field3 = :P2, field4 = :P2, ' +
                  ' field5 = field4, field6 = :P3' +
                 ' WHERE id = :P4' +
                   ' AND ISNULL(field9)' +
                   ' AND ISNULL(field10)';
    end
    else
    begin
      Result := 'UPDATE t1 ' +
                 ' SET field9 = :P1, field10 = :P1, field7 = :P1, field3 = :P2, field4 = :P2, ' +
                  ' field11 = :P2, field5 = field11, field6 = :P3' +
                 ' WHERE id = :P4' +
                   ' AND ISNULL(field9)' +
                   ' AND ISNULL(field10)' +
                   ' AND ISNULL(field7)';
    end;
  end;
end;

function TDataAccess3.E3(const field1, field2: string; dir1: string; flag1: Boolean): string;
begin
  if flag1 then
  begin
    Result := Format('UPDATE t1 ' +
                     ' SET %S = :P1, %S = :P2, field5 = :P3, field6 = :P1' +
                     ' WHERE id = :P4' +
                       ' AND %S IS NULL',
                     [field1, field2, field1]);
  end
  else
  begin
    Result := Format('UPDATE t1 ' +
                     ' SET %S = :P1, %S = :P2, field5 = :P3, field6 = :P1' +
                     ' WHERE id = :P4' +
                       ' AND %S IS NULL',
                     [field1, field2, field1]);
  end;
end;

function TDataAccess3.E4(const type1: string; field2: string): string;
begin
  if (type1 = 'Type2') then
    Result := Format('UPDATE t1 ' +
      ' SET %S = :P1, field1 = field3' +
      ' WHERE id = :P2',
      [field2])
  else if (type1 = 'Type5') then
    Result := Format('UPDATE t1 ' +
      ' SET %S = :P1, field1 = field3, field2 = field3' +
      ' WHERE id = :P2',
      [field2])
  else
    Result := '';
end;

function TDataAccess3.E5(const field2: string): string;
begin
  Result := Format('UPDATE t1 ' +
    ' SET %S = :P1' +
    ' WHERE id = :P2',
    [field2]);
end;

function TDataAccess3.R1(const field2, field1: string): string;
begin
  Result := Format('UPDATE t1 ' +
    ' SET %S = NULL, %S = NULL' + ' WHERE id = :P1',
    [field2, F3 + F2]);
end;

function TDataAccess3.R2(const type1: string; dir1: string): string;
begin
  if (type1 = 'Type2') then
    Result := 'UPDATE t1 ' +
      ' SET field1 = NULL, field2 = NULL' +
      ' WHERE id = :P1'
  else if (type1 = 'Type5') then
    Result := 'UPDATE t1 ' +
      ' SET field1 = NULL, field2 = NULL, field7 = NULL' +
      ' WHERE id = :P1'
  else
    Result := '';
end;

function TDataAccess3.R3(const field2, field1: string): string;
begin
  Result := Format('UPDATE t1 ' +
    ' SET %S = NULL, %S = NULL' + ' WHERE id = :P1',
    [field2, F3 + F2]);
end;

function TDataAccess3.U1(): string;
begin
  Result := 'UPDATE t1 ' +
            ' SET field1 = ''N'', field2 = NULL' +
            ' WHERE id = :P1';
end;

function TDataAccess3.U2(): string;
begin
  Result := 'CALL proc_cancel(''MATERIAL'', :P1, :P2, :P3)';
end;

function TDataAccess3.U3(): string;
begin
  Result := 'SELECT status FROM table_status' +
            ' WHERE field1 = :P1' +
             ' AND (field2 = ' + IntToStr(123) + ')';
end;

end.
