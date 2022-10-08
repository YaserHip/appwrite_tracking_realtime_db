import 'package:appwrite_tracking_realtime_db/app/features/home/controller_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PageHome extends ConsumerWidget {
  const PageHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streamLocationProvider = ref.watch(providerStreamLocationFromDB);
    return Scaffold(
        body: Center(
      child: Container(
        child: streamLocationProvider.when(data: (data) {
          return Text('lat: ${data.lat}, lon: ${data.lon}');
        }, error: (e, r) {
          return Text(e.toString());
        }, loading: () {
          return const CircularProgressIndicator();
        }),
      ),
    ));
  }
}
