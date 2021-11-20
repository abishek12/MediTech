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
            right: 40,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xFFa1d0ff).withOpacity(0.6),
                    Color(0xFFfc3838),
                  ],
                ),
              ),
              child: Text(
                imageDescription,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
