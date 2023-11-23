import 'package:flutter/material.dart';
import 'package:local_sell/components/constants.dart';
import 'package:local_sell/models/product_model.dart';
import 'package:local_sell/pages/product_display.dart';

// ignore: must_be_immutable
class DrawerTiles extends StatelessWidget {
  DrawerTiles({super.key, required this.onTap, required this.child});
  Function()? onTap;
  Widget? child;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: child,
      ),
    );
  }
}

class SneakerTile extends StatelessWidget {
  const SneakerTile({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) =>  ProductDetails(product: product,))),
      child: SizedBox(
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                    color: containerBackground,
                    // border: Border.all(color: Colors.black12),
                    // color: Colors.amber,
                    image:  DecorationImage(
                        image: NetworkImage(
                           product.imageUrl),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
             Text(
              product.name,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 5,
            ),
             Text(
              product.price,
              style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
