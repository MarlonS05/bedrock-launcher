# AGENTS.md — bedrockLauncher

Android custom home screen app launcher. Read `docs/architecture.md` and the
relevant `docs/*-design-spec.md` before making changes. For Dart/Flutter
practices, see `docs/agent-guidelines/`.

## Architecture & layers

- **Layers:** `domain` (pure types, ports, use cases) · `repo` (repository impls) ·
  `db` (persistence) · `platform` (Android/OS adapters) · `screens` (views + BLoCs) ·
  `router`, `di`, `theme`, `logger` (cross-cutting).
- **BLoC** talks to a **use case** for writes/deletes and to a **repository** for
  simple reads.
- **All navigation happens in BLoCs** — views only dispatch events; never call
  the router or navigator from a view/widget. Register every screen in
  `lib/router/` — BLoCs navigate only via those registered routes (never ad-hoc
  paths or view-level navigation).
- **No infrastructure / plugins in BLoC** (no `go_router`, `sqflite`, and other
  direct platform/DB plugins).
- **`lib/domain` must not import** `package:flutter/`,
  `package:bedrock_launcher/screens/`, `package:bedrock_launcher/repo/`,
  `package:bedrock_launcher/db/`, `package:bedrock_launcher/platform/`,
  `package:bedrock_launcher/router/`, `package:bedrock_launcher/di/`,
  `package:bedrock_launcher/theme/`, `package:flutter_bloc/`, `package:go_router/`.
- Import boundaries are enforced by `bedrock_launcher_lint_rules` and
  `test/architecture/layer_import_test.dart`. Update both (and `docs/architecture.md`)
  if boundaries change.

## Conventions

- **One directory per screen** under `screens/<feature>/<screen>/` — BLoC,
  Freezed event/state, and UI (`*_view`) live together; never share a folder
  across screens (see `docs/project-structure.md`).
- **Widget classes.** Prefer `Widget` classes over helper methods that return
  a `Widget`. Screen-specific private widgets live in the same `*_view.*`
  file; shared widgets live under `screens/components/` (see
  `docs/project-structure.md`). Prefer `StatelessWidget` before `StatefulWidget`.
- **Dart/Flutter practices.** Interaction, tooling, style, serialization,
  testing, layout/assets, and dartdoc — see `docs/agent-guidelines/`.
- **Use cases grouped by entity/function** under `domain/use_cases/<group>/`
  — do not dump all use cases in one flat folder (see `docs/project-structure.md`).
- **DI registration split by kind** in `di/` — `_registerSingletons`,
  `_registerUseCases`, `_registerScreens` (etc.), with comment-marked
  sections inside (e.g. `// favorite use cases`); call them from one startup
  method in `main` (see `docs/project-structure.md`).
- **Routes + navigation.** Register every new screen and its route in
  `router/`. Views dispatch navigation-intent events; the BLoC calls the
  router for that registered route. No `context.go` / `Navigator` / router
  imports in `*_view.*` or shared components.
- **Keep docs in sync.** When you add or change functionality, structure, or
  layer boundaries, update the relevant docs in the same change — especially
  `docs/architecture.md`, affected `docs/*-design-spec.md`, and enforcement
  artifacts (lint rules, architecture tests) when boundaries change.
- Run `dart run build_runner build --delete-conflicting-outputs` after editing
  freezed/json_serializable sources.
- UI uses `lib/theme/` tokens. Errors via BLoC error states surfaced via a shared
  error widget / `BlocListener`.
- Schema changes require a numbered migration in `lib/db/`.
- Log API interactions at completion in the shared HTTP client — see
  `docs/architecture.md` (core rules) for placement; use `Success …` /
  `Failed …` with `logger.i` / `logger.w`.
- Configure the shared logger in `lib/logger/` — see `docs/architecture.md`
  (Logger setup) for `PrettyPrinter` options.
- Temporary diagnostic logs while investigating: `logger.d` only — remove before
  considering work done.

## Android launcher

- Register as the Android **HOME** intent handler in
  `android/app/src/main/AndroidManifest.xml` — not from presentation code.
- **Installed apps, launch intents, and system queries** go through
  `domain/services/` ports; adapters live in `lib/platform/` (e.g. package manager,
  intent launcher). BLoCs and views never import Android/plugin packages directly.
- **Favorites, layout, and user prefs** persist via repository + use cases
  (`lib/repo/`, `lib/db/`), not from BLoCs writing to storage directly.
- Feature specs: `docs/home-design-spec.md`, `docs/settings-design-spec.md`,
  `docs/all-apps-design-spec.md`.
- Step-by-step launcher setup guide (Appwriters tutorial, essential snippets):
  `docs/android-launcher-guide.md`.

## Plan mode

When using Plan mode, the plan body contains only three sections:
**Description**, **Files & layers** (mermaid diagram), and **Code to add**
(exact snippets, not prose about what to write). Omit goals-as-bullets, step
narratives, checklists, assumptions, and file-touch summaries.

## Commits

Use this format for commit messages:

```
[<type>] <short description>
```

Choose `type` from:

| Type | Use for |
|------|---------|
| `feat` | Feature |
| `fix` | Bug fix |
| `style` | Styling |
| `refrac` | Verbesserung des Codes |
| `test` | Automatisierte Tests |
| `docs` | Dokumentation |
| `project` | Änderungen der Projektkonfiguration |
| `perf` | Verbesserung der Performance |
| `wip` | Work in Progress / Zwischenstände |

Example: `[feat] Add order export to CSV`

## Verify

```bash
flutter analyze
flutter test
```
