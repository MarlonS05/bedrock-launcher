# All Apps — Design & Layout Specification

<!--
  AGENT METADATA — parse before implementing
  feature_id: all-apps
  product_name: bedrockLauncher
  source: N/A
  target_platform: Android (custom HOME launcher)
  status: implemented
-->

> **Purpose:** Machine-readable design spec for the All Apps screen.
> **Audience:** Coding agents and contributors. Follow `AGENTS.md` and
> `docs/architecture.md` before writing code. Visual identity is defined in
> [`docs/design-language.md`](design-language.md).

---

## Document map

| § | Section |
|---|---------|
| 0 | [Repo conventions](#0-repo-conventions) |
| 1 | [Feature overview](#1-feature-overview) |
| 2 | [Data model](#2-data-model) |
| 3 | [Component reuse](#3-component-reuse) |
| 4 | [Screens](#4-screens) |
| 5 | [Navigation & state](#5-navigation--state) |
| 6 | [Interaction & tokens](#6-interaction--tokens) |
| 7 | [Out of scope](#7-out-of-scope) |

---

## 0. Repo conventions

| Rule | This feature |
|------|--------------|
| BLoC + codegen | `AllAppsBloc`, `AllAppsEvent`, `AllAppsState` (freezed) |
| Navigation in BLoC | Home dispatches `allAppsTapped`; `HomeBloc` calls `AppRouter.goAllApps()` |
| Infra I/O | `InstalledAppsPort` (domain) → `AndroidInstalledAppsAdapter` (platform MethodChannel) |
| Reads | `LoadLauncherAppsUseCase` (`ListInstalledAppsUseCase` + `GetFavoriteAppsUseCase` + `GetRestrictedAppsUseCase`) |
| Writes | `LaunchAppUseCase`, `AddFavoriteAppUseCase`, `RemoveFavoriteAppUseCase`, `UninstallAppUseCase`, `OpenAppSettingsUseCase` |
| Errors | `AllAppsState.error` surfaced via `BlocListener` SnackBar |
| Theme | `launcher*` tokens from [`design-language.md`](design-language.md); `AppSpacing` |

**Reference implementations:** [`home-design-spec.md`](home-design-spec.md).

---

## 1. Feature overview

### 1.1 Screens

| Screen | Route | Top bar |
|--------|-------|---------|
| All Apps | `/all-apps` | None — search field at top of content |

Entry: tap the three-line icon stacked above the settings button on home (bottom-right).

### 1.2 Flows

- **Browse all apps:** screen opens → search field auto-focused → full installed app list loads → tap name → launch app (or math hurdle if restricted) → navigate back to home in the background so the HOME button returns to the home screen.
- **Search:** type in search field → list filters live (case-insensitive substring match on `displayName`); press Enter / search IME action to launch the top filtered result (same as tap, including hurdle), then go home.
- **Long press:** hold an app name → action dialog with favorite toggle, uninstall, and app settings.
- **Back:** Android back or `go_router` pop returns to home.

---

## 2. Data model

Uses `LauncherApp` from `lib/domain/entities/launcher_app.dart`:

```dart
class LauncherApp {
  const LauncherApp({
    required this.packageName,
    required this.displayName,
    this.isRestricted = false,
  });

  final String packageName;
  final String displayName;
  final bool isRestricted;
}
```

| Value | Notes |
|-------|-------|
| `packageName` | Unique id for launch intent; from Android `PackageManager` |
| `displayName` | Shown in list and used for search filtering |
| `isRestricted` | Stamped by `LoadLauncherAppsUseCase` when a `RestrictedApp` row exists |

Apps are loaded with `onlyAppsWithLaunchIntent: true`, `includeSystemApps: true`, sorted A→Z by `displayName`.

---

## 3. Component reuse

### 3.1 Reuse as-is

- `LauncherBackground`, `LauncherAppList`, `AppSpacing`, launcher theme tokens.

### 3.2 Build new

| Component | Path | API |
|-----------|------|-----|
| `LauncherSearchField` | `lib/screens/components/launcher/launcher_search_field.dart` | `textColor`, `onChanged`, `trailing`, `autofocus: true` |
| `AllAppsCornerIcon` | `lib/screens/components/launcher/all_apps_corner_icon.dart` | Three-line icon for home entry |
| `LauncherAppActionDialog` | `lib/screens/components/launcher/launcher_app_action_dialog.dart` | Long-press action popup |
| `MathHurdleDialog` | `lib/screens/components/launcher/math_hurdle_dialog.dart` | Math challenge before launching restricted apps |

---

## 4. Screens

```yaml
route: /all-apps
folder: lib/screens/all_apps/
bloc: AllAppsBloc
view: AllAppsView
```

```
AllAppsView
└── BlocProvider<AllAppsBloc>
    └── BlocBuilder<AllAppsBloc, AllAppsState>
        └── BlocListener (errors)
            └── Stack (fit: expand)
                ├── LauncherBackground
                └── SafeArea
                    └── Column
                        ├── LauncherSearchField (autofocus, trailing refresh icon)
                        └── Expanded
                            └── LauncherAppList (filtered apps, long-press → action dialog)
```

`AllAppsView` observes app lifecycle and dispatches `resumed` when returning from
system uninstall or app-settings screens.

**States:**

| State | UI |
|-------|-----|
| `loading` | Brief initial load before appearance prefs are known |
| `loaded` (`isAppsLoading: true`) | Themed background + search field + inline list loading indicator |
| `loaded` (`isAppsLoading: false`) | Search field + filtered app list |
| `error` | Error message + retry button |

---

## 5. Navigation & state

### Routes

```dart
static const allApps = '/all-apps';
```

Pushed from home via `AppRouter.goAllApps()`. Android back pops to home.

### AllAppsBloc events

| Event | Behavior |
|-------|----------|
| `started` | Load appearance prefs and emit the themed shell with no apps (`isAppsLoading: true`), then dispatch `appsLoadRequested` |
| `appsLoadRequested` | Load installed apps and favorite package names, then emit `loaded` with `isAppsLoading: false`. When `preserveSearch` is true, keep the current search query and re-apply filtering. When `forceRefresh` is true, bypass the installed-apps cache. |
| `searchQueryChanged(query)` | Filter `allApps` by display name (case-insensitive) |
| `searchSubmitted` | Same launch gate as `appTapped` for `filteredApps.first`; no-op if query empty or no matches |
| `appTapped(packageName)` | If restricted → set `pendingRestrictedLaunchPackageName` (view shows `MathHurdleDialog`); else `LaunchAppUseCase` then `AppRouter.goHome()` |
| `restrictedLaunchConfirmed` | Launch pending package, clear pending, `AppRouter.goHome()` |
| `restrictedLaunchCancelled` | Clear pending without launching |
| `favoriteToggled(packageName)` | `AddFavoriteAppUseCase` or `RemoveFavoriteAppUseCase`; update `favoritePackageNames` |
| `uninstallTapped(packageName)` | `UninstallAppUseCase` (Android system uninstall UI) |
| `openAppSettingsTapped(packageName)` | `OpenAppSettingsUseCase` (Android Application Info) |
| `resumed` | Set `isAppsLoading: true` on the current shell, then dispatch `appsLoadRequested(preserveSearch: true)` |
| `refreshTapped` | Set `isAppsLoading: true`, then dispatch `appsLoadRequested(preserveSearch: true, forceRefresh: true)` |
| `backTapped` | `AppRouter.pop()` — returns to home |
| `retryTapped` | Re-load the themed shell, then dispatch `appsLoadRequested` |

### AllAppsBloc state (loaded)

| Field | Purpose |
|-------|---------|
| `allApps` | Full installed app list |
| `filteredApps` | Subset matching current search query |
| `searchQuery` | Current search text |
| `themeColorArgb` | Background color from appearance prefs |
| `useWhiteText` | Text color selection from appearance prefs |
| `showTileSeparators` | Whether list rows show separator lines |
| `favoritePackageNames` | Set of package names currently in favorites |
| `isAppsLoading` | Whether the installed app list is still being fetched |
| `pendingRestrictedLaunchPackageName` | Package awaiting math hurdle confirmation; null when idle |

---

## 6. Interaction & tokens

Same launcher tokens as home. No 1/3 top spacer — search field occupies the top of the content area.

**Search behavior:**

- Auto-focused on screen open (`autofocus: true` on `LauncherSearchField`)
- Filters as user types; no debounce
- Empty query shows all apps
- Case-insensitive substring match on `displayName`
- Borderless reload icon sits to the right of the search field (sibling in a `Row`); disabled while apps are loading; keeps the current search query and force-refreshes the installed-apps cache

**Long-press action dialog:**

- Triggered by long-pressing an app name in `LauncherAppList`
- Uses launcher typography and the current theme background/text colors
- Rounded corners (`LauncherTheme.dialogBorderRadius`)
- Favorite toggle label reflects current state (`Add to favorites` / `Remove from favorites`)
- Uninstall opens the Android system uninstall dialog directly (no in-app confirmation); hidden for the launcher itself (`com.example.bedrock_launcher`)
- Uninstall and app settings delegate to Android system UI via `InstalledAppsPort`
- Uninstall requires `REQUEST_DELETE_PACKAGES` in `AndroidManifest.xml` (normal permission, granted at install time)

---

## 7. Out of scope

- App icons in the list
- Grid layout
- Folders or categories
- Recent apps / usage sorting
