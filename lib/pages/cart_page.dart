import 'package:flutter/material.dart';
import 'package:local_sell/components/beta.dart';
import 'package:local_sell/components/constants.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

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
      body: const Column(children: [
        CartTiles(),
        CartTiles(),
      ],),
    );
  }
}
