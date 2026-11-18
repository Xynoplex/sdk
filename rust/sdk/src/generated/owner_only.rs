// Generated from protocol/specs/src/sign-in-store/owner-only.json; do not edit.
// Regenerate: make generate (codegen/lib/sign_in/rust.ml)
/// The directory's mode, in octal, on a system that has modes: its owner reads, writes and enters it, and nobody else does.
#[cfg(unix)]
const OWNER_ONLY_DIRECTORY_MODE: u32 = 0o700;
/// The mode, in octal, on a system that has modes, that a writer makes tokens.json's temporary file and its lock with, and the launcher its own files in its state home: its owner reads and writes each, and nobody else does.
#[cfg(unix)]
const OWNER_ONLY_FILE_MODE: u32 = 0o600;
/// The directory's access list on Windows, where a mode keeps nobody out, in SDDL, with `owner` where the SID of the user the writer runs as goes (its process token's user): full access for that user, the system and the administrators, and nobody else. It is handed down to everything made in the directory, and protected, so nothing is inherited from above.
#[cfg(windows)]
fn owner_only_directory_access_list(owner: &str) -> String {
    [
        "D:PAI(A;OICI;FA;;;",
        owner,
        ")(A;OICI;FA;;;SY)(A;OICI;FA;;;BA)",
    ]
    .concat()
}
/// A file's access list on Windows, which the launcher gives each file it keeps to its owner, in SDDL, with `owner` where the SID of the user it runs as goes: the directory's list, with nothing handed down, since a file has nothing beneath it. Full access for that user, the system and the administrators, and nobody else, protected, so nothing is inherited from above.
#[cfg(windows)]
#[expect(
    dead_code,
    reason = "the store's files inherit the directory's list; only the launcher gives a file its own"
)]
fn owner_only_file_access_list(owner: &str) -> String {
    ["D:PAI(A;;FA;;;", owner, ")(A;;FA;;;SY)(A;;FA;;;BA)"].concat()
}
