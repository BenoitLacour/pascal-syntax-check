# AGENTS.md

## Overview

A zero-dependency Rust CLI tool that validates Pascal/Delphi source file syntax.
Recursive descent parser, single-file input, exits 0 (valid) or 1 (error).

## Build / Run

```bash
source "$HOME/.cargo/env"   # required if cargo not on PATH

# Debug build
cargo build

# Release build (faster for large files)
cargo build --release

# Run against a file
cargo run -- Examples/valid/Unit1.pas
cargo run --release -- Examples/valid/Unit1.pas

# Or use pre-built binary directly
target/release/pascal-check Examples/valid/Unit1.pas
```

No external dependencies. Rust edition 2024.

## Lint / Format

```bash
cargo clippy
cargo fmt
```

## Tests

Integration tests live in `tests/integration.rs`. They run the binary against
`Examples/valid/` (must exit 0) and `Examples/invalid/` (must exit 1).

```bash
# Run all tests
cargo test

# Run a single test by name
cargo test all_valid_files_pass
cargo test missing_file_exits_2

# Run tests in release mode (faster)
cargo test --release
```

## Source Layout

```
src/
  main.rs          Entry point, CLI arg parsing, wiring
  token.rs         TokenKind enum, Token struct, keyword_or_ident()
  lexer.rs         Lexer struct, tokenize() -- source -> Vec<Token>
  parser.rs        Parser struct, recursive descent grammar (~1400 lines)
  diagnostics.rs   Diagnostics struct, error collection and formatted report()
tests/
  integration.rs   Integration tests against Examples/
```

Data flows: `main.rs` -> `Lexer::tokenize()` -> `Parser::parse()` -> `Diagnostics::report()`.

## Code Style

### Naming Conventions

- **Types**: `PascalCase` -- `TokenKind`, `Diagnostics`, `Lexer`
- **Functions/methods**: `snake_case` -- `parse_const_decl`, `peek`, `advance`
- **Constants/enums**: `PascalCase` for variants, no `SCREAMING_CASE`
- **Variables**: `snake_case` -- `is_class`, `start_line`

### Imports

Use `crate::` paths (no `use super::`):

```rust
use crate::diagnostics::Diagnostics;
use crate::token::{Token, TokenKind, keyword_or_ident};
```

Standard library imports (`std::fmt`, `std::env`, etc.) at the top.

### Error Handling

- Errors collected in `Diagnostics` struct, never panicking: `self.diagnostics.error(line, col, format!("..."));`
- Never use `?` with `Result` (explicit error handling only)
- Parser recovers from errors to continue parsing
- Exit codes: 0 = valid, 1 = errors, 2 = file not found/invalid usage

### Formatting Conventions

No `rustfmt.toml` or `.rustfmt.toml` exists. Default `rustfmt` formatting applies. Key observed conventions:

- Opening braces on same line as declaration
- Short match arms on one line: `self.advance(); tokens.push(Token::new(...));`
- Struct field initialization on one line when short
- No trailing commas in small tuples (observed: `Self { x, y, z }`)

### Sections

Large files use comment headers to delineate logical groups:

```rust
// ============================================================
// SECTION NAME
// ============================================================
```

### General Rules

- Keep `Cargo.toml` dependency-free (zero deps)
- No doc comments on functions (code is self-documenting via descriptive names)
- `#[allow(dead_code)]` is used for public API items that are not yet consumed internally
- Parser methods own the recursion; lexer is a simple flat loop
- Token kinds that also appear as variable/field names (e.g., `Read`, `Write`, `Name`, `Index`) must remain as `Identifier` tokens and be matched by text in the parser -- do not convert them to dedicated `TokenKind` variants

### Lifetime Annotations

When a struct holds a reference, use explicit lifetime parameters:

```rust
pub struct Lexer<'a> {
    src: &'a [u8],
    diagnostics: &'a mut Diagnostics,
}
```

### Method Patterns

- Use `&mut self` for methods that mutate internal state (lexer, parser)
- Use `&self` for read-only access
- Avoid consuming `self` unless the type is intentionally one-shot

### Struct Initialization

Follow patterns observed in the codebase:

```rust
// Short: one line
Self { kind, text, line, col }

// Longer: multi-line with trailing comma
Self {
    src: src.as_bytes(),
    pos: 0,
    line: 1,
    col: 1,
    diagnostics,
}
```
