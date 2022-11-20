import 'package:appwrite_tracking_realtime_db/app/app_providers.dart';
import 'package:appwrite_tracking_realtime_db/app/features/home/repository_home.dart';
import 'package:appwrite_tracking_realtime_db/app/features/models/model_location.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';

class ControllerHome extends StateNotifier<AsyncValue<void>> {
  ControllerHome({required this.repositoryHome, required this.location})
      : super(const AsyncData(null));
  final RepositoryHome repositoryHome;
  final Location location;
  bool isActive = false;

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

  Future<void> updateLocationDB(String lat, String lon) async {
    await repositoryHome.updateLocationDB(lat, lon);
  }
}

final providerControllerHome =
    StateNotifierProvider<ControllerHome, AsyncValue<void>>(
  (ref) => ControllerHome(
      repositoryHome: ref.watch(repositoryHomeProvider),
      location: ref.watch(locationServiceProvider)),
);

final providerStreamLocationFromDB = StreamProvider.autoDispose<ModelLocation>(
  (ref) {
    final controllerHome = ref.read(providerControllerHome.notifier);
    return controllerHome.getLocationFromDB();
  },
);
