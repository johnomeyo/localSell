import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SneakerTileShimmer extends StatelessWidget {
  const SneakerTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 100,
              width: 150,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(5)),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 20,
              width: 150,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(5)),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 20,
              width: 150,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(5)),
            ),
          ],
        ),
      ),
    );
  }
}
