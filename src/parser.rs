use crate::diagnostics::Diagnostics;
use crate::token::{Token, TokenKind};

pub struct Parser<'a> {
    tokens: &'a [Token],
    pos: usize,
    diagnostics: &'a mut Diagnostics,
    in_implementation: bool,
    // (class_name_uppercased, method_name_uppercased, line, col, is_abstract_or_external)
    interface_declarations: Vec<(String, String, usize, usize, bool)>,
    implementations: Vec<(String, String, usize, usize)>,
    depth_limit: usize,
}

impl<'a> Parser<'a> {
    pub fn new(tokens: &'a [Token], diagnostics: &'a mut Diagnostics) -> Self {
        Self {
            tokens,
            pos: 0,
            diagnostics,
            in_implementation: false,
            interface_declarations: Vec::new(),
            implementations: Vec::new(),
            depth_limit: 10000,
        }
    }

    fn current(&self) -> &Token {
        &self.tokens[self.pos]
    }

    fn peek(&self, offset: usize) -> &Token {
        let idx = self.pos + offset;
        if idx < self.tokens.len() {
            &self.tokens[idx]
        } else {
            &self.tokens[self.tokens.len() - 1] // Eof
        }
    }

    fn peek_method_name(&self, offset: usize) -> Option<String> {
        let tok = self.peek(offset);
        if matches!(tok.kind, TokenKind::Identifier) {
            Some(tok.text.clone())
        } else {
            None
        }
    }

    fn is(&self, kind: &TokenKind) -> bool {
        std::mem::discriminant(&self.current().kind) == std::mem::discriminant(kind)
    }

    fn is_any(&self, kinds: &[TokenKind]) -> bool {
        kinds.iter().any(|k| self.is(k))
    }

    fn advance(&mut self) -> &Token {
        let tok = &self.tokens[self.pos];
        if self.pos + 1 < self.tokens.len() {
            self.pos += 1;
        }
        tok
    }

    fn expect(&mut self, kind: &TokenKind) -> bool {
        if self.is(kind) {
            self.advance();
            true
        } else {
            let tok = self.current();
            self.diagnostics.error(
                tok.line,
                tok.col,
                format!("expected '{}', found '{}'", self.kind_name(kind), tok.text),
            );
            false
        }
    }

