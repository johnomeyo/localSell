import 'package:flutter/material.dart';
import 'package:local_sell/models/product_model.dart';

class CartModel extends ChangeNotifier {
  final List<Product> _cartProducts = [];
  List<Product> get products => _cartProducts;
  void addToCart(Product product) {
    if (!_cartProducts.contains(product)) {
      _cartProducts.add(product);
      notifyListeners();
    }
  }

  void removeFromCart(Product product) {
    _cartProducts.remove(product);
    notifyListeners();
  }

  bool isInCart(Product product) {
    return _cartProducts.contains(product);
  }
}
