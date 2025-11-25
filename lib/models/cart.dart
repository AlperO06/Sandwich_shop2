import 'package:flutter/foundation.dart';
import '../models/sandwich.dart';
import '../repositories/pricing_repository.dart';

class Cart with ChangeNotifier {
  // map of Sandwich -> quantity
  final Map<Sandwich, int> _items = {};

  // Returns a read-only copy of the items and their quantities
  Map<Sandwich, int> get items => Map.unmodifiable(_items);

  // add quantity (default 1). Prevent negative totals.
  void add(Sandwich sandwich, {int quantity = 1}) {
    if (quantity <= 0) return;
    final current = _items[sandwich] ?? 0;
    _items[sandwich] = current + quantity;
    notifyListeners();
  }

  // remove quantity (default 1). If resulting quantity <= 0 remove the item entirely.
  void remove(Sandwich sandwich, {int quantity = 1}) {
    if (!_items.containsKey(sandwich) || quantity <= 0) return;
    final current = _items[sandwich]!;
    final newQty = current - quantity;
    if (newQty > 0) {
      _items[sandwich] = newQty;
    } else {
      _items.remove(sandwich);
    }
    notifyListeners();
  }

  // remove entire item
  void removeItem(Sandwich sandwich) {
    if (_items.remove(sandwich) != null) {
      notifyListeners();
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  int getQuantity(Sandwich sandwich) => _items[sandwich] ?? 0;

  // total price computed with PricingRepository
  double get totalPrice {
    final repo = PricingRepository();
    double total = 0.0;
    _items.forEach((sandwich, qty) {
      total += repo.calculatePrice(quantity: qty, isFootlong: sandwich.isFootlong);
    });
    return total;
  }

  bool get isEmpty => _items.isEmpty;

  int get length => _items.length;

  int get countOfItems {
    int total = 0;
    for (Sandwich sandwich in _items.keys) {
      total += _items[sandwich]!;
    }
    return total;
  }
}
