import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app_test/feature/history/history_screen.dart';
import 'package:weather_app_test/feature/home/home_screen.dart';
import 'package:weather_app_test/feature/weekly/weekly_screen.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: "/",
    debugLogDiagnostics: kDebugMode,
    redirectLimit: 10,
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            path: 'weekly',
            builder: (context, state) => WeeklyScreen(
              lat: double.parse(state.uri.queryParameters['lat'] ?? '0'),
              lon: double.parse(state.uri.queryParameters['lon'] ?? '0'),
            ),
          ),
          GoRoute(
            path: 'history/:id',
            builder: (context, state) => HistoryScreen(
              cityId: int.parse(state.pathParameters['id'] ?? '0'),
            ),
          )
        ],
      ),
    ],
  );
}, name: 'router');
