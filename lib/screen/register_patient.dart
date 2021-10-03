import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicalapp/widgets/custom_text.dart';

class RegisterPatientScreen extends StatelessWidget {
  const RegisterPatientScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Register as a Patient"),
            Container(
              margin: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CustomTextField(
                    helperText: "Email",
                    hintText: 'Enter email address',
                    obscureText: false,
                    onChanged: (value) {},
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  CustomTextField(
                    helperText: "Password",
                    hintText: 'Enter password',
                    obscureText: true,
                    onChanged: (value) {},
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("Login"),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Back To Login"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
