import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Minimal, self-contained checkout widget used only for tests.
/// Replace TestCheckoutScreen with your real CheckoutScreen when available.
class TestCheckoutScreen extends StatefulWidget {
  final int initialCount;
  const TestCheckoutScreen({Key? key, this.initialCount = 0}) : super(key: key);

  @override
  State<TestCheckoutScreen> createState() => _TestCheckoutScreenState();
}

class _TestCheckoutScreenState extends State<TestCheckoutScreen> {
  late int _count;

  @override
  void initState() {
    super.initState();
    _count = widget.initialCount;
  }

  void _increment() => setState(() => _count++);
  void _decrement() => setState(() {
        if (_count > 0) _count--;
      });

  @override
  Widget build(BuildContext context) {
    final total = (_count * 5).toString(); // pretend each item costs 5 units
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Checkout')),
        body: Column(
          key: const Key('checkout-body'),
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Items: $_count', key: const Key('items-count')),
            const SizedBox(height: 8),
            Text('Total: $total', key: const Key('total-amount')),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  key: const Key('decrement-button'),
                  onPressed: _decrement,
                  icon: const Icon(Icons.remove),
                ),
                IconButton(
                  key: const Key('increment-button'),
                  onPressed: _increment,
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              key: const Key('place-order'),
              onPressed: _count > 0 ? () {} : null,
              child: const Text('Place Order'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  testWidgets('renders title, item count, total and place order button',
      (WidgetTester tester) async {
    await tester.pumpWidget(const TestCheckoutScreen(initialCount: 2));

    expect(find.text('Checkout'), findsOneWidget);
    expect(find.byKey(const Key('items-count')), findsOneWidget);
    expect(find.text('Items: 2'), findsOneWidget);
    expect(find.byKey(const Key('total-amount')), findsOneWidget);
    expect(find.text('Total: 10'), findsOneWidget);
    expect(find.byKey(const Key('place-order')), findsOneWidget);
    // Button should be enabled since count > 0
    final ElevatedButton button = tester.widget(find.byKey(const Key('place-order')));
    expect(button.enabled, isTrue);
  });

  testWidgets('increment and decrement buttons change item count and total',
      (WidgetTester tester) async {
    await tester.pumpWidget(const TestCheckoutScreen(initialCount: 1));

    // initial assertions
    expect(find.text('Items: 1'), findsOneWidget);
    expect(find.text('Total: 5'), findsOneWidget);

    // tap increment
    await tester.tap(find.byKey(const Key('increment-button')));
    await tester.pumpAndSettle();
    expect(find.text('Items: 2'), findsOneWidget);
    expect(find.text('Total: 10'), findsOneWidget);

    // tap decrement twice (one brings back to 1, second to 0)
    await tester.tap(find.byKey(const Key('decrement-button')));
    await tester.pumpAndSettle();
    expect(find.text('Items: 1'), findsOneWidget);

    await tester.tap(find.byKey(const Key('decrement-button')));
    await tester.pumpAndSettle();
    expect(find.text('Items: 0'), findsOneWidget);
    expect(find.text('Total: 0'), findsOneWidget);
  });

  testWidgets('place order button is disabled when cart is empty',
      (WidgetTester tester) async {
    await tester.pumpWidget(const TestCheckoutScreen(initialCount: 0));

    final Finder placeOrderFinder = find.byKey(const Key('place-order'));
    expect(placeOrderFinder, findsOneWidget);

    final ElevatedButton button = tester.widget(placeOrderFinder);
    expect(button.enabled, isFalse);
  });
}