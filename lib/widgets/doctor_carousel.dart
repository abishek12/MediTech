import 'package:flutter/material.dart';

class TopRatedDoctor extends StatelessWidget {
  final String imageName;
  final String doctorName;
  final String doctorEmail;
  final int likes;

  const TopRatedDoctor(
      {required this.imageName,
      required this.doctorName,
      required this.doctorEmail,
      required this.likes});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage("assets/images/$imageName"),
          ),
          SizedBox(
            width: 8.0,
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(doctorName),
                SizedBox(
                  height: 4.0,
                ),
                Text(doctorEmail),
              ],
            ),
          ),
          SizedBox(
            width: 8.0,
          ),
          Text("asblsknsd"),
        ],
      ),
    );
  }
}
