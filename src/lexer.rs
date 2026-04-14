use crate::diagnostics::Diagnostics;
use crate::token::{Token, TokenKind, keyword_or_ident};

pub struct Lexer<'a> {
    src: &'a [u8],
    pos: usize,
    line: usize,
    col: usize,
    diagnostics: &'a mut Diagnostics,
}

impl<'a> Lexer<'a> {
    pub fn new(src: &'a str, diagnostics: &'a mut Diagnostics) -> Self {
        Self {
            src: src.as_bytes(),
            pos: 0,
            line: 1,
            col: 1,
            diagnostics,
        }
    }

    fn peek(&self) -> u8 {
        if self.pos < self.src.len() {
            self.src[self.pos]
        } else {
            0
        }
    }

    fn peek2(&self) -> u8 {
        if self.pos + 1 < self.src.len() {
            self.src[self.pos + 1]
        } else {
            0
        }
    }

    fn advance(&mut self) -> u8 {
        let ch = self.src[self.pos];
        self.pos += 1;
        if ch == b'\n' {
            self.line += 1;
            self.col = 1;
        } else {
            self.col += 1;
        }
        ch
    }

    fn skip_whitespace(&mut self) {
        while self.pos < self.src.len() {
            match self.peek() {
                b' ' | b'\t' | b'\r' | b'\n' => {
                    self.advance();
                }
                _ => break,
            }
        }
    }

    fn skip_line_comment(&mut self) {
        // Skip //
        self.advance();
        self.advance();
        while self.pos < self.src.len() && self.peek() != b'\n' {
            self.advance();
        }
    }

    fn skip_brace_comment(&mut self) {
        // Skip {
        let start_line = self.line;
        let start_col = self.col;
        self.advance();

        if self.peek() == b'$' {
            // Compiler directive {$...} - emit as a single token
            return; // Will be handled by caller
        }

        while self.pos < self.src.len() {
            if self.peek() == b'}' {
                self.advance();
                return;
            }
            self.advance();
        }
        self.diagnostics.error(
            start_line,
            start_col,
            "unterminated comment '{' without matching '}'".to_string(),
        );
    }

    fn skip_paren_star_comment(&mut self) {
        // Skip (*
        let start_line = self.line;
        let start_col = self.col;
        self.advance(); // (
        self.advance(); // *

        while self.pos < self.src.len() {
            if self.peek() == b'*' && self.peek2() == b')' {
                self.advance(); // *
                self.advance(); // )
                return;
            }
            self.advance();
        }
        self.diagnostics.error(
            start_line,
            start_col,
            "unterminated comment '(*' without matching '*)'".to_string(),
        );
    }

    fn read_compiler_directive(&mut self) -> Token {
        let line = self.line;
        let col = self.col;
        let start = self.pos;
        self.advance(); // skip $

        while self.pos < self.src.len() {
            match self.peek() {
                b'}' => {
                    let text =
                        String::from_utf8_lossy(&self.src[start - 1..self.pos + 1]).to_string();
                    self.advance(); // skip }
                    return Token::new(TokenKind::DirectiveCompiler, text, line, col);
                }
                b'\n' => {
                    break;
                }
                _ => {
                    self.advance();
                }
            }
        }

        let text = String::from_utf8_lossy(&self.src[start - 1..self.pos]).to_string();
        self.diagnostics
            .error(line, col, "unterminated compiler directive".to_string());
        Token::new(TokenKind::DirectiveCompiler, text, line, col)
    }

    fn read_string_literal(&mut self) -> Token {
        let line = self.line;
        let col = self.col;
        self.advance(); // skip opening '

        let start = self.pos;
        while self.pos < self.src.len() {
            match self.peek() {
                b'\'' => {
                    let text = String::from_utf8_lossy(&self.src[start..self.pos]).to_string();
                    self.advance(); // skip closing '
                    // Handle adjacent strings: 'hello' 'world' -> 'helloworld'
                    let mut full = text;
                    while self.pos < self.src.len() && self.peek() == 39u8 {
                        self.advance(); // skip opening '
                        let sub_start = self.pos;
                        while self.pos < self.src.len() && self.peek() != b'\'' {
                            self.advance();
                        }
                        full.push_str(&String::from_utf8_lossy(&self.src[sub_start..self.pos]));
                        if self.pos < self.src.len() {
                            self.advance(); // skip closing '
                        }
                    }
                    // Handle character codes: 'text'#13#10 should be one string
                    while self.pos < self.src.len() && self.peek() == b'#' {
                        // Consume the # followed by digits
                        self.advance(); // skip #
                        while self.pos < self.src.len() && self.peek().is_ascii_digit() {
                            self.advance();
                        }
                        // Also consume any following adjacent strings
                        while self.pos < self.src.len() && self.peek() == 39u8 {
                            self.advance(); // skip opening '
                            let sub_start = self.pos;
                            while self.pos < self.src.len() && self.peek() != b'\'' {
                                self.advance();
                            }
                            full.push_str(&String::from_utf8_lossy(&self.src[sub_start..self.pos]));
                            if self.pos < self.src.len() {
                                self.advance(); // skip closing '
                            }
                        }
                    }
                    return Token::new(TokenKind::StringLiteral, full, line, col);
                }
                b'\n' => {
                    let text = String::from_utf8_lossy(&self.src[start..self.pos]).to_string();
                    self.diagnostics
                        .error(line, col, "unterminated string literal".to_string());
                    return Token::new(TokenKind::StringLiteral, text, line, col);
                }
                _ => {
                    self.advance();
                }
            }
        }

        let text = String::from_utf8_lossy(&self.src[start..self.pos]).to_string();
        self.diagnostics
            .error(line, col, "unterminated string literal".to_string());
        Token::new(TokenKind::StringLiteral, text, line, col)
    }

