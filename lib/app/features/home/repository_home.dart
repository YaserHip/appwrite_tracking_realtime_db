// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:appwrite/appwrite.dart';
import 'package:appwrite_tracking_realtime_db/app/app_providers.dart';
import 'package:appwrite_tracking_realtime_db/app/aw_paths.dart';
import 'package:appwrite_tracking_realtime_db/app/features/login/repository_auth.dart';
import 'package:appwrite_tracking_realtime_db/app/features/models/model_location.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appwrite/models.dart' as models;

class RepositoryHome {
  RepositoryHome(
      {required this.userID, required this.realtime, required this.databases});
  String userID;
  Realtime realtime;
  Databases databases;

  RealtimeSubscription getLocationFromDB() {
    return realtime.subscribe([
      'databases.${AWPaths().databaseID}.collections.${AWPaths().userInfoCollection}.documents.$userID'
    ]);
  }

  Future<models.Document> updateLocationDB(String lat, String lon) async {
    return await databases.updateDocument(
        databaseId: AWPaths().databaseID,
        collectionId: AWPaths().userInfoCollection,
        documentId: userID,
        data: ModelLocation(lat: lat, lon: lon).toMap());
  }
}

final repositoryHomeProvider = Provider<RepositoryHome>(
  (ref) => RepositoryHome(
      userID: ref.watch(repositoryAuthProvider).userID,
      realtime: ref.watch(AWRealTimeProvider),
      databases: ref.watch(AWDatabaseProvider)),
);
