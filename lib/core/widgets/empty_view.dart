import 'package:flutter/material.dart';
import 'package:flutter_base_project/core/utils/extensions/context_extensions.dart';

/// Placeholder shown when a screen has loaded successfully but has no data.
///
/// Mirrors [ErrorView] so success-but-empty and error states look consistent.
/// The caller supplies a localized [message]; [icon] and an optional [action]
/// let it be reused across features.
class EmptyView extends StatelessWidget {
  const EmptyView({
    required this.message,
    this.icon = Icons.inbox_outlined,
    this.action,
    super.key,
  });

  final String message;
  final IconData icon;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 56, color: context.colors.outline),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: context.textTheme.bodyLarge,
            ),
            if (action != null) ...[const SizedBox(height: 16), action!],
          ],
        ),
      ),
    );
  }
}
