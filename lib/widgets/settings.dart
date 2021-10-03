import 'package:flutter/material.dart';
import 'package:medicalapp/constants/styles.dart';

class SettingsContent extends StatelessWidget {
  final String title;
  final bool value;

  SettingsContent({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ListTile(
        leading: Text(
          title,
          style: MyStyles.paragraph,
        ),
        trailing: Switch(value: value, onChanged: (values) {}),
      ),
    );
  }
}
