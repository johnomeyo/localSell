// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:local_sell/components/beta.dart';
import 'package:local_sell/components/constants.dart';
import 'package:local_sell/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({
    super.key,
  });

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
          builder: (context, cart, child) => cart.products.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        size: 80,
                      ),
                      SizedBox(height: 10,),
                      Text("Oops, your cart seems to be empty😪", style: TextStyle(fontSize: 17),),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: cart.products.length,
                  itemBuilder: (context, index) {
                    final product = cart.products[index];
                    return Slidable(
                      endActionPane:
                          ActionPane(motion: const StretchMotion(), children: [
                        SlidableAction(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.red,
                            icon: Icons.delete,
                            label: 'Delete',
                            onPressed: (BuildContext context) {
                              cart.removeFromCart(product);
                            })
                      ]),
                      child: CartTiles(
                        name: product.name,
                        category: product.size,
                        price: product.price,
                        imageUrl: product.imageUrl,
                      ),
                    );
                  }),
        ));
  }
}
