# Comprehensive Integration Test Coverage

## Overview

The `app_test.dart` integration test suite provides extensive coverage of the Sandwich Shop application with **20+ test cases** organized into three categories: Happy Path, Edge Cases, and Error Scenarios.

## Test Categories

### ✅ HAPPY PATH TESTS (4 tests)

These tests verify that core user journeys work correctly when everything goes as expected.

#### 1. **Complete Order Flow - Happy Path**
- **What it tests**: The entire happy path from app launch to successful payment
- **User journey**: Select sandwich → Choose size → Pick bread → Set quantity → Add to cart → View cart → Checkout → Confirm payment
- **Verifications**: All screen transitions work, data persists, snackbars appear as expected

#### 2. **Multiple Items in Cart Flow**
- **What it tests**: Adding multiple different sandwiches to cart
- **User journey**: Add first item → Change sandwich type → Add second item → View cart
- **Verifications**: Both items appear in cart, quantity controls available for each

#### 3. **Profile Save and Display Flow**
- **What it tests**: Profile screen data entry and saving
- **User journey**: Navigate to Profile → Enter name and location → Save → Confirmation
- **Verifications**: Form accepts input, save button works, confirmation snackbar appears

#### 4. **Font Size Persistence Across Screens**
- **What it tests**: Settings changes persist when navigating between screens
- **User journey**: Go to Settings → Adjust font size → Return to Order screen
- **Verifications**: Font size slider works, changes are applied

---

### ⚠️ EDGE CASE TESTS (7 tests)

These tests verify that the app handles unusual but valid scenarios correctly.

#### 5. **Add Item with Zero Quantity - Edge Case**
- **What it tests**: Boundary condition when quantity reaches 0
- **Scenario**: User decrements quantity to 0 and tries to add to cart
- **Expected behavior**: Add to Cart button becomes disabled, no item added
- **Why important**: Prevents invalid orders and provides good UX

#### 6. **High Quantity Order - Edge Case**
- **What it tests**: Large quantities and price calculations
- **Scenario**: User increases quantity to 6 and adds to cart
- **Verifications**: Quantity displays correctly, total price calculates accurately
- **Why important**: Tests numeric limits and price calculation accuracy

#### 7. **All Sandwich Types - Edge Case**
- **What it tests**: All sandwich type options are available
- **Scenario**: User opens sandwich type dropdown
- **Verifications**: Multiple menu options appear
- **Why important**: Ensures all menu items are selectable

#### 8. **All Bread Types - Edge Case**
- **What it tests**: All bread type options are available
- **Scenario**: User opens bread type dropdown
- **Verifications**: Multiple bread options appear
- **Why important**: Ensures all bread choices are available

#### 9. **Toggle Size Multiple Times - Edge Case**
- **What it tests**: Repeated state changes don't cause issues
- **Scenario**: User toggles between six-inch and footlong 4 times
- **Verifications**: App remains responsive, Add to Cart still functions
- **Why important**: Tests state management stability

#### 10. **Cart Modification After Navigation - Edge Case**
- **What it tests**: Cart state persists through navigation
- **Scenario**: Add item → Modify quantity → Go to checkout → Verify updated quantity
- **Verifications**: Modified quantity shown in Order Summary
- **Why important**: Ensures Provider/state management works correctly

#### 11. **Different Sandwich Types with Same Settings - Edge Case**
- **What it tests**: Multiple different sandwiches can be ordered
- **Scenario**: Add one sandwich → Change type → Add another → View cart
- **Verifications**: Both distinct items appear in cart
- **Why important**: Tests cart's ability to handle multiple distinct items

---

### ❌ ERROR SCENARIO TESTS (6 tests)

These tests verify that the app handles errors, invalid states, and unexpected user behavior gracefully.

#### 12. **Empty Profile Submission - Error Scenario**
- **What it tests**: Form submission with no data
- **Scenario**: User clicks Save Profile without entering any data
- **Expected behavior**: App handles gracefully (snackbar still appears)
- **Why important**: Tests form validation and error handling

#### 13. **Navigate with Items in Cart - Error Scenario**
- **What it tests**: Data retention when navigating between unrelated screens
- **Scenario**: Add items → Go to Settings → Return → Check cart
- **Verifications**: Cart items still present, not lost during navigation
- **Why important**: Tests state persistence and Provider robustness

#### 14. **Rapid Button Presses - Error Scenario**
- **What it tests**: App stability under rapid user input
- **Scenario**: User rapidly taps Add to Cart button multiple times
- **Verifications**: No crashes, items added to cart, cart updates correctly
- **Why important**: Tests debouncing and concurrency handling

#### 15. **Cancel Checkout Flow - Error Scenario**
- **What it tests**: Back navigation from checkout screen
- **Scenario**: Go through checkout → Press back button → Return to cart
- **Verifications**: Successfully returns to cart screen
- **Why important**: Tests navigation stack integrity

#### 16. **Empty Cart Checkout Attempt - Error Scenario**
- **What it tests**: Checkout with no items
- **Scenario**: Go directly to cart without adding items → Try to checkout
- **Verifications**: Checkout button not shown, empty cart message displayed
- **Why important**: Prevents invalid orders and confusing UX

