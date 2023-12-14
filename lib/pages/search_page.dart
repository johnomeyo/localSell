import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_sell/components/alpha.dart';
import 'package:local_sell/components/constants.dart';
import 'package:local_sell/models/product_model.dart';
import 'package:local_sell/pages/cart_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  String search = "";
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: backgroundColor,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        title: CupertinoTextField(
          controller: _searchController,
          placeholder: 'Search Here...',
          onChanged: (value) {
            setState(() {
              search = value;
            });
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartPage()),
              ),
              icon: const Icon(
                Icons.shopping_cart_outlined,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("shop_items").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Network Error");
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.red,
            ));
          }

          var docs = snapshot.data!.docs;

          var filteredDocs = docs.where((doc) => doc['title']
              .toString()
              .toLowerCase()
              .contains(search.toLowerCase()));

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
                itemCount: filteredDocs.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  var doc = filteredDocs.toList()[index];
                  return SneakerTile(
                    product: Product(
                      name: doc['title'],
                      price: doc['price'],
                      description: doc['description'],
                      imageUrl: doc['displayPhoto'],
                      size: doc['size'],
                      condition: docs[index]['condition'],
                      carouselUrls: docs[index]['imageUrls'],
                      category: docs[index]['category'],
                       sellerUsername: docs[index]['sellerUsername'],
                        sellerPhone: docs[index]['sellerPhone'],
                    ),
                  );
                }),
          );
        },
      ),
    );
  }
}
