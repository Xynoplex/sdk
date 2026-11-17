# Unicode Character Database

Files of the Unicode Character Database, unmodified, from
`https://www.unicode.org/Public/<version>/ucd/`, under Unicode's licence
([LICENSE](LICENSE)). Each file's first line names its version, and the
generator states that version in what it writes from it.

- `DerivedCoreProperties.txt`: the code points Unicode gives each derived
  property. The `unicode-case` group writes the Cased and Case_Ignorable
  properties from it.

To move to a new Unicode version, replace the files with that version's and
run `make generate`; the generated tables' diff is the change.
