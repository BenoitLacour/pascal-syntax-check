# pascal-check
**✨ 100% Vibe Coded ✨**

A fast Pascal/Delphi syntax checker written in Rust. Validates `.pas` files for syntactic correctness without requiring a Delphi or Free Pascal compiler.

## Features

- **Zero dependencies** — single binary, no runtime requirements
- **Fast** — lexes and parses files in milliseconds
- **Accurate errors** — reports `file(line,col) : error: message` format matching Delphi compiler output
- **CI-friendly** — exit code `0` for valid files, `1` for errors
- **Consistency checks** — verifies interface declarations have matching implementations and vice versa
- **Error recovery** — parses through multiple errors in a single pass
- **Generics** — supports generic type declarations (`TList<Integer>`, `TDictionary<string, T>`)

## Supported Syntax

### Declarations

- `program`, `unit`, `library` declarations
- `interface` / `implementation` / `initialization` / `finalization` sections
- `uses` clauses (including qualified names like `System.SysUtils`)
- `const`, `type`, `var`, `threadvar` declarations
- Typed constants with record and array initializers
- `procedure`, `function`, `constructor`, `destructor` declarations and implementations
- Class, record, object, interface, and helper type declarations
- Generic type declarations (`T<T>`, `T<K, V>`)
- Class forward declarations with ancestors
- Visibility sections (`private`, `protected`, `public`, `published`, `strict`)
- Properties with `read`, `write`, `index`, `default`, `stored`, `implements`
- Class methods (`class procedure`, `class function`, `class var`)
- Method directives (`virtual`, `override`, `overload`, `abstract`, `dynamic`, `static`, `inline`, `reintroduce`)
- Calling conventions (`cdecl`, `stdcall`, `register`, `pascal`, `safecall`)
- `Label` declarations and `goto` statements
- Operator precedence in expressions (correct handling of `*`, `/`, `div`, `mod` vs `+`, `-`)

### Statements & Expressions

- Control flow: `if/then/else`, `case/of`, `for/to/downto/do`, `while/do`, `repeat/until`, `with/do`
- `try/except/finally`, `raise`, `on...do` exception handling
- `inherited` calls
- Inline assembly (`asm...end`)
- Chained method calls and property access (`Foo.Bar('X').Baz[0] := Value`)
- Set types and set literals (`[a, b, c]`, `[low..high]`)
- Pointer types (`^Type`) and dereferencing (`ptr^`)
- Array types (`array[low..high] of Type`, `array of Type`)
- Enumerated types
- Procedural types (including `of object`)
- String literals with `#character_codes` and adjacent string concatenation (`'hello' 'world'`)

### Other

- Compiler directives (`{$REGION}`, `{$R}`, `{$IFDEF}`, `{$MESSAGE}`, etc.) — recognized and skipped
- Comments: `//`, `{ }`, `(* *)`
- Hex literals (`$FF`), character codes (`#13#10`), real numbers with exponent
- Interface/implementation consistency — every `procedure`/`function` declared in a class must have a matching implementation, and vice versa

## Installation

### From source

```bash
git clone https://github.com/youruser/pascal-check.git
cd pascal-check
cargo build --release
```

The binary will be at `target/release/pascal-check`.

## Usage

```
pascal-check <file.pas>
```

### Exit codes

| Code | Meaning |
|------|---------|
| `0`  | File is syntactically valid |
| `1`  | Syntax errors found |
| `2`  | Could not read file or no arguments provided |

### Example

```bash
$ pascal-check MyApp.pas
# no output — file is valid

$ pascal-check Broken.pas
Broken.pas(42,15) : error: expected ';', found 'end'
Broken.pas(88,3)  : error: expected 'end' for type declaration, found 'implementation'
2 error(s) found.
```

### Using in scripts

```bash
# Check all Pascal files in a directory
find src -name '*.pas' -exec pascal-check {} \;

# Fail CI if any file has errors
pascal-check src/*.pas || exit 1
```

## Project Structure

```
src/
├── main.rs           CLI entry point
├── token.rs          Token type definitions and keyword mapping
├── lexer.rs          Tokenizer (comments, strings, numbers, operators)
├── parser.rs         Recursive descent parser for Pascal grammar
└── diagnostics.rs    Error collection and formatted output
tests/
└── integration.rs    Integration tests against Examples/
```

## Tests

Run all tests:

```bash
cargo test
```

The integration test suite (`tests/integration.rs`) validates:

- All `.pas` files in `Examples/valid/` parse without errors (exit code 0)
- All `.pas` files in `Examples/invalid/` produce errors (exit code 1)
- Invalid files produce stderr output
- Missing file and no-argument cases exit with code 2

Test files in `Examples/` are anonymized and contain no proprietary content.

## How It Works

1. **Lexer** — reads the source file character by character, producing a stream of tokens. Handles all comment styles, string literals (including adjacent string concatenation like `'hello' 'world'`), character codes (`#13`), hex literals (`$FF`), and compiler directives (`{$REGION 'name'}`).

2. **Parser** — a hand-written recursive descent parser that consumes the token stream and validates it against the Pascal grammar. Uses predictive parsing (one token lookahead) with error recovery to report multiple errors in a single pass.

3. **Diagnostics** — collects errors with line and column positions, then formats them for output.

## Error Output Format

Errors follow the same format as the Delphi compiler:

```
filename(line,col) : error: description
```

This format is recognized by most editors and CI tools for clickable error navigation.

## Limitations

- **No type checking** — validates syntax only, does not check type compatibility or resolve symbols
- **No macro expansion** — compiler directives are recognized but not processed (e.g., `{$IFDEF}` blocks are not conditionally evaluated)
- **Partial asm support** — `asm...end` blocks are recognized but assembly instructions are not validated
- **Single file only** — does not resolve `uses` dependencies across files

## License

MIT