    fn read_number(&mut self) -> Token {
        let line = self.line;
        let col = self.col;
        let start = self.pos;
        let mut is_float = false;

        while self.pos < self.src.len() && self.peek().is_ascii_digit() {
            self.advance();
        }

        // Check for float
        if self.pos < self.src.len() && self.peek() == b'.' && self.peek2() != b'.' {
            is_float = true;
            self.advance(); // skip .
            while self.pos < self.src.len() && self.peek().is_ascii_digit() {
                self.advance();
            }
        }

        // Scientific notation
        if self.pos < self.src.len() && (self.peek() == b'e' || self.peek() == b'E') {
            is_float = true;
            self.advance();
            if self.pos < self.src.len() && (self.peek() == b'+' || self.peek() == b'-') {
                self.advance();
            }
            while self.pos < self.src.len() && self.peek().is_ascii_digit() {
                self.advance();
            }
        }

        let text = String::from_utf8_lossy(&self.src[start..self.pos]).to_string();
        if is_float {
            Token::new(TokenKind::FloatLiteral, text, line, col)
        } else {
            Token::new(TokenKind::IntegerLiteral, text, line, col)
        }
    }

    fn read_hex_literal(&mut self) -> Token {
        let line = self.line;
        let col = self.col;
        self.advance(); // skip $
        let start = self.pos;

        while self.pos < self.src.len() && self.peek().is_ascii_hexdigit() {
            self.advance();
        }

        let text = String::from_utf8_lossy(&self.src[start..self.pos]).to_string();
        Token::new(TokenKind::HexLiteral, text, line, col)
    }

    fn read_identifier(&mut self) -> Token {
        let line = self.line;
        let col = self.col;
        let start = self.pos;

        while self.pos < self.src.len()
            && (self.peek().is_ascii_alphanumeric() || self.peek() == b'_')
        {
            self.advance();
        }

        let text = String::from_utf8_lossy(&self.src[start..self.pos]).to_string();
        let kind = keyword_or_ident(&text);
        Token::new(kind, text, line, col)
    }

