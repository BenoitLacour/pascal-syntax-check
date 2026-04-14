mod diagnostics;
mod lexer;
mod parser;
mod token;

use std::env;
use std::fs;
use std::process;

fn main() {
    let args: Vec<String> = env::args().collect();

    if args.len() < 2 {
        eprintln!("Usage: pascal-check <file.pas>");
        process::exit(2);
    }

    let filename = &args[1];

    let raw_bytes = match fs::read(filename) {
        Ok(b) => b,
        Err(e) => {
            eprintln!("{}: {}", filename, e);
            process::exit(2);
        }
    };

    let source_bytes = if raw_bytes.len() >= 3
        && raw_bytes[0] == 0xEF
        && raw_bytes[1] == 0xBB
        && raw_bytes[2] == 0xBF
    {
        &raw_bytes[3..]
    } else {
        &raw_bytes[..]
    };

    let source = String::from_utf8_lossy(source_bytes).to_string();

    let mut diagnostics = diagnostics::Diagnostics::new(filename.clone());

    // Phase 1: Lexing
    let mut lexer = lexer::Lexer::new(&source, &mut diagnostics);
    let tokens = lexer.tokenize();

    // Phase 2: Parsing
    let mut parser = parser::Parser::new(&tokens, &mut diagnostics);
    parser.parse();

    // Report
    let output = diagnostics.report();
    if !output.is_empty() {
        eprint!("{}", output);
    }

    if diagnostics.has_errors() {
        process::exit(1);
    }
}
