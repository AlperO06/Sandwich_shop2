import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sandwich_shop/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Sandwich Shop Integration Tests', () {
    testWidgets('Complete order flow', (WidgetTester tester) async {
      // Launch the app
      await tester.pumpWidget(const app.App());

      // Wait for the app to be fully loaded
      await tester.pumpAndSettle();

      // Verify that we're on the order screen
      expect(find.text('Sandwich Counter'), findsOneWidget);

      // Step 1: Select a sandwich type
      await tester.tap(find.byType(DropdownMenu).first);
      await tester.pumpAndSettle();

      // Step 2: Toggle between six-inch and footlong
      final switchFinder = find.byType(Switch);
      expect(switchFinder, findsOneWidget);
      await tester.tap(switchFinder);
      await tester.pumpAndSettle();

      // Step 3: Select bread type
      await tester.tap(find.byType(DropdownMenu).last);
      await tester.pumpAndSettle();

      // Step 4: Increase quantity
      final addQuantityButton = find.byIcon(Icons.add).first;
      await tester.tap(addQuantityButton);
      await tester.pumpAndSettle();

      // Step 5: Add to cart
      final addToCartButton = find.widgetWithText(
        ElevatedButton,
        'Add to Cart',
      );
      expect(addToCartButton, findsOneWidget);
      await tester.tap(addToCartButton);
      await tester.pumpAndSettle();

      // Verify snackbar appears
      expect(find.byType(SnackBar), findsOneWidget);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Step 6: Navigate to cart
      final viewCartButton = find.widgetWithText(
        ElevatedButton,
        'View Cart',
      );
      expect(viewCartButton, findsOneWidget);
      await tester.tap(viewCartButton);
      await tester.pumpAndSettle();

      // Verify we're on the cart screen
      expect(find.text('Cart View'), findsOneWidget);
      expect(find.text('Total:'), findsOneWidget);

      // Step 7: Navigate to checkout
      final checkoutButton = find.widgetWithText(
        ElevatedButton,
        'Checkout',
      );
      expect(checkoutButton, findsOneWidget);
      await tester.tap(checkoutButton);
      await tester.pumpAndSettle();

      // Verify we're on the checkout screen
      expect(find.text('Checkout'), findsOneWidget);
      expect(find.text('Order Summary'), findsOneWidget);

      // Step 8: Confirm payment
      final confirmPaymentButton = find.widgetWithText(
        ElevatedButton,
        'Confirm Payment',
      );
      expect(confirmPaymentButton, findsOneWidget);
      await tester.tap(confirmPaymentButton);
      await tester.pumpAndSettle();

      // Wait for payment processing
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Verify order confirmation snackbar
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('Navigate to Profile Screen', (WidgetTester tester) async {
      await tester.pumpWidget(const app.App());
      await tester.pumpAndSettle();

      // Find and tap the Profile button
      final profileButton = find.widgetWithText(
        ElevatedButton,
        'Profile',
      );
      expect(profileButton, findsOneWidget);
      await tester.tap(profileButton);
      await tester.pumpAndSettle();

      // Verify we're on the profile screen
      expect(find.text('Profile'), findsOneWidget);
      expect(find.text('Enter your details:'), findsOneWidget);

      // Enter name
      final nameField = find.byType(TextField).first;
      await tester.enterText(nameField, 'John Doe');
      await tester.pumpAndSettle();

      // Enter location
      final locationField = find.byType(TextField).last;
      await tester.enterText(locationField, 'Downtown');
      await tester.pumpAndSettle();

      // Save profile
      final saveButton = find.widgetWithText(
        ElevatedButton,
        'Save Profile',
      );
      await tester.tap(saveButton);
      await tester.pumpAndSettle();

      // Verify snackbar appears
      expect(find.byType(SnackBar), findsOneWidget);

      // Go back to order screen
      final backButton = find.byType(BackButton);
      if (backButton.evaluate().isNotEmpty) {
        await tester.tap(backButton);
        await tester.pumpAndSettle();
      }
    });

    testWidgets('Navigate to Settings Screen', (WidgetTester tester) async {
      await tester.pumpWidget(const app.App());
      await tester.pumpAndSettle();

      // Find and tap the Settings button
      final settingsButton = find.widgetWithText(
        ElevatedButton,
        'Settings',
      );
      expect(settingsButton, findsOneWidget);
      await tester.tap(settingsButton);
      await tester.pumpAndSettle();

      // Verify we're on the settings screen
      expect(find.text('Settings'), findsOneWidget);
      expect(find.text('Font Size'), findsOneWidget);

      // Find and interact with the slider
      final sliderFinder = find.byType(Slider);
      expect(sliderFinder, findsOneWidget);

      // Drag slider to change font size
      await tester.drag(sliderFinder, const Offset(50, 0));
      await tester.pumpAndSettle();

      // Verify font size changed
      expect(find.text('This is sample text to preview the font size.'),
          findsOneWidget);

      // Go back
      final backButton = find.byType(BackButton);
      if (backButton.evaluate().isNotEmpty) {
        await tester.tap(backButton);
        await tester.pumpAndSettle();
      }
    });

    testWidgets('Cart operations', (WidgetTester tester) async {
      await tester.pumpWidget(const app.App());
      await tester.pumpAndSettle();

      // Add item to cart
      final addToCartButton = find.widgetWithText(
        ElevatedButton,
        'Add to Cart',
      );
      await tester.tap(addToCartButton);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Navigate to cart
      final viewCartButton = find.widgetWithText(
        ElevatedButton,
        'View Cart',
      );
      await tester.tap(viewCartButton);
      await tester.pumpAndSettle();

      // Verify cart has items
      expect(find.text('Your cart is empty.'), findsNothing);
      expect(find.text('Total:'), findsOneWidget);

      // Test quantity controls
      final addQuantityButton = find.byIcon(Icons.add).first;
      await tester.tap(addQuantityButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      // Verify snackbar for quantity increase
      expect(find.byType(SnackBar), findsOneWidget);

      // Test remove item
      final removeButton = find.byIcon(Icons.delete).first;
      await tester.tap(removeButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      // Verify item was removed
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('Empty cart message', (WidgetTester tester) async {
      await tester.pumpWidget(const app.App());
      await tester.pumpAndSettle();

      // Navigate to cart without adding anything
      final viewCartButton = find.widgetWithText(
        ElevatedButton,
        'View Cart',
      );
      await tester.tap(viewCartButton);
      await tester.pumpAndSettle();

      // Verify empty cart message
      expect(find.text('Your cart is empty.'), findsOneWidget);
      expect(find.text('Checkout'), findsNothing);
    });

    testWidgets('Verify cart indicator updates', (WidgetTester tester) async {
      await tester.pumpWidget(const app.App());
      await tester.pumpAndSettle();

      // Find initial cart count (should be 0)
      final initialCartIndicator = find.text('0');
      expect(initialCartIndicator, findsWidgets);

      // Add item to cart
      final addToCartButton = find.widgetWithText(
        ElevatedButton,
        'Add to Cart',
      );
      await tester.tap(addToCartButton);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Find updated cart count (should be 1)
      final updatedCartIndicator = find.text('1');
      expect(updatedCartIndicator, findsWidgets);
    });
  });
}