    pub fn tokenize(&mut self) -> Vec<Token> {
        let mut tokens = Vec::new();

        loop {
            self.skip_whitespace();
            if self.pos >= self.src.len() {
                break;
            }

            let ch = self.peek();

            // Comments
            if ch == b'/' && self.peek2() == b'/' {
                self.skip_line_comment();
                continue;
            }

            if ch == b'(' && self.peek2() == b'*' {
                self.skip_paren_star_comment();
                continue;
            }

            if ch == b'{' {
                // Check if it's a compiler directive
                if self.pos + 1 < self.src.len() && self.src[self.pos + 1] == b'$' {
                    self.advance(); // skip {
                    let tok = self.read_compiler_directive();
                    tokens.push(tok);
                    continue;
                }
                // Otherwise it's a brace comment
                self.skip_brace_comment();
                continue;
            }

            // String literal
            if ch == b'\'' {
                tokens.push(self.read_string_literal());
                continue;
            }

            // Character code literal #number (may be consecutive like #13#10)
            if ch == b'#' {
                let line = self.line;
                let col = self.col;
                let mut full_text = String::new();

                // Consume consecutive character codes
                while self.pos < self.src.len() && self.peek() == b'#' {
                    self.advance(); // skip #
                    let num_start = self.pos;
                    while self.pos < self.src.len() && self.peek().is_ascii_digit() {
                        self.advance();
                    }
                    let code_str =
                        String::from_utf8_lossy(&self.src[num_start..self.pos]).to_string();
                    full_text.push('#');
                    full_text.push_str(&code_str);
                    // Convert to actual character for the string value
                    if !code_str.is_empty()
                        && let Ok(num) = code_str.parse::<u8>()
                    {
                        full_text.push(num as char);
                    }

                    // Also consume any adjacent strings (e.g., #13#10'text')
                    while self.pos < self.src.len() && self.peek() == 39u8 {
                        self.advance(); // skip opening '
                        let str_start = self.pos;
                        while self.pos < self.src.len() && self.peek() != b'\'' {
                            self.advance();
                        }
                        full_text
                            .push_str(&String::from_utf8_lossy(&self.src[str_start..self.pos]));
                        if self.pos < self.src.len() {
                            self.advance(); // skip closing '
                        }
                    }
                }
                tokens.push(Token::new(TokenKind::StringLiteral, full_text, line, col));
                continue;
            }

            // Hex literal $xxxx
            if ch == b'$'
                && self.pos + 1 < self.src.len()
                && self.src[self.pos + 1].is_ascii_hexdigit()
            {
                tokens.push(self.read_hex_literal());
                continue;
            }

            // Numbers
            if ch.is_ascii_digit() {
                tokens.push(self.read_number());
                continue;
            }

            // Identifiers and keywords
            if ch.is_ascii_alphabetic() || ch == b'_' {
                tokens.push(self.read_identifier());
                continue;
            }

            // Symbols
            let line = self.line;
            let col = self.col;
            match ch {
                b'+' => {
                    self.advance();
                    tokens.push(Token::new(TokenKind::Plus, "+".to_string(), line, col));
                }
                b'-' => {
                    self.advance();
                    tokens.push(Token::new(TokenKind::Minus, "-".to_string(), line, col));
                }
                b'*' => {
                    self.advance();
                    tokens.push(Token::new(TokenKind::Star, "*".to_string(), line, col));
                }
                b'/' => {
                    self.advance();
                    tokens.push(Token::new(TokenKind::Slash, "/".to_string(), line, col));
                }
                b'=' => {
                    self.advance();
                    tokens.push(Token::new(TokenKind::Equal, "=".to_string(), line, col));
                }
                b'<' => {
                    self.advance();
                    if self.peek() == b'=' {
                        self.advance();
                        tokens.push(Token::new(
                            TokenKind::LessEqual,
                            "<=".to_string(),
                            line,
                            col,
                        ));
                    } else if self.peek() == b'>' {
                        self.advance();
                        tokens.push(Token::new(TokenKind::NotEqual, "<>".to_string(), line, col));
                    } else {
                        tokens.push(Token::new(TokenKind::Less, "<".to_string(), line, col));
                    }
                }
                b'>' => {
                    self.advance();
                    if self.peek() == b'=' {
                        self.advance();
                        tokens.push(Token::new(
                            TokenKind::GreaterEqual,
                            ">=".to_string(),
                            line,
                            col,
                        ));
                    } else {
                        tokens.push(Token::new(TokenKind::Greater, ">".to_string(), line, col));
                    }
                }
                b'(' => {
                    self.advance();
                    tokens.push(Token::new(TokenKind::LeftParen, "(".to_string(), line, col));
                }
                b')' => {
                    self.advance();
                    tokens.push(Token::new(
                        TokenKind::RightParen,
                        ")".to_string(),
                        line,
                        col,
                    ));
                }
                b'[' => {
                    self.advance();
                    tokens.push(Token::new(
                        TokenKind::LeftBracket,
                        "[".to_string(),
                        line,
                        col,
                    ));
                }
                b']' => {
                    self.advance();
                    tokens.push(Token::new(
                        TokenKind::RightBracket,
                        "]".to_string(),
                        line,
                        col,
                    ));
                }
                b',' => {
                    self.advance();
                    tokens.push(Token::new(TokenKind::Comma, ",".to_string(), line, col));
                }
                b';' => {
                    self.advance();
                    tokens.push(Token::new(TokenKind::Semicolon, ";".to_string(), line, col));
                }
                b'^' => {
                    self.advance();
                    tokens.push(Token::new(TokenKind::Caret, "^".to_string(), line, col));
                }
                b'@' => {
                    self.advance();
                    tokens.push(Token::new(TokenKind::AtSign, "@".to_string(), line, col));
                }
                b':' => {
                    self.advance();
                    if self.peek() == b'=' {
                        self.advance();
                        tokens.push(Token::new(TokenKind::Assign, ":=".to_string(), line, col));
                    } else {
                        tokens.push(Token::new(TokenKind::Colon, ":".to_string(), line, col));
                    }
                }
                b'.' => {
                    self.advance();
                    if self.peek() == b'.' {
                        self.advance();
                        tokens.push(Token::new(TokenKind::DotDot, "..".to_string(), line, col));
                    } else {
                        tokens.push(Token::new(TokenKind::Dot, ".".to_string(), line, col));
                    }
                }
                _ => {
                    self.diagnostics.error(
                        line,
                        col,
                        format!("unexpected character '{}'", ch as char),
                    );
                    self.advance();
                }
            }
        }

        tokens.push(Token::new(
            TokenKind::Eof,
            String::new(),
            self.line,
            self.col,
        ));
        tokens
    }
}
