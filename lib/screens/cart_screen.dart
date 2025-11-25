import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';
import '../models/sandwich.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your Cart')),
      body: Consumer<Cart>(
        builder: (context, cart, _) {
          final items = cart.items;
          if (items.isEmpty) {
            return Center(child: Text('Your cart is empty'));
          }
          return Column(
            children: [
              Expanded(
                child: ListView(
                  children: items.keys.map((sandwich) {
                    final qty = cart.getQuantity(sandwich);
                    return ListTile(
                      leading: null, // Placeholder for sandwich image
                      title: Text(sandwich.name),
                      subtitle: Text(
                          '${sandwich.breadType}${sandwich.isFootlong ? " • Footlong" : ""}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Decrease quantity
                          IconButton(
                            icon: Icon(Icons.remove_circle_outline),
                            onPressed: () {
                              cart.remove(sandwich, quantity: 1);
                              // If removed entirely, show feedback
                              if (cart.getQuantity(sandwich) == 0) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          '${sandwich.name} removed from cart')),
                                );
                              }
                            },
                          ),
                          // Quantity display
                          Text(
                            '$qty',
                            style: TextStyle(fontSize: 16),
                          ),
                          // Increase quantity
                          IconButton(
                            icon: Icon(Icons.add_circle_outline),
                            onPressed: () {
                              cart.add(sandwich, quantity: 1);
                            },
                          ),
                          // Remove entirely
                          IconButton(
                            icon: Icon(Icons.delete_outline),
                            onPressed: () {
                              final name = sandwich.name;
                              cart.removeItem(sandwich);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('$name removed from cart')),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              // Total price area
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total',
                        style: Theme.of(context).textTheme.headline6),
                    Text('\$${cart.totalPrice.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.headline6),
                  ],
                ),
              ),
              // ...existing Back to Order button etc...
            ],
          );
        },
      ),
    );
  }
}