import 'package:flutter/material.dart';
import 'package:medicalapp/widgets/custom_appbar.dart';
import 'package:medicalapp/widgets/custom_drawer.dart';
import 'package:medicalapp/widgets/settings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar("Settings"),
      drawer: MyDrawer(),
      body: ListView(
        children: [
          SettingsContent(
            title: "Wifi",
            value: false,
          ),
          SettingsContent(
            title: "Dark Mode",
            value: false,
          ),
          SettingsContent(
            title: "Notification",
            value: true,
          ),
        ],
      ),
    );
  }
}
