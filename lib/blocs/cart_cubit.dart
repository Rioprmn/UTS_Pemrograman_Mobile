import 'package:flutter/foundation.dart';
import '../models/produk.dart';

/// Simple cart cubit backed by ChangeNotifier.
///
/// This keeps a private list of Produk and exposes unmodifiable view via
/// the `items` getter. Use `addToCart` to add a product and notify listeners.
class CartCubit extends ChangeNotifier {
  final List<Produk> _items = [];

  /// Returns a copy of items in the cart.
  List<Produk> get items => List.unmodifiable(_items);

  /// Number of items in the cart.
  int get count => _items.length;

  /// Add a product to the cart and notify listeners.
  ///
  /// This method does not deduplicate products; it simply appends the
  /// provided [product]. If you need quantity tracking, we can extend the
  /// model to include quantities.
  void addToCart(Produk product) {
    _items.add(product);
    notifyListeners();
  }

  /// Remove a product by id (first match) and notify listeners.
  bool removeFromCart(String id) {
    final index = _items.indexWhere((p) => p.id == id);
    if (index == -1) return false;
    _items.removeAt(index);
    notifyListeners();
    return true;
  }

  /// Clear the cart.
  void clear() {
    _items.clear();
    notifyListeners();
  }

  /// Remove a product by instance (first match by id) and notify listeners.
  /// Returns true if an item was removed.
  bool removeFromCartProduct(Produk product) {
    final index = _items.indexWhere((p) => p.id == product.id);
    if (index == -1) return false;
    _items.removeAt(index);
    notifyListeners();
    return true;
  }

  /// Update the quantity of [product] in the cart to [qty].
  ///
  /// This implementation treats the cart as a simple list of product
  /// instances (duplicates represent quantity). To set the quantity we
  /// remove any existing occurrences of the product (by id) then add the
  /// product [qty] times. If [qty] is 0 or negative, the product is removed.
  void updateQuantity(Produk product, int qty) {
    // remove all existing with same id
    _items.removeWhere((p) => p.id == product.id);

    if (qty > 0) {
      for (var i = 0; i < qty; i++) {
        _items.add(product);
      }
    }

    notifyListeners();
  }

  /// Get current quantity of a product by id.
  int quantityOf(Produk product) =>
      _items.where((p) => p.id == product.id).length;

  /// Total number of items in the cart.
  /// This counts each duplicate entry as one (duplicates represent quantity).
  int getTotalItems() => _items.length;

  /// Total price of all items in the cart.
  /// Sums each product.price; returns int because Produk.price is int.
  int getTotalPrice() => _items.fold<int>(0, (sum, p) => sum + p.price);

  /// Alias with the exact name requested: getTotalprice()
  int getTotalprice() => getTotalPrice();
}
