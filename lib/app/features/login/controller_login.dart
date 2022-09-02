import 'package:appwrite_tracking_realtime_db/app/features/login/repository_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginController extends StateNotifier<AsyncValue<void>> {
  LoginController({required this.repositoryAuth})
      : super(const AsyncData(null));
  final RepositoryAuth repositoryAuth;

  Future<bool> oAuth2Session(String provider) async {
    try {
      state = const AsyncLoading();
      final value = await repositoryAuth.oAuth2Session(provider);
      state = AsyncData(value);
    } on Exception catch (e) {
      state = AsyncError(e);
    }
    return state.hasError == false;
  }

  Future<bool> magicURLSession(String email) async {
    try {
      state = const AsyncLoading();
      final value = await repositoryAuth.magicURLSession(email);
      state = AsyncData(value);
    } on Exception catch (e) {
      state = AsyncError(e);
    }
    return state.hasError == false;
  }

  Future<bool> magicURLSessionConfirmation(String secret) async {
    try {
      state = const AsyncLoading();
      final value = await repositoryAuth.magicURLSessionConfirmation(secret);
      state = AsyncData(value);
    } on Exception catch (e) {
      state = AsyncError(e);
    }
    return state.hasError == false;
  }
}

final loginControllerProvider =
    StateNotifierProvider<LoginController, AsyncValue<void>>((ref) {
  return LoginController(repositoryAuth: ref.watch(repositoryAuthProvider));
});
