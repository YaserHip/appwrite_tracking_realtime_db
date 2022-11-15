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
  bool isActive = false;
  StreamSubscription? subscription;

  void startService() async {
    subscription = location.onLocationChanged.listen((event) async {
      await controllerHome.updateLocationDB(
          "${event.latitude}", "${event.longitude}");
    });
    isActive = true;
  }

  get isEnable => isActive;

  void stopService() {
    isActive = false;
    subscription?.cancel();
  }
}

final providerServiceLocation = Provider<ServiceLocation>((ref) {
  final location = ref.watch(locationServiceProvider);
  final controllerHome = ref.watch(providerControllerHome.notifier);
  return ServiceLocation(controllerHome: controllerHome, location: location);
});
