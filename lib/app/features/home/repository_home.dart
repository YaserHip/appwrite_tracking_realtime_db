import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';

class RepositoryHome {
  RepositoryHome(this.account);
  final Account account;

  Future<User> getUserInformation() async {
    return await account.get();
  }
}