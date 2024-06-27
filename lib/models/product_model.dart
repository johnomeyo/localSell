import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String name;
  final String size;
  final String price;
  final String category;
  final String description;
  final String imageUrl;
  final String condition;
  final String sellerUsername;
  final String sellerPhone;
  final List<dynamic> carouselUrls;

  Product({
    required this.name,
    required this.size,
    required this.price,
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.condition,
    required this.sellerUsername,
    required this.sellerPhone,
    required this.carouselUrls,
  });

  // Factory constructor to create a Product from a Firestore document
  factory Product.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Product(
      name: data['name'] ?? '',
      size: data['size'] ?? '',
      price: data['price'] ?? '',
      category: data['category'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      condition: data['condition'] ?? '',
      sellerUsername: data['sellerUsername'] ?? '',
      sellerPhone: data['sellerPhone'] ?? '',
      carouselUrls: List<String>.from(data['carouselUrls'] ?? []),
    );
  }

  // Method to convert a Product instance to a Map
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'size': size,
      'price': price,
      'category': category,
      'description': description,
      'imageUrl': imageUrl,
      'condition': condition,
      'sellerUsername': sellerUsername,
      'sellerPhone': sellerPhone,
      'carouselUrls': carouselUrls,
    };
  }
}
