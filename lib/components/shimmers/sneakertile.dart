import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SneakerTileShimmer extends StatelessWidget {
  const SneakerTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.red,
      child: Column(
        children: [
          Container(
            height: 80,
            width: 50,
            color: Colors.grey,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 20,
            width: 50,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
