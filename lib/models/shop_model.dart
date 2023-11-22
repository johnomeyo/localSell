import 'package:flutter/material.dart';
import 'package:local_sell/models/product_model.dart';

class Shop extends ChangeNotifier {
  final List<Product> _shop = [
    Product(
        name: "Airmax 97",
        price: "\$ 300",
        description: "The GOAT's",
        imageUrl:
            "https://images.unsplash.com/photo-1597045566677-8cf032ed6634?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8c25lYWtlcnN8ZW58MHx8MHx8fDA%3D"),
    Product(
        name: "Airmax 97",
        price: "\$ 300",
        description: "The GOAT's",
        imageUrl:
            "https://images.unsplash.com/photo-1597045566677-8cf032ed6634?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8c25lYWtlcnN8ZW58MHx8MHx8fDA%3D"),
    Product(
        name: "Airmax 97",
        price: "\$ 300",
        description: "The GOAT's",
        imageUrl:
            "https://images.unsplash.com/photo-1597045566677-8cf032ed6634?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8c25lYWtlcnN8ZW58MHx8MHx8fDA%3D"),
    Product(
        name: "Airmax 97",
        price: "\$ 300",
        description: "The GOAT's",
        imageUrl:
            "https://images.unsplash.com/photo-1597045566677-8cf032ed6634?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8c25lYWtlcnN8ZW58MHx8MHx8fDA%3D"),
  ];

  final List<Product> _cart = [];

  //get shop
  List<Product> get shop => _shop;

  //get cart
  List<Product> get cart => _cart;
//add to cart
  addToCart(Product item) {
    _cart.add(item);
    notifyListeners();
  }

  //remove from cart
  removeFromCart(Product item) {
    _cart.remove(item);
    notifyListeners();
  }
}
