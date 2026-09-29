# bedrock_launcher

A custom Android home screen app launcher built with Flutter. This is a layered, architecturally clean application that lets users customize their home screen with favorites, restricted apps, and an organized all-apps view.

## Project Overview

**bedrockLauncher** is a production-grade Flutter application designed to replace the Android system launcher. It features:

- **Custom Home Launcher** — Full-screen launcher with favorite apps and quick access to settings
- **All Apps Browser** — Organized view of all installed applications
- **Favorites Management** — Pin and reorder your most-used apps
- **Restricted Apps** — Hide apps you don't want to use
- **Clean Architecture** — Layered design with strict separation of concerns (domain, data-access, persistence, platform adapters, presentation)
- **BLoC State Management** — Predictable, testable state handling
- **Local Persistence** — SQLite-based storage for user preferences

## Getting Started

### Prerequisites

- **Flutter SDK**: 3.12.2 or higher
- **Android SDK**: API level 21 or higher (for launcher functionality)
- **Dart**: 3.12.2 or higher

### Installation

1. **Install dependencies**
   ```bash
   flutter pub get
   ```

2. **Generate code** (for freezed models and build_runner)
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

### Running the App

1. **Run the app in debug mode**
   ```bash
   flutter run
   ```

2. **Run in release mode**
   ```bash
   flutter run --release
   ```

### Setting as Default Home Launcher (Android)

After installing on your device:

1. Press the **Home** button on your device
2. Select **bedrockLauncher** from the app chooser
3. Tap **Always** to set it as your default home launcher

## Development

### Project Structure

- **`lib/domain/`** — Pure business logic, entities, use cases, and repository interfaces
- **`lib/repo/`** — Repository implementations and data-access layer
- **`lib/db/`** — SQLite database setup, DAOs, and migrations
- **`lib/platform/`** — Android/OS adapters (package manager, intent launcher, etc.)
- **`lib/screens/`** — UI screens and BLoC state management
- **`lib/router/`** — Navigation routing (go_router)
- **`lib/di/`** — Dependency injection setup
- **`lib/theme/`** — Design tokens and theming
- **`lib/logger/`** — Centralized logging

### Key Commands

| Command | Purpose |
|---------|---------|
| `flutter analyze` | Run Dart linter and analyzer |
| `flutter test` | Run unit and widget tests |
| `flutter run` | Run app in debug mode |
| `dart run build_runner build` | Generate freezed/serializable code |

### Architecture Principles

- **Layered design** — Each layer depends only inward (domain → repo → platform → screens)
- **BLoC for state** — All navigation and business logic goes through BLoCs
- **Domain-driven** — Business logic isolated from Flutter/platform code
- **No direct infra in BLoCs** — Platform/database access only through ports and repositories

For detailed architecture documentation, see [`docs/architecture.md`](docs/architecture.md).

### Code Standards

- Follow Dart style conventions (see [`docs/agent-guidelines/`](docs/agent-guidelines/))
- One screen directory per feature (e.g., `screens/home/`, `screens/all_apps/`)
- Prefer `StatelessWidget` over `StatefulWidget`
- Keep domain layer pure (no Flutter/plugin imports)
- Log API completions with `Success …` / `Failed …` format

## Documentation

- **[`docs/architecture.md`](docs/architecture.md)** — Layered architecture overview and strict import rules
- **[`docs/home-design-spec.md`](docs/home-design-spec.md)** — Home launcher feature spec
- **[`docs/all-apps-design-spec.md`](docs/all-apps-design-spec.md)** — All apps browser spec
- **[`docs/settings-design-spec.md`](docs/settings-design-spec.md)** — Settings screen spec
- **[`docs/design-language.md`](docs/design-language.md)** — UI design tokens and theming
- **[`docs/project-structure.md`](docs/project-structure.md)** — Directory layout conventions
- **[`docs/android-launcher-guide.md`](docs/android-launcher-guide.md)** — Step-by-step launcher setup guide

## Tech Stack

- **Flutter** 3.12.2+
- **Dart** 3.12.2+
- **State Management**: `flutter_bloc` 9.1.1
- **Routing**: `go_router` 16.2.1
- **DI**: `get_it` 8.2.0
- **Persistence**: `sqflite` 2.4.3
- **Logging**: `logger` 2.6.1
- **Code Generation**: `freezed` 3.2.0, `build_runner` 2.7.1
- **Installed Apps**: Vendored `device_apps` package

## Contributing

1. Read [`AGENTS.md`](AGENTS.md) for guidelines and conventions
2. Follow the architecture rules in [`docs/architecture.md`](docs/architecture.md)
3. Keep the domain layer pure
4. Ensure tests pass: `flutter test`
5. Run analyzer: `flutter analyze`

## License

This project is private and not currently licensed for public use.
