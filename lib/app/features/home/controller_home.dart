import 'package:appwrite_tracking_realtime_db/app/features/home/repository_home.dart';
import 'package:appwrite_tracking_realtime_db/app/features/models/model_location.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ControllerHome extends StateNotifier<AsyncValue<void>> {
  ControllerHome({required this.repositoryHome}) : super(const AsyncData(null));
  final RepositoryHome repositoryHome;

  Stream<ModelLocation> getLocationFromDB() {
    return repositoryHome.getLocationFromDB().stream.map((event) {
      if (event.payload.isNotEmpty) {
        if (event.events
            .contains("databases.*.collections.*.documents.*.update")) {
          return ModelLocation.fromMap(event.payload);
        } else {
          return const ModelLocation(lat: "", lon: "");
        }
      } else {
        return const ModelLocation(lat: "", lon: "");
      }
    });
  }
}

final providerControllerHome =
    StateNotifierProvider<ControllerHome, AsyncValue<void>>(
  (ref) => ControllerHome(repositoryHome: ref.watch(repositoryHomeProvider)),
);

final providerStreamLocationFromDB = StreamProvider.autoDispose<ModelLocation>(
  (ref) {
    final controllerHome = ref.read(providerControllerHome.notifier);
    return controllerHome.getLocationFromDB();
  },
);
