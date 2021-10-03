import 'package:flutter/material.dart';
import 'package:medicalapp/constants/styles.dart';
import 'package:medicalapp/widgets/custom_appbar.dart';
import 'package:medicalapp/widgets/custom_drawer.dart';
import 'package:medicalapp/widgets/custom_text.dart';

class LabPaymentScreen extends StatelessWidget {
  const LabPaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar("Payment"),
      drawer: MyDrawer(),
      body: Container(
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: 32.0),
              child: Center(
                child: Text(
                  "Book Your Lab Test",
                  style: MyStyles.headingFour,
                ),
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            // username
            Container(
              margin: EdgeInsets.all(16.0),
              child: CustomTextField(
                helperText: "Username",
                hintText: "Enter username",
                onChanged: (value) {},
                obscureText: false,
              ),
            ),
            // email
            Container(
              margin: EdgeInsets.all(16.0),
              child: CustomTextField(
                helperText: "Email",
                hintText: "Enter email address",
                onChanged: (value) {},
                obscureText: false,
              ),
            ),
            // title
            Container(
              margin: EdgeInsets.all(16.0),
              child: Text("Test Name"),
            ),
            // price
            Container(
              margin: EdgeInsets.all(16.0),
              child: Text("Test Price"),
            ),
            Container(
              margin: EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Payment"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
