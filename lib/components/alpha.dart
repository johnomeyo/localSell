import 'package:flutter/material.dart';
import 'package:local_sell/components/constants.dart';
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
  const SneakerTile({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ProductDetails())),
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
                    image: const DecorationImage(
                        image: NetworkImage(
                            "https://images.unsplash.com/photo-1552346154-21d32810aba3?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Nike Air Max 97",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              "Ksh 1400",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
