import 'dart:async';
import 'package:appwrite_tracking_realtime_db/app/app_providers.dart';
import 'package:appwrite_tracking_realtime_db/app/features/home/controller_home.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';

class ServiceLocation {
  ServiceLocation({required this.controllerHome, required this.location});
  final Location location;
  final ControllerHome controllerHome;
  StreamController streamController = StreamController();

  void startService() {
    streamController = StreamController();
    streamController.add(location.onLocationChanged);
    streamController.stream.listen((event) async {
      print("MAPThiNGS: $event");
      //LocationData data = event;
      /* await controllerHome.updateLocationDB(
          "${data.latitude}", "${data.longitude}"); */
    });
  }

  get hasListener => streamController.hasListener;

  void stopService() {
    streamController.close();
  }
}

final providerServiceLocation = Provider<ServiceLocation>((ref) {
  final location = ref.watch(locationServiceProvider);
  final controllerHome = ref.watch(providerControllerHome.notifier);

  return ServiceLocation(controllerHome: controllerHome, location: location);
});
