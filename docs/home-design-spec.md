# Home — Design & Layout Specification

<!--
  AGENT METADATA — parse before implementing
  feature_id: home
  product_name: bedrockLauncher
  source: N/A
  target_platform: Android (custom HOME launcher)
  status: design-only
-->

> **Purpose:** Machine-readable design spec for implementing the home launcher screen.
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
| BLoC + codegen | `HomeBloc`, `HomeEvent`, `HomeState` (freezed when implemented) |
| Navigation in BLoC | Views dispatch events; `HomeBloc` calls `AppRouter` (e.g. open settings) |
| Infra I/O | `InstalledAppsPort` (domain) → platform package-manager adapter; `DefaultBrowserPort` (domain) → platform default-browser intent adapter; `BatteryPort` (domain) → platform battery adapter; `InstalledFontsPort` (domain) → platform system-fonts adapter |
| Reads | `LoadLauncherAppsUseCase` (`ListInstalledAppsUseCase` → `InstalledAppsRepository` in-memory cache + `GetFavoriteAppsUseCase` → `FavoriteAppRepository` + `GetRestrictedAppsUseCase` → `RestrictedAppRepository`) |
| Persistence | `FavoriteAppRepository` → `FavoriteAppRepositoryImpl` + SQLite (`lib/db/`) |
| Writes | Use cases for launch intent (future); `AddFavoriteAppUseCase`, `RemoveFavoriteAppUseCase`, `ReorderFavoriteAppsUseCase` |
| Errors | `HomeState.error` surfaced via shared error widget + `BlocListener` |
| Theme | `launcher*` tokens from [`design-language.md`](design-language.md); `AppSpacing` |

**Replaces:** Placeholder `HomeView` (centered title text).

**Reference implementations:** N/A — first feature. Settings chrome: [`settings-design-spec.md`](settings-design-spec.md).

---

## 1. Feature overview

### 1.1 Screens

| Screen | Route | Top bar |
|--------|-------|---------|
| Home | `/` | None — full-bleed launcher surface |

Entry: app launch as Android HOME handler; `GoRouter` initial location `/`.

### 1.2 Flows

- **Browse apps:** home loads → analog clock + installed app names render → tap name → launch app via use case / platform port.
- **Clock:** tap analog clock → BLoC opens the preferred clock app via `LaunchAppUseCase` when set in Preferred Apps; otherwise the system clock via `SystemAppsPort` / use case (falls back to system if preferred launch fails).
- **Open default browser:** swipe up on the lower half of the screen → BLoC opens the system default browser via `DefaultBrowserPort` / use case. Taps in that zone still reach the app list underneath; list scroll gestures do not need to pass through.
- **Corner action:** tap bottom-right slot (camera icon) → BLoC opens the preferred camera app via `LaunchAppUseCase` when set; otherwise the system camera via `SystemAppsPort` / use case (falls back to system if preferred launch fails).
- **Gallery:** long-press bottom-right camera slot → BLoC opens the preferred gallery app via `LaunchAppUseCase` when set; otherwise the system gallery via `SystemAppsPort` / use case (falls back to system if preferred launch fails).
- **Settings:** tap settings icon stacked above camera (bottom-right) → BLoC navigates to `/settings`.
- **Phone:** tap bottom-left slot (phone icon) → BLoC opens the preferred phone app via `LaunchAppUseCase` when set; otherwise the system dialer via `SystemAppsPort` / use case (falls back to system if preferred launch fails).
- **All apps:** tap three-line icon above settings (bottom-right) → BLoC navigates to `/all-apps`.
- **Back:** Android back on home is a no-op or exits launcher per platform convention (document when implementing).

---

## 2. Data model

```dart
// domain — illustrative; implement when wiring installed apps
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

// domain/entities/favorite_app.dart — persisted user pins
class FavoriteApp {
  const FavoriteApp({
    this.id,
    required this.packageName,
    required this.order,
  });

  final int? id;
  final String packageName;
  final int order;
}

// domain/entities/restricted_app.dart — math hurdle by existence
class RestrictedApp {
  const RestrictedApp({required this.packageName});
  final String packageName;
}
```

