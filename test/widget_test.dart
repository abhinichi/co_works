import 'package:co_works/core/providers/core_providers.dart';
import 'package:co_works/features/auth/presentation/views/login_view.dart';
import 'package:co_works/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('LoginView renders its fields and submit button', (tester) async {
    // Setup mock shared preferences.
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: LoginView(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Verify UI components.
    expect(find.text('Login'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.text('Sign In'), findsOneWidget);
  });
}
