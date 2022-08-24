import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:appwrite_tracking_realtime_db/app/project_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthRepository {
  AuthRepository({required this.account});
  final Account account;
  String userID = "";

  Future<void> oAuth2Session(String provider) async {
    return await account.createOAuth2Session(provider: provider);
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

final authRepositoryProvider = Provider<AuthRepository>(
    (ref) => AuthRepository(account: ref.watch(AWAccountProvider)));
