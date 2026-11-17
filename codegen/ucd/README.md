# Unicode Character Database

Files of the Unicode Character Database, unmodified, from
`https://www.unicode.org/Public/<version>/ucd/`, under Unicode's licence
([LICENSE](LICENSE)). Each file but `UnicodeData.txt` names its version on its
first line; the generator refuses files of different versions, and states the
version in what it writes from them. `UnicodeData.txt` names none: it is
fetched from the same version's directory as the others.

- `DerivedCoreProperties.txt`: the code points Unicode gives each derived
  property. The `unicode-case` group writes the Cased and Case_Ignorable
  properties from it.
- `PropList.txt`: the code points Unicode gives each other binary property.
  The `unicode-case` group writes the White_Space property from it.
- `UnicodeData.txt`: each code point's simple case mappings, among its other
  properties. The `unicode-case` group writes the lowercase mappings from it.
- `SpecialCasing.txt`: the case mappings of more than one code point, and
  those a context or a language decides. The `unicode-case` group writes the
  ones that always hold, and Final_Sigma's, from it.

Every file the generator writes from these carries the licence's copyright
and permission notice in its banner, as the licence asks of every copy of
Unicode's data.

To move to a new Unicode version, replace every file with that version's and
run `make generate`; the generated tables' diff is the change.
