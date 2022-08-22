import 'package:appwrite/appwrite.dart';
import 'package:appwrite_tracking_realtime_db/project_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthRepository {
  AuthRepository({required this.account});
  final Account account;

  Future<void> oAuth2Session(String provider) async {
    return await account.createOAuth2Session(provider: provider);
  }
}

final authRepositoryProvider = Provider<AuthRepository>(
    (ref) => AuthRepository(account: ref.watch(AWAccountProvider)));
