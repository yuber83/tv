import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_strategy/url_strategy.dart';

import 'app/data/http/http.dart';
import 'app/data/repositories_implementation/account_repostory_impl.dart';
import 'app/data/repositories_implementation/authentication_repository_impl.dart';
import 'app/data/repositories_implementation/connectivity_repository_impl.dart';
import 'app/data/repositories_implementation/movies_repository_impl.dart';
import 'app/data/repositories_implementation/preferences_repository_impl.dart';
import 'app/data/repositories_implementation/trending_repository_impl.dart';
import 'app/data/services/local/session_service.dart';
import 'app/data/services/remote/account_api.dart';
import 'app/data/services/remote/authentication_api.dart';
import 'app/data/services/remote/internet_checker.dart';
import 'app/data/services/remote/movies_api.dart';
import 'app/data/services/remote/trending_api.dart';
import 'app/domain/repositories/account_repository.dart';
import 'app/domain/repositories/authentication_repository.dart';
import 'app/domain/repositories/connectivity_repository.dart';
import 'app/domain/repositories/movies_repository.dart';
import 'app/domain/repositories/preferences_repository.dart';
import 'app/domain/repositories/trending_repository.dart';
import 'app/generated/translations.g.dart';
import 'app/my_app.dart';
import 'app/presentation/global/controllers/favorites/favorites_controller.dart';
import 'app/presentation/global/controllers/favorites/state/favorite_state.dart';
import 'app/presentation/global/controllers/session_controller.dart';
import 'app/presentation/global/controllers/theme_controlloer.dart';

void main() async {
  setHashUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();

  LocaleSettings.useDeviceLocale();

  const apiKey =
      'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjNTJmYTRjZTBlYzc2MmUwNjcxMzQxNzZmZDUxNTkwOSIsInN1YiI6IjVmNWU0ZmMyZWMwYzU4MDAzNWI0OGJhNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.dzZHeJoJhiCWvnXeQO3DKWhlVoq42h9zzggDI9HrmZw';

  final sessionService = SessionService(const FlutterSecureStorage());
  final http = Http(
    client: Client(),
    baseUrl: 'https://api.themoviedb.org/3',
    apiKey: apiKey,
  );
  final accountAPI = AccountAPI(
    http,
    sessionService,
  );
  final deviceTheme = PlatformDispatcher.instance.platformBrightness;

  final deviceDarkMode = deviceTheme == Brightness.dark;

  final preferences = await SharedPreferences.getInstance();
  final connectivityRepository = ConnectivityRepositoryImpl(
    Connectivity(),
    InternetChecker(),
  );
  await connectivityRepository.initialize();
  runApp(
    MultiProvider(
      providers: [
        Provider<AccountRepository>(
          lazy: false, // false para inicializar este providder sin instanciarlo
          create: (_) => AccountRepositoryImpl(
            accountAPI,
            sessionService,
          ),
        ),
        Provider<PreferencesRepository>(
          lazy: false, // false para inicializar este providder sin instanciarlo
          create: (_) => PreferencesRepositoryImpl(
            preferences,
          ),
        ),
        Provider<ConnectivityRepository>(
          create: (_) => connectivityRepository,
        ),
        Provider<AuthenticationRepository>(
          create: (_) => AuthenticationRepositoryImpl(
            AuthenticationAPI(http),
            sessionService,
            accountAPI,
          ),
        ),
        Provider<TrendingRepository>(
          create: (_) => TrendingRepositoryImplentation(
            TrendingAPI(http),
          ),
        ),
        Provider<MoviesRepository>(
          create: (_) => MoviesRepositoryImpl(
            MoviesAPI(http),
          ),
        ),
        ChangeNotifierProvider<SessionController>(
          create: (context) => SessionController(
            authenticationRepository: context.read(),
          ),
        ),
        ChangeNotifierProvider<FavoritesController>(
          create: (context) => FavoritesController(
            FavoritesState.loading(),
            accountRepository: context.read(),
          ),
        ),
        ChangeNotifierProvider<ThemeController>(create: (context) {
          final PreferencesRepository preferencesRepository = context.read();
          return ThemeController(
            preferencesRepository.darkMode ?? deviceDarkMode,
            preferencesRepository: preferencesRepository,
          );
        })
      ],
      child: TranslationProvider(
        child: const MyApp(),
      ),
    ),
  );
}
