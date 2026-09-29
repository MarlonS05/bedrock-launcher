# Settings — Design & Layout Specification

<!--
  AGENT METADATA — parse before implementing
  feature_id: settings
  product_name: bedrockLauncher
  source: N/A (Windows 95 visual reference)
  target_platform: Android
  status: design-only
-->

> **Purpose:** Machine-readable design spec for implementing the settings experience
> in Windows 95 style.
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
| A | [Implementation checklist](#appendix-a-implementation-checklist) |

---

## 0. Repo conventions

| Rule | This feature |
|------|--------------|
| BLoC + codegen | `SettingsBloc`, `SettingsEvent`, `SettingsState` (freezed when implemented) |
| Navigation in BLoC | Views dispatch events; `SettingsBloc` calls `AppRouter` |
| Infra I/O | Preference ports / repositories as settings are added |
| Persistence | Repository + use cases per setting (future) |
| Writes | `<Set…>UseCase` per preference — BLoC does not write directly |
| Errors | `SettingsState.error` via shared error widget + `BlocListener` inside window |
| Theme | `win95*` tokens from [`design-language.md`](design-language.md); `AppSpacing` |

**Replaces:** N/A — new feature.

**Reference implementations:** Home entry point: [`home-design-spec.md`](home-design-spec.md) (corner slot → `/settings`).

---

## 1. Feature overview

### 1.1 Screens

| Screen | Route | Top bar |
|--------|-------|---------|
| Settings hub | `/settings` | Win95 title bar inside `Win95WindowFrame` |
| Appearance | `/settings/appearance` | Same window chrome |
| Permissions | `/settings/permissions` | Same window chrome |
| Favorites | `/settings/favorites` | Same window chrome |
| Preferred Apps | `/settings/preferred-apps` | Same window chrome |
| Restricted Apps | `/settings/restricted-apps` | Same window chrome |

Entry: home bottom-right corner slot (`HomeEvent.settingsTapped` → `AppRouter.goSettings()`).

### 1.2 Flows

- **Open settings:** navigate to `/settings` → teal desktop + centered settings window.
- **Navigate sub-setting (future):** push `/settings/...` or swap window body — same Win95 chrome.
- **Back:** title-bar close or Android back → BLoC pops route / closes window.

---

## 2. Data model

```dart
enum LauncherTextColor { black, white }

class LauncherAppFont {
  final String familyId; // 'system' or device family id
}

class AppearancePreferences {
  final int themeColorArgb;
  final LauncherTextColor textColor;
  final bool showTileSeparators;
  final LauncherAppFont appFont;
}
```

| Value | Label | Notes |
|-------|-------|-------|
| `themeColorArgb` | Theme color | Launcher background color (ARGB int) |
| `textColor` | Text color | `black` or `white` for app name labels |
| `showTileSeparators` | Tile separators | 1px lines between app name rows |
| `appFont` | App font | Font for app name labels (`Default` / `system`, or a device-installed family id) |

**Default:** `themeColorArgb = 0xFF1A1A1A`, `textColor = black`, `showTileSeparators = true`, `appFont = system`.

**App font discovery:** Appearance loads available families via `InstalledFontsPort` → `AndroidInstalledFontsAdapter` / `SystemFontsHandler` (API 29+ `SystemFonts.getAvailableFonts()`, API 28 directory scan). Selected faces are registered with Flutter `FontLoader` before preview and launcher labels render.

**Persistence:** `GetAppearancePreferencesUseCase`, `SetAppearancePreferencesUseCase` via `AppearancePreferencesRepository` (SQLite migration 002; tile separators added in migration 003; app font added in migration 004).

**Preferred apps:**

```dart
class PreferredAppsPreferences {
  final String? clockPackageName;
  final String? phonePackageName;
  final String? cameraPackageName;
  final String? galleryPackageName;
}
```

| Value | Label | Notes |
|-------|-------|-------|
| `clockPackageName` | Clock | Package for home clock tap; null = system default |
| `phonePackageName` | Phone | Preferred dialer/phone app; null = system default |
| `cameraPackageName` | Camera | Preferred camera app; null = system default |
| `galleryPackageName` | Gallery | Preferred gallery app; null = system default |

**Default:** all package names `null` (system default).

**Persistence:** `GetPreferredAppsPreferencesUseCase`, `SetPreferredAppsPreferencesUseCase` via `PreferredAppsPreferencesRepository` (SQLite migration 005).

**Restricted (distracting) apps:**

```dart
class RestrictedApp {
  const RestrictedApp({required this.packageName});
  final String packageName; // PRIMARY KEY — existence = restricted
}
```

| Value | Label | Notes |
|-------|-------|-------|
| `packageName` | Distracting apps | Row present → math hurdle before launch |

**Default:** empty set (no restricted apps).

**Persistence:** `GetRestrictedAppsUseCase`, `ReplaceRestrictedAppsUseCase` via `RestrictedAppRepository` (SQLite migration 006). Drafted on Restricted Apps until Save.

**Permissions (no persistence):** `OpenDefaultLauncherSettingsUseCase` via `LauncherSettingsPort` → `AndroidLauncherSettingsAdapter` → `LauncherSettingsHandler` MethodChannel (opens system default home-app settings).

---

## 3. Component reuse

### 3.1 Reuse as-is

- `AppSpacing` for internal window padding and control gaps.

### 3.2 Adapt

- None.

### 3.3 Do not reuse

- Material 3 `ElevatedButton`, `FilledButton`, `Card`, `Dialog` — settings uses Win95 components only.
- Launcher components (`LauncherBackground`, `LauncherAppList`, etc.) — different visual system.

### 3.4 Build new

| Component | Path | API (sketch) |
|-----------|------|--------------|
| `Win95WindowFrame` | `lib/screens/components/win95/win95_window_frame.dart` | `title`, `onClose`, `child` |
| `Win95TitleBar` | `lib/screens/components/win95/win95_title_bar.dart` | `title`, `active`, `onClose` |
| `Win95Button` | `lib/screens/components/win95/win95_button.dart` | `label`, `onPressed`, `enabled` |
| `Win95Panel` | `lib/screens/components/win95/win95_panel.dart` | inset group box; optional `label` |
| `Win95Desktop` | `lib/screens/components/win95/win95_desktop.dart` | teal full-screen backdrop; `child` |
| `Win95ExplorerTile` | `lib/screens/components/win95/win95_explorer_tile.dart` | `label`, `icon`, `onTap` — explorer icon + label |
| `Win95ExplorerViewport` | `lib/screens/components/win95/win95_explorer_viewport.dart` | white inset explorer content area |
| `SettingsMenuIcons` | `lib/screens/components/win95/settings_menu_icons.dart` | PNG assets from `lib/screens/components/win95/icons/` |
| `Win95Dropdown` | `lib/screens/components/win95/win95_dropdown.dart` | `value`, `items`, `labelBuilder`, `onChanged` |

Bevel helpers live in `lib/theme/win95/win95_decorations.dart` (outset / inset `BoxDecoration` or border painters).

---

## 4. Screens

```yaml
route: /settings
folder: lib/screens/settings/
bloc: SettingsBloc
view: SettingsView
```

```
SettingsView
└── PopScope (Android back → backTapped)
    └── BlocBuilder<SettingsBloc, SettingsState>
        └── Win95Desktop (win95Desktop fill)
            └── Center
                └── Win95WindowFrame (title: "Settings")
                    ├── Win95TitleBar (active, close → backTapped)
                    └── Padding (AppSpacing.md)
                        └── Column
                            ├── Win95ExplorerViewport (white inset area)
                            │   └── GridView (crossAxisCount: 2)
                            │       ├── Win95ExplorerTile (Appearance)
                            │       ├── Win95ExplorerTile (Permissions)
                            │       ├── Win95ExplorerTile (Favorites)
                            │       ├── Win95ExplorerTile (Preferred Apps)
                            │       └── Win95ExplorerTile (Restricted Apps)
                            └── Align (right)
                                └── Win95Button ("<< back" — backTapped)
```

```yaml
route: /settings/appearance
folder: lib/screens/settings/appearance/
bloc: AppearanceSettingsBloc
view: AppearanceSettingsView
```

```
AppearanceSettingsView
└── PopScope (Android back → backTapped)
    └── BlocBuilder<AppearanceSettingsBloc, AppearanceSettingsState>
        └── Win95Desktop
            └── Win95WindowFrame (title: "Appearance")
                └── Padding
                    └── Column
                        ├── SingleChildScrollView
                        │   ├── _AppearancePreview (theme + text color)
                        │   ├── Win95Panel → Win95ColorPicker
                        │   ├── Win95Panel → Win95RadioButton (Black / White)
                        │   ├── Win95Panel → Win95Dropdown (App font)
                        │   └── Win95Panel → Win95Checkbox (Show separator lines)
                        └── Win95Button ("<< back" — backTapped)
```

```yaml
route: /settings/permissions
folder: lib/screens/settings/permissions/
bloc: PermissionsSettingsBloc
view: PermissionsSettingsView
```

```
PermissionsSettingsView
└── PopScope (Android back → backTapped)
    └── BlocBuilder<PermissionsSettingsBloc, PermissionsSettingsState>
        └── Win95Desktop
            └── Win95WindowFrame (title: "Permissions")
                └── Padding
                    └── Column
                        ├── SingleChildScrollView
                        │   └── Win95Panel
                        │       ├── explanatory text
                        │       └── Win95Button ("Open home app settings" — openDefaultLauncherTapped)
                        └── Win95Button ("<< back" — backTapped)
```

```yaml
route: /settings/preferred-apps
folder: lib/screens/settings/preferred_apps/
bloc: PreferredAppsSettingsBloc
view: PreferredAppsSettingsView
```

```
PreferredAppsSettingsView
└── PopScope (Android back → backTapped)
    └── BlocBuilder<PreferredAppsSettingsBloc, PreferredAppsSettingsState>
        └── Win95Desktop
            └── Win95WindowFrame (title: "Preferred Apps")
                └── Padding
                    └── Column
                        ├── SingleChildScrollView
                        │   ├── Win95Panel → Win95Dropdown (Clock)
                        │   ├── Win95Panel → Win95Dropdown (Phone)
                        │   ├── Win95Panel → Win95Dropdown (Camera)
                        │   └── Win95Panel → Win95Dropdown (Gallery)
                        ├── Win95Button ("Save" — saveTapped)
                        └── Win95Button ("<< back" — backTapped)
```

```yaml
route: /settings/restricted-apps
folder: lib/screens/settings/restricted_apps/
bloc: RestrictedAppsSettingsBloc
view: RestrictedAppsSettingsView
```

```
RestrictedAppsSettingsView
└── PopScope (Android back → backTapped)
    └── BlocBuilder<RestrictedAppsSettingsBloc, RestrictedAppsSettingsState>
        └── Win95Desktop
            └── Win95WindowFrame (title: "Restricted Apps")
                └── Padding
                    └── Column
                        ├── SingleChildScrollView
                        │   └── Win95Panel → Win95Checkbox list (Distracting apps)
                        ├── Win95Button ("Save" — saveTapped)
                        └── Win95Button ("<< back" — backTapped)
```

**Selection / actions:**

- Title bar close (×) or Android back → `SettingsEvent.backTapped` → `AppRouter.pop()` (not `goHome()`).
- `<< back` button → same as title bar close; dotted focus border on press, held via `SettingsState.closing` until pop completes.
- Menu tiles → `appearanceTapped` navigates to `/settings/appearance`; `permissionsTapped` navigates to `/settings/permissions`; `favoritesTapped` navigates to `/settings/favorites`; `preferredAppsTapped` navigates to `/settings/preferred-apps`; `restrictedAppsTapped` navigates to `/settings/restricted-apps`.
- Appearance sub-settings → theme color picker + text color radio (black/white); persisted via use cases.
- Permissions sub-settings → "Open home app settings" opens Android default home-app screen via `OpenDefaultLauncherSettingsUseCase`.
- Favorites sub-settings → reorderable list of favorited apps; persisted via `ReorderFavoriteAppsUseCase` on Save.
- Preferred Apps sub-settings → dropdowns for Clock / Phone / Camera / Gallery from installed apps (plus System default); draft until Save via `SetPreferredAppsPreferencesUseCase`. Home shortcuts honor saved packages via `OpenDialerUseCase` / `OpenCameraUseCase` / `OpenGalleryUseCase` / `OpenClockUseCase` (preferred `LaunchAppUseCase`, else system intent). Restricted preferred packages require the math hurdle before launch.
- Restricted Apps sub-settings → **Distracting apps** checkbox list over installed apps; draft until Save via `ReplaceRestrictedAppsUseCase`.

**States & styling:**

| State | UI |
|-------|-----|
| `loaded` | Explorer grid with Appearance, Permissions, Favorites, Preferred Apps, Restricted Apps |
| `error` | Error message inside window client area (Win95 text styles) |
| Button pressed | Inset bevel (see §6) |
| Button disabled | Flat gray, no outset bevel |

---

## 5. Navigation & state

### Routes

```dart
// lib/router/routes.dart
static const settings = '/settings';
static const settingsAppearance = '/settings/appearance';
static const settingsPermissions = '/settings/permissions';
static const settingsFavorites = '/settings/favorites';
static const settingsPreferredApps = '/settings/preferred-apps';
static const settingsRestrictedApps = '/settings/restricted-apps';
```

Register under `GoRouter` with Win95-friendly transitions optional (instant or none — no Material fade).

### SettingsBloc events

**SettingsBloc:** `started`, `backTapped`, `appearanceTapped`, `permissionsTapped`, `favoritesTapped`, `preferredAppsTapped`, `restrictedAppsTapped`

- `started`: emit loaded stub state.
- `backTapped`: `AppRouter.pop()` — returns to previous route on the stack.
- `appearanceTapped`: `AppRouter.goSettingsAppearance()` → push `/settings/appearance`.
- `permissionsTapped`: `AppRouter.goSettingsPermissions()` → push `/settings/permissions`.
- `favoritesTapped`: `AppRouter.goSettingsFavorites()` → push `/settings/favorites`.
- `preferredAppsTapped`: `AppRouter.goSettingsPreferredApps()` → push `/settings/preferred-apps`.
- `restrictedAppsTapped`: `AppRouter.goSettingsRestrictedApps()` → push `/settings/restricted-apps`.

**AppearanceSettingsBloc:** `started`, `backTapped`, `saveTapped`, `themeColorChanged`, `textColorChanged`, `tileSeparatorsChanged`

- `started`: load prefs via `GetAppearancePreferencesUseCase`; draft mirrors saved values.
- `themeColorChanged` / `textColorChanged` / `tileSeparatorsChanged`: update draft only (not persisted).
- `saveTapped`: persist draft via `SetAppearancePreferencesUseCase`; update saved values.
- `backTapped`: pop immediately; unsaved draft changes are discarded silently.

**PermissionsSettingsBloc:** `started`, `backTapped`, `openDefaultLauncherTapped`

- `started`: emit `loaded` immediately (no async load).
- `openDefaultLauncherTapped`: call `OpenDefaultLauncherSettingsUseCase`; surface errors inline.
- `backTapped`: pop immediately.

**FavoritesSettingsBloc:** `started`, `backTapped`, `saveTapped`, `orderChanged`

- `started`: load favorites via `PruneUninstalledFavoriteAppsUseCase` (removes favorites for uninstalled apps, then returns remaining order); draft mirrors saved order.
- `orderChanged`: update draft package-name order only (not persisted).
- `saveTapped`: persist draft via `ReorderFavoriteAppsUseCase`; update saved order.
- `backTapped`: pop immediately; unsaved draft changes are discarded silently.

**PreferredAppsSettingsBloc:** `started`, `backTapped`, `saveTapped`, `clockAppChanged`, `phoneAppChanged`, `cameraAppChanged`, `galleryAppChanged`

- `started`: load prefs via `GetPreferredAppsPreferencesUseCase` and installed apps via `ListInstalledAppsUseCase`; draft mirrors saved values.
- `*AppChanged`: update draft package name only (not persisted); null = system default.
- `saveTapped`: persist draft via `SetPreferredAppsPreferencesUseCase`; update saved values.
- `backTapped`: pop immediately; unsaved draft changes are discarded silently.

**RestrictedAppsSettingsBloc:** `started`, `backTapped`, `saveTapped`, `restrictedAppToggled`

- `started`: load restricted apps via `GetRestrictedAppsUseCase` and installed apps via `ListInstalledAppsUseCase`; draft mirrors the saved set.
- `restrictedAppToggled`: add/remove package in draft restricted set only (not persisted).
- `saveTapped`: persist draft via `ReplaceRestrictedAppsUseCase`; update saved set.
- `backTapped`: pop immediately; unsaved draft changes are discarded silently.

**Entry from home:** `HomeEvent.settingsTapped` → `AppRouter.goSettings()` (`push` `/settings`).

---

## 6. Interaction & tokens

Canonical palette for `lib/theme/win95/win95_colors.dart`:

| Token | Hex | Usage |
|-------|-----|-------|
| `win95Desktop` | `#008080` | Full-screen settings backdrop |
| `win95WindowFace` | `#C0C0C0` | Window client area |
| `win95ButtonFace` | `#C0C0C0` | Button fill |
| `win95Highlight` | `#FFFFFF` | Top / left bevel (light) |
| `win95Shadow` | `#808080` | Bottom / right bevel (mid) |
| `win95DarkShadow` | `#000000` | Outer 1 px edge |
| `win95TitleBarActive` | `#000080` | Active title bar background |
| `win95TitleBarInactive` | `#808080` | Inactive title bar |
| `win95TitleBarText` | `#FFFFFF` | Title bar label |
| `win95Text` | `#000000` | Body labels |
| `win95Selection` | `#000080` | Selected list row |
| `win95SelectionText` | `#FFFFFF` | Selected list row text |

### Control specifications

**Raised button (default):**

- Fill: `win95ButtonFace`
- Border: 2 px — top/left `win95Highlight`, bottom/right `win95Shadow`
- Outer: 1 px `win95DarkShadow` on container
- Min height: 48 dp (touch target)
- Horizontal padding: `AppSpacing.md`

**Pressed button:**

- Invert bevel: top/left `win95Shadow`, bottom/right `win95Highlight`
- Optional 1 px inset offset

**Inset panel / group box:**

- Background: `win95WindowFace`
- Border: top/left `win95Shadow`, bottom/right `win95Highlight`
- Optional etched label: small caps text on top border break

**Window frame:**

- Title bar min height: 28 dp (scale up on high-DPI if needed)
- Title bar: `win95TitleBarActive` when focused; close glyph (×) on the right
- Client: `win95WindowFace` with 1 px `win95DarkShadow` outer border
- Window max width: ~90% of screen; centered on desktop

**Checkbox / radio (future pass):**

- 13×13 dp box, 1 px black border, check mark in `win95Text`
- Label: `win95Text`, 12–14 sp, 4 dp gap from control

### Typography

- **Aesthetic:** MS Sans Serif (Windows 95)
- **Implementation:** Prefer `Tahoma` as bundled/system fallback on Android; optional custom font asset if closer match is required
- **Title bar:** bold, 16 sp, `win95TitleBarText`
- **Body:** regular, 18 sp, `win95Text`
- **Explorer labels:** regular, ~26 sp (`12 * explorerLabelScale`), `win95Text`

All screens: error state rendered inside the window client area, not as a Material snackbar.

---

## 7. Out of scope

- Start menu, taskbar, system tray, multiple overlapping draggable windows
- Window minimize / maximize (close only for v1)
- Sound effects (click, chord)
- Actual preference persistence for permissions sub-settings page (permissions opens system settings only; no in-app prefs)
- Win95 styling on home launcher routes
- File dialogs, common controls beyond button / panel / list row

---

## Appendix A. Implementation checklist

```
[x] win95/ theme tokens (colors, typography, decorations)
[x] Win95Desktop, Win95WindowFrame, Win95TitleBar, Win95Button, Win95Panel, Win95ExplorerTile
[x] SettingsBloc + freezed event/state + DI registration
[x] SettingsView per widget tree above
[x] Route /settings + AppRouter registration (goSettings, pop)
[x] Home corner slot → settingsTapped navigation hook
[x] Route /settings/appearance + AppearanceSettingsBloc/View
[x] Appearance preferences persistence (migration 002)
[x] Route /settings/favorites + FavoritesSettingsBloc/View
[x] Favorites reorder persistence via ReorderFavoriteAppsUseCase
[x] Route /settings/permissions + PermissionsSettingsBloc/View
[x] OpenDefaultLauncherSettingsUseCase + LauncherSettingsPort + AndroidLauncherSettingsAdapter
[x] Route /settings/preferred-apps + PreferredAppsSettingsBloc/View
[x] Preferred apps persistence (migration 005)
[x] Restricted (distracting) apps + math hurdle (migration 006)
[x] Route /settings/restricted-apps + RestrictedAppsSettingsBloc/View
[ ] Verify: flutter analyze + test/architecture/layer_import_test.dart
```
