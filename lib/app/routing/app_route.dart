import 'package:appwrite_tracking_realtime_db/app/features/login/page_login.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

enum AppRoute {
  login,
  home,
}

final goRouterProvider = Provider<GoRouter>((ref) => {
  GoRoute _router = GoRouter(initialLocation: 'login', routes: <GoRoute>[
  GoRoute(path: 'login', name: AppRoute.login.name, builder: (context, state) => const PageLogin(),);
  return _router;
])});
