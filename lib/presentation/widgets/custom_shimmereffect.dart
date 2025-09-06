import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmereffect extends StatelessWidget {
  final double screenWidth;
  const CustomShimmereffect({super.key, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.grey.shade300,
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 130,
              height: 45,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 40,
              width: screenWidth * 0.8,
              color: Colors.white,
            ),
            const SizedBox(height: 10),
            Container(
              height: 40,
              width: screenWidth * 0.6,
              color: Colors.white,
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                height: 40,
                width: screenWidth * 0.3,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
