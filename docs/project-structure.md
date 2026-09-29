# Project structure

Recommended folder scaffolding for bedrockLauncher. The key idea: **one
directory per layer**, **one directory per screen** in presentation (BLoC +
Freezed event/state + UI together), a separate **lint-rules package**, and an
**architecture test** that guards the whole thing.

## Recommended tree

```
bedrockLauncher/
├── AGENTS.md                         # terse agent rules
├── docs/
│   ├── architecture.md               # layers + strict import table
│   ├── agent-guidelines/             # Dart/Flutter practices
│   ├── design-spec.template.md       # copy per feature
│   └── <feature>-design-spec.md      # one machine-readable spec per feature
├── bedrock_launcher_lint_rules/      # standalone package holding the deny-list rules class
│   └── lib/
│       └── layer_import_rules.dart   # path-keyed deny-lists
├── lib/
│   ├── domain/                       # PURE: entities, models, repositories (interfaces),
│   │   ├── entities/                 #        services (ports), use_cases, formatters, validators
│   │   ├── models/
│   │   ├── repositories/             # interfaces only
│   │   ├── services/                 # ports (interfaces) to infra
│   │   ├── use_cases/                # one class per write/delete; grouped by entity/function
│   │   │   ├── <entity>/             # e.g. favorite_app/, appearance/
│   │   │   │   └── <verb>_<noun>_use_case.*
│   │   │   └── <function>/           # e.g. launch/, system/ — when not tied to one entity
│   │   │       └── <verb>_<noun>_use_case.*
│   │   ├── formatters/
│   │   └── validators/
│   ├── repo/                         # repository implementations (fulfil domain interfaces)
│   ├── db/                           # persistence — connection, tables, migrations, DAOs
│   │   ├── app_database.*            # open/close, version, transaction()
│   │   ├── tables/                   # CREATE TABLE DDL / table constants
│   │   ├── migrations/               # incremental upgrade steps
│   │   └── daos/                     # one DAO per table/aggregate — SQL CRUD
│   │       └── <entity>_dao.*
│   ├── platform/                     # OS/plugin adapters implementing domain ports
│   ├── screens/                      # PRESENTATION — one directory per screen
│   │   ├── components/               # shared / reusable widgets only
│   │   │   ├── launcher/             # home / all-apps chrome
│   │   │   └── win95/                # settings chrome
│   │   ├── home/
│   │   │   ├── home_view.*
│   │   │   ├── home_bloc.*
│   │   │   ├── home_event.*
│   │   │   └── home_state.*
│   │   ├── all_apps/
│   │   │   └── …                     # view + BLoC + Freezed event/state
│   │   └── settings/
│   │       ├── settings_view.*       # settings hub
│   │       ├── appearance/           # nested screen folder
│   │       ├── favorites/
│   │       ├── permissions/
│   │       └── preferred_apps/
│   ├── router/                       # route table — register every screen here
│   ├── di/                           # dependency injection wiring
│   ├── theme/                        # design tokens (launcher/ + win95/)
│   ├── logger/                       # shared Logger instance
│   │   └── logger.*
│   └── main.* (entrypoint)
└── test/
    └── architecture/
        └── layer_import_test.dart    # walks lib/, fails on denied imports
```

## Folder purposes

| Folder | Contains | Never contains |
|--------|----------|----------------|
| `domain/` | Pure business types, interfaces, use cases | Framework, UI, DB, platform imports |
| `repo/` | Repository implementations | UI, routing, DI, state-mgmt |
| `db/` | `AppDatabase`, tables, migrations, DAOs | UI, repo, routing, DI |
| `platform/` | Adapters for OS/plugins (implement domain ports) | UI, repo, db, routing, DI |
| `screens/<feature>/` or `screens/<feature>/<screen>/` | One screen’s view + BLoC + Freezed event/state (+ generated); private Widget classes may live in `*_view.*` | Separate widget *files*; other screens; data-access / navigation packages |
| `screens/components/` | Shared / reusable UI widgets (subdirs OK) | Data-access, routing, DI, state-mgmt; screen BLoC/view files |
| `router/` | Route table — every screen registered here | Business logic; ad-hoc unregistered routes |
| `di/`, `theme/`, `logger/` | Cross-cutting wiring, tokens, logging | Business logic |

## Naming conventions

- **One directory per screen.** Every screen gets its own folder under
  `screens/<feature>/` (or a nested folder for settings sub-screens). That
  folder holds only the screen’s view, BLoC, Freezed event/state, and generated
  parts — no separate widget *files*. Example:

  ```
  screens/home/
  ├── home_view.dart      # UI (+ private screen-specific Widget classes)
  ├── home_bloc.dart      # BLoC
  ├── home_event.dart     # Freezed events
  ├── home_state.dart     # Freezed state
  └── home_bloc.freezed.dart   # generated — do not edit
  ```

