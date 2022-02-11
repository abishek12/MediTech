import 'package:flutter/material.dart';

class CustomCarousel extends StatelessWidget {
  final String imageName;

  const CustomCarousel({required this.imageName});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Positioned(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                "$imageName",
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
