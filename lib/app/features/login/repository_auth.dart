import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:appwrite_tracking_realtime_db/app/app_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RepositoryAuth {
  RepositoryAuth({required this.account});
  final Account account;
  String userID = "";
  Map<String, dynamic> userMap = {};

  Future<void> oAuth2Session(String provider) async {
    final value = await account.createOAuth2Session(provider: provider);
    var user = await account.get();
    userMap = user.toMap();
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
}

final repositoryAuthProvider = Provider<RepositoryAuth>(
    (ref) => RepositoryAuth(account: ref.watch(AWAccountProvider)));
