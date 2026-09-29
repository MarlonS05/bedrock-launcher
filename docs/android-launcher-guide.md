# Android Launcher — Step-by-Step Guide

A minimal walkthrough for building an Android home-screen launcher in Flutter.
Distilled from [Let's Build an Android Launcher Application with Flutter](https://www.appwriters.dev/blog/lets-build-an-android-launcher-application-with-flutter)
by Appwriters, with only the essential code snippets required to register as a
launcher, list installed apps, and launch them. Background rendering is owned
entirely by Flutter (see `LauncherBackground` in the home screen).

**Reference implementation:** [flutter_android_launcher](https://github.com/lohanidamodar/flutter_android_launcher)

## Prerequisites

- Flutter SDK installed
- Android device or emulator (API 28+ / Android 9+)
- Android-only Flutter project (no iOS/desktop required)

bedrockLauncher sets `minSdk = 28` in `android/app/build.gradle.kts` so the app
can open the system default home-app settings screen
(`Settings.ACTION_HOME_SETTINGS`) from Settings → Permissions.

## Step 1 — Create the project

Create a new Android-only Flutter project:

```bash
flutter create my_launcher --platform=android
```

Open the project in your editor. The remaining steps assume the default Flutter
Android layout (`android/app/src/main/…`, `lib/main.dart`).

## Step 2 — Register as a launcher

Edit `android/app/src/main/AndroidManifest.xml`.

### 2a. Add package-query permission

Add `QUERY_ALL_PACKAGES` so the app can discover installed applications:

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <uses-permission android:name="android.permission.QUERY_ALL_PACKAGES"/>
    ...
</manifest>
```

> On Android 11+, package visibility is restricted. This permission (or
> targeted `<queries>` entries) is required to list other installed apps.

Also add `REQUEST_DELETE_PACKAGES` so the launcher can open the system uninstall
dialog for other apps (required on Android 9+):

```xml
<uses-permission android:name="android.permission.REQUEST_DELETE_PACKAGES"/>
```

### 2b. Add HOME intent categories

Update the `MainActivity` intent filter to include `HOME` and `DEFAULT` in
addition to the standard `MAIN` + `LAUNCHER` entries:

```xml
<activity
    android:name=".MainActivity"
    android:exported="true"
    android:launchMode="singleTop"
    android:theme="@style/LaunchTheme"
    ...>
    <meta-data
        android:name="io.flutter.embedding.android.NormalTheme"
        android:resource="@style/NormalTheme" />
    <intent-filter>
        <action android:name="android.intent.action.MAIN"/>
        <category android:name="android.intent.category.LAUNCHER"/>
        <category android:name="android.intent.category.HOME"/>
        <category android:name="android.intent.category.DEFAULT"/>
    </intent-filter>
</activity>
```

- `HOME` — tells Android this app can act as the home screen
- `DEFAULT` — required alongside `HOME` for the system picker to offer it

## Step 3 — Build, run, and set as default home

1. Build and install on a device or emulator:

   ```bash
   flutter run
   ```

2. Press the device **Home** button.
3. Android shows a "Complete action using" / "Select home app" picker — choose
   your launcher.
4. Optionally check "Always" to set it as the default home screen.

From within bedrockLauncher, you can also open the same screen via **Settings →
Permissions → Open home app settings** (uses `Settings.ACTION_HOME_SETTINGS` via
`LauncherSettingsHandler` MethodChannel; requires API 28+).

## Step 4 — List installed applications

Production code wraps `device_apps` in [`AndroidInstalledAppsAdapter`](../../lib/platform/android_installed_apps_adapter.dart)
(domain `InstalledAppsPort` → platform adapter). The dependency is vendored at
[`packages/device_apps`](../../packages/device_apps) (Gradle 8+ / AGP 9 patch). The snippets below are the underlying API; BLoCs and use cases never import the plugin directly.

### 4a. Add the dependency

```bash
flutter pub add device_apps
```

Or add to `pubspec.yaml`:

```yaml
dependencies:
  device_apps: ^2.2.0
```

### 4b. Fetch installed apps

```dart
import 'package:device_apps/device_apps.dart';

List<Application> applications = [];

Future<void> getApplications() async {
  final apps = await DeviceApps.getInstalledApplications(
    includeAppIcons: true,
    includeSystemApps: true,
    onlyAppsWithLaunchIntent: true,
  );
  setState(() {
    applications = apps;
  });
}
```

Call `getApplications()` from `initState()` (or your state-management equivalent).

| Parameter | Purpose |
|-----------|---------|
| `includeAppIcons` | Returns icon bytes for each app |
| `includeSystemApps` | Includes pre-installed system apps |
| `onlyAppsWithLaunchIntent` | Excludes apps that cannot be opened |

### 4c. Display the app list

```dart
body: ListView.builder(
  itemCount: applications.length,
  itemBuilder: (context, index) {
    final application = applications[index] as ApplicationWithIcon;
    return ListTile(
      title: Text(application.appName),
      leading: Image.memory(application.icon),
      onTap: () {
        DeviceApps.openApp(application.packageName);
      },
    );
  },
),
```

Tapping a list item launches the selected application.

## Step 5 — Next steps

The snippets above give you a working minimal launcher. A production launcher
typically adds:

- App grid or paginated home screen (instead of a plain list)
- Favorites and custom layout persistence
- App search and folders
- Gestures (swipe between pages, pull-down drawer)
- State management and caching for faster startup
- Widgets, shortcuts, and notification badges

For a more complete example with state management, see
[fl_live_launcher](https://github.com/lohanidamodar/fl_live_launcher).

## Checklist

Use this checklist to track progress through the guide:

- [ ] Create an Android-only Flutter project (`flutter create --platform=android`)
- [ ] Add `HOME` + `DEFAULT` intent categories to `MainActivity` in `AndroidManifest.xml`
- [ ] Add `QUERY_ALL_PACKAGES` permission to `AndroidManifest.xml`
- [ ] Set `MainActivity` theme to `@style/LaunchTheme` with `NormalTheme` meta-data
- [ ] Build, install, and set the app as the default home launcher
- [x] Add `device_apps` package dependency
- [x] Fetch installed apps via `DeviceApps.getInstalledApplications` (via `AndroidInstalledAppsAdapter`)
- [ ] Render app list (`ListView.builder` with name + icon)
- [x] Launch apps on tap via `DeviceApps.openApp` (via `LaunchAppUseCase`)
