import 'package:appwrite_tracking_realtime_db/app/app_providers.dart';
import 'package:appwrite_tracking_realtime_db/app/features/home/controller_home.dart';
import 'package:appwrite_tracking_realtime_db/app/features/models/model_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';

class PageHome extends ConsumerWidget {
  const PageHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streamLocationProvider = ref.watch(providerStreamLocationFromDB);
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          containerLatLonInformation(streamLocationProvider),
          containerButtonActive(ref)
        ],
      ),
    ));
  }

  containerLatLonInformation(AsyncValue<ModelLocation> stream) => Center(
          child: Container(
        child: stream.when(data: (data) {
          return Text('lat: ${data.lat}, lon: ${data.lon}');
        }, error: (e, r) {
          return Text(e.toString());
        }, loading: () {
          return const CircularProgressIndicator();
        }),
      ));

  Widget containerButtonActive(WidgetRef ref) {
    final streamLocationListener = ref.watch(providerStreamLocation.stream);
    final streamController = ref.read(streamControllerLocationProvider);
    final controllerHome = ref.watch(providerControllerHome.notifier);

    return ElevatedButton(
      child: streamController.hasListener
          ? const Text("Disable")
          : const Text("Enable"),
      onPressed: () async {
        if (streamController.hasListener) {
          await streamController.close();
        } else {
          streamController.addStream(streamLocationListener);
          streamController.stream.listen((event) async {
            LocationData data = event;
            await controllerHome.updateLocationDB(
                "${data.latitude}", "${data.longitude}");
          });
        }
      },
    );
  }
}
