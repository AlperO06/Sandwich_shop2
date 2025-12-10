import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandwich_shop/models/cart.dart';
import 'package:sandwich_shop/views/app_styles.dart';

/// A reusable AppBar widget with the sandwich shop logo and title
class AppBarWithLogo extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final TextStyle? titleStyle;
  final bool showCartIndicator;
  final List<Widget>? additionalActions;

  const AppBarWithLogo({
    super.key,
    required this.title,
    this.titleStyle,
    this.showCartIndicator = true,
    this.additionalActions,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> actions = [];

    if (showCartIndicator) {
      actions.add(
        Consumer<Cart>(
          builder: (context, cart, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.shopping_cart),
                  const SizedBox(width: 4),
                  Text('${cart.countOfItems}'),
                ],
              ),
            );
          },
        ),
      );
    }

    if (additionalActions != null) {
      actions.addAll(additionalActions!);
    }

    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 100,
          child: Image.asset('assets/images/logo.png'),
        ),
      ),
      title: Text(
        title,
        style: titleStyle ?? AppStyles.heading1,
      ),
      actions: actions.isNotEmpty ? actions : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/// A reusable styled button widget used throughout the app
class StyledButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final String label;
  final Color backgroundColor;

  const StyledButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.label,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final ButtonStyle myButtonStyle = ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      foregroundColor: Colors.white,
      textStyle: AppStyles.normalText,
    );

    return ElevatedButton(
      onPressed: onPressed,
      style: myButtonStyle,
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }
}

/// A cart indicator widget that can be used independently
class CartIndicator extends StatelessWidget {
  const CartIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, cart, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.shopping_cart),
              const SizedBox(width: 4),
              Text('${cart.countOfItems}'),
            ],
          ),
        );
      },
    );
  }
}
