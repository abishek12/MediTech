import 'package:flutter/material.dart';
import 'package:medicalapp/constants/colors.dart';

AppBar myAppBar(String title) {
  return AppBar(
    iconTheme: IconThemeData(color: Colors.green),
    backgroundColor: Color(MyColor.backgroundColor),
    title: Text(
      title,
      style: TextStyle(color: Colors.black),
    ),
  );
}
