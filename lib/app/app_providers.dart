// ignore_for_file: non_constant_identifier_names

import 'package:appwrite/appwrite.dart';
import 'package:appwrite_tracking_realtime_db/app/aw_paths.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final AWClientProvider = Provider<Client>((ref) {
  Client client = Client();
  client
      .setEndpoint(
          'https://f523-2806-2f0-20c0-30e8-cc07-d307-5d03-8b4b.ngrok.io/v1')
      .setProject('6321f4da3075a9f4073a');
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