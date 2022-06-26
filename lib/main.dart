import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '0-core/constants/app_constants.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await SentryFlutter.init(
    (options) {
      options.dsn = 'https://example@sentry.io/add-your-dsn-here';
    },
    // Init your App.
    appRunner: () => runApp(
      EasyLocalization(
        supportedLocales: [
          Locale('en', 'US'),
        ],
        path: AppConstants.translatesPath.path,
        fallbackLocale: Locale('en', 'US'),
        child: const App(),
      ),
    ),
  );
}

/*
  static const baseApi = 'https://api.themoviedb.org/3';
  static const baseImageApi = 'https://image.tmdb.org/t/p/';
  static const postPosterSize = 'w185/';
  static const searchPosterSize = 'w154/';
  static const posterSize = 'w342/'; // 92 154 185 342 500 780
  static const backdropSize = 'w780/'; // 300 780 1280
  static const profileSize = 'w185/'; //45 185 632
  static const searchMulti = baseApi + '/search/multi?api_key=' + apiKey;
  static const getMovieBase = 'https://api.themoviedb.org/3/movie/';
  static const getTvMovieBase = 'https://api.themoviedb.org/3/tv/';
  static const getTrendingMovieBase = 'https://api.themoviedb.org/3/trending/movie/';
  static const getTrendingTvBase = 'https://api.themoviedb.org/3/trending/tv/';
 */
