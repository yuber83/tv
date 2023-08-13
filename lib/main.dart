import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'app/data/http/http.dart';
import 'app/data/repositories_implementation/account_repostory_impl.dart';
import 'app/data/repositories_implementation/authentication_repository_impl.dart';
import 'app/data/repositories_implementation/connectivity_repository_impl.dart';
import 'app/data/services/remote/authentication_api.dart';
import 'app/data/services/remote/internet_checker.dart';
import 'app/domain/repositories/account_repository.dart';
import 'app/domain/repositories/authentication_repository.dart';
import 'app/domain/repositories/connectivity_repository.dart';
import 'app/my_app.dart';

void main() {
  const apiKey =
      'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjNTJmYTRjZTBlYzc2MmUwNjcxMzQxNzZmZDUxNTkwOSIsInN1YiI6IjVmNWU0ZmMyZWMwYzU4MDAzNWI0OGJhNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.dzZHeJoJhiCWvnXeQO3DKWhlVoq42h9zzggDI9HrmZw';
  runApp(
    MultiProvider(
      providers: [
        Provider<AccountRepository>(
            lazy:
                false, // false para inicializar este providder sin instanciarlo
            create: (_) => AccountRepositoryImpl()),
        Provider<ConnectivityRepository>(
          create: (_) => ConnectivityRepositoryImpl(
            Connectivity(),
            InternetChecker(),
          ),
        ),
        Provider<AuthenticationRepository>(
          create: (_) => AuthenticationRepositoryImpl(
            const FlutterSecureStorage(),
            AuthenticationAPI(
              Http(
                client: http.Client(),
                baseUrl: 'https://api.themoviedb.org/3',
                apiKey: apiKey,
              ),
            ),
          ),
        )
      ],
      child: const MyApp(),
    ),
  );
}
