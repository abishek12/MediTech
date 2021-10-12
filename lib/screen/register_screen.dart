import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicalapp/widgets/custom_text.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _email = "";
    String _password = "";
    String _fullName = "";
    String _licensesNumber = "";
    String _registeredDate = "";

    void _dialogBox(String content) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text("Error"),
              content: Text(content),
              actions: [
                ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Close"))
              ],
            );
          });
    }

    Future<void> _registerDoctor() async {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password)
            .then((value) => FirebaseFirestore.instance
                    .collection("users")
                    .doc(value.user!.uid)
                    .set({
                  "fullName": _fullName,
                  "email": _email,
                  "password": _password,
                  "role": "doctor",
                  "licensesNumber": _licensesNumber,
                  "registeredDate": _registeredDate,
                }));
        Navigator.pushNamed(context, "/login");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          _dialogBox('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          _dialogBox('The account already exists for that email.');
        }
      } catch (e) {
        _dialogBox(e.toString());
      }
    }

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: 48.0,
            ),
            Center(
              child: Text("Register as a Doctor"),
            ),
            SizedBox(
              height: 32.0,
            ),
            Container(
              margin: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CustomTextField(
                    helperText: "Full Name",
                    hintText: 'Enter full name',
                    obscureText: false,
                    onChanged: (value) {
                      _fullName = value;
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  CustomTextField(
                    helperText: "Email",
                    hintText: 'Enter email address',
                    obscureText: false,
                    onChanged: (value) {
                      _email = value;
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  CustomTextField(
                    helperText: "Password",
                    hintText: 'Enter password',
                    obscureText: true,
                    onChanged: (value) {
                      _password = value;
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  CustomTextField(
                    helperText: "Licenses number",
                    hintText: 'Enter doctor licenses number',
                    obscureText: false,
                    onChanged: (value) {
                      _licensesNumber = value;
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  CustomTextField(
                    helperText: "Registered Date",
                    hintText: '2021-12-25',
                    obscureText: false,
                    onChanged: (value) {
                      _registeredDate = value;
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                      onPressed: (){
                        _registerDoctor();

                      },
                      child: Text("Register"),
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
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
