use std::fmt;

#[derive(Debug, Clone)]
pub struct Diagnostic {
    pub line: usize,
    pub col: usize,
    pub message: String,
}

impl fmt::Display for Diagnostic {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "error({},{}) : {}", self.line, self.col, self.message)
    }
}

pub struct Diagnostics {
    errors: Vec<Diagnostic>,
    filename: String,
}

impl Diagnostics {
    pub fn new(filename: String) -> Self {
        Self {
            errors: Vec::new(),
            filename,
        }
    }

    pub fn error(&mut self, line: usize, col: usize, message: String) {
        self.errors.push(Diagnostic { line, col, message });
    }

    pub fn has_errors(&self) -> bool {
        !self.errors.is_empty()
    }

    #[allow(dead_code)]
    pub fn error_count(&self) -> usize {
        self.errors.len()
    }

    pub fn report(&self) -> String {
        let mut out = String::new();
        for diag in &self.errors {
            out.push_str(&format!(
                "{}({},{}) : error: {}\n",
                self.filename, diag.line, diag.col, diag.message
            ));
        }
        if !self.errors.is_empty() {
            out.push_str(&format!("{} error(s) found.\n", self.errors.len()));
        }
        out
    }
}
