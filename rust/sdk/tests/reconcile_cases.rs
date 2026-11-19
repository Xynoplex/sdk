//! Where the words a model quoted are in a text is one table,
//! protocol/specs/src/annotations/reconcile-cases.json, which every SDK runs: this
//! crate's `xynolog::annotations::reconcile` answers, for each case's text
//! and quote, what TypeScript's and Python's answer.

use serde_json::Value;
use xynolog::annotations::reconcile;
use xynolog::types::{QuotedText, ReconciledSpan};

fn table() -> Value {
    serde_json::from_str(include_str!("../specs/annotations/reconcile-cases.json"))
        .expect("the table is JSON")
}

/// What a case says the model quoted.
fn quoted(case: &Value) -> QuotedText {
    let said = |member: &str| case["quoted"][member].as_str().map(str::to_owned);
    QuotedText {
        exact: said("exact").expect("what a model quoted has its words"),
        prefix: said("prefix"),
        suffix: said("suffix"),
    }
}

/// An answer as the table writes one, which is the wire's: nothing found is
/// `null`, a prefix or a suffix the text does not have is left out, and
/// which looser search found the span is said only where one did.
fn written(found: Option<&ReconciledSpan>) -> Value {
    serde_json::to_value(found).expect("a reconciled span serializes")
}

#[test]
fn every_quote_of_the_table_is_found_where_the_table_says_or_not_at_all() {
    let table = table();
    let cases = table["cases"].as_array().expect("cases");
    assert!(!cases.is_empty());
    for case in cases {
        let why = case["why"].as_str().expect("why");
        let text = case["text"].as_str().expect("text");
        let found = reconcile(text, &quoted(case));
        assert_eq!(written(found.as_ref()), case["reconciled"], "{why}");
    }
}