- **Widget classes:** Prefer small `Widget` subclasses over methods returning
  `Widget`. Screen-only pieces: private classes in `*_view.*`. Shared:
  `screens/components/` only — do not add separate widget files inside a
  screen directory. Subdirectories under `components/` are allowed for
  grouping (`launcher/`, `win95/`).

- **Feature folders**: one folder per feature under `screens/`, then one
  subfolder per screen when a feature has multiple screens (e.g. settings).
- **Presentation files** use consistent suffixes so the enforcement test can key
  rules off them:
  - `*_view.*` — the UI view (render + dispatch only; **no navigation**)
  - `*_bloc.*` (or `*_controller.*`) — logic + **all navigation** (calls router)
  - `*_event.*` / `*_state.*` — Freezed inputs/outputs (codegen-friendly)
  - `*.freezed.dart` — generated Freezed parts (never hand-edit)
- **Navigation & routes:** register every screen and its route in `router/`
  when adding a screen. Only BLoCs navigate — a view that needs to leave
  dispatches an event; the BLoC calls the router for that registered route.
  Never navigate from `*_view.*` or `screens/components/`, and never use
  paths that are not registered in the router.
- **Use cases**: one class per write/delete operation, named
  `<Verb><Noun>UseCase` (e.g. `AddFavoriteAppUseCase`,
  `UninstallAppUseCase`). Sort them into subdirectories under
  `domain/use_cases/` by the entity they serve, or by function when the
  operation is not tied to a single entity — never a flat dump of all use
  cases in `use_cases/`.

  ```
  domain/use_cases/
  ├── favorite_app/
  │   ├── add_favorite_app_use_case.dart
  │   └── remove_favorite_app_use_case.dart
  ├── appearance/
  │   └── set_appearance_preferences_use_case.dart
  └── launch/
      └── launch_app_use_case.dart
  ```
- **Repository interfaces** live in `domain/repositories/`; their `...Impl` live
  in `repo/`.
- **Service ports** (interfaces to infra) live in `domain/services/`; their
  adapters live in `platform/`.
- **DAOs**: one class per table/aggregate in `db/daos/`, named
  `<Entity>Dao` in `<entity>_dao.*` (e.g. `FavoriteAppDao` in
  `favorite_app_dao.dart`). DAOs own SQL CRUD and return domain entities.
- **`AppDatabase`**: connection handle, version, `onCreate`/`onUpgrade`, and
  `transaction()` for cross-DAO writes. No per-table queries — those belong in DAOs.

## Wiring (DI)

`di/` constructs concrete implementations and provides them to the presentation
layer. Controllers receive use cases and repositories via DI — they never
construct DB or platform objects directly.

**Split registration into private helpers**, then call them from one public
startup method (e.g. `configureDependencies()`) invoked from `main` before
`runApp`. Typical helpers:

- `_registerSingletons` — `AppDatabase`, DAOs, repository impls, platform
  adapters, shared clients (order: DB → DAOs → repos/adapters)
- `_registerUseCases` — domain use cases
- `_registerScreens` — BLoC / screen factories

Inside each helper, group registrations into **comment-marked sections** when
there is more than one feature area (e.g. `// favorite use cases`,
`// settings screens`). Do not dump every registration into one flat list.

```dart
// lib/di/di.dart (conceptual target layout)
Future<void> configureDependencies() async {
  _registerSingletons();
  _registerUseCases();
  _registerScreens();
}

void _registerSingletons() {
  // database
  getIt.registerLazySingleton<AppDatabase>(() => AppDatabase());
  getIt.registerLazySingleton<FavoriteAppDao>(() => FavoriteAppDao(getIt()));

  // favorite repos
  getIt.registerLazySingleton<FavoriteAppRepository>(
    () => FavoriteAppRepositoryImpl(getIt()),
  );
}

void _registerUseCases() {
  // favorite use cases
  getIt.registerLazySingleton(() => AddFavoriteAppUseCase(getIt()));
  getIt.registerLazySingleton(() => RemoveFavoriteAppUseCase(getIt()));

  // launch use cases
  getIt.registerLazySingleton(() => LaunchAppUseCase(getIt()));
}

void _registerScreens() {
  // home screens
  getIt.registerFactory(() => HomeBloc(getIt(), getIt()));

  // settings screens
  getIt.registerFactory(() => SettingsBloc(getIt()));
}
```

## Logger setup

Centralize the `logger` package in `lib/logger/logger.*`. Import it everywhere —
do not create ad-hoc `Logger` instances. See
[architecture.md — Logger setup](architecture.md#logger-setup)
for `PrettyPrinter` configuration (`methodCount: 1`, `errorMethodCount: 1`).
Use `logger.i` / `logger.w` / `logger.d` per AGENTS.md.
