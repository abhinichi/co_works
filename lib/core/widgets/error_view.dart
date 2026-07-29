import 'package:flutter/material.dart';
import 'package:co_works/core/utils/extensions/context_extensions.dart';

/// Full-screen error placeholder with an optional retry action.
///
/// Pair this with an `AsyncValue.when`/`.error` branch to give every screen a
/// consistent error experience.
class ErrorView extends StatelessWidget {
  const ErrorView({required this.message, this.onRetry, super.key});

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 56, color: context.colors.error),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: context.textTheme.bodyLarge,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: Text(context.l10n.retryButton),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
