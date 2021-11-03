import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String helperText;
  final String hintText;
  final Function(String) onChanged;
  final bool obscureText;

  CustomTextField({
    required this.helperText,
    required this.hintText,
    required this.onChanged,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      child: TextField(
        obscureText: obscureText,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: helperText,
          labelStyle: TextStyle(color: Colors.redAccent),
          hintStyle: TextStyle(
            color: Colors.redAccent,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
