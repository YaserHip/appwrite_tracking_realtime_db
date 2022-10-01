import 'package:appwrite_tracking_realtime_db/app/features/login/repository_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ControllerLogin extends StateNotifier<AsyncValue<void>> {
  ControllerLogin({required this.repositoryAuth})
      : super(const AsyncData(null));
  final RepositoryAuth repositoryAuth;

  Future<bool> oAuth2Session(String provider) async {
    try {
      state = const AsyncLoading();
      final value = await repositoryAuth.oAuth2Session(provider);
      state = AsyncData(value);
    } on Exception catch (e, trace) {
      state = AsyncError(e, trace);
    }

    if (!state.hasError) {
      try {
        final value = await repositoryAuth.checkIfUserExist();
        print("CHECKIFEXIST: ${value.toMap()}");
      } on Exception catch (e) {
        print("CHECKIFEXIST-error: ${e.toString()}");
        await repositoryAuth.createUserDocument();
      }
    }

    return state.hasError == false;
  }

  Future<bool> magicURLSession(String email) async {
    try {
      state = const AsyncLoading();
      final value = await repositoryAuth.magicURLSession(email);
      state = AsyncData(value);
    } on Exception catch (e, trace) {
      state = AsyncError(e, trace);
    }
    return state.hasError == false;
  }

  Future<bool> magicURLSessionConfirmation(String secret) async {
    try {
      state = const AsyncLoading();
      final value = await repositoryAuth.magicURLSessionConfirmation(secret);
      state = AsyncData(value);
    } on Exception catch (e, trace) {
      state = AsyncError(e, trace);
    }
    return state.hasError == false;
  }
}

final loginControllerProvider =
    StateNotifierProvider<ControllerLogin, AsyncValue<void>>((ref) {
  return ControllerLogin(repositoryAuth: ref.watch(repositoryAuthProvider));
});
