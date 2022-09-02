import 'package:appwrite/models.dart';
import 'package:appwrite_tracking_realtime_db/app/features/login/repository_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PageHome extends ConsumerWidget {
  const PageHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountProvider = ref.watch(repositoryAuthProvider);
    User user = User.fromMap(accountProvider.userMap);
    return Scaffold(
      body: Center(
          child: Text(
        'userID: ${user.toMap()}',
        style: const TextStyle(fontSize: 11, color: Colors.amber),
      )),
    );
  }
}
