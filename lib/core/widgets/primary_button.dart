import 'package:flutter/material.dart';

/// App-wide primary call-to-action button.
///
/// Shared widgets like this live in `core/widgets` so every feature renders
/// consistent UI and there is a single place to tweak look & behaviour. It
/// shows a spinner and disables itself while [isLoading] is true.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? const SizedBox.square(
              dimension: 22,
              child: CircularProgressIndicator(strokeWidth: 2.5),
            )
          : Text(label),
    );
  }
}
