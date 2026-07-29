import 'package:flutter/material.dart';

/// Full-screen centered loading indicator.
///
/// Shared so every screen renders the same loading state — pair it with an
/// `AsyncValue.when`/`.loading` branch.
class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
