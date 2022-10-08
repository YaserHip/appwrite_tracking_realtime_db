// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:appwrite/appwrite.dart';
import 'package:appwrite_tracking_realtime_db/app/app_providers.dart';
import 'package:appwrite_tracking_realtime_db/app/aw_paths.dart';
import 'package:appwrite_tracking_realtime_db/app/features/login/repository_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RepositoryHome {
  RepositoryHome({required this.userID, required this.realtime});
  String userID;
  Realtime realtime;

  RealtimeSubscription getLocationFromDB() {
    return realtime.subscribe([
      'databases.${AWPaths().databaseID}.collections.${AWPaths().userInfoCollection}.documents.$userID'
    ]);
  }
}

final repositoryHomeProvider = Provider<RepositoryHome>(
  (ref) => RepositoryHome(
      userID: ref.watch(repositoryAuthProvider).userID,
      realtime: ref.watch(AWRealTimeProvider)),
);