| Value | Label | Notes |
|-------|-------|-------|
| `LauncherApp.packageName` | — | Unique id for launch intent; same as `Application.packageName` from `device_apps` |
| `LauncherApp.displayName` | — | Shown in the name list |
| `LauncherApp.isRestricted` | — | Stamped when loading via `LoadLauncherAppsUseCase`; true when a `RestrictedApp` row exists |
| `FavoriteApp.packageName` | — | Stored app id when pinning; resolve via `DeviceApps.getApp` / match against installed apps |
| `FavoriteApp.order` | — | Zero-based display position; load favorites sorted ascending |
| `RestrictedApp.packageName` | — | PRIMARY KEY; presence means math hurdle before launch |

Digit ranges for the hurdle are the eight static fields in
[`lib/domain/math/math_problem_config.dart`](../lib/domain/math/math_problem_config.dart)
(per operation, left/right max digits).

Answers are parsed by `MathProblem.parseAnswer`: the last non-digit character
is the decimal separator (`.`, `,` or any locale variant the keyboard emits),
earlier ones are grouping marks, and the comparison uses half-up rounding to
2 decimals.

**Default:** Empty list until `InstalledAppsPort` returns apps. No favorites until the user pins apps. No restricted apps until configured in Restricted Apps settings.

**Persistence:** `favorite_apps` SQLite table (`package_name` UNIQUE, `display_order` indexed). `restricted_apps` SQLite table (`package_name` PRIMARY KEY, migration 006). Load with `FavoriteAppRepository.getAll()` / `RestrictedAppRepository.getAll()`.

---

## 3. Component reuse

### 3.1 Reuse as-is

- `AppSpacing` (`lib/theme/app_spacing.dart`) for list padding and gaps.

### 3.2 Adapt

- None.

### 3.3 Do not reuse

- Material 3 `AppBar`, `ListTile`, `FilledButton`, or Win95 components — home uses the launcher visual system only.
- Default `Scaffold` app bar — home has no top chrome.

### 3.4 Build new

| Component | Path | API (sketch) |
|-----------|------|--------------|
| `LauncherBackground` | `lib/screens/components/launcher/launcher_background.dart` | `color`, optional `child` |
| `LauncherAppList` | `lib/screens/components/launcher/launcher_app_list.dart` | `apps: List<LauncherApp>`, `onAppTap(String packageName)` |
| `CornerActionSlot` | `lib/screens/components/launcher/corner_action_slot.dart` | `alignment` (TL/TR/BL/BR), `onTap`, optional `child` |
| `BrowserSwipeZone` | `lib/screens/components/launcher/browser_swipe_zone.dart` | `onSwipeUp`, `onSwipeLeft`, `onDoubleTap`, `heightFraction` (default `0.5`); invisible lower-half overlay that captures swipes / double taps and lets single taps pass through to the list below |

---

## 4. Screens

```yaml
route: /
folder: lib/screens/home/
bloc: HomeBloc
view: HomeView
```

```
HomeView
└── BlocProvider<HomeBloc>
    └── BlocBuilder<HomeBloc, HomeState>
        └── BlocListener (errors)
            └── Stack (fit: expand)
                ├── LauncherBackground
                │   └── user theme color from appearance prefs (fallback: launcherBackgroundFallback)
                ├── SafeArea
                │   └── Column
                │       ├── SizedBox (height = 1/3 screen)
                │       │   └── LauncherAnalogClock (centered)
                │       │       ├── hour tick marks (12 small + 4 larger quarter marks) + hour/minute hands (no seconds)
                │       │       └── battery ring: arc only (0–100%), matches text color
                │       └── Expanded
                │           └── LauncherAppList
                │               └── scrollable app names (Text rows)
                ├── BrowserSwipeZone (Positioned: bottom, height = 50% of stack)
                │   └── invisible gesture layer; swipe up → browser; taps pass through
                └── CornerActionSlots (4× Positioned)
                    ├── topLeft: CornerActionSlot (empty v1)
                    ├── topRight: CornerActionSlot (empty v1)
                    ├── bottomLeft: CornerActionSlot (PhoneCornerIcon → dialer)
                    └── bottomRight:
                        ├── stackIndex 0: CornerActionSlot (CameraCornerIcon → camera)
                        └── stackIndex 1: CornerActionSlot (SettingsCornerIcon → /settings)
```

**Selection / actions:**

- Tap app name → dispatch `HomeEvent.appTapped(index)` → if restricted, set pending challenge / show `MathHurdleDialog`; else BLoC invokes launch use case / port.
- Swipe up in lower half → dispatch `HomeEvent.browserSwipeUpDetected` → BLoC invokes open-default-browser use case / `DefaultBrowserPort`. The swipe zone must **not** consume taps intended for `LauncherAppList`; vertical list-scroll drags in the zone may be absorbed by the overlay.
- Double tap in lower half → dispatch `HomeEvent.browserDoubleTapped` → show `MathHurdleDialog` for practice (no app launch).
- Tap corner slot (when wired) → dispatch corner event → BLoC navigates (e.g. `settingsTapped` → `/settings`).

