import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:local_sell/models/product_model.dart';

class ProductProvider extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  List<Product> _products = [];
  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool _isLoading = false;
  String? _error;

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();
    try {
      QuerySnapshot snapshot = await _db.collection("shop_items").get();
      _products =
          snapshot.docs.map((doc) => Product.fromFirestore(doc)).toList();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
    }
  }

  Future<void> addProduct(Product product) async {
    await FirebaseFirestore.instance
        .collection('shop_items')
        .add(product.toFirestore());
  }
}
