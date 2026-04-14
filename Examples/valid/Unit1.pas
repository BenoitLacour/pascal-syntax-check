unit Unit1;

interface
  type
  THelper1 = class
  public
    class function Check1(Param1: string):boolean;
    class function Check2(Param1: string):boolean;
  end;

implementation

{ THelper1 }

class function THelper1.Check2(
  Param1: string): boolean;
begin
  Result := Pos('Value1', Param1) > 0;
end;

class function THelper1.Check1(Param1: string): boolean;
begin
  Result := False;

  if (Param1 = 'Value2') or (Param1 = 'Value3') then
    Result := True
  else if THelper1.Check2(Param1) then
    Result := True;
end;

end.
