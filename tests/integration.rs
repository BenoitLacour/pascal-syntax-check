use std::path::{Path, PathBuf};
use std::process::Command;

fn get_binary_path() -> PathBuf {
    let manifest_dir = Path::new(env!("CARGO_MANIFEST_DIR"));
    let profile = if cfg!(debug_assertions) {
        "debug"
    } else {
        "release"
    };
    manifest_dir
        .join("target")
        .join(profile)
        .join("pascal-check")
}

fn run_pascal_check(file: &Path) -> (i32, String, String) {
    let binary = get_binary_path();
    let output = Command::new(&binary)
        .arg(file)
        .output()
        .unwrap_or_else(|e| panic!("Failed to execute {:?}: {}", binary, e));

    let exit_code = output.status.code().unwrap_or(-1);
    let stdout = String::from_utf8_lossy(&output.stdout).to_string();
    let stderr = String::from_utf8_lossy(&output.stderr).to_string();
    (exit_code, stdout, stderr)
}

fn valid_files() -> Vec<PathBuf> {
    let dir = Path::new(env!("CARGO_MANIFEST_DIR"))
        .join("Examples")
        .join("valid");
    assert!(dir.exists(), "Examples/valid/ directory not found");
    let mut files: Vec<PathBuf> = std::fs::read_dir(&dir)
        .expect("Failed to read Examples/valid/")
        .filter_map(|e| e.ok())
        .map(|e| e.path())
        .filter(|p| p.extension().map(|ext| ext == "pas").unwrap_or(false))
        .collect();
    files.sort();
    files
}

fn invalid_files() -> Vec<PathBuf> {
    let dir = Path::new(env!("CARGO_MANIFEST_DIR"))
        .join("Examples")
        .join("invalid");
    assert!(dir.exists(), "Examples/invalid/ directory not found");
    let mut files: Vec<PathBuf> = std::fs::read_dir(&dir)
        .expect("Failed to read Examples/invalid/")
        .filter_map(|e| e.ok())
        .map(|e| e.path())
        .filter(|p| p.extension().map(|ext| ext == "pas").unwrap_or(false))
        .collect();
    files.sort();
    files
}

#[test]
fn all_valid_files_pass() {
    let files = valid_files();
    assert!(!files.is_empty(), "No valid .pas files found");

    for file in &files {
        let (code, _stdout, stderr) = run_pascal_check(file);
        assert_eq!(
            code,
            0,
            "Valid file {:?} should exit 0, got {}.\nStderr:\n{}",
            file.file_name().unwrap(),
            code,
            stderr
        );
    }
}

#[test]
fn all_invalid_files_fail() {
    let files = invalid_files();
    assert!(!files.is_empty(), "No invalid .pas files found");

    for file in &files {
        let (code, _stdout, stderr) = run_pascal_check(file);
        assert_eq!(
            code,
            1,
            "Invalid file {:?} should exit 1, got {}.\nStderr:\n{}",
            file.file_name().unwrap(),
            code,
            stderr
        );
    }
}

#[test]
fn invalid_files_produce_stderr() {
    let files = invalid_files();
    assert!(!files.is_empty(), "No invalid .pas files found");

    for file in &files {
        let (_code, _stdout, stderr) = run_pascal_check(file);
        assert!(
            !stderr.is_empty(),
            "Invalid file {:?} should produce stderr output",
            file.file_name().unwrap()
        );
    }
}

#[test]
fn missing_file_exits_2() {
    let (code, _stdout, stderr) = run_pascal_check(Path::new("nonexistent_file.pas"));
    assert_eq!(code, 2, "Missing file should exit 2, got {}", code);
    assert!(
        !stderr.is_empty(),
        "Missing file should produce stderr output"
    );
}

#[test]
fn no_args_exits_2() {
    let binary = get_binary_path();
    let output = Command::new(&binary)
        .output()
        .unwrap_or_else(|e| panic!("Failed to execute {:?}: {}", binary, e));

    let exit_code = output.status.code().unwrap_or(-1);
    assert_eq!(exit_code, 2, "No args should exit 2, got {}", exit_code);

    let stderr = String::from_utf8_lossy(&output.stderr);
    assert!(
        stderr.contains("Usage"),
        "No args should print usage, got: {}",
        stderr
    );
}
