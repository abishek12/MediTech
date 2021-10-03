import 'package:flutter/material.dart';

class CustomCarousel extends StatelessWidget {
  final String imageName;
  final String imageDescription;
  const CustomCarousel(
      {required this.imageName, required this.imageDescription});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Positioned(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.asset(
                "assets/images/$imageName",
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            left: 10,
            bottom: 10,
            child: Text(
              imageDescription,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
