import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:sandwich_shop/views/profile_screen.dart';
import 'package:sandwich_shop/models/cart.dart';

void main() {
  testWidgets('Profile screen drawer and save snackbar', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => Cart()),
        ],
        child: const MaterialApp(home: ProfileScreen()),
      ),
    );

    final nameField = find.byKey(const Key('profile_name_field'));
    final emailField = find.byKey(const Key('profile_email_field'));
    final phoneField = find.byKey(const Key('profile_phone_field'));
    final saveButton = find.byKey(const Key('profile_save_button'));

    expect(nameField, findsOneWidget);
    expect(emailField, findsOneWidget);
    expect(phoneField, findsOneWidget);
    expect(saveButton, findsOneWidget);

    // Open the drawer (AppBar shows the menu icon automatically when a drawer is present)
    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();

    // Verify drawer items are present
    expect(find.byKey(const Key('drawer_profile')), findsOneWidget);
    expect(find.byKey(const Key('drawer_order')), findsOneWidget);
    expect(find.byKey(const Key('drawer_cart')), findsOneWidget);
    expect(find.byKey(const Key('drawer_about')), findsOneWidget);

    // Close the drawer by tapping the modal barrier (avoids triggering navigation)
    final modalBarrier = find.byType(ModalBarrier);
    if (modalBarrier.evaluate().isNotEmpty) {
      await tester.tap(modalBarrier);
      await tester.pumpAndSettle();
    }

    await tester.enterText(nameField, 'Alice');
    await tester.enterText(emailField, 'alice@example.com');
    await tester.enterText(phoneField, '1234567890');

    await tester.tap(saveButton);
    await tester.pump(); // start animation for snackbar
    await tester.pump(const Duration(seconds: 1)); // show snackbar

    expect(find.text('Profile saved (not persisted)'), findsOneWidget);
  });
}
