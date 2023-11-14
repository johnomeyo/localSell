import 'package:flutter/material.dart';

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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical:15),
        child: child,
      ),
    );
  }
}
