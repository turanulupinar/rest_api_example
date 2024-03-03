import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(
          height: 50,
        ),
        for (int i = 0; i < 10; i++)
          SizedBox(
            child: Shimmer.fromColors(
              baseColor: const Color.fromARGB(255, 216, 210, 209),
              highlightColor: const Color.fromARGB(255, 238, 238, 234),
              child: Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.all(12),
                width: 200.0,
                height: 50.0,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
      ],
    );
  }
}