**States & styling:**

| State | UI |
|-------|-----|
| `loading` | Optional centered indicator over background (minimal; no Material app bar) |
| `loaded` | Analog clock + name list + corner slots |
| `error` | Shared error widget via listener |
| Row pressed | `launcherAppNamePressed` (opacity or underline) |

---

## 5. Navigation & state

### Routes

```dart
// lib/router/routes.dart — existing
static const home = '/';
```

Future: settings entry adds no new home routes; navigation targets `/settings` from a corner slot.

### HomeBloc events

**HomeBloc:** `started`, `appTapped`, `browserSwipeUpDetected`, `settingsTapped`, `phoneTapped`, `cameraTapped`, `cameraLongPressed`, `clockTapped`, `retryTapped`, `batteryRefreshRequested`, `restrictedLaunchConfirmed`, `restrictedLaunchCancelled`, `browserDoubleTapped`, `mathPracticeDismissed`

- `started`: load favorited apps via `LoadLauncherAppsUseCase` (installed-apps cache + favorites + restricted join); read battery level via `BatteryPort`.
- **Startup preload:** `main.dart` fires a background `ListInstalledAppsUseCase()` immediately after DI so the cache is warm before the user opens All Apps. Home's own `started` load dedupes against this in-flight fetch.
- `appTapped`: if `LauncherApp.isRestricted`, emit `pendingRestrictedLaunchPackageName` (view shows `MathHurdleDialog`); else launch via use case.
- `browserSwipeUpDetected`: open system default browser via use case / `DefaultBrowserPort`.
- `browserDoubleTapped`: set `pendingMathPractice` (view shows `MathHurdleDialog` for fun; no launch).
- `mathPracticeDismissed`: clear `pendingMathPractice`.
- `settingsTapped`: navigate to `/settings` (Win95 world).
- `phoneTapped`: if preferred phone package is restricted, emit pending challenge; else open via `OpenDialerUseCase` (`LaunchAppUseCase` when set, else `SystemAppsPort`).
- `cameraTapped`: if preferred camera package is restricted, emit pending challenge; else open via `OpenCameraUseCase`.
- `cameraLongPressed`: if preferred gallery package is restricted, emit pending challenge; else open via `OpenGalleryUseCase`.
- `clockTapped`: if preferred clock package is restricted, emit pending challenge; else open via `OpenClockUseCase`.
- `restrictedLaunchConfirmed`: launch pending package and clear pending.
- `restrictedLaunchCancelled`: clear pending without launching.
- `retryTapped`: re-run load after error.
- `batteryRefreshRequested`: re-read battery level without full reload spinner (dispatched on app resume from `LauncherAnalogClock`).

---

## 6. Interaction & tokens

All values reference [`design-language.md`](design-language.md). Future home for code:
`lib/theme/launcher/`.

| Token | Value | Usage |
|-------|-------|-------|
| `launcherBackgroundFallback` | `#1A1A1A` | Default background before prefs load |
| `launcherAppName` | `#1A1A1A` | App name text |
| `launcherAppNamePressed` | 70% opacity of `launcherAppName` | Press feedback |
| `launcherAppNameSize` | 18–20 sp | Typography scale |
| `launcherListTopSpacerFraction` | `1/3` | Upper zone height (clock area) |
| `launcherClockSizeFraction` | `0.55` | Max clock diameter vs upper zone height |
| `launcherClockMaxWidthFraction` | `0.38` | Max clock diameter vs screen width |
| `launcherClockRingStrokeWidth` | `3` dp | Battery ring stroke |
| `launcherClockHandMinuteReachFraction` | `0.72` | Minute hand length vs widget radius |
| `launcherClockHandHourReachFraction` | `0.5` | Hour hand length vs widget radius |
| `launcherClockRingHandGap` | `6` dp | Gap between hand tips and battery ring inner edge |
| `launcherClockHandHourWidth` | `3` dp | Hour hand stroke |
| `launcherClockHandMinuteWidth` | `2` dp | Minute hand stroke |
| `launcherClockHourTickInnerRadiusFraction` | `0.62` | Hour tick inner edge vs widget radius |
| `launcherClockHourTickOuterRadiusFraction` | `0.65` | Hour tick outer edge vs widget radius |
| `launcherClockHourTickStrokeWidth` | `1` dp | Hour tick stroke |
| `launcherClockQuarterTickInnerRadiusFraction` | `0.56` | Quarter tick inner edge vs widget radius |
| `launcherClockQuarterTickOuterRadiusFraction` | `0.70` | Quarter tick outer edge vs widget radius |
| `launcherClockQuarterTickStrokeWidth` | `2` dp | Quarter tick stroke |
| `launcherClockHourTickOpacity` | `0.5` | Tick mark opacity |
| `launcherListPaddingHorizontal` | `AppSpacing.md` | List horizontal inset |
| `launcherListItemPaddingVertical` | `AppSpacing.md` | Vertical padding inside each row |
| `launcherListSeparator` | same as `launcherAppName` | 1 dp rule between rows |
| `launcherCornerSlotSize` | 48 dp | Corner touch target |
| `launcherCornerInset` | `AppSpacing.md` | Offset from screen edges |
| `launcherBrowserSwipeZoneFraction` | `0.5` | Lower-half overlay height as a fraction of the `Stack` |
| `launcherBrowserSwipeMinDistance` | 48 dp | Minimum upward displacement before treating a drag as a browser swipe |

