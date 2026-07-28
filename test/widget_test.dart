import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:co_works/main.dart';

void main() {
  testWidgets('Login screen elements and validation test', (WidgetTester tester) async {
    // Set a larger viewport to prevent widgets from being off-screen in tests.
    tester.view.physicalSize = const Size(800, 1000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // 1. Verify that the brand name "CoWork" is present.
    expect(find.text('CoWork'), findsOneWidget);

    // 2. Verify that "MEMBER LOGIN" is present.
    expect(find.text('MEMBER LOGIN'), findsOneWidget);

    // 3. Verify that "Login" heading is present.
    expect(find.text('Login'), findsOneWidget);

    // 4. Verify that User ID field is prefilled with "naren@nichi.com".
    expect(find.text('naren@nichi.com'), findsOneWidget);

    // 5. Verify the presence of text fields
    final textFieldsFinder = find.byType(TextField);
    expect(textFieldsFinder, findsNWidgets(2));

    // 6. Test toggling password visibility
    // Check initial obscured state of password field.
    TextField getPasswordField() => tester.widget<TextField>(textFieldsFinder.at(1));
    expect(getPasswordField().obscureText, true);

    // Tap visibility icon to show password
    final visibilityIconFinder = find.byIcon(Icons.visibility_outlined);
    expect(visibilityIconFinder, findsOneWidget);
    await tester.tap(visibilityIconFinder);
    await tester.pump();

    // Verify it is no longer obscured
    expect(getPasswordField().obscureText, false);

    // 7. Test Form Validation (User ID empty)
    // First, clear the User ID field
    final userIdFinder = textFieldsFinder.at(0);
    await tester.enterText(userIdFinder, '');
    await tester.pump();

    // Tap Sign In button
    final signInButtonFinder = find.text('Sign In');
    expect(signInButtonFinder, findsOneWidget);
    await tester.tap(signInButtonFinder);
    await tester.pump();

    // Verify validation error
    expect(find.text('User ID is required'), findsOneWidget);

    // Enter invalid email
    await tester.enterText(userIdFinder, 'invalid-email');
    await tester.tap(signInButtonFinder);
    await tester.pump();
    expect(find.text('Please enter a valid email address'), findsOneWidget);

    // Enter valid email
    await tester.enterText(userIdFinder, 'naren@nichi.com');
    await tester.pump();

    // Now, test Password validation by clearing password
    final passwordFieldFinder = textFieldsFinder.at(1);
    await tester.enterText(passwordFieldFinder, '');
    await tester.pump();
    await tester.tap(signInButtonFinder);
    await tester.pump();
    expect(find.text('Password is required'), findsOneWidget);
  });
}
