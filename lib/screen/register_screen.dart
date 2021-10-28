import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicalapp/constants/styles.dart';
import 'package:medicalapp/widgets/custom_text.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _email = "";
    String _password = "";
    String _fullName = "";

    _registerDoctor() async {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password)
            .then((value) => FirebaseFirestore.instance
                    .collection("doctor")
                    .doc(value.user!.uid)
                    .set({
                  "fullName": _fullName,
                  "email": _email,
                  "role": "doctor",
                  "description": "",
                  "likes": "",
                  "rating": "",
                  "images": "",
                }));
        Navigator.pushNamed(context, "/landing");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e.toString());
      }
    }

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: 64.0),
              child: Center(
                child: Text(
                  "Register as a Doctor",
                  style: MyStyles.heading,
                ),
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CustomTextField(
                      helperText: "Fullname",
                      hintText: "Enter Fullname",
                      onChanged: (value) {
                        _fullName = value;
                      },
                      obscureText: false,
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    CustomTextField(
                      helperText: "Email",
                      hintText: "Enter email address",
                      onChanged: (value) {
                        _email = value;
                      },
                      obscureText: false,
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    CustomTextField(
                      helperText: "Password",
                      hintText: "Enter password",
                      onChanged: (value) {
                        _password = value;
                      },
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          _registerDoctor();
                        },
                        child: Text("Register"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
