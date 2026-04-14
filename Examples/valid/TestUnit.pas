unit TestUnit;

interface
uses
  TestFramework,
  SysUtils;

type
  [TestFixture]
  TMyTestClass = class(TObject)
  private
    FValue: Integer;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    [TestCase('Basic', '1,2')]
    [TestCase('Zero', '0,0')]
    procedure TestAdd(A, B: Integer);

    [Test]
    [Ignore]
    procedure TestIgnored;

    [Test]
    [Slow]
    procedure TestSlow;

    [Test]
    [RequiresThreads]
    procedure TestWithThreads;
  end;

implementation

procedure TMyTestClass.Setup;
begin
  FValue := 0;
end;

procedure TMyTestClass.TearDown;
begin
  FValue := 0;
end;

procedure TMyTestClass.TestAdd(A, B: Integer);
begin
  // Test implementation
end;

procedure TMyTestClass.TestIgnored;
begin
  // This test is ignored
end;

procedure TMyTestClass.TestSlow;
begin
  // Slow test
end;

procedure TMyTestClass.TestWithThreads;
begin
  // Multi-threaded test
end;

end.
