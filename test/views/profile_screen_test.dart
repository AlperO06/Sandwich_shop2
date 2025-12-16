import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:sandwich_shop/views/profile_screen.dart';
import 'package:sandwich_shop/views/common_widgets.dart';
import 'package:sandwich_shop/models/cart.dart';

void main() {
  testWidgets('Profile screen renders with AppBar', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => Cart()),
        ],
        child: const MaterialApp(home: ProfileScreen()),
      ),
    );

    // Verify the screen displays
    expect(find.text('Profile'), findsOneWidget);
    
    // Verify AppBar with logo is present
    expect(find.byType(AppBarWithLogo), findsOneWidget);
  });
}
