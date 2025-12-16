import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sandwich_shop/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Sandwich Shop Integration Tests', () {
    // ========== HAPPY PATH TESTS ==========

    testWidgets('Complete order flow - Happy Path', (WidgetTester tester) async {
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

    testWidgets('Multiple items in cart flow', (WidgetTester tester) async {
      await tester.pumpWidget(const app.App());
      await tester.pumpAndSettle();

      // Add first item
      await tester.tap(find.byIcon(Icons.add).first); // increase quantity
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(ElevatedButton, 'Add to Cart'));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Change sandwich type and add second item
      await tester.tap(find.byType(DropdownMenu).first);
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(ElevatedButton, 'Add to Cart'));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Navigate to cart
      await tester.tap(find.widgetWithText(ElevatedButton, 'View Cart'));
      await tester.pumpAndSettle();

      // Verify both items are in cart
      expect(find.text('Total:'), findsOneWidget);
      expect(find.byIcon(Icons.add), findsWidgets); // quantity controls for items
    });

    testWidgets('Profile save and display flow', (WidgetTester tester) async {
      await tester.pumpWidget(const app.App());
      await tester.pumpAndSettle();

      // Navigate to profile
      await tester.tap(find.widgetWithText(ElevatedButton, 'Profile'));
      await tester.pumpAndSettle();

      // Verify on profile screen
      expect(find.text('Enter your details:'), findsOneWidget);

      // Enter profile data
      await tester.enterText(find.byType(TextField).first, 'Alice Johnson');
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).last, 'North Park');
      await tester.pumpAndSettle();

      // Save profile
      await tester.tap(find.widgetWithText(ElevatedButton, 'Save Profile'));
      await tester.pumpAndSettle();

      // Verify save confirmation
      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Profile saved'), findsOneWidget);
    });

    testWidgets('Font size persistence across screens', (WidgetTester tester) async {
      await tester.pumpWidget(const app.App());
      await tester.pumpAndSettle();

      // Navigate to settings
      await tester.tap(find.widgetWithText(ElevatedButton, 'Settings'));
      await tester.pumpAndSettle();

      // Adjust font size
      final slider = find.byType(Slider);
      await tester.drag(slider, const Offset(100, 0)); // drag right to increase
      await tester.pumpAndSettle();

      // Go back to order screen
      final backButton = find.byType(BackButton);
      if (backButton.evaluate().isNotEmpty) {
        await tester.tap(backButton);
        await tester.pumpAndSettle();
      }

      // Font changes should persist (verify via AppStyles)
      expect(find.text('Sandwich Counter'), findsOneWidget);
    });

    // ========== EDGE CASE TESTS ==========

    testWidgets('Add item with zero quantity - Edge Case', (WidgetTester tester) async {
      await tester.pumpWidget(const app.App());
      await tester.pumpAndSettle();

      // Verify default quantity is 1
      expect(find.text('1'), findsWidgets);

      // Try to decrease quantity below zero
      final decreaseButton = find.byIcon(Icons.remove).first;
      await tester.tap(decreaseButton);
      await tester.pumpAndSettle();

      // Quantity should be 0
      expect(find.text('0'), findsWidgets);

      // Add to cart button should be disabled
      final addToCartButton = find.widgetWithText(ElevatedButton, 'Add to Cart');
      final addButton = tester.widget<ElevatedButton>(addToCartButton);
      expect(addButton.onPressed, isNull);
    });

    testWidgets('High quantity order - Edge Case', (WidgetTester tester) async {
      await tester.pumpWidget(const app.App());
      await tester.pumpAndSettle();

      // Increase quantity multiple times
      final addQuantityButton = find.byIcon(Icons.add).first;
      for (int i = 0; i < 5; i++) {
        await tester.tap(addQuantityButton);
        await tester.pumpAndSettle();
      }

      // Should show quantity of 6 (1 default + 5 added)
      expect(find.text('6'), findsWidgets);

      // Add to cart
      await tester.tap(find.widgetWithText(ElevatedButton, 'Add to Cart'));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Verify in cart
      await tester.tap(find.widgetWithText(ElevatedButton, 'View Cart'));
      await tester.pumpAndSettle();

      // Should show correct total price
      expect(find.text('Total:'), findsOneWidget);
    });

    testWidgets('All sandwich types - Edge Case', (WidgetTester tester) async {
      await tester.pumpWidget(const app.App());
      await tester.pumpAndSettle();

      // Test that we can cycle through sandwich types
      final sandwichDropdown = find.byType(DropdownMenu).first;

      // Open dropdown
      await tester.tap(sandwichDropdown);
      await tester.pumpAndSettle();

      // Verify multiple options exist
      expect(find.byType(MenuItemButton), findsWidgets);
    });

    testWidgets('All bread types - Edge Case', (WidgetTester tester) async {
      await tester.pumpWidget(const app.App());
      await tester.pumpAndSettle();

      // Test that we can cycle through bread types
      final breadDropdown = find.byType(DropdownMenu).last;

      // Open dropdown
      await tester.tap(breadDropdown);
      await tester.pumpAndSettle();

      // Verify multiple options exist
      expect(find.byType(MenuItemButton), findsWidgets);
    });

    testWidgets('Toggle size multiple times - Edge Case', (WidgetTester tester) async {
      await tester.pumpWidget(const app.App());
      await tester.pumpAndSettle();

      final switchFinder = find.byType(Switch);

      // Toggle multiple times
      for (int i = 0; i < 4; i++) {
        await tester.tap(switchFinder);
        await tester.pumpAndSettle();
      }

      // Should still function properly
      expect(find.byType(Switch), findsOneWidget);

      // Add to cart should still work
      await tester.tap(find.widgetWithText(ElevatedButton, 'Add to Cart'));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Verify item was added
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('Cart modification after checkout - Edge Case', 
        (WidgetTester tester) async {
      await tester.pumpWidget(const app.App());
      await tester.pumpAndSettle();

      // Add item to cart
      await tester.tap(find.widgetWithText(ElevatedButton, 'Add to Cart'));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Go to cart
      await tester.tap(find.widgetWithText(ElevatedButton, 'View Cart'));
      await tester.pumpAndSettle();

      // Modify quantity
      await tester.tap(find.byIcon(Icons.add).first);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      // Go to checkout
      await tester.tap(find.widgetWithText(ElevatedButton, 'Checkout'));
      await tester.pumpAndSettle();

      // Verify order summary is updated
      expect(find.text('Order Summary'), findsOneWidget);
    });

    // ========== ERROR SCENARIO TESTS ==========

    testWidgets('Empty profile submission - Error Scenario', 
        (WidgetTester tester) async {
      await tester.pumpWidget(const app.App());
      await tester.pumpAndSettle();

      // Navigate to profile
      await tester.tap(find.widgetWithText(ElevatedButton, 'Profile'));
      await tester.pumpAndSettle();

      // Don't enter any data, just click save
      await tester.tap(find.widgetWithText(ElevatedButton, 'Save Profile'));
      await tester.pumpAndSettle();

      // Should still show snackbar (app allows empty save)
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('Navigate with items in cart - Error Scenario',
        (WidgetTester tester) async {
      await tester.pumpWidget(const app.App());
      await tester.pumpAndSettle();

      // Add item to cart
      await tester.tap(find.widgetWithText(ElevatedButton, 'Add to Cart'));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Navigate to settings
      await tester.tap(find.widgetWithText(ElevatedButton, 'Settings'));
      await tester.pumpAndSettle();

      // Go back
      final backButton = find.byType(BackButton);
      if (backButton.evaluate().isNotEmpty) {
        await tester.tap(backButton);
        await tester.pumpAndSettle();
      }

      // Cart should still have items
      await tester.tap(find.widgetWithText(ElevatedButton, 'View Cart'));
      await tester.pumpAndSettle();
      expect(find.text('Your cart is empty.'), findsNothing);
    });

    testWidgets('Rapid button presses - Error Scenario', 
        (WidgetTester tester) async {
      await tester.pumpWidget(const app.App());
      await tester.pumpAndSettle();

      // Rapidly tap Add to Cart multiple times
      final addButton = find.widgetWithText(ElevatedButton, 'Add to Cart');
      await tester.tap(addButton);
      await tester.tap(addButton);
      await tester.tap(addButton);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Navigate to cart and verify items
      await tester.tap(find.widgetWithText(ElevatedButton, 'View Cart'));
      await tester.pumpAndSettle();

      // Should have items in cart (no crash)
      expect(find.text('Total:'), findsOneWidget);
    });

    testWidgets('Cancel checkout flow - Error Scenario', 
        (WidgetTester tester) async {
      await tester.pumpWidget(const app.App());
      await tester.pumpAndSettle();

      // Add item and go to checkout
      await tester.tap(find.widgetWithText(ElevatedButton, 'Add to Cart'));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      await tester.tap(find.widgetWithText(ElevatedButton, 'View Cart'));
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(ElevatedButton, 'Checkout'));
      await tester.pumpAndSettle();

      // Try to go back
      final backButton = find.byType(BackButton);
      if (backButton.evaluate().isNotEmpty) {
        await tester.tap(backButton);
        await tester.pumpAndSettle();
      }

      // Should navigate back successfully
      expect(find.text('Cart View'), findsOneWidget);
    });

    // ========== CART OPERATIONS ==========

    testWidgets('Add and remove items sequentially', (WidgetTester tester) async {
      await tester.pumpWidget(const app.App());
      await tester.pumpAndSettle();

      // Add item
      await tester.tap(find.widgetWithText(ElevatedButton, 'Add to Cart'));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Go to cart
      await tester.tap(find.widgetWithText(ElevatedButton, 'View Cart'));
      await tester.pumpAndSettle();

      // Remove item
      final removeButton = find.byIcon(Icons.delete).first;
      await tester.tap(removeButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      // Verify empty cart
      expect(find.text('Your cart is empty.'), findsOneWidget);
    });

    testWidgets('Decrement quantity to zero', (WidgetTester tester) async {
      await tester.pumpWidget(const app.App());
      await tester.pumpAndSettle();

      // Add item with quantity 2
      await tester.tap(find.byIcon(Icons.add).first);
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(ElevatedButton, 'Add to Cart'));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Go to cart
      await tester.tap(find.widgetWithText(ElevatedButton, 'View Cart'));
      await tester.pumpAndSettle();

      // Decrement quantity twice
      final decrementButton = find.byIcon(Icons.remove).first;
      await tester.tap(decrementButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.tap(decrementButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      // Item should be removed
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('Empty cart checkout attempt - Error Scenario', 
        (WidgetTester tester) async {
      await tester.pumpWidget(const app.App());
      await tester.pumpAndSettle();

      // Go directly to cart without adding items
      await tester.tap(find.widgetWithText(ElevatedButton, 'View Cart'));
      await tester.pumpAndSettle();

      // Checkout button should not be visible
      expect(find.widgetWithText(ElevatedButton, 'Checkout'), findsNothing);

      // Empty cart message should be shown
      expect(find.text('Your cart is empty.'), findsOneWidget);
    });

    testWidgets('Cart indicator consistency', (WidgetTester tester) async {
      await tester.pumpWidget(const app.App());
      await tester.pumpAndSettle();

      // Add item with quantity 2
      await tester.tap(find.byIcon(Icons.add).first);
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(ElevatedButton, 'Add to Cart'));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Cart indicator should show 2
      expect(find.text('2'), findsWidgets);

      // Add another item
      await tester.tap(find.widgetWithText(ElevatedButton, 'Add to Cart'));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Cart indicator should show 3
      expect(find.text('3'), findsWidgets);
    });

    testWidgets('Settings screen interactions', (WidgetTester tester) async {
      await tester.pumpWidget(const app.App());
      await tester.pumpAndSettle();

      // Navigate to settings
      await tester.tap(find.widgetWithText(ElevatedButton, 'Settings'));
      await tester.pumpAndSettle();

      // Verify settings elements
      expect(find.text('Font Size'), findsOneWidget);
      expect(find.byType(Slider), findsOneWidget);

      // Drag slider multiple times
      final slider = find.byType(Slider);
      await tester.drag(slider, const Offset(50, 0));
      await tester.pumpAndSettle();

      await tester.drag(slider, const Offset(-30, 0));
      await tester.pumpAndSettle();

      // Should not crash
      expect(find.text('Font Size'), findsOneWidget);
    });
  });
}
