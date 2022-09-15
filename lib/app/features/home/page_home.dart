import 'package:appwrite_tracking_realtime_db/app/features/home/controller_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PageHome extends ConsumerWidget {
  const PageHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountProvider = ref.watch(providerControllerHome);
    return Scaffold(
      body: Center(
          child: Text(
        'userID: ${accountProvider.userID}',
        style: const TextStyle(fontSize: 11, color: Colors.amber),
      )),
    );
  }
}
