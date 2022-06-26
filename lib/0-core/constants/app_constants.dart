enum AppConstants {
  translatesPath;

  String get path {
    switch (this) {
      case AppConstants.translatesPath:
        return 'assets/translations';
    }
  }
}
