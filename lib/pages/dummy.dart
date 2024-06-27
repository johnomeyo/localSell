import 'package:flutter/material.dart';
import 'package:local_sell/components/alpha.dart';
import 'package:local_sell/models/product_model.dart';
import 'package:local_sell/providers/data_fetching.dart';
import 'package:provider/provider.dart';

class Dummy extends StatefulWidget {
  const Dummy({super.key});

  @override
  State<Dummy> createState() => _DummyState();
}

class _DummyState extends State<Dummy> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductProvider>(context, listen: false).fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<ProductProvider>(
      builder: (BuildContext context, ProductProvider provider, Widget? child) {
        if (provider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (provider.error != null) {
          return Center(child: Text('Error: ${provider.error}'));
        } else if (provider.products.isEmpty) {
          return const Center(child: Text('No items found.'));
        } else {
          return  GridView.builder(
                itemCount: provider.products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
            itemBuilder: (context, index) {
              final docs = provider.products[index];
              return SneakerTile(
                product: Product(
                  name: docs.name,
                  price: docs.price,
                  description: docs.description,
                  imageUrl:"https://images.unsplash.com/photo-1718924902065-030cc47ac9e0?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                  size: docs.size,
                  condition: docs.condition,
                  carouselUrls: docs.carouselUrls,
                  category: docs.category,
                  sellerUsername: docs.sellerUsername,
                  sellerPhone: docs.sellerPhone,
                ),
              );
            },
          );
        }
      },
    ));
  }
}
