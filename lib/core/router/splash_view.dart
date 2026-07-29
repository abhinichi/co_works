import 'package:flutter/material.dart';

/// Shown while the app determines the initial auth status
/// (`AuthStatus.unknown`). The router redirects away from here as soon as the
/// status resolves to authenticated/unauthenticated.
class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
