import 'package:appwrite_tracking_realtime_db/app/features/home/controller_home.dart';
import 'package:appwrite_tracking_realtime_db/app/features/models/model_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PageHome extends ConsumerWidget {
  const PageHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streamLocationProvider = ref.watch(providerStreamLocationFromDB);
    final streamLocationListener = ref.watch(providerStreamLocation);
    return Scaffold(
        body: Center(
      child: Container(
          child: Column(
        children: [
          containerLatLonInformation(streamLocationProvider),
        ],
      )),
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
}
