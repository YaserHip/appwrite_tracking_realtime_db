import 'package:appwrite_tracking_realtime_db/app/features/login/controller_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PageLogin extends ConsumerStatefulWidget {
  const PageLogin({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PageLoginState();
}

class _PageLoginState extends ConsumerState<PageLogin> {
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginControllerProvider);
    final nav = Navigator.of(context);

    return Scaffold(
        appBar: AppBar(title: const Text("Login with phone")),
        body: Center(
          child: state.isLoading
              ? const CircularProgressIndicator()
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      child: const Text("Google"),
                      onPressed: () async {
                        final success = await ref
                            .read(loginControllerProvider.notifier)
                            .oAuth2Session("google");
                        if (success) {
                          nav.pushNamed(AppRoutes.homePage);
                        }
                      },
                    ),
                  ],
                ),
        ));
  }
}
