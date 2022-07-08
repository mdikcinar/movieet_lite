enum AppConstants {
  translatesPath,
  tmdbBaseImageUrl,
  tmdbBaseApiUrl,
  posterSize,
  backdropSize;

  String get value {
    switch (this) {
      case AppConstants.translatesPath:
        return 'assets/translations';
      case AppConstants.tmdbBaseApiUrl:
        return 'https://api.themoviedb.org/3';
      case AppConstants.tmdbBaseImageUrl:
        return 'https://image.tmdb.org/t/p';
      case AppConstants.posterSize:
        return '/w342';
      case AppConstants.backdropSize:
        return '/w780';
    }
  }
}
