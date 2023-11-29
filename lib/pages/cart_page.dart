// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:local_sell/components/beta.dart';
import 'package:local_sell/components/constants.dart';
import 'package:local_sell/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
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
          title: Text(
            "Cart Page",
            style: style3,
          ),
        ),
        body: Consumer<CartModel>(
          builder: (context, cart, child) => ListView.builder(
              itemCount: cart.products.length,
              itemBuilder: (context, index) {
                final product = cart.products[index];
                return CartTiles(
                  name: product.name,
                  category: product.size,
                  price: product.price,
                  imageUrl: product.imageUrl,
                );
              }),
        ));
  }
}