**Typography:** Single weight, clean sans-serif (system default or grotesque). **Not** Win95 / MS Sans Serif.

**Lower-half browser swipe zone:**

| Behavior | Rule |
|----------|------|
| Coverage | Bottom `launcherBrowserSwipeZoneFraction` (50%) of the home `Stack`, full width, above the app list in paint order |
| Swipe up | Upward drag exceeding `launcherBrowserSwipeMinDistance` with net positive vertical delta → `browserSwipeUpDetected` |
| Tap through | Single taps and short presses on app names must reach `LauncherAppList` underneath the zone |
| List scroll | Vertical scroll/drag gestures in the zone do **not** need to pass through; the overlay may handle or block them |
| Visual | No chrome, scrim, or hint in v1 — the zone is invisible |
| Platform | Opens the Android default browser (user's preferred browser app), not an in-app WebView |

**Tap-through implementation note (for agents):** `BrowserSwipeZone` is an overlay and must not absorb taps meant for list rows. Distinguish taps from upward swipes (e.g. no significant movement before release → defer hit-test to `LauncherAppList`). Vertical drags and list-scroll gestures do not require pass-through. Do not use a full-size `GestureDetector` with an `onTap` handler on the overlay.

**Corner slots (v1):**

| Corner | Use |
|--------|-----|
| Top-left | Empty placeholder |
| Top-right | Empty placeholder |
| Bottom-left | Phone / dialer entry (`PhoneCornerIcon`) → system dialer |
| Bottom-right | Camera entry (`CameraCornerIcon`) → tap: system camera; long-press: system gallery |
| Bottom-right (stacked above camera) | Settings entry (`SettingsCornerIcon`, 4-dot grid) → `/settings` |
| Bottom-right (stacked above settings) | All Apps entry (`AllAppsCornerIcon`, three-line icon) → `/all-apps` |

**Background layer:** `LauncherBackground` fills the stack with the user's theme
color from appearance preferences (`themeColorArgb`). Falls back to
`launcherBackgroundFallback` while loading. Background is rendered entirely in
Flutter — no system wallpaper passthrough.

All screens: shared error-handling wrapper on `HomeState.error`.

---

## 7. Out of scope

- App icons, grid layout, drag-and-drop reorder, folders
- Image wallpaper picker (solid theme color is supported via appearance settings)
- In-app browser / WebView; browser-picker UI (always system default browser)
- Win95 styling anywhere on home
- Start menu, taskbar, or system tray metaphors

---

## Appendix A. Implementation checklist

```
[x] launcher/ theme tokens (colors, typography)
[x] LauncherBackground, LauncherAppList, CornerActionSlot, BrowserSwipeZone, LauncherAnalogClock widgets
[x] HomeBloc + freezed event/state + DI registration
[x] Reshape HomeView per widget tree above
[x] Load favorited apps on home via `LoadLauncherAppsUseCase`
[x] Launch favorite apps via `LaunchAppUseCase`
[x] BatteryPort + get-battery-level use case (domain + platform)
[ ] Verify lower-half swipe opens browser while taps still launch apps in the list
[x] Wire corner slot → settings navigation when settings route exists
[ ] Verify: flutter analyze + test/architecture/layer_import_test.dart
```
