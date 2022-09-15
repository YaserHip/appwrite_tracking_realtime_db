import 'package:appwrite_tracking_realtime_db/app/features/home/repository_home.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ControllerHome extends StateNotifier<AsyncValue<void>> {
  ControllerHome({required this.repositoryHome}) : super(const AsyncData(null));
  final RepositoryHome repositoryHome;

  Future<bool> checkIfUserExist() async {
    try {
      state = const AsyncLoading();
      final value = await repositoryHome.checkIfUserExist();
      state = AsyncData(value);
    } on Exception catch (e) {
      state = AsyncError(e);
    }
    return state.hasError == false;
  }
}

final providerControllerHome =
    StateNotifierProvider<ControllerHome, AsyncValue<void>>(
  (ref) => ControllerHome(repositoryHome: ref.watch(repositoryHomeProvider)),
);
