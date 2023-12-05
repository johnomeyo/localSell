import 'package:flutter/material.dart';
import 'package:local_sell/models/product_model.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<Product> _favoriteProducts = [];
  List<Product> get favorites => _favoriteProducts;
  addToFavorites(Product product) {
    if (!_favoriteProducts.contains(product)) {
      _favoriteProducts.add(product);
      notifyListeners();
    }
    
  }

  removeFromFavorites(Product product) {
  if(_favoriteProducts.contains(product)){
      _favoriteProducts.remove(product);
  }
  }

  bool isFavorite(Product product) {
    return _favoriteProducts.contains(product);
  }
}
