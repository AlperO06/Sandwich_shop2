import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/views/profile_screen.dart';

void main() {
  testWidgets('Profile screen save shows snackbar', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: ProfileScreen()));

    final nameField = find.byKey(const Key('profile_name_field'));
    final emailField = find.byKey(const Key('profile_email_field'));
    final phoneField = find.byKey(const Key('profile_phone_field'));
    final saveButton = find.byKey(const Key('profile_save_button'));

    expect(nameField, findsOneWidget);
    expect(emailField, findsOneWidget);
    expect(phoneField, findsOneWidget);
    expect(saveButton, findsOneWidget);

    await tester.enterText(nameField, 'Alice');
    await tester.enterText(emailField, 'alice@example.com');
    await tester.enterText(phoneField, '1234567890');

    await tester.tap(saveButton);
    await tester.pump(); // start animation for snackbar
    await tester.pump(const Duration(seconds: 1)); // show snackbar

    expect(find.text('Profile saved (not persisted)'), findsOneWidget);
  });
}
