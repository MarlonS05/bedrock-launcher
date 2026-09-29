/// Text color option for launcher app names.
enum LauncherTextColor {
  black,
  white;

  static LauncherTextColor fromStorage(String value) {
    return switch (value) {
      'white' => LauncherTextColor.white,
      _ => LauncherTextColor.black,
    };
  }

  String toStorage() => name;
}
