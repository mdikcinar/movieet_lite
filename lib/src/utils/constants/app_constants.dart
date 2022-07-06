enum AppConstants {
  translatesPath,
  tmdbBaseApiUrl;

  String get value {
    switch (this) {
      case AppConstants.translatesPath:
        return 'assets/translations';
      case AppConstants.tmdbBaseApiUrl:
        return 'https://api.themoviedb.org/3';
    }
  }
}
