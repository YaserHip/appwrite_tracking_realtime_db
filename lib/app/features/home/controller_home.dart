import 'package:appwrite_tracking_realtime_db/app/features/home/repository_home.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ControllerHome extends StateNotifier<AsyncValue<void>> {
  ControllerHome({required this.repositoryHome}) : super(const AsyncData(null));
  final RepositoryHome repositoryHome;
  Stream<String> getLocationFromDB() {
    return repositoryHome.getLocationFromDB().stream.map((event) {
      if (event.payload.isEmpty) {
        if (event.events
            .contains('databases.*.collections.*.documents.update')) {
          return event.payload.toString();
        } else {
          return "";
        }
      } else {
        return "";
      }
    });
  }
}

final providerControllerHome =
    StateNotifierProvider<ControllerHome, AsyncValue<void>>(
  (ref) => ControllerHome(repositoryHome: ref.watch(repositoryHomeProvider)),
);

final providerStreamLocationFromDB = StreamProvider.autoDispose<String>(
  (ref) {
    final controllerHome = ref.read(providerControllerHome.notifier);
    return controllerHome.getLocationFromDB();
  },
);
