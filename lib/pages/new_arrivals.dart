import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:local_sell/components/alpha.dart';
import 'package:local_sell/components/beta.dart';
import 'package:local_sell/components/constants.dart';
import 'package:local_sell/models/product_model.dart';
import 'package:local_sell/pages/cart_page.dart';

class NewArrivalsPage extends StatelessWidget {
  const NewArrivalsPage({super.key});

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
            )),
        elevation: 0,
        title: Text("New Arrivals", style: style3),
        actions: [
          const SearchButton(),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const CartPage())),
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.black,
                )),
          )
        ],
      ),
      backgroundColor: backgroundColor,
      body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection("shop_items").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text("Network Error");
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            var docs = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                itemCount: docs.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
                itemBuilder: (context, index) => SneakerTile(
                  product: Product(
                      name: docs[index]['title'],
                      price: docs[index]['price'],
                      description: docs[index]['description'],
                      imageUrl: docs[index]['imageUrl']),
                ),
              ),
            );
          }),
    );
  }
}
