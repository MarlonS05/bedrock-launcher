# Enforcement — making import boundaries real

Prose in `docs/architecture.md` rots unless something fails the build when it's
violated. This project enforces the **strict import table** with two artifacts:

1. A **rules class** in `bedrock_launcher_lint_rules/lib/layer_import_rules.dart`
   that, given a file path, returns the list of import prefixes that file may
   not contain.
2. A **test** at `test/architecture/layer_import_test.dart` that walks every
   source file, extracts its imports, and asserts none match a denied prefix.

Together with the table in `docs/architecture.md`, these are the **three
sources that must stay in sync**. Change a boundary → change all three in the
same commit.

Verify locally:

```bash
flutter test test/architecture/layer_import_test.dart
```

## 1. The rules class (path-keyed deny-lists)

Shape (language-agnostic pseudocode; Dart constants live in
`bedrock_launcher_lint_rules`):

```
denyListForDomain      = [ framework, screens, repo, db, platform, router, di, theme, stateMgmt, navPkg ]
denyListForDataAccess  = [ framework, screens, router, di, stateMgmt ]
denyListForPersistence = [ framework, screens, repo, router, di, stateMgmt ]
denyListForInfra       = [ screens, repo, db, router, di, stateMgmt ]
denyListForView        = [ repo, db, router, di, navPkg ]
denyListForController  = [ repo, db, navPkg, ...infrastructurePlugins ]
denyListForComponent   = [ repo, db, router, di, stateMgmt, navPkg ]

function denialsForFile(path):
    if path under domainDir:            return denyListForDomain
    if path under dataAccessDir:        return denyListForDataAccess
    if path under persistenceDir:       return denyListForPersistence
    if path under infraDir:             return denyListForInfra
    if path under sharedComponentsDir:  return denyListForComponent
    if path is a presentation file:
        if path ends with view suffix:       return denyListForView
        if path ends with controller suffix: return denyListForController
    return []   # no restrictions

function importMatchesDenial(importUri, denialPrefix):
    return importUri startsWith denialPrefix   # plus intra-package suffix handling
```

Keep the deny-lists as plain constants keyed by a `denialsForFile(path)`
dispatcher so the mapping between file location and its rules is obvious and
greppable.

## 2. The test (walk sources, assert no denied imports)

Pseudocode (implemented by `test/architecture/layer_import_test.dart`):

```
for each source file under sourceRoot:
    denials = denialsForFile(file.path)
    if denials is empty: continue
    for each line in file:
        if line is an import/export directive:
            uri = extractUri(line)
            for each denial in denials:
                if importMatchesDenial(uri, denial):
                    record violation "file: line"
assert violations is empty   # message lists every violation
```

Run it in CI and locally. Because the rules class is shared between the test and
(optionally) any editor-integrated linter, there's exactly one definition of the
boundaries.

## 3. The sync rule

The `docs/architecture.md` strict import table, the rules-class deny-lists, and
the test must agree. If they disagree, **the table is the spec** and the other
two are bugs. Make boundary changes as one commit touching all three.

## Adapting to other ecosystems

The pattern (path predicate → deny-list → build-failing check) ports directly:

| Ecosystem | Mechanism |
|-----------|-----------|
| Dart / Flutter | Custom rules class + a `flutter test` that walks `lib/` (this project). |
| TypeScript / JS | `eslint-plugin-boundaries` or `eslint-plugin-import` `no-restricted-paths`; zones map to layers. |
| Python | `import-linter` contracts (`forbidden` / `layers` contract types). |
| Java / Kotlin | ArchUnit `layeredArchitecture()` / `noClasses().should().dependOnClassesThat()`. |
| Go | `depguard` / `go-arch-lint`. |

Whatever the tool, keep the source of truth human-readable in
`docs/architecture.md` and mechanically checked in CI.