---

### 🛒 CART OPERATIONS & CONSISTENCY TESTS (5 tests)

These tests specifically focus on cart functionality and data consistency.

#### 17. **Add and Remove Items Sequentially**
- **What it tests**: Complete add/remove cycle
- **Scenario**: Add item → Go to cart → Remove item → Verify empty
- **Verifications**: Item removed, cart shows empty state
- **Why important**: Tests remove functionality end-to-end

#### 18. **Decrement Quantity to Zero**
- **What it tests**: Removing items by decrementing quantity
- **Scenario**: Add item with quantity 2 → Decrement twice → Item removed
- **Verifications**: Item disappears from cart after reaching 0
- **Why important**: Tests alternative removal method (decrement vs delete button)

#### 19. **Cart Indicator Consistency**
- **What it tests**: Cart count indicator shows correct values
- **Scenario**: Add item (qty 2) → Verify shows 2 → Add another → Verify shows 3
- **Verifications**: Indicator updates correctly with each addition
- **Why important**: Tests that AppBar cart indicator stays in sync with Cart state

#### 20. **Settings Screen Interactions**
- **What it tests**: Settings UI responsiveness and state changes
- **Scenario**: Navigate to Settings → Drag slider multiple times
- **Verifications**: No crashes, slider responds to input
- **Why important**: Tests Settings screen stability

---

## Test Organization & Structure

```
Sandwich Shop Integration Tests
├── HAPPY PATH TESTS (Basic user journeys)
│   ├── Complete order flow
│   ├── Multiple items in cart
│   ├── Profile save and display
│   └── Font size persistence
├── EDGE CASE TESTS (Boundary conditions)
│   ├── Zero quantity handling
│   ├── High quantity orders
│   ├── All menu options
│   ├── Repeated toggles
│   └── State persistence
├── ERROR SCENARIO TESTS (Error handling)
│   ├── Empty form submission
│   ├── Navigation with cart items
│   ├── Rapid input handling
│   ├── Navigation cancellation
│   └── Invalid checkout attempts
└── CART OPERATIONS (Data consistency)
    ├── Add/remove cycles
    ├── Quantity decrements
    ├── Cart indicator sync
    └── Settings interactions
```

## Running Specific Tests

### Run all integration tests:
```bash
flutter test integration_test/app_test.dart
```

### Run tests with verbose output:
```bash
flutter test --verbose integration_test/app_test.dart
```

### Run tests on a device:
```bash
flutter drive --target=integration_test/app_test.dart
```

## Key Testing Strategies Used

1. **State Management Testing**: Verifies that Provider state persists correctly across navigation
2. **Boundary Testing**: Tests edge cases like zero quantity, maximum quantity
3. **Navigation Testing**: Verifies all screen transitions and back navigation work
4. **Data Persistence**: Ensures cart, profile, and settings data persist appropriately
5. **User Interaction Testing**: Tests button taps, text input, slider interaction
6. **Error Resilience**: Tests app stability under invalid inputs and edge cases
7. **UI Consistency**: Verifies cart indicator and other UI elements stay synchronized

## Coverage Map

| Feature | Unit Tests | Widget Tests | Integration Tests |
|---------|------------|--------------|-------------------|
| Cart Management | ✅ | ✅ | ✅ |
| Order Flow | ❌ | ❌ | ✅ |
| Navigation | ❌ | ❌ | ✅ |
| Profile Screen | ❌ | ❌ | ✅ |
| Settings Screen | ❌ | ❌ | ✅ |
| Price Calculations | ✅ | ❌ | ✅ |
| Data Persistence | ❌ | ❌ | ✅ |
| State Management | ❌ | ❌ | ✅ |

## Expected Test Results

When all tests pass successfully, you should see:
- ✓ 20+ passing tests
- No crashes or hangs
- Consistent screen transitions
- Proper error handling
- Data persistence across navigation

## Adding New Tests

To add a new integration test following the established patterns:

1. **Identify the user journey** to test
2. **Determine the category**: Happy Path, Edge Case, or Error Scenario
3. **Write descriptive test name** indicating what's being tested
4. **Launch app**: `await tester.pumpWidget(const app.App());`
5. **Perform user actions**: Tap buttons, enter text, drag sliders
6. **Verify expectations**: Use `expect()` statements
7. **Wait appropriately**: Use `pumpAndSettle()` between major actions

### Example Test Template:
```dart
testWidgets('Test description here', (WidgetTester tester) async {
  // Setup
  await tester.pumpWidget(const app.App());
  await tester.pumpAndSettle();
  
  // Action
  await tester.tap(find.byType(SomeWidget));
  await tester.pumpAndSettle();
  
  // Verify
  expect(find.text('Expected Result'), findsOneWidget);
});
```

## Troubleshooting

- **Test hangs**: Increase `pumpAndSettle()` duration
- **Widget not found**: Verify widget exists with `find.byType()` first
- **Navigation not working**: Check that screen widgets are properly imported
- **State not persisting**: Ensure Provider is wrapping the app correctly

---

This comprehensive test suite ensures that your Sandwich Shop application is robust, handles edge cases gracefully, and provides a consistent user experience across all user journeys.