    fn kind_name(&self, kind: &TokenKind) -> &'static str {
        match kind {
            TokenKind::Semicolon => "';'",
            TokenKind::Colon => "':'",
            TokenKind::Comma => "','",
            TokenKind::LeftParen => "'('",
            TokenKind::RightParen => "')'",
            TokenKind::LeftBracket => "'['",
            TokenKind::RightBracket => "']'",
            TokenKind::Dot => "'.'",
            TokenKind::DotDot => "'..'",
            TokenKind::Assign => "':='",
            TokenKind::Equal => "'='",
            TokenKind::Begin => "'begin'",
            TokenKind::End => "'end'",
            TokenKind::Then => "'then'",
            TokenKind::Do => "'do'",
            TokenKind::Of => "'of'",
            TokenKind::To => "'to'",
            TokenKind::DownTo => "'downto'",
            TokenKind::Identifier => "identifier",
            _ => "token",
        }
    }

    // ============================================================
    // TOP LEVEL
    // ============================================================

    pub fn parse(&mut self) {
        // Skip compiler directives at the beginning of the file
        while self.is(&TokenKind::DirectiveCompiler) {
            self.advance();
        }

        match self.current().kind {
            TokenKind::Program => self.parse_program(),
            TokenKind::Unit => self.parse_unit(),
            TokenKind::Library => self.parse_program(), // library is similar to program
            TokenKind::Package => self.parse_program(),
            _ => {
                let tok = self.current();
                self.diagnostics.error(
                    tok.line,
                    tok.col,
                    format!(
                        "expected 'program', 'unit', or 'library', found '{}'",
                        tok.text
                    ),
                );
            }
        }
    }

    fn parse_program(&mut self) {
        self.advance(); // program/library/package
        self.expect(&TokenKind::Identifier);

        // Optional ( param_list )
        if self.is(&TokenKind::LeftParen) {
            self.advance();
            self.parse_id_list();
            self.expect(&TokenKind::RightParen);
        }
        self.expect(&TokenKind::Semicolon);

        // Uses and declarations
        self.parse_decl_sections();

        // Optional begin..end block
        if self.is(&TokenKind::Begin) {
            self.parse_begin_end_block();
        }

        self.expect(&TokenKind::Dot);
    }

    fn parse_unit(&mut self) {
        self.advance(); // unit
        self.expect(&TokenKind::Identifier);
        self.expect(&TokenKind::Semicolon);

        // Interface section
        self.expect(&TokenKind::Interface);
        self.parse_decl_sections();

        // Implementation section
        if self.is(&TokenKind::Implementation) {
            self.in_implementation = true;
            self.advance();
            self.parse_decl_sections();
        }

        // Optional begin...end block at unit level (implementation section code)
        if self.is(&TokenKind::Begin) {
            self.parse_begin_end_block();
        }

        // Optional initialization section
        if self.is(&TokenKind::Initialization) {
            self.advance();
            self.parse_stmt_list(&TokenKind::Finalization, &TokenKind::End);
            if self.is(&TokenKind::Finalization) {
                self.advance();
                self.parse_stmt_list(&TokenKind::End, &TokenKind::End);
            }
        }

        self.expect(&TokenKind::End);
        self.check_interface_impl_consistency();
        self.expect(&TokenKind::Dot);
    }

    fn parse_decl_sections(&mut self) {
        loop {
            match self.current().kind {
                TokenKind::Uses => self.parse_uses_clause(),
                TokenKind::Const => self.parse_const_section(),
                TokenKind::Type => self.parse_type_section(),
                TokenKind::Var => self.parse_var_section(),
                TokenKind::ThreadVar => self.parse_var_section(), // threadvar handled same as var
                TokenKind::Procedure | TokenKind::Function => {
                    self.parse_proc_or_func_decl();
                }
                TokenKind::Constructor => {
                    self.parse_proc_or_func_decl();
                }
                TokenKind::Destructor => {
                    self.parse_proc_or_func_decl();
                }
                TokenKind::Class => {
                    // class procedure/function implementation
                    self.advance(); // class
                    if self.is_any(&[
                        TokenKind::Procedure,
                        TokenKind::Function,
                        TokenKind::Constructor,
                        TokenKind::Destructor,
                    ]) {
                        self.parse_proc_or_func_decl();
                    } else {
                        // Not a class method, don't consume
                        break;
                    }
                }
                TokenKind::DirectiveCompiler => {
                    // Skip compiler directives
                    self.advance();
                }
                _ => break,
            }
        }
    }

    // ============================================================
    // USES CLAUSE
    // ============================================================

    fn parse_uses_clause(&mut self) {
        self.advance(); // uses

        loop {
            // Skip compiler directives like {$ifdef ...}
            while self.is(&TokenKind::DirectiveCompiler) {
                self.advance();
            }

            if self.is(&TokenKind::Identifier) {
                // Handle qualified names like System.SysUtils
                self.parse_qualified_name();
            } else {
                break;
            }

            if !self.is(&TokenKind::Comma) {
                break;
            }
            self.advance();
        }
        self.expect(&TokenKind::Semicolon);
    }

    // ============================================================
    // CONST SECTION
    // ============================================================

    fn parse_const_section(&mut self) {
        self.advance(); // const

        loop {
            match self.current().kind {
                TokenKind::Identifier => self.parse_const_decl(),
                TokenKind::DirectiveCompiler => {
                    // Skip compiler directives
                    self.advance();
                }
                _ => break,
            }
        }
    }

    fn parse_const_decl(&mut self) {
        self.advance(); // identifier

        // Typed constant: id : type = value;
        if self.is(&TokenKind::Colon) {
            self.advance();
            self.parse_type();
        }

        self.expect(&TokenKind::Equal);
        self.parse_const_expr();
        self.expect(&TokenKind::Semicolon);
    }

    fn parse_const_expr(&mut self) {
        if self.depth_limit == 0 {
            let tok = self.current();
            self.diagnostics.error(
                tok.line,
                tok.col,
                format!(
                    "maximum parsing depth exceeded in const expression (near '{}')",
                    tok.text
                ),
            );
            return;
        }
        self.depth_limit -= 1;
        // Const expression can be: literal, identifier, set literal, array literal, record literal, etc.
        match self.current().kind {
            TokenKind::LeftParen => {
                // Parenthesized const expression or record/array constant
                self.advance();
                if self.is(&TokenKind::RightParen) {
                    // Empty ()
                    self.advance();
                    return;
                }
                // Check if first item is a named field: identifier : value
                if self.is(&TokenKind::Identifier) && self.peek(1).kind == TokenKind::Colon {
                    // Named field constant: (field: value; field: value; ...)
                    loop {
                        let start_pos = self.pos;
                        self.advance(); // field name
                        self.advance(); // :
                        self.parse_const_expr();
                        if !self.is(&TokenKind::Semicolon) {
                            break;
                        }
                        self.advance();
                        if self.is(&TokenKind::RightParen) {
                            break; // trailing semicolon before ), don't consume )
                        }
                        // Safety: prevent infinite loop
                        if self.pos == start_pos {
                            let tok = self.current();
                            self.diagnostics.error(
                                tok.line,
                                tok.col,
                                format!("unexpected token '{}' in const expression", tok.text),
                            );
                            break;
                        }
                    }
                } else {
                    // Array or parenthesized constant: (value, value, ...) or (value)
                    loop {
                        let start_pos = self.pos;
                        self.parse_const_expr();
                        if self.is(&TokenKind::RightParen) {
                            break;
                        }
                        if !self.is(&TokenKind::Comma) {
                            break;
                        }
                        self.advance();
                        // Safety: prevent infinite loop
                        if self.pos == start_pos {
                            let tok = self.current();
                            self.diagnostics.error(
                                tok.line,
                                tok.col,
                                format!("unexpected token '{}' in const expression", tok.text),
                            );
                            break;
                        }
                    }
                }
                self.expect(&TokenKind::RightParen);
            }
            TokenKind::LeftBracket => {
                // Set constant
                self.advance();
                if !self.is(&TokenKind::RightBracket) {
                    self.parse_expr();
                    if self.is(&TokenKind::DotDot) {
                        self.advance();
                        self.parse_expr();
                    }
                    while self.is(&TokenKind::Comma) {
                        self.advance();
                        self.parse_expr();
                        if self.is(&TokenKind::DotDot) {
                            self.advance();
                            self.parse_expr();
                        }
                    }
                }
                self.expect(&TokenKind::RightBracket);
            }
            _ => {
                self.parse_expr();
            }
        }
        self.depth_limit += 1;
    }

    // ============================================================
    // TYPE SECTION
    // ============================================================

    fn parse_type_section(&mut self) {
        self.advance(); // type

        loop {
            match self.current().kind {
                TokenKind::Identifier => self.parse_type_decl(),
                TokenKind::DirectiveCompiler => {
                    self.advance();
                }
                TokenKind::LeftBracket => {
                    self.parse_method_attributes();
                }
                _ => break,
            }
        }
    }

    fn parse_type_decl(&mut self) {
        let type_name = self.current().text.to_uppercase();
        let _name_line = self.current().line;
        let _name_col = self.current().col;
        self.advance(); // identifier

        self.expect(&TokenKind::Equal);

        // Check for class/record helpers: type Foo = class helper for TBar
        if self.is_any(&[
            TokenKind::Class,
            TokenKind::Record,
            TokenKind::Object,
            TokenKind::Interface,
        ]) {
            self.parse_structured_type_decl(&type_name);
        } else {
            self.parse_type();
        }

        self.expect(&TokenKind::Semicolon);
    }

    fn parse_structured_type_decl(&mut self, type_name: &str) {
        let is_class = self.is(&TokenKind::Class);
        let _is_record = self.is(&TokenKind::Record);
        let _is_interface = self.is(&TokenKind::Interface);

        self.advance(); // class/record/interface/object

        // Check for "helper"
        if self.is(&TokenKind::Helper) {
            self.advance(); // helper
            if self.is(&TokenKind::For) {
                self.advance(); // for
                self.parse_type_ref();
            }
        }

        // Check for forward declaration: just "class;" or "record;"
        if self.is(&TokenKind::Semicolon) {
            return;
        }

        // Check for inheritance: class(Parent)
        if is_class && self.is(&TokenKind::LeftParen) {
            self.advance();
            self.parse_type_ref();
            while self.is(&TokenKind::Comma) {
                self.advance();
                self.parse_type_ref();
            }
            self.expect(&TokenKind::RightParen);
            // Check for forward declaration with ancestor: class(Parent);
            if self.is(&TokenKind::Semicolon) {
                return;
            }
        }

        // Parse class/record members
        loop {
            match self.current().kind {
                TokenKind::End => {
                    self.advance();
                    return;
                }
                TokenKind::Private
                | TokenKind::Protected
                | TokenKind::Public
                | TokenKind::Published
                | TokenKind::Strict => {
                    self.advance(); // visibility specifier
                    if self.is(&TokenKind::Private) || self.is(&TokenKind::Protected) {
                        self.advance(); // strict private, strict protected
                    }
                }
                TokenKind::Identifier => {
                    // Field declaration: name : type;
                    self.parse_id_list();
                    self.expect(&TokenKind::Colon);
                    self.parse_type();
                    self.expect(&TokenKind::Semicolon);
                }
                TokenKind::LeftBracket => {
                    // Method attributes: [Setup], [Test], [TestCase('...')], etc.
                    self.parse_method_attributes();
                }
                TokenKind::Procedure
                | TokenKind::Function
                | TokenKind::Constructor
                | TokenKind::Destructor => {
                    if !self.in_implementation
                        && let Some(name) = self.peek_method_name(1)
                    {
                        let is_abstract_or_external = self.is_method_abstract_or_external();
                        let is_destructor = name.to_uppercase() == "DESTROY";
                        self.interface_declarations.push((
                            type_name.to_uppercase(),
                            name.to_uppercase(),
                            self.current().line,
                            self.current().col,
                            is_abstract_or_external || is_destructor,
                        ));
                    }
                    self.parse_proc_header();
                    self.expect(&TokenKind::Semicolon);
                    self.parse_proc_directives();
                }
                TokenKind::Property => {
                    self.parse_property_decl();
                }
                TokenKind::Class => {
                    // class var, class procedure, class function, class property
                    self.advance();
                    match self.current().kind {
                        TokenKind::Var => {
                            self.advance();
                            self.parse_id_list();
                            self.expect(&TokenKind::Colon);
                            self.parse_type();
                            self.expect(&TokenKind::Semicolon);
                        }
                        TokenKind::Procedure | TokenKind::Function => {
                            if !self.in_implementation
                                && let Some(name) = self.peek_method_name(1)
                            {
                                let is_abstract_or_external = self.is_method_abstract_or_external();
                                self.interface_declarations.push((
                                    type_name.to_uppercase(),
                                    name.to_uppercase(),
                                    self.current().line,
                                    self.current().col,
                                    is_abstract_or_external,
                                ));
                            }
                            self.parse_proc_header();
                            self.expect(&TokenKind::Semicolon);
                            self.parse_proc_directives();
                        }
                        TokenKind::Property => {
                            self.parse_property_decl();
                        }
                        _ => {
                            // class var without 'var' keyword
                            self.parse_id_list();
                            self.expect(&TokenKind::Colon);
                            self.parse_type();
                            self.expect(&TokenKind::Semicolon);
                        }
                    }
                }
                TokenKind::Var => {
                    // record var section
                    self.advance();
                    while self.is(&TokenKind::Identifier) {
                        self.parse_id_list();
                        self.expect(&TokenKind::Colon);
                        self.parse_type();
                        self.expect(&TokenKind::Semicolon);
                    }
                }
                TokenKind::Case => {
                    // Variant record
                    self.advance();
                    if self.is(&TokenKind::Identifier) {
                        self.advance(); // optional name
                        if self.is(&TokenKind::Colon) {
                            self.advance();
                            self.parse_type_ref();
                        }
                    } else {
                        self.parse_type_ref();
                    }
                    self.expect(&TokenKind::Of);
                    loop {
                        if self.is(&TokenKind::End) || self.is(&TokenKind::Semicolon) {
                            break;
                        }
                        // const_list : ( field_decls )
                        self.parse_const_expr();
                        while self.is(&TokenKind::Comma) {
                            self.advance();
                            self.parse_const_expr();
                        }
                        self.expect(&TokenKind::Colon);
                        self.expect(&TokenKind::LeftParen);
                        while !self.is(&TokenKind::RightParen) && !self.is(&TokenKind::Eof) {
                            if self.is(&TokenKind::Identifier) {
                                self.parse_id_list();
                                self.expect(&TokenKind::Colon);
                                self.parse_type();
                                if self.is(&TokenKind::Semicolon) {
                                    self.advance();
                                }
                            } else {
                                break;
                            }
                        }
                        self.expect(&TokenKind::RightParen);
                        if self.is(&TokenKind::Semicolon) {
                            self.advance();
                        }
                        // Safety: if we couldn't parse anything useful, advance
                        if self.is(&TokenKind::Of)
                            || self.is(&TokenKind::Private)
                            || self.is(&TokenKind::Public)
                            || self.is(&TokenKind::End)
                        {
                            break;
                        }
                    }
                }
                TokenKind::DirectiveCompiler => {
                    // Skip compiler directives inside type declarations
                    self.advance();
                }
                _ => {
                    let tok = self.current();
                    if tok.kind == TokenKind::Eof {
                        return;
                    }
                    // Recovery: if we see section-level keywords, exit type declaration
                    if tok.kind == TokenKind::Implementation
                        || tok.kind == TokenKind::Initialization
                        || tok.kind == TokenKind::Begin
                        || tok.kind == TokenKind::End
                        || tok.kind == TokenKind::Finalization
                    {
                        self.diagnostics.error(
                            tok.line,
                            tok.col,
                            format!("expected 'end' for type declaration, found '{}'", tok.text),
                        );
                        return;
                    }
                    self.diagnostics.error(
                        tok.line,
                        tok.col,
                        format!("unexpected token '{}' in type declaration", tok.text),
                    );
                    self.advance();
                }
            }
        }
    }

    fn parse_property_decl(&mut self) {
        self.advance(); // property
        self.expect(&TokenKind::Identifier);

        // Optional [index]
        if self.is(&TokenKind::LeftBracket) {
            self.advance();
            self.parse_formal_param_list();
            self.expect(&TokenKind::RightBracket);
        }

        // Optional : type
        if self.is(&TokenKind::Colon) {
            self.advance();
            self.parse_type_ref();
        }

        // Read/Write specifiers and directives
        loop {
            if self.is(&TokenKind::Identifier) {
                let text = self.current().text.to_uppercase();
                match text.as_str() {
                    "READ" => {
                        self.advance();
                        self.parse_qualified_name();
                    }
                    "WRITE" => {
                        self.advance();
                        self.parse_qualified_name();
                    }
                    "INDEX" => {
                        self.advance();
                        self.parse_expr();
                    }
                    "DEFAULT" => {
                        self.advance();
                        // Optional default value (can be a set literal like [pfPiping, pfSupport])
                        if self.is(&TokenKind::LeftBracket) {
                            self.advance();
                            if !self.is(&TokenKind::RightBracket) {
                                self.parse_const_expr();
                                while self.is(&TokenKind::Comma) {
                                    self.advance();
                                    self.parse_const_expr();
                                }
                            }
                            self.expect(&TokenKind::RightBracket);
                        }
                    }
                    "NODEFAULT" => {
                        self.advance();
                    }
                    "STORED" => {
                        self.advance();
                        self.parse_expr();
                    }
                    "IMPLEMENTS" => {
                        self.advance();
                        self.parse_type_ref();
                    }
                    _ => break,
                }
            } else {
                break;
            }
        }

        self.expect(&TokenKind::Semicolon);
    }

    fn parse_proc_header(&mut self) {
        self.advance(); // procedure/function/constructor/destructor

        // Allow qualified names like TMyClass.Method
        self.parse_qualified_name();

        // Formal parameters
        if self.is(&TokenKind::LeftParen) {
            self.parse_formal_params();
        }

        // Return type for functions
        if self.is(&TokenKind::Colon) {
            self.advance();
            self.parse_type_ref();
        }
    }

    fn is_method_abstract_or_external(&self) -> bool {
        let start = self.pos;
        let mut pos = start;

        while pos < self.tokens.len() {
            match self.tokens[pos].kind {
                TokenKind::Semicolon => {
                    break;
                }
                TokenKind::Abstract | TokenKind::External => {
                    return true;
                }
                _ => {}
            }
            pos += 1;
        }
        false
    }

    fn parse_proc_directives(&mut self) {
        loop {
            // Skip optional semicolons between directives
            while self.is(&TokenKind::Semicolon) {
                self.advance();
            }
            match self.current().kind {
                TokenKind::Virtual
                | TokenKind::Override
                | TokenKind::Overload
                | TokenKind::Reintroduce
                | TokenKind::Abstract
                | TokenKind::Static
                | TokenKind::Inline
                | TokenKind::Forward
                | TokenKind::External
                | TokenKind::Message
                | TokenKind::Dynamic
                | TokenKind::Cdecl
                | TokenKind::Stdcall
                | TokenKind::Register
                | TokenKind::Pascal
                | TokenKind::Safecall => {
                    self.advance();
                    if self.current().kind == TokenKind::IntegerLiteral
                        || self.current().kind == TokenKind::Identifier
                    {
                        // message directive with value
                        if self.is(&TokenKind::IntegerLiteral) || self.is(&TokenKind::Identifier) {
                            self.advance();
                        }
                    }
                }
                TokenKind::StringLiteral => {
                    // External with string literal
                    self.advance();
                }
                _ => break,
            }
        }
    }

    fn parse_method_attributes(&mut self) {
        while self.is(&TokenKind::LeftBracket) {
            self.advance();
            // Parse attribute name
            if self.is(&TokenKind::Identifier) {
                self.advance();
                // Optional arguments: (arg1, arg2, ...)
                if self.is(&TokenKind::LeftParen) {
                    self.advance();
                    // Consume tokens until we find the closing paren
                    // Handle nested parens and strings
                    let mut paren_depth = 1;
                    while paren_depth > 0 {
                        match self.current().kind {
                            TokenKind::LeftParen => {
                                paren_depth += 1;
                                self.advance();
                            }
                            TokenKind::RightParen => {
                                paren_depth -= 1;
                                self.advance();
                            }
                            TokenKind::StringLiteral => {
                                self.advance();
                            }
                            _ => {
                                self.advance();
                            }
                        }
                    }
                }
            }
            self.expect(&TokenKind::RightBracket);
        }
    }

    fn parse_formal_params(&mut self) {
        self.expect(&TokenKind::LeftParen);
        if !self.is(&TokenKind::RightParen) {
            self.parse_formal_param();
            while self.is(&TokenKind::Semicolon) {
                self.advance();
                if self.is(&TokenKind::RightParen) {
                    break; // trailing semicolon
                }
                self.parse_formal_param();
            }
        }
        self.expect(&TokenKind::RightParen);
    }

    fn parse_formal_param(&mut self) {
        // Optional modifiers: var, const, out
        match self.current().kind {
            TokenKind::Var | TokenKind::Const | TokenKind::Out => {
                self.advance();
            }
            _ => {}
        }

        // Parameter names
        self.parse_id_list();

        // Optional : type  (if no type, it's an untyped param)
        if self.is(&TokenKind::Colon) {
            self.advance();
            self.parse_type();

            // Optional default value = const_expr
            if self.is(&TokenKind::Equal) {
                self.advance();
                self.parse_const_expr();
            }
        }

        // Optional array of const
        if self.is(&TokenKind::Array) {
            self.advance();
            if self.is(&TokenKind::Of) {
                self.advance();
                if self.is(&TokenKind::Identifier) && self.current().text.to_uppercase() == "CONST"
                {
                    self.advance();
                } else {
                    self.parse_type();
                }
            }
        }
    }

    fn parse_formal_param_list(&mut self) {
        if !self.is(&TokenKind::RightBracket) {
            self.parse_formal_param();
            while self.is(&TokenKind::Semicolon) {
                self.advance();
                if self.is(&TokenKind::RightBracket) {
                    break;
                }
                self.parse_formal_param();
            }
        }
    }

    fn parse_id_list(&mut self) {
        match self.current().kind {
            TokenKind::Identifier | TokenKind::Message | TokenKind::Label => {
                self.advance();
            }
            _ => {
                self.expect(&TokenKind::Identifier);
            }
        }
        while self.is(&TokenKind::Comma) {
            self.advance();
            match self.current().kind {
                TokenKind::Identifier | TokenKind::Message | TokenKind::Label => {
                    self.advance();
                }
                _ => {
                    self.expect(&TokenKind::Identifier);
                }
            }
        }
    }

    fn parse_qualified_name(&mut self) {
        match self.current().kind {
            TokenKind::Identifier | TokenKind::Message => {
                self.advance();
            }
            _ => {
                self.expect(&TokenKind::Identifier);
            }
        }
        loop {
            if self.is(&TokenKind::Dot) {
                self.advance();
                match self.current().kind {
                    TokenKind::Identifier | TokenKind::Message => {
                        self.advance();
                    }
                    _ => {
                        self.expect(&TokenKind::Identifier);
                    }
                }
            } else if self.is(&TokenKind::LeftBracket) {
                // Array indexing like Foo[i].Bar
                self.advance();
                self.parse_expr();
                while self.is(&TokenKind::Comma) {
                    self.advance();
                    self.parse_expr();
                }
                self.expect(&TokenKind::RightBracket);
            } else {
                break;
            }
        }
    }

    fn parse_type_ref(&mut self) {
        // Like parse_type but doesn't consume structured type declarations
        match self.current().kind {
            TokenKind::Identifier | TokenKind::Label => {
                self.parse_qualified_name();
                // Handle generics: TList<T> or TDictionary<TKey, TValue>
                if self.is(&TokenKind::Less) {
                    self.advance();
                    self.parse_type();
                    while self.is(&TokenKind::Comma) {
                        self.advance();
                        self.parse_type();
                    }
                    self.expect(&TokenKind::Greater);
                }
            }
            TokenKind::String => {
                self.advance();
                if self.is(&TokenKind::LeftBracket) {
                    self.advance();
                    self.parse_expr();
                    self.expect(&TokenKind::RightBracket);
                }
            }
            TokenKind::Array | TokenKind::Packed => {
                self.parse_array_type();
            }
            TokenKind::Set => {
                self.parse_set_type();
            }
            TokenKind::Caret => {
                self.advance();
                self.parse_type_ref();
            }
            TokenKind::Procedure | TokenKind::Function => {
                self.parse_proc_type();
            }
            TokenKind::LeftParen => {
                // Enum type
                self.advance();
                self.parse_id_list();
                self.expect(&TokenKind::RightParen);
            }
            TokenKind::Class => {
                // class of / class reference
                self.advance();
                if self.is(&TokenKind::Of) {
                    self.advance();
                    self.parse_type_ref();
                }
            }
            TokenKind::File => {
                self.advance();
                if self.is(&TokenKind::Of) {
                    self.advance();
                    self.parse_type_ref();
                }
            }
            _ => {
                let tok = self.current();
                self.diagnostics.error(
                    tok.line,
                    tok.col,
                    format!("expected type, found '{}'", tok.text),
                );
            }
        }
    }

    fn parse_proc_type(&mut self) {
        self.advance(); // procedure/function
        if self.is(&TokenKind::LeftParen) {
            self.parse_formal_params();
        }
        if self.is(&TokenKind::Colon) {
            self.advance();
            self.parse_type_ref();
        }
        if self.is(&TokenKind::Of) {
            self.advance();
            if self.is(&TokenKind::Object) {
                self.advance();
            }
        }
    }

    fn parse_type(&mut self) {
        if self.depth_limit == 0 {
            let tok = self.current();
            self.diagnostics.error(
                tok.line,
                tok.col,
                format!(
                    "maximum parsing depth exceeded in type (near '{}')",
                    tok.text
                ),
            );
            return;
        }
        self.depth_limit -= 1;
        match self.current().kind {
            TokenKind::Identifier | TokenKind::Label => {
                self.parse_type_ref();
            }
            TokenKind::String => {
                self.advance();
                if self.is(&TokenKind::LeftBracket) {
                    self.advance();
                    self.parse_expr();
                    self.expect(&TokenKind::RightBracket);
                }
            }
            TokenKind::Array | TokenKind::Packed => {
                self.parse_array_type();
            }
            TokenKind::Set => {
                self.parse_set_type();
            }
            TokenKind::Caret => {
                self.advance();
                self.parse_type();
            }
            TokenKind::LeftParen => {
                // Enum type
                self.advance();
                self.parse_id_list();
                self.expect(&TokenKind::RightParen);
            }
            TokenKind::Procedure | TokenKind::Function => {
                self.parse_proc_type();
            }
            TokenKind::Class => {
                self.advance();
                if self.is(&TokenKind::Of) {
                    self.advance();
                    self.parse_type_ref();
                }
            }
            TokenKind::Record | TokenKind::Object => {
                self.parse_structured_type_decl("");
            }
            TokenKind::File => {
                self.advance();
                if self.is(&TokenKind::Of) {
                    self.advance();
                    self.parse_type();
                }
            }
            TokenKind::Interface => {
                self.parse_structured_type_decl("");
            }
            _ => {
                let tok = self.current();
                self.diagnostics.error(
                    tok.line,
                    tok.col,
                    format!("expected type, found '{}'", tok.text),
                );
            }
        }
        self.depth_limit += 1;
    }

    fn parse_array_type(&mut self) {
        if self.is(&TokenKind::Packed) {
            self.advance();
        }
        self.expect(&TokenKind::Array);

        if self.is(&TokenKind::LeftBracket) {
            self.advance();
            self.parse_subrange_type();
            while self.is(&TokenKind::Comma) {
                self.advance();
                self.parse_subrange_type();
            }
            self.expect(&TokenKind::RightBracket);
        }

        self.expect(&TokenKind::Of);
        self.parse_type();
    }

    fn parse_subrange_type(&mut self) {
        self.parse_expr();
        if self.is(&TokenKind::DotDot) {
            self.advance();
            self.parse_expr();
        }
    }

    fn parse_set_type(&mut self) {
        self.advance(); // set
        self.expect(&TokenKind::Of);
        // Handle ordinal subrange: Set of 0..100 or Set of 'A'..'Z'
        // These start with a number, char literal, or identifier that could be ordinal
        match self.current().kind {
            TokenKind::IntegerLiteral | TokenKind::CharLiteral | TokenKind::HexLiteral => {
                // Could be ordinal range start
                self.parse_const_expr();
                if self.is(&TokenKind::DotDot) {
                    self.advance();
                    self.parse_const_expr();
                }
            }
            _ => {
                // It's a type
                self.parse_type();
            }
        }
    }

    // ============================================================
    // VAR SECTION
    // ============================================================

    fn parse_var_section(&mut self) {
        self.advance(); // var / threadvar

        loop {
            match self.current().kind {
                TokenKind::Identifier | TokenKind::Label | TokenKind::Message => {
                    // Check if this is a label declaration (Label ident;)
                    if self.is(&TokenKind::Label)
                        || (self.is(&TokenKind::Identifier)
                            && self.peek(1).kind == TokenKind::Label)
                    {
                        self.parse_label_decl();
                    } else {
                        self.parse_var_decl();
                    }
                }
                TokenKind::DirectiveCompiler => {
                    self.advance();
                }
                _ => break,
            }
        }
    }

    fn parse_label_decl(&mut self) {
        // Label declaration: label ident1, ident2, ...;
        self.expect(&TokenKind::Label);
        // Parse label names (identifiers)
        self.expect(&TokenKind::Identifier);
        while self.is(&TokenKind::Comma) {
            self.advance();
            self.expect(&TokenKind::Identifier);
        }
        self.expect(&TokenKind::Semicolon);
    }

    fn parse_var_decl(&mut self) {
        self.parse_id_list();
        self.expect(&TokenKind::Colon);
        self.parse_type();

        // Optional default value
        if self.is(&TokenKind::Equal) {
            self.advance();
            self.parse_const_expr();
        }

        self.expect(&TokenKind::Semicolon);
    }

    // ============================================================
    // PROCEDURE/FUNCTION DECLARATION
    // ============================================================

    fn parse_proc_or_func_decl(&mut self) {
        // Detect qualified name in implementation section (e.g., TMyClass.Method)
        if self.in_implementation {
            let tok = self.current();
            let is_destructor = matches!(tok.kind, TokenKind::Destructor)
                || (matches!(tok.kind, TokenKind::Identifier)
                    && tok.text.to_uppercase() == "DESTROY");
            let line = tok.line;
            let col = tok.col;
            let class_tok = self.peek(1);
            let dot_tok = self.peek(2);
            if matches!(class_tok.kind, TokenKind::Identifier)
                && matches!(dot_tok.kind, TokenKind::Dot)
            {
                let method_tok = self.peek(3);
                if matches!(method_tok.kind, TokenKind::Identifier) && !is_destructor {
                    self.implementations.push((
                        class_tok.text.to_uppercase(),
                        method_tok.text.to_uppercase(),
                        line,
                        col,
                    ));
                }
            }
        }

        self.parse_proc_header();
        self.expect(&TokenKind::Semicolon);

        // Check for forward/external
        if self.is(&TokenKind::Forward) || self.is(&TokenKind::External) {
            self.advance();
            if self.is(&TokenKind::StringLiteral) || self.is(&TokenKind::Identifier) {
                self.advance(); // external name
            }
            if self.is(&TokenKind::Identifier) && self.current().text.to_uppercase() == "NAME" {
                self.advance();
                self.parse_expr();
            }
            self.expect(&TokenKind::Semicolon);
            return;
        }

        // Nested declarations
        self.parse_decl_sections();

        // Optional begin..end body (not for interface-only declarations)
        if self.is(&TokenKind::Begin) {
            self.parse_begin_end_block();
            self.expect(&TokenKind::Semicolon);
        } else if self.is(&TokenKind::Asm) {
            // asm...end block
            self.advance();
            while !self.is(&TokenKind::End) && !self.is(&TokenKind::Eof) {
                self.advance();
            }
            self.expect(&TokenKind::End);
            self.expect(&TokenKind::Semicolon);
        }
    }

    // ============================================================
    // STATEMENTS
    // ============================================================

    fn parse_begin_end_block(&mut self) {
        self.expect(&TokenKind::Begin);
        self.parse_stmt_list(&TokenKind::End, &TokenKind::End);
        self.expect(&TokenKind::End);
    }

    fn parse_stmt_list(&mut self, end_token: &TokenKind, end_token2: &TokenKind) {
        while !self.is(end_token) && !self.is(end_token2) && !self.is(&TokenKind::Eof) {
            let start_pos = self.pos;
            // Skip compiler directives at statement boundaries
            if self.is(&TokenKind::DirectiveCompiler) {
                self.advance();
                continue;
            }
            self.parse_stmt();
            // Safety: if position didn't change, we're stuck - advance to avoid infinite loop
            if self.pos == start_pos {
                if self.is(&TokenKind::Eof) {
                    break;
                }
                self.advance();
            }
            if self.is(&TokenKind::Semicolon) {
                self.advance();
                // Skip additional semicolons (multiple semicolons are allowed)
                while self.is(&TokenKind::Semicolon) {
                    self.advance();
                }
            } else if !self.is(end_token) && !self.is(end_token2) && !self.is(&TokenKind::Eof) {
                // Don't report if we're at the end
                break;
            }
        }
    }

    fn parse_stmt(&mut self) {
        let start_pos = self.pos;
        match self.current().kind {
            TokenKind::Begin => {
                self.parse_begin_end_block();
            }
            TokenKind::If => {
                self.parse_if_stmt();
            }
            TokenKind::Case => {
                self.parse_case_stmt();
            }
            TokenKind::For => {
                self.parse_for_stmt();
            }
            TokenKind::While => {
                self.parse_while_stmt();
            }
            TokenKind::Repeat => {
                self.parse_repeat_stmt();
            }
            TokenKind::With => {
                self.parse_with_stmt();
            }
            TokenKind::Try => {
                self.parse_try_stmt();
            }
            TokenKind::Raise => {
                self.parse_raise_stmt();
            }
            TokenKind::Goto => {
                self.advance();
                if self.is(&TokenKind::Identifier) || self.is(&TokenKind::IntegerLiteral) {
                    self.advance();
                }
            }
            TokenKind::Identifier | TokenKind::Message | TokenKind::Label => {
                // Could be: assignment, procedure call, or label:
                let is_label = self.parse_labeled_or_assignment_stmt();
                if is_label {
                    // After label (identifier:), parse the actual statement
                    self.parse_stmt();
                }
            }
            TokenKind::Inherited => {
                // inherited call
                self.advance();
                if self.is(&TokenKind::Identifier) || self.is(&TokenKind::Message) {
                    self.parse_qualified_name();
                    if self.is(&TokenKind::LeftParen) {
                        self.parse_arg_list();
                    }
                }
            }
            TokenKind::Asm => {
                // Inline assembly - skip until end
                self.advance();
                while !self.is(&TokenKind::End) && !self.is(&TokenKind::Eof) {
                    self.advance();
                }
                self.expect(&TokenKind::End);
            }
            _ => {
                // Handle compiler directives in statements
                if self.is(&TokenKind::DirectiveCompiler) {
                    self.advance();
                    return;
                }
                // Empty statement or expression statement
                if self.is(&TokenKind::Semicolon)
                    || self.is(&TokenKind::End)
                    || self.is(&TokenKind::Else)
                    || self.is(&TokenKind::Eof)
                {
                    return; // empty statement
                }
                // Safety: if we couldn't parse anything, advance to avoid infinite loop
                if self.pos == start_pos {
                    let tok = self.current();
                    if tok.kind != TokenKind::Eof {
                        self.diagnostics.error(
                            tok.line,
                            tok.col,
                            format!("unexpected token '{}' in statement", tok.text),
                        );
                        self.advance();
                    }
                } else {
                    self.parse_expr();
                }
            }
        }
    }

    fn parse_labeled_or_assignment_stmt(&mut self) -> bool {
        // Try to parse as qualified name (could be assignment target or procedure call)
        self.parse_qualified_name();

        // Handle label statement: identifier followed by colon
        if self.is(&TokenKind::Colon) {
            self.advance();
            return true; // Label statement handled
        }

        // Handle generics: TList<T>.Create or TDictionary<TKey, TValue>.Create
        // Only treat < as generics if followed by a type name (starts with uppercase T or is String)
        if self.is(&TokenKind::Less) {
            let peek_tok = &self.peek(1);
            let looks_like_type = peek_tok.kind == TokenKind::String
                || (peek_tok.kind == TokenKind::Identifier
                    && (peek_tok.text.starts_with('T') || peek_tok.text.starts_with('I')));
            if looks_like_type {
                self.advance();
                self.parse_type();
                while self.is(&TokenKind::Comma) {
                    self.advance();
                    self.parse_type();
                }
                self.expect(&TokenKind::Greater);
            }
        }

        // Handle chained access: .prop, [index], (args), ^ (pointer dereference)
        // e.g., Foo.Bar('X').Baz[0].Qux := expr; or P^.Field := value;
        loop {
            match self.current().kind {
                TokenKind::Dot => {
                    self.advance();
                    match self.current().kind {
                        TokenKind::Identifier | TokenKind::Message => {
                            self.advance();
                        }
                        _ => {
                            self.expect(&TokenKind::Identifier);
                        }
                    }
                }
                TokenKind::LeftParen => {
                    self.parse_arg_list();
                }
                TokenKind::LeftBracket => {
                    self.advance();
                    self.parse_expr();
                    while self.is(&TokenKind::Comma) {
                        self.advance();
                        self.parse_expr();
                    }
                    self.expect(&TokenKind::RightBracket);
                }
                TokenKind::Caret => {
                    self.advance(); // pointer dereference
                }
                _ => break,
            }
        }

        // Check for assignment
        if self.is(&TokenKind::Assign) {
            self.advance();
            self.parse_expr();
            return false;
        } else if !self.is(&TokenKind::Semicolon)
            && !self.is(&TokenKind::End)
            && !self.is(&TokenKind::Else)
            && !self.is(&TokenKind::Do)
            && !self.is(&TokenKind::Then)
            && !self.is(&TokenKind::Of)
            && !self.is(&TokenKind::Comma)
            && !self.is(&TokenKind::RightParen)
            && !self.is(&TokenKind::RightBracket)
            && !self.is(&TokenKind::Eof)
        {
            // Continue parsing as part of larger expression (e.g., "Images.Count < 5")
            self.parse_expr();
        }
        false
    }

    fn parse_arg_list(&mut self) {
        self.expect(&TokenKind::LeftParen);
        if !self.is(&TokenKind::RightParen) {
            self.parse_arg();
            while self.is(&TokenKind::Comma) {
                self.advance();
                self.parse_arg();
            }
        }
        self.expect(&TokenKind::RightParen);
    }

    fn parse_arg(&mut self) {
        // Named parameter: name: value
        if self.is(&TokenKind::Identifier) && self.peek(1).kind == TokenKind::Colon {
            self.advance(); // name
            self.advance(); // :
        }
        self.parse_expr();
    }

    fn parse_if_stmt(&mut self) {
        self.advance(); // if
        self.parse_expr();
        self.expect(&TokenKind::Then);

        // Handle compiler directives before the statement
        while self.is(&TokenKind::DirectiveCompiler) {
            self.advance();
        }

        self.parse_stmt();

        // Handle compiler directives before else
        while self.is(&TokenKind::DirectiveCompiler) {
            self.advance();
        }

        if self.is(&TokenKind::Else) {
            self.advance();

            // Handle compiler directives before the else statement
            while self.is(&TokenKind::DirectiveCompiler) {
                self.advance();
            }

            self.parse_stmt();
        }
    }

    fn parse_case_stmt(&mut self) {
        self.advance(); // case
        self.parse_expr();
        self.expect(&TokenKind::Of);

        while !self.is(&TokenKind::End) && !self.is(&TokenKind::Else) && !self.is(&TokenKind::Eof) {
            let start_pos = self.pos;
            self.parse_case_item();
            // Safety: if position didn't change, we're stuck - advance to avoid infinite loop
            if self.pos == start_pos {
                if self.is(&TokenKind::Eof) {
                    break;
                }
                self.advance();
            }
            if self.is(&TokenKind::Semicolon) {
                self.advance();
            }
        }

        if self.is(&TokenKind::Else) {
            self.advance();
            self.parse_stmt_list(&TokenKind::End, &TokenKind::End);
        }

        self.expect(&TokenKind::End);
    }

    fn parse_case_item(&mut self) {
        // case_labels : stmt
        self.parse_case_label();
        while self.is(&TokenKind::Comma) {
            self.advance();
            self.parse_case_label();
        }
        self.expect(&TokenKind::Colon);
        self.parse_stmt();
    }

    fn parse_case_label(&mut self) {
        self.parse_expr();
        if self.is(&TokenKind::DotDot) {
            self.advance();
            self.parse_expr();
        }
    }

    fn parse_for_stmt(&mut self) {
        self.advance(); // for
        self.parse_qualified_name();

        // Check for for-in loop: for element in collection do
        if self.is(&TokenKind::In) {
            self.advance(); // in
            self.parse_expr();
            self.expect(&TokenKind::Do);
            self.parse_stmt();
        } else {
            // Traditional for loop: for i := 1 to 10 do
            self.expect(&TokenKind::Assign);
            self.parse_expr();
            if self.is(&TokenKind::To) || self.is(&TokenKind::DownTo) {
                self.advance();
            }
            self.parse_expr();
            self.expect(&TokenKind::Do);
            self.parse_stmt();
        }
    }

    fn parse_while_stmt(&mut self) {
        self.advance(); // while
        self.parse_expr();
        self.expect(&TokenKind::Do);
        self.parse_stmt();
    }

    fn parse_repeat_stmt(&mut self) {
        self.advance(); // repeat
        self.parse_stmt_list(&TokenKind::Until, &TokenKind::Until);
        self.expect(&TokenKind::Until);
        self.parse_expr();
    }

    fn parse_with_stmt(&mut self) {
        self.advance(); // with
        self.parse_expr();
        while self.is(&TokenKind::Comma) {
            self.advance();
            self.parse_expr();
        }
        self.expect(&TokenKind::Do);
        self.parse_stmt();
    }

    fn parse_try_stmt(&mut self) {
        self.advance(); // try

        // Track begin/end depth to handle nested blocks
        let mut begin_depth = 0;

        // Parse statements in the try block
        while !self.is(&TokenKind::Except)
            && !self.is(&TokenKind::Finally)
            && !self.is(&TokenKind::End)
            && !self.is(&TokenKind::Eof)
        {
            // Track nested begin/end blocks
            if self.is(&TokenKind::Begin) {
                begin_depth += 1;
            } else if self.is(&TokenKind::End) {
                begin_depth -= 1;
            }

            // If we're about to see except/finally and we've unwound all nested blocks, stop
            if (self.is(&TokenKind::Except) || self.is(&TokenKind::Finally)) && begin_depth <= 0 {
                break;
            }

            // If we've unwound all nested blocks and there's no except/finally, stop
            if begin_depth < 0 && !self.is(&TokenKind::Except) && !self.is(&TokenKind::Finally) {
                break;
            }

            let start_pos = self.pos;
            self.parse_stmt();
            // Safety: if position didn't change, we're stuck - advance to avoid infinite loop
            if self.pos == start_pos {
                if self.is(&TokenKind::Eof) {
                    break;
                }
                self.advance();
            }
            // Skip compiler directives after a statement
            while self.is(&TokenKind::DirectiveCompiler) {
                self.advance();
            }
            if self.is(&TokenKind::Semicolon) {
                self.advance();
                // Skip multiple semicolons (e.g., ;;)
                while self.is(&TokenKind::Semicolon) {
                    self.advance();
                }
            } else if self.is(&TokenKind::Except) || self.is(&TokenKind::Finally) {
                // We're at the end of try block - that's fine
            } else {
                // No semicolon but not at except/finally - this could be a statement
                // without semicolon (like a statement before except), or could be
                // something else. Continue to let parse_stmt handle it.
            }
        }

        if self.is(&TokenKind::Except) {
            self.advance();
            // Reset depth for except block
            begin_depth = 0;
            // Exception handlers
            while !self.is(&TokenKind::End) && !self.is(&TokenKind::Eof) {
                // Track nested begin/end blocks
                if self.is(&TokenKind::Begin) {
                    begin_depth += 1;
                } else if self.is(&TokenKind::End) {
                    begin_depth -= 1;
                }

                // Only exit if we've unwound all nested blocks
                if begin_depth < 0 {
                    break;
                }

                let start_pos = self.pos;
                if self.is(&TokenKind::On) {
                    // on E: Exception do stmt
                    self.advance();
                    if self.is(&TokenKind::Identifier) {
                        self.advance();
                        if self.is(&TokenKind::Colon) {
                            self.advance();
                            self.parse_type_ref();
                        }
                    } else {
                        self.parse_type_ref();
                    }
                    self.expect(&TokenKind::Do);
                    self.parse_stmt();
                    if self.is(&TokenKind::Semicolon) {
                        self.advance();
                    }
                } else {
                    // Default exception handler statements
                    self.parse_stmt();
                    if self.is(&TokenKind::Semicolon) {
                        self.advance();
                    }
                }
                // Safety: if position didn't change, we're stuck - advance
                if self.pos == start_pos {
                    if self.is(&TokenKind::Eof) {
                        break;
                    }
                    self.advance();
                }
            }
            self.expect(&TokenKind::End);
        } else if self.is(&TokenKind::Finally) {
            self.advance();
            self.parse_stmt_list(&TokenKind::End, &TokenKind::End);
            self.expect(&TokenKind::End);
        } else {
            let tok = self.current();
            self.diagnostics.error(
                tok.line,
                tok.col,
                "expected 'except' or 'finally' in try statement".to_string(),
            );
        }
    }

    fn parse_raise_stmt(&mut self) {
        self.advance(); // raise
        if !self.is(&TokenKind::Semicolon)
            && !self.is(&TokenKind::End)
            && !self.is(&TokenKind::Else)
            && !self.is(&TokenKind::Eof)
        {
            self.parse_expr();
            if self.is(&TokenKind::At) {
                self.advance();
                self.parse_expr();
            }
        }
    }

    // ============================================================
    // EXPRESSIONS
    // ============================================================

    fn parse_expr(&mut self) {
        if self.depth_limit == 0 {
            let tok = self.current();
            self.diagnostics.error(
                tok.line,
                tok.col,
                format!(
                    "maximum parsing depth exceeded (possible infinite loop near '{}')",
                    tok.text
                ),
            );
            return;
        }
        self.depth_limit -= 1;
        self.parse_relational_expr();
        self.depth_limit += 1;
    }

    fn parse_relational_expr(&mut self) {
        self.parse_logical_expr();
        while self.is_any(&[
            TokenKind::Equal,
            TokenKind::NotEqual,
            TokenKind::Less,
            TokenKind::LessEqual,
            TokenKind::Greater,
            TokenKind::GreaterEqual,
            TokenKind::In,
            TokenKind::Is,
            TokenKind::As,
        ]) {
            self.advance();
            self.parse_logical_expr();
        }
    }

    fn parse_additive_expr(&mut self) {
        self.parse_multiplicative_expr();
        while self.is_any(&[TokenKind::Plus, TokenKind::Minus, TokenKind::And]) {
            self.advance();
            self.parse_multiplicative_expr();
        }
    }

    fn parse_multiplicative_expr(&mut self) {
        self.parse_unary_expr();
        while self.is_any(&[
            TokenKind::Star,
            TokenKind::Slash,
            TokenKind::Div,
            TokenKind::Mod,
            TokenKind::Shl,
            TokenKind::Shr,
        ]) {
            self.advance();
            self.parse_unary_expr();
        }
    }

    fn parse_logical_expr(&mut self) {
        self.parse_additive_expr();
        while self.is_any(&[TokenKind::Xor, TokenKind::Or]) {
            self.advance();
            self.parse_additive_expr();
        }
    }

    fn parse_unary_expr(&mut self) {
        match self.current().kind {
            TokenKind::Not => {
                self.advance();
                self.parse_unary_expr();
            }
            TokenKind::Minus => {
                self.advance();
                self.parse_unary_expr();
            }
            TokenKind::Plus => {
                self.advance();
                self.parse_unary_expr();
            }
            TokenKind::AtSign => {
                self.advance();
                self.parse_unary_expr();
            }
            TokenKind::Inherited => {
                self.advance();
                if self.is(&TokenKind::Identifier) || self.is(&TokenKind::Message) {
                    self.parse_qualified_name();
                    if self.is(&TokenKind::LeftParen) {
                        self.parse_arg_list();
                    }
                }
            }
            _ => {
                self.parse_postfix_expr();
            }
        }
    }

    fn parse_postfix_expr(&mut self) {
        let mut start_pos = self.pos;
        self.parse_primary_expr();

        // Handle generics: TList<T>.Create
        // Only treat < as generics if followed by a type name (starts with uppercase T, I followed by uppercase, or is String)
        if self.is(&TokenKind::Less) {
            let peek_tok = &self.peek(1);
            let next_char = peek_tok.text.chars().nth(1);
            let looks_like_type = peek_tok.kind == TokenKind::String
                || (peek_tok.kind == TokenKind::Identifier
                    && (peek_tok.text.starts_with('T')
                        || (peek_tok.text.starts_with('I')
                            && next_char.is_some_and(|c| c.is_uppercase()))));
            if looks_like_type {
                self.advance();
                self.parse_type();
                while self.is(&TokenKind::Comma) {
                    self.advance();
                    self.parse_type();
                }
                self.expect(&TokenKind::Greater);
            }
        }

        loop {
            match self.current().kind {
                TokenKind::Dot => {
                    self.advance();
                    match self.current().kind {
                        TokenKind::Identifier | TokenKind::Message => {
                            self.advance();
                        }
                        _ => {
                            self.expect(&TokenKind::Identifier);
                        }
                    }
                }
                TokenKind::LeftBracket => {
                    self.advance();
                    self.parse_expr();
                    while self.is(&TokenKind::Comma) {
                        self.advance();
                        self.parse_expr();
                    }
                    self.expect(&TokenKind::RightBracket);
                }
                TokenKind::LeftParen => {
                    self.parse_arg_list();
                }
                TokenKind::Caret => {
                    self.advance(); // dereference
                }
                TokenKind::RightParen | TokenKind::RightBracket => {
                    // End of expression
                    break;
                }
                _ => {
                    // Safety: if we didn't make progress, break to avoid infinite loop
                    if self.pos == start_pos {
                        break;
                    }
                    // Reset start_pos for next iteration
                    start_pos = self.pos;
                }
            }
        }
    }

    fn parse_primary_expr(&mut self) {
        match self.current().kind {
            TokenKind::IntegerLiteral
            | TokenKind::FloatLiteral
            | TokenKind::StringLiteral
            | TokenKind::CharLiteral
            | TokenKind::HexLiteral
            | TokenKind::Nil => {
                self.advance();
            }
            TokenKind::Identifier | TokenKind::Message => {
                // Could be variable, function call, or type cast
                let _save_pos = self.pos;
                self.parse_qualified_name();

                // Handle generics: TList<T>.Create
                // Only treat < as generics if followed by a type name (starts with uppercase T, I followed by uppercase, or is String)
                if self.is(&TokenKind::Less) {
                    let peek_tok = &self.peek(1);
                    let next_char = peek_tok.text.chars().nth(1);
                    let looks_like_type = peek_tok.kind == TokenKind::String
                        || (peek_tok.kind == TokenKind::Identifier
                            && (peek_tok.text.starts_with('T')
                                || (peek_tok.text.starts_with('I')
                                    && next_char.is_some_and(|c| c.is_uppercase()))));
                    if looks_like_type {
                        self.advance();
                        self.parse_type();
                        while self.is(&TokenKind::Comma) {
                            self.advance();
                            self.parse_type();
                        }
                        self.expect(&TokenKind::Greater);
                    }
                }

                // Check for type cast: Type(expr)
                if self.is(&TokenKind::LeftParen) {
                    // This could be a function call or a type cast
                    // We'll parse it as an arg list - the parser doesn't distinguish
                    self.parse_arg_list();
                }
            }
            TokenKind::LeftParen => {
                self.advance();
                self.parse_expr();
                self.expect(&TokenKind::RightParen);
            }
            TokenKind::LeftBracket => {
                // Set literal
                self.advance();
                if !self.is(&TokenKind::RightBracket) {
                    self.parse_expr();
                    if self.is(&TokenKind::DotDot) {
                        self.advance();
                        self.parse_expr();
                    }
                    while self.is(&TokenKind::Comma) {
                        self.advance();
                        self.parse_expr();
                        if self.is(&TokenKind::DotDot) {
                            self.advance();
                            self.parse_expr();
                        }
                    }
                }
                self.expect(&TokenKind::RightBracket);
            }
            TokenKind::Inherited => {
                self.advance();
                if self.is(&TokenKind::Identifier) || self.is(&TokenKind::Message) {
                    self.parse_qualified_name();
                    if self.is(&TokenKind::LeftParen) {
                        self.parse_arg_list();
                    }
                }
            }
            _ => {
                let tok = self.current();
                if tok.kind != TokenKind::Eof {
                    self.diagnostics.error(
                        tok.line,
                        tok.col,
                        format!("expected expression, found '{}'", tok.text),
                    );
                    self.advance();
                }
            }
        }
    }

    fn check_interface_impl_consistency(&mut self) {
        // Only check when we have both interface declarations and implementations
        if self.interface_declarations.is_empty() || self.implementations.is_empty() {
            return;
        }

        // Check: every implementation must have a matching interface declaration
        for (class, method, line, col) in &self.implementations {
            let found = self
                .interface_declarations
                .iter()
                .any(|(c, m, _, _, _)| c == class && m == method);
            if !found {
                self.diagnostics.error(
                    *line,
                    *col,
                    format!(
                        "implementation of '{}.{}' has no corresponding interface declaration",
                        class, method
                    ),
                );
            }
        }

        // Check: every interface declaration must have a matching implementation
        for (class, method, line, col, is_abstract_or_external) in &self.interface_declarations {
            let found = self
                .implementations
                .iter()
                .any(|(c, m, _, _)| c == class && m == method);
            if !found && !is_abstract_or_external {
                self.diagnostics.error(
                    *line,
                    *col,
                    format!(
                        "method '{}' in class '{}' has no implementation",
                        method, class
                    ),
                );
            }
        }
    }
}
