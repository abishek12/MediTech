import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LabTest extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onPressed;

  LabTest({
    required this.title,
    required this.subtitle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text("Price: Rs.$subtitle"),
        trailing: IconButton(
          onPressed: () {
            onPressed();
          },
          icon: Icon(CupertinoIcons.arrow_right),
        ),
      ),
    );
  }
}
