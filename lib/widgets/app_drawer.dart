import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  void _navigate(BuildContext context, String route) {
    Navigator.of(context).pop(); // close drawer
    // Use pushReplacement for top-level navigation to avoid stacking many screens
    if (ModalRoute.of(context)?.settings.name != route) {
      Navigator.of(context).pushReplacementNamed(route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      key: const Key('app_drawer'),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text('Sandwich Shop', style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
          ListTile(
            key: const Key('drawer_order'),
            leading: const Icon(Icons.home),
            title: const Text('Order'),
            onTap: () => _navigate(context, '/'),
          ),
          ListTile(
            key: const Key('drawer_cart'),
            leading: const Icon(Icons.shopping_cart),
            title: const Text('Cart'),
            onTap: () => _navigate(context, '/cart'),
          ),
          ListTile(
            key: const Key('drawer_profile'),
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () => _navigate(context, '/profile'),
          ),
          ListTile(
            key: const Key('drawer_about'),
            leading: const Icon(Icons.info),
            title: const Text('About'),
            onTap: () => _navigate(context, '/about'),
          ),
        ],
      ),
    );
  }
}
