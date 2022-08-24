import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

enum AppRoute {
  login,
  home,
}

final goRouterProvider = Provider<GoRouter>((ref) => {
  return GoRouter(

  initialLocation: '/',
  debugLogDiagnostics: false,
  routes: [
    GoRoute(path: '/',
    name: AppRoute.home.name)
  ]
    
  );
});
