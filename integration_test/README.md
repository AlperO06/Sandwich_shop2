# Integration Tests for Sandwich Shop App

This directory contains integration tests for the Sandwich Shop application. Integration tests verify that different parts of your app work together properly by simulating end-to-end user flows.

## What are Integration Tests?

Integration tests differ from unit tests and widget tests:
- **Unit tests** verify individual functions or classes in isolation
- **Widget tests** verify that widgets look and behave as expected
- **Integration tests** verify the behavior of the complete app, simulating real user interactions

## Running Integration Tests

### On a Physical Device or Emulator

1. **For Android:**
```bash
flutter drive --target=integration_test/app_test.dart
```

2. **For iOS:**
```bash
flutter drive --target=integration_test/app_test.dart
```

3. **For Web:**
```bash
flutter drive --target=integration_test/app_test.dart --web-renderer=html
```

### Using Flutter Test

You can also run integration tests using the test runner:

```bash
flutter test integration_test/app_test.dart
```

## Test Coverage

The `app_test.dart` file includes the following integration test scenarios:

1. **Complete Order Flow** - Tests the entire ordering process:
   - Select sandwich type
   - Choose size (six-inch or footlong)
   - Select bread type
   - Increase quantity
   - Add to cart
   - Navigate to cart
   - Proceed to checkout
   - Confirm payment

2. **Profile Screen Navigation** - Tests profile functionality:
   - Navigate to profile screen
   - Enter name and location
   - Save profile
   - Display confirmation

3. **Settings Screen Navigation** - Tests settings functionality:
   - Navigate to settings screen
   - Adjust font size using slider
   - Verify changes take effect

4. **Cart Operations** - Tests cart management:
   - Add items to cart
   - Navigate to cart view
   - Increase quantity
   - Remove items
   - Verify notifications

5. **Empty Cart Display** - Tests empty cart state:
   - Verify empty cart message when no items
   - Verify checkout button is hidden

6. **Cart Indicator Updates** - Tests that the cart count indicator:
   - Displays 0 initially
   - Updates to reflect added items
   - Works across navigation

## Important Notes

- Integration tests require a running emulator or device
- Tests may take longer than unit or widget tests
- Integration tests are more brittle and sensitive to UI changes
- Use integration tests for critical user flows and scenarios
- Ensure the app builds successfully before running integration tests

## Debugging Integration Tests

If integration tests fail:

1. **Check device connectivity**: Ensure your device/emulator is connected
2. **Review test logs**: Use `flutter drive` with verbose logging:
   ```bash
   flutter drive --verbose --target=integration_test/app_test.dart
   ```
3. **Verify UI elements**: Make sure the app's UI elements match what tests are looking for
4. **Check timeouts**: Increase `pumpAndSettle()` durations if the app needs more time

## Adding More Integration Tests

To add more integration tests:

1. Add new test cases to `app_test.dart`
2. Follow the pattern of existing tests
3. Use meaningful test names describing what is being tested
4. Include comments explaining complex test steps
5. Handle navigation and waiting appropriately with `pumpAndSettle()`

Example template:
```dart
testWidgets('Your test name', (WidgetTester tester) async {
  await tester.pumpWidget(const app.App());
  await tester.pumpAndSettle();
  
  // Your test steps here
  
  // Verify expected behavior
  expect(find.text('Expected Text'), findsOneWidget);
});
```

## References

- [Flutter Integration Testing Documentation](https://flutter.dev/docs/testing/integration-tests)
- [Flutter Testing Best Practices](https://flutter.dev/docs/testing)
