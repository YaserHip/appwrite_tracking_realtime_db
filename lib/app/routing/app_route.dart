import 'package:appwrite_tracking_realtime_db/app/features/home/page_home.dart';
import 'package:appwrite_tracking_realtime_db/app/features/login/page_login.dart';
import 'package:appwrite_tracking_realtime_db/app/routing/not_found_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

enum AppRoute {
  login,
  home,
}

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/',
        name: AppRoute.home.name,
        builder: (context, state) => const PageHome(),
      ),
      GoRoute(
        path: '/login',
        name: AppRoute.login.name,
        builder: (context, state) => const PageLogin(),
      )
    ],
    errorBuilder: (context, state) => const NotFoundPage(),
  );
});
