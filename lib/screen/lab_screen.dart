import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicalapp/widgets/custom_appbar.dart';
import 'package:medicalapp/widgets/custom_drawer.dart';
import 'package:medicalapp/widgets/labtest.dart';

class LabScreen extends StatelessWidget {
  const LabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar("Lab Test"),
      drawer: MyDrawer(),
      body: ListView(
        children: [
          LabTest(
            title: "COVID-19",
            subtitle: "2000",
            onPressed: () => Navigator.pushNamed(context, "/labPayment"),
          ),
          LabTest(
            title: "Blood Group",
            subtitle: "250",
            onPressed: () => Navigator.pushNamed(context, "/labPayment"),
          ),
          LabTest(
            title: "Sugar Test",
            subtitle: "100",
            onPressed: () => Navigator.pushNamed(context, "/labPayment"),
          ),
          LabTest(
            title: "Urine, Stool",
            subtitle: "500",
            onPressed: () => Navigator.pushNamed(context, "/labPayment"),
          ),
          LabTest(
            title: "COVID-19",
            subtitle: "2000",
            onPressed: () => Navigator.pushNamed(context, "/labPayment"),
          ),
        ],
      ),
    );
  }
}
