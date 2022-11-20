import 'dart:async';
import 'package:appwrite_tracking_realtime_db/app/app_providers.dart';
import 'package:appwrite_tracking_realtime_db/app/features/home/controller_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';

class ServiceLocation extends ChangeNotifier {
  ServiceLocation({required this.location, required this.controllerHome})
      : super();
  final Location location;
  final ControllerHome controllerHome;
  StreamSubscription? subscription;
  bool _isActive = false;

  void startService() async {
    subscription = location.onLocationChanged.listen((event) async {
      await controllerHome.updateLocationDB(
          "${event.latitude}", "${event.longitude}");
    });
    _isActive = true;
    notifyListeners();
  }

  bool get isActive => _isActive;

  void stopService() async {
    await subscription?.cancel();
    _isActive = false;
    notifyListeners();
  }
}

final providerServiceLocation = ChangeNotifierProvider((ref) {
  final location = ref.watch(locationServiceProvider);
  final controllerHome = ref.watch(providerControllerHome.notifier);
  return ServiceLocation(controllerHome: controllerHome, location: location);
});
