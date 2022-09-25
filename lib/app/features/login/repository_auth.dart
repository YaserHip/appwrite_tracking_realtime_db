import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:appwrite_tracking_realtime_db/app/app_providers.dart';
import 'package:appwrite_tracking_realtime_db/app/aw_paths.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RepositoryAuth {
  RepositoryAuth({required this.account, required this.databases});
  final Account account;
  String userID = "";
  Databases databases;

  Future<void> oAuth2Session(String provider) async {
    final value = await account.createOAuth2Session(provider: provider);
    var user = await account.get();
    userID = user.$id;
    return value;
  }

  Future<Token> magicURLSession(String email) async {
    var value =
        await account.createMagicURLSession(userId: 'unique()', email: email);
    userID = value.userId;
    return value;
  }

  Future<Session> magicURLSessionConfirmation(String secret) async {
    return await account.updateMagicURLSession(userId: userID, secret: secret);
  }

  Future<Document> checkIfUserExist() async {
    return await databases.getDocument(
        collectionId: AWPaths().userInfoCollection, documentId: userID);
  }

  Future<void> createUserDocument() async {
    return;
  }
}

final repositoryAuthProvider = Provider<RepositoryAuth>((ref) => RepositoryAuth(
    account: ref.watch(AWAccountProvider),
    databases: ref.watch(AWDatabaseProvider)));
