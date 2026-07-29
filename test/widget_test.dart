import 'package:flutter/material.dart';
import 'package:co_works/features/auth/presentation/views/login_view.dart';
import 'package:co_works/l10n/generated/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('LoginView renders its fields and submit button', (tester) async {
    // A View can be pumped in isolation: it only depends on its ViewModel,
    // whose initial state has no external dependencies. Localization delegates
    // are supplied so `context.l10n` resolves.
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: LoginView(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Welcome back'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.widgetWithText(FilledButton, 'Sign in'), findsOneWidget);
  });
}
