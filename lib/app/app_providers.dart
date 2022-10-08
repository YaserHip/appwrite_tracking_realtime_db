// ignore_for_file: non_constant_identifier_names

import 'package:appwrite/appwrite.dart';
import 'package:appwrite_tracking_realtime_db/app/aw_paths.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';

final AWClientProvider = Provider<Client>((ref) {
  Client client = Client();
  client
      .setEndpoint(
          'https://afc9-2806-2f0-20c0-30e8-f85b-877a-5f01-118a.ngrok.io/v1')
      .setProject('633088dbd2a6daa85866');
  return client;
});

final AWAccountProvider = Provider<Account>((ref) {
  final AWClient = ref.watch(AWClientProvider);
  return Account(AWClient);
});

final AWDatabaseProvider = Provider<Databases>(
  (ref) {
    final AWClient = ref.watch(AWClientProvider);
    return Databases(AWClient, databaseId: AWPaths().databaseID);
  },
);

final AWRealTimeProvider = Provider<Realtime>(
  (ref) {
    final AWClient = ref.watch(AWClientProvider);
    return Realtime(AWClient);
  },
);

final locationServiceProvider = Provider<Location>(
  (ref) => Location(),
);
